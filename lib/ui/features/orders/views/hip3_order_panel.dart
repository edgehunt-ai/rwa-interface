import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
import 'package:rwa_interface/domain/repositories/hip3_order_execution_repository.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';

/// HIP-3-specific order composition. Keeping it separate from bStocks prevents
/// perpetual-only fields leaking into the spot order payload.
class Hip3OrderPanel extends ConsumerStatefulWidget {
  const Hip3OrderPanel({
    super.key,
    this.initialSide = TradingSide.long,
    this.initialReduceOnly = false,
    this.symbol = 'NVDA',
  });

  final TradingSide initialSide;
  final bool initialReduceOnly;
  final String symbol;

  @override
  ConsumerState<Hip3OrderPanel> createState() => _Hip3OrderPanelState();
}

class _Hip3OrderPanelState extends ConsumerState<Hip3OrderPanel> {
  final _amount = TextEditingController();
  final _limitPrice = TextEditingController();
  var _side = TradingSide.long;
  final _type = TradingOrderType.market;
  var _marginMode = TradingMarginMode.cross;
  var _leverage = 10;
  var _reduceOnly = false;
  var _showTpSl = false;
  var _percentage = 0.0;
  var _submitting = false;
  String? _error;
  OrderPreview? _preview;
  OrderPreview? _quotePreview;
  TradingOrder? _submitted;
  String? _pendingOrderId;
  Timer? _quoteDebounce;
  var _quoteGeneration = 0;

