import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
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
  final _amount = TextEditingController(text: '100');
  final _limitPrice = TextEditingController();
  var _side = TradingSide.long;
  final _type = TradingOrderType.market;
  var _marginMode = TradingMarginMode.cross;
  var _leverage = 10;
  var _reduceOnly = false;
  var _showTpSl = false;
  var _submitting = false;
  String? _error;
  OrderPreview? _preview;
  OrderPreview? _quotePreview;
  TradingOrder? _submitted;
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
      var submitted = await ref
          .read(orderCommandProvider.notifier)
          .submit(preview.intent, previewId: preview.previewId);
      if (submitted?.resource.status == TradingOrderStatus.pendingSignature) {
        submitted = await ref
            .read(hip3OrderExecutionRepositoryProvider)
            .awaitActionAndSubmit(submitted!.resource.orderId);
      }
      if (!mounted) return;
      setState(() {
        _submitted = submitted?.resource;
        _error = submitted == null
            ? 'Order was not submitted. Try again.'
            : null;
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

  Widget _form(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _reduceOnly
                    ? 'Close Position'
                    : '${_side == TradingSide.long ? 'Long' : 'Short'} ${widget.symbol}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              _Hip3SegmentedControl<TradingSide>(
                values: const [TradingSide.long, TradingSide.short],
                selected: _side,
                label: (value) => value == TradingSide.long ? 'Long' : 'Short',
                onChanged: (value) {
                  setState(() => _side = value);
                  _scheduleQuote();
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _amount,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Order Value',
                  suffixText: _quotePreview?.settlementAsset ?? 'USDC',
                ),
              ),
              if (_type == TradingOrderType.limit) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _limitPrice,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Limit Price',
                    prefixText: r'$',
                  ),
                ),
              ],
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Leverage: ${_leverage}x'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () async {
                  final leverage = await showModalBottomSheet<int>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) =>
                        Hip3LeverageSheet(initialLeverage: _leverage),
                  );
                  if (leverage != null && mounted) {
                    setState(() => _leverage = leverage);
                  }
                },
              ),
              _Hip3SegmentedControl<TradingMarginMode>(
                values: const [
                  TradingMarginMode.cross,
                  TradingMarginMode.isolated,
                ],
                selected: _marginMode,
                label: (value) =>
                    value == TradingMarginMode.cross ? 'Cross' : 'Isolated',
                onChanged: (value) {
                  setState(() => _marginMode = value);
                  _scheduleQuote();
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Reduce only'),
                value: _reduceOnly,
                onChanged: (value) {
                  setState(() => _reduceOnly = value);
                  _scheduleQuote();
                },
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Take profit / stop loss'),
                value: _showTpSl,
                onChanged: (value) => setState(() => _showTpSl = value),
              ),
              const _Hip3RiskSummary(),
              if (_showTpSl)
                const Text('TP/SL will be set during order review.'),
              if (_error case final error?)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(error),
                ),
              const SizedBox(height: 16),
              FilledButton(
                style: _actionStyle(context),
                onPressed: _submitting ? null : _review,
                child: Text(
                  _submitting
                      ? 'Preparing order…'
                      : _reduceOnly
                      ? 'Close ${widget.symbol}'
                      : '${_side == TradingSide.long ? 'Long' : 'Short'} ${widget.symbol}',
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _confirmation(BuildContext context) => Material(
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_reduceOnly
                ? 'Close'
                : _side == TradingSide.long
                ? 'Long'
                : 'Short'} ${widget.symbol} · ${_type.name}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Order value: ${TokenAmountFormatter.format(_preview!.orderValue, symbol: _preview!.orderValue.asset ?? _preview!.settlementAsset ?? 'USDC')}',
          ),
          Text('Leverage: ${_leverage}x · ${_marginMode.name}'),
          if (_preview!.fee case final fee?)
            Text(
              'Estimated fee: ${TokenAmountFormatter.format(fee, symbol: fee.asset ?? _preview!.settlementAsset ?? 'USDC')}',
            ),
          const SizedBox(height: 16),
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
                        ? 'Submitting…'
                        : 'Confirm ${_reduceOnly
                              ? 'Close'
                              : _side == TradingSide.long
                              ? 'Long'
                              : 'Short'}',
                  ),
                ),
              ),
            ],
          ),
          if (_error case final error?)
            Padding(padding: const EdgeInsets.only(top: 8), child: Text(error)),
        ],
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
    required this.label,
    required this.onChanged,
  });

  final List<T> values;
  final T selected;
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
          borderRadius: BorderRadius.circular(8),
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
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(6),
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
                                      ? colors.primaryText
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
  const _Hip3RiskSummary();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.only(bottom: 12),
    child: Column(
      children: [
        _Hip3RiskRow('Liquidation Price', '–'),
        SizedBox(height: 8),
        _Hip3RiskRow('Margin Required', '– USDC'),
      ],
    ),
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