  @override
  void initState() {
    super.initState();
    _side = widget.initialSide;
    _reduceOnly = widget.initialReduceOnly;
    _amount.addListener(_scheduleQuote);
    _limitPrice.addListener(_scheduleQuote);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scheduleQuote());
  }

  @override
  void dispose() {
    _quoteDebounce?.cancel();
    _amount.removeListener(_scheduleQuote);
    _limitPrice.removeListener(_scheduleQuote);
    _amount.dispose();
    _limitPrice.dispose();
    super.dispose();
  }

  OrderIntent? _intentFromFields() {
    final rawAmount = _amount.text.trim();
    if (rawAmount.isEmpty) return null;
    final rawLimitPrice = _limitPrice.text.trim();
    if (_type == TradingOrderType.limit && rawLimitPrice.isEmpty) return null;
    try {
      return OrderIntent(
        symbol: widget.symbol,
        kind: MarketProductKind.perp,
        side: _side,
        type: _type,
        amount: _type == TradingOrderType.market
            ? DecimalValue(rawAmount, asset: 'USDC', unit: 'token')
            : null,
        quantity: _type == TradingOrderType.limit
            ? DecimalValue(rawAmount, asset: widget.symbol, unit: 'token')
            : null,
        limitPrice: _type == TradingOrderType.limit
            ? DecimalValue(rawLimitPrice, asset: 'USD', unit: 'fiat')
            : null,
        leverage: DecimalValue('$_leverage', asset: 'x', unit: 'multiple'),
        marginMode: _marginMode,
        reduceOnly: _reduceOnly,
      );
    } on FormatException {
      return null;
    }
  }

  void _scheduleQuote() {
    _quoteDebounce?.cancel();
    final generation = ++_quoteGeneration;
    final intent = _intentFromFields();
    if (intent == null) {
      if (_quotePreview != null) setState(() => _quotePreview = null);
      return;
    }
    _quoteDebounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final quote = await ref.read(orderPreviewProvider(intent).future);
        if (mounted && generation == _quoteGeneration) {
          setState(() => _quotePreview = quote);
        }
      } on Object {
        if (mounted && generation == _quoteGeneration) {
          setState(() => _quotePreview = null);
        }
      }
    });
  }

  Future<void> _review() async {
    final rawAmount = _amount.text.trim();
    if (rawAmount.isEmpty) {
      setState(() => _error = 'Enter an order value.');
      return;
    }
    final rawLimitPrice = _limitPrice.text.trim();
    if (_type == TradingOrderType.limit && rawLimitPrice.isEmpty) {
      setState(() => _error = 'Enter a valid limit price.');
      return;
    }
    try {
      final intent = _intentFromFields()!;
      setState(() {
        _error = null;
        _submitting = true;
      });
      final cachedQuote = _quotePreview;
      final preview = cachedQuote?.intent.fingerprint == intent.fingerprint
          ? cachedQuote
          : await ref.read(orderPreviewProvider(intent).future);
      if (mounted) {
        setState(() => _preview = preview);
      }
    } on FormatException {
      if (mounted) {
        setState(() => _error = 'Enter valid order values.');
      }
    } on Object {
      if (mounted) {
        setState(() => _error = 'Unable to prepare this order. Try again.');
      }
    } finally {
      if (mounted) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<void> _submit() async {
    final preview = _preview;
    if (preview == null) return;
    setState(() => _submitting = true);
    try {
      var submitted = _pendingOrderId != null
          ? await ref
                .read(hip3OrderExecutionRepositoryProvider)
                .awaitActionAndSubmit(_pendingOrderId!)
          : await ref
                .read(orderCommandProvider.notifier)
                .submit(preview.intent, previewId: preview.previewId);
      if (submitted?.resource.status == TradingOrderStatus.pendingSignature) {
        _pendingOrderId = submitted!.resource.orderId;
        submitted = await ref
            .read(hip3OrderExecutionRepositoryProvider)
            .awaitActionAndSubmit(_pendingOrderId!);
      }
      ref.invalidate(hip3OrdersProvider);
      if (!mounted) return;
      setState(() {
        _submitted = submitted?.resource;
        _error = submitted == null
            ? 'Order was not submitted. Try again.'
            : null;
      });
    } on Hip3ExecutionPending catch (pending) {
      if (!mounted) return;
      setState(() {
        _pendingOrderId = pending.orderId;
        _error = pending.requiresReview
            ? 'This order needs review. Do not place a replacement order.'
            : 'Confirming this order. Retry to check the same order; do not place a replacement.';
      });
    } on Hip3SigningFailure catch (failure) {
      if (!mounted) return;
      setState(() => _error = _signingError(failure));
    } on Object {
      if (!mounted) return;
      setState(() => _error = 'Unable to sign this order. Try again.');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String _signingError(Hip3SigningFailure failure) => switch (failure.code) {
    Hip3SigningFailureCode.walletMismatch =>
      'Connect the wallet requested for this order.',
    Hip3SigningFailureCode.actionExpired =>
      'This signing request expired. Prepare the order again.',
    Hip3SigningFailureCode.rejected => 'Signature request was cancelled.',
    Hip3SigningFailureCode.actionNotReady =>
      'The order is still being prepared. Try again.',
    Hip3SigningFailureCode.walletUnavailable =>
      'The signing wallet is unavailable. Reconnect and try again.',
    Hip3SigningFailureCode.invalidPayload =>
      'The signing request is invalid. Prepare the order again.',
  };

  @override
  Widget build(BuildContext context) {
    if (_submitted != null) return _result(context);
    if (_preview != null) return _confirmation(context);
    return _form(context);
  }

  Widget _form(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final isShort = _side == TradingSide.short || _reduceOnly;
    final actionColor = isShort ? semantic.loss : semantic.success;
    final amount = _amount.text.trim();
    final settlementAsset = _quotePreview?.settlementAsset ?? 'USDC';
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 543 + (_error == null ? 0 : 36),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Hip3SheetHeader(
                  title: _reduceOnly
                      ? 'Close Position'
                      : '${_side == TradingSide.long ? 'Long' : 'Short'} ${widget.symbol}',
                  leverage: _leverage,
                  color: actionColor,
                  onClose: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 16),
                if (!_reduceOnly) ...[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: 143,
                      child: _Hip3SegmentedControl<TradingSide>(
                        values: const [TradingSide.long, TradingSide.short],
                        selected: _side,
                        selectedColor: actionColor,
                        label: (value) =>
                            value == TradingSide.long ? 'Long' : 'Short',
                        onChanged: (value) {
                          setState(() => _side = value);
                          _scheduleQuote();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                _Hip3ModeLeverageCard(
                  marginMode: _marginMode,
                  leverage: _leverage,
                  controller: _amount,
                  settlementAsset: settlementAsset,
                  percentage: _percentage,
                  onMarginModeTap: () {
                    setState(() {
                      _marginMode = _marginMode == TradingMarginMode.cross
                          ? TradingMarginMode.isolated
                          : TradingMarginMode.cross;
                    });
                    _scheduleQuote();
                  },
                  onLeverageTap: () async {
                    final leverage = await showModalBottomSheet<int>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) =>
                          Hip3LeverageSheet(initialLeverage: _leverage),
                    );
                    if (leverage != null && mounted) {
                      setState(() => _leverage = leverage);
                      _scheduleQuote();
                    }
                  },
                  onPercentageChanged: (value) =>
                      setState(() => _percentage = value),
                ),
                const SizedBox(height: 16),
                Divider(color: colors.subtleSurface),
                const SizedBox(height: 16),
                _Hip3RiskSummary(
                  settlementAsset: settlementAsset,
                  showTpSl: _showTpSl,
                  onTpSlTap: () => setState(() => _showTpSl = !_showTpSl),
                ),
                if (_error case final error?) ...[
                  const SizedBox(height: 8),
                  Text(
                    error,
                    style: TextStyle(color: semantic.loss, fontSize: 12),
                  ),
                ],
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: actionColor),
                    onPressed: _submitting ? null : _review,
                    child: Text(
                      _submitting
                          ? 'Preparing order...'
                          : '${_reduceOnly
                                ? 'Close'
                                : _side == TradingSide.long
                                ? 'Long'
                                : 'Short'} ${widget.symbol} · \$${amount.isEmpty ? '0' : amount}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmation(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Hip3SheetHeader(
              title:
                  'Review ${_side == TradingSide.long ? 'Long' : 'Short'} ${widget.symbol}',
              leverage: _leverage,
              color: _side == TradingSide.short
                  ? Theme.of(context).extension<AppSemanticColors>()!.loss
                  : Theme.of(context).extension<AppSemanticColors>()!.success,
              onClose: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 24),
            _Hip3ReviewRow(
              'Order Value',
              TokenAmountFormatter.format(
                _preview!.orderValue,
                symbol:
                    _preview!.orderValue.asset ??
                    _preview!.settlementAsset ??
                    'USDC',
              ),
            ),
            const SizedBox(height: 12),
            _Hip3ReviewRow(
              'Margin Mode',
              _marginMode == TradingMarginMode.cross ? 'Cross' : 'Isolated',
            ),
            const SizedBox(height: 12),
            _Hip3ReviewRow('Leverage', '${_leverage}x'),
            if (_preview!.fee case final fee?) ...[
              const SizedBox(height: 12),
              _Hip3ReviewRow(
                'Estimated Fee',
                TokenAmountFormatter.format(
                  fee,
                  symbol: fee.asset ?? _preview!.settlementAsset ?? 'USDC',
                ),
              ),
            ],
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _preview = null),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: _actionStyle(context),
                    onPressed: _submitting ? null : _submit,
                    child: Text(
                      _submitting
                          ? (_pendingOrderId == null
                                ? 'Submitting...'
                                : 'Checking order...')
                          : (_pendingOrderId == null
                                ? 'Confirm'
                                : 'Check order status'),
                    ),
                  ),
                ),
              ],
            ),
            if (_error case final error?)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error),
              ),
          ],
        ),
      ),
    ),
  );

  ButtonStyle _actionStyle(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final color = _side == TradingSide.short || _reduceOnly
        ? semantic.loss
        : semantic.success;
    return FilledButton.styleFrom(backgroundColor: color);
  }

  Widget _result(BuildContext context) => Material(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_outline, size: 48),
          const SizedBox(height: 12),
          Text(
            _submitted!.status == TradingOrderStatus.filled
                ? 'Trade Successful'
                : 'Order submitted',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close & View Later'),
          ),
        ],
      ),
    ),
  );
}

class _Hip3SegmentedControl<T> extends StatelessWidget {
  const _Hip3SegmentedControl({
    required this.values,
    required this.selected,
    required this.selectedColor,
    required this.label,
    required this.onChanged,
  });

  final List<T> values;
  final T selected;
  final Color selectedColor;
  final String Function(T value) label;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final selectedIndex = values.indexOf(selected);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Container(
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.subtleSurface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              alignment: selectedIndex == 0
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                for (final value in values)
                  Expanded(
                    child: Semantics(
                      button: true,
                      inMutuallyExclusiveGroup: true,
                      selected: selected == value,
                      label: label(value),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(6),
                        onTap: () => onChanged(value),
                        child: Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOutCubic,
                            style: Theme.of(context).textTheme.labelLarge!
                                .copyWith(
                                  color: selected == value
                                      ? colors.onPrimaryAction
                                      : colors.secondaryText,
                                  fontWeight: selected == value
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                            child: Text(label(value)),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Hip3RiskSummary extends StatelessWidget {
  const _Hip3RiskSummary({
    required this.settlementAsset,
    required this.showTpSl,
    required this.onTpSlTap,
  });

  final String settlementAsset;
  final bool showTpSl;
  final VoidCallback onTpSlTap;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const _Hip3RiskRow('Liquidation Price', '-'),
      const SizedBox(height: 8),
      _Hip3RiskRow('Margin Required', '- $settlementAsset'),
      const SizedBox(height: 8),
      InkWell(
        key: const Key('hip3-tp-sl-toggle'),
        onTap: onTpSlTap,
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Take profit/stop loss',
                style: TextStyle(
                  color: Theme.of(context)
                      .extension<AppRwaColors>()!
                      .secondaryText,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Color(0xFFFF7BE5),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 14),
            ),
            const SizedBox(width: 4),
            Text(
              showTpSl ? 'Added' : 'Add',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ],
  );
}

class _Hip3SheetHeader extends StatelessWidget {
  const _Hip3SheetHeader({
    required this.title,
    required this.leverage,
    required this.color,
    required this.onClose,
  });

  final String title;
  final int leverage;
  final Color color;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
      const SizedBox(width: 4),
      _Hip3Badge('$leverage×'),
      const SizedBox(width: 4),
      const _Hip3Badge('HIP-3 Perps'),
      const Spacer(),
      IconButton(
        tooltip: 'Close',
        onPressed: onClose,
        icon: const Icon(Icons.keyboard_double_arrow_down, size: 24),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints.tightFor(width: 24, height: 24),
      ),
    ],
  );
}

class _Hip3Badge extends StatelessWidget {
  const _Hip3Badge(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, height: 16 / 12)),
    );
  }
}

class _Hip3ModeLeverageCard extends StatelessWidget {
  const _Hip3ModeLeverageCard({
    required this.marginMode,
    required this.leverage,
    required this.controller,
    required this.settlementAsset,
    required this.percentage,
    required this.onMarginModeTap,
    required this.onLeverageTap,
    required this.onPercentageChanged,
  });

  final TradingMarginMode marginMode;
  final int leverage;
  final TextEditingController controller;
  final String settlementAsset;
  final double percentage;
  final VoidCallback onMarginModeTap;
  final VoidCallback onLeverageTap;
  final ValueChanged<double> onPercentageChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 36,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    key: const Key('hip3-margin-mode-toggle'),
                    onTap: onMarginModeTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          marginMode == TradingMarginMode.cross
                              ? 'Cross'
                              : 'Isolated',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),
                ),
                Container(width: 2, height: 16, color: colors.surface),
                Expanded(
                  child: InkWell(
                    key: const Key('hip3-leverage-toggle'),
                    onTap: onLeverageTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$leverage×',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: colors.surface),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Value',
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.secondaryText,
                      ),
                    ),
                    const Text(
                      'Balance: --',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,8}'),
                            ),
                          ],
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(color: colors.primaryText),
                          decoration: InputDecoration(
                            hintText: '0.0',
                            hintStyle: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(color: colors.tertiaryText),
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        settlementAsset,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                _Hip3AmountRail(
                  value: percentage,
                  onChanged: onPercentageChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Hip3AmountRail extends StatelessWidget {
  const _Hip3AmountRail({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 20,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: colors.primaryAction,
          inactiveTrackColor: colors.surface,
          trackHeight: 8,
          thumbColor: colors.primaryAction,
          overlayShape: SliderComponentShape.noOverlay,
          valueIndicatorColor: colors.primaryAction,
          showValueIndicator: ShowValueIndicator.onDrag,
        ),
        child: Slider(
          value: value,
          divisions: 4,
          label: '${(value * 100).round()}%',
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _Hip3ReviewRow extends StatelessWidget {
  const _Hip3ReviewRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
          ),
        ),
      ),
      Text(
        value,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      ),
    ],
  );
}

/// Leverage selection is kept inside the HIP-3 presentation layer so its
/// result remains local UI state until an order preview is requested.
class Hip3LeverageSheet extends StatefulWidget {
  const Hip3LeverageSheet({super.key, required this.initialLeverage});

  final int initialLeverage;

  @override
  State<Hip3LeverageSheet> createState() => _Hip3LeverageSheetState();
}

class _Hip3LeverageSheetState extends State<Hip3LeverageSheet> {
  late var _leverage = widget.initialLeverage;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 543,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Back',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.chevron_left, size: 20),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Leverage',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const Spacer(),
                Center(
                  child: Text(
                    '${_leverage}x',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 32),
                Semantics(
                  label: 'Drag to set leverage',
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: colors.subtleSurface,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Slider(
                      value: _leverage.toDouble(),
                      min: 1,
                      max: 20,
                      divisions: 19,
                      label: '${_leverage}x',
                      onChanged: (value) =>
                          setState(() => _leverage = value.round()),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    for (final option in const [2, 5, 10, 20]) ...[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: option == 20 ? 0 : 8),
                          child: _LeverageOption(
                            value: option,
                            selected: _leverage == option,
                            onTap: () => setState(() => _leverage = option),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const Spacer(flex: 3),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () => Navigator.of(context).pop(_leverage),
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LeverageOption extends StatelessWidget {
  const _LeverageOption({
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final int value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      button: true,
      selected: selected,
      label: 'Set leverage to ${value}x',
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? colors.selected : colors.subtleSurface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '${value}x',
            style: TextStyle(
              color: selected ? colors.onPrimaryAction : colors.secondaryText,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class _Hip3RiskRow extends StatelessWidget {
  const _Hip3RiskRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: Text(label, style: const TextStyle(fontSize: 13))),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );
}
