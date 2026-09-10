import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

part 'bstocks_funding_required.dart';
part 'bstocks_transfer_flow.dart';

class BstocksOrderPanel extends ConsumerStatefulWidget {
  const BstocksOrderPanel({
    super.key,
    this.symbol = 'NVDAB',
    this.initialSide = TradingSide.buy,
  });
  final String symbol;
  final TradingSide initialSide;

  @override
  ConsumerState<BstocksOrderPanel> createState() => _BstocksOrderPanelState();
}

class _BstocksOrderPanelState extends ConsumerState<BstocksOrderPanel> {
  final amount = TextEditingController();
  final limitPrice = TextEditingController();
  late TradingSide side;
  var type = TradingOrderType.market;
  var percentage = 0.0;
  var slippage = 0.12;
  OrderPreview? preview;
  OrderPreview? quotePreview;
  TradingOrder? submittedOrder;
  String? error;
  bool reviewing = false;
  Timer? _quoteDebounce;
  var _quoteGeneration = 0;
  var _quoting = false;

  @override
  void initState() {
    super.initState();
    side = widget.initialSide;
    amount.addListener(_refreshAmount);
    limitPrice.addListener(_scheduleQuote);
  }

  void _refreshAmount() {
    setState(() {});
    _scheduleQuote();
  }

  void _scheduleQuote() {
    _quoteDebounce?.cancel();
    final generation = ++_quoteGeneration;
    final intent = _intentFromFields();
    if (intent == null) {
      if (quotePreview != null || _quoting) {
        setState(() {
          quotePreview = null;
          _quoting = false;
        });
      }
      return;
    }
    if (!_quoting) setState(() => _quoting = true);
    _quoteDebounce = Timer(const Duration(milliseconds: 300), () async {
      try {
        final quote = await ref.read(orderPreviewProvider(intent).future);
        if (mounted && generation == _quoteGeneration) {
          setState(() {
            quotePreview = quote;
            _quoting = false;
          });
        }
      } on Object {
        if (mounted && generation == _quoteGeneration) {
          setState(() {
            quotePreview = null;
            _quoting = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _quoteDebounce?.cancel();
    amount.removeListener(_refreshAmount);
    limitPrice.removeListener(_scheduleQuote);
    amount.dispose();
    limitPrice.dispose();
    super.dispose();
  }

  Future<void> _review() async {
    final amountValue = amount.text.trim();
    if (amountValue.isEmpty || !_isDecimal(amountValue)) {
      setState(() => error = 'Enter a valid order value.');
      return;
    }
    if (type == TradingOrderType.limit &&
        (limitPrice.text.trim().isEmpty ||
            !_isDecimal(limitPrice.text.trim()))) {
      setState(() => error = 'Enter a valid limit price.');
      return;
    }
    final intent = _intentFromFields()!;
    final cachedQuote = quotePreview;
    if (cachedQuote?.intent.fingerprint == intent.fingerprint) {
      setState(() {
        error = null;
        preview = cachedQuote;
      });
      return;
    }
    setState(() {
      error = null;
      reviewing = true;
    });
    try {
      final next = await ref.read(orderPreviewProvider(intent).future);
      if (mounted) {
        setState(() => preview = next);
      }
    } on Object {
      if (mounted) {
        setState(() => error = 'Unable to prepare this order. Try again.');
      }
    } finally {
      if (mounted) {
        setState(() => reviewing = false);
      }
    }
  }

  OrderIntent? _intentFromFields() {
    final amountValue = amount.text.trim();
    if (amountValue.isEmpty || !_isDecimal(amountValue)) return null;
    final rawPrice = limitPrice.text.trim();
    if (type == TradingOrderType.limit &&
        (rawPrice.isEmpty || !_isDecimal(rawPrice))) {
      return null;
    }
    final sellsBstocks = side == TradingSide.sell;
    return OrderIntent(
      symbol: widget.symbol,
      kind: MarketProductKind.bstock,
      side: side,
      type: type,
      amount: type == TradingOrderType.market && !sellsBstocks
          ? DecimalValue(amountValue, asset: 'USDT', unit: 'token')
          : null,
      quantity: type == TradingOrderType.limit || sellsBstocks
          ? DecimalValue(amountValue, asset: widget.symbol, unit: 'token')
          : null,
      limitPrice: type == TradingOrderType.limit
          ? DecimalValue(rawPrice, asset: 'USD', unit: 'fiat')
          : null,
      slippage: DecimalValue(slippage.toString(), unit: 'percent'),
    );
  }

  Future<void> _submit() async {
    final current = preview;
    if (current == null) return;
    setState(() {
      error = null;
      reviewing = true;
    });
    final result = await ref
        .read(orderCommandProvider.notifier)
        .submit(current.intent, previewId: current.previewId);
    if (!mounted) return;
    setState(() {
      reviewing = false;
      if (result == null) {
        error = AppLocalizations.of(context).orderSubmissionFailed;
      } else {
        submittedOrder = result.resource;
      }
    });
  }

  Future<void> _editSlippage() async {
    final next = await showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _SlippageSheet(initialValue: slippage),
    );
    if (next == null || !mounted) return;
    setState(() => slippage = next);
    _scheduleQuote();
  }

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: SingleChildScrollView(
          child: submittedOrder != null
              ? _submitted(context)
              : reviewing && preview != null
              ? _submitting(context)
              : preview == null
              ? _form(context)
              : _preview(context),
        ),
      ),
    ),
  );

  Widget _form(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final success = Theme.of(context).extension<AppSemanticColors>()!.success;
    final isBuy = side == TradingSide.buy;
    final amountAsset = type == TradingOrderType.market && isBuy
        ? quotePreview?.settlementAsset ?? 'USDT'
        : widget.symbol;
    final enteredAmount = amount.text.trim();
    final buttonAmount = enteredAmount.isEmpty ? '0' : enteredAmount;
    final portfolio = ref.watch(portfolioSummaryProvider);
    final balance = _availableBalance(portfolio.value);
    final receive =
        quotePreview?.estimatedReceive ?? quotePreview?.estimatedQuantity;
    final fee = quotePreview?.fee;
    final formHeight =
        490.0 +
        (type == TradingOrderType.limit ? 64 : 0) +
        (error != null ? 52 : 0);
    return SizedBox(
      height: formHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .extension<AppSemanticColors>()!
                      .success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${side == TradingSide.buy ? 'Buy' : 'Sell'} ${widget.symbol}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.keyboard_double_arrow_down, size: 24),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints.tightFor(
                  width: 24,
                  height: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _ChoiceRow<TradingSide>(
                key: const Key('bstocks-side-tabs'),
                width: 123,
                values: const [TradingSide.buy, TradingSide.sell],
                selected: side,
                selectedColor: success,
                selectedForeground: Colors.white,
                label: (value) => value == TradingSide.buy ? 'Buy' : 'Sell',
                onChanged: (value) {
                  setState(() => side = value);
                  _scheduleQuote();
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 93,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            decoration: BoxDecoration(
              color: colors.subtleSurface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type == TradingOrderType.market && isBuy
                          ? 'Order Value'
                          : type == TradingOrderType.limit
                          ? 'Quantity'
                          : 'Amount',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.secondaryText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Balance: ',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (portfolio.isLoading)
                          const SkeletonBlock(
                            key: Key('bstocks-balance-skeleton'),
                            width: 56,
                            height: 12,
                            radius: 4,
                          )
                        else
                          Text(
                            balance ?? '—',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 36,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amount,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: Theme.of(context).textTheme.titleLarge,
                          decoration: const InputDecoration(
                            hintText: '0.0',
                            filled: false,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        amountAsset,
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                _PercentageSlider(
                  value: percentage,
                  onChanged: (value) => setState(() => percentage = value),
                ),
              ],
            ),
          ),
          if (type == TradingOrderType.limit) ...[
            const SizedBox(height: 8),
            TextField(
              controller: limitPrice,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Limit Price',
                prefixText: r'$',
              ),
            ),
          ],
          const SizedBox(height: 8),
          _OutlinedSummaryRow(
            label: 'will receive',
            value: _quoting
                ? const SkeletonBlock(width: 76, height: 14, radius: 4)
                : Text(
                    receive == null
                        ? '- ${widget.symbol}'
                        : TokenAmountFormatter.format(
                            receive,
                            symbol: widget.symbol,
                          ),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
          ),
          if (error case final error?) ...[
            const SizedBox(height: 8),
            _OrderFailureNotice(message: error),
          ],
          const SizedBox(height: 16),
          Divider(color: colors.subtleSurface),
          const SizedBox(height: 14),
          _SlippageRow(value: slippage, onEdit: _editSlippage),
          if (_quoting)
            const _LoadingSummaryRow(label: 'Estimated Fee')
          else
            _SummaryRow(
              label: 'Estimated Fee',
              value: fee == null
                  ? '-'
                  : TokenAmountFormatter.format(
                      fee,
                      symbol: fee.asset ?? widget.symbol,
                    ),
            ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              key: const Key('bstocks-primary-order-action'),
              style: FilledButton.styleFrom(backgroundColor: success),
              onPressed: reviewing ? null : _review,
              child: Text(
                reviewing
                    ? 'Preparing order…'
                    : '${isBuy ? 'Buy' : 'Sell'} ${widget.symbol} · \$$buttonAmount',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _preview(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${side == TradingSide.buy ? 'Buy' : 'Sell'} ${widget.symbol}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 16),
      _SummaryRow(
        label: '${side == TradingSide.buy ? 'Buy' : 'Sell'} ${widget.symbol}',
        value: type == TradingOrderType.market ? 'Market' : 'Limit',
      ),
      _SummaryRow(
        label: 'Order value',
        value: TokenAmountFormatter.format(
          preview!.orderValue,
          symbol:
              preview!.orderValue.asset ?? preview!.settlementAsset ?? 'USDT',
        ),
      ),
      if (preview!.estimatedQuantity case final quantity?)
        _SummaryRow(
          label: 'Estimated receive',
          value: TokenAmountFormatter.format(quantity, symbol: widget.symbol),
        ),
      if (preview!.fee case final fee?)
        _SummaryRow(
          label: 'Estimated fee',
          value: TokenAmountFormatter.format(fee, symbol: widget.symbol),
        ),
      if (preview!.marketPrice case final marketPrice?)
        _SummaryRow(
          label: AppLocalizations.of(context).marketPrice,
          value: TokenAmountFormatter.formatUsd(marketPrice),
        ),
      if (preview!.estimatedPrice case final estimatedPrice?)
        _SummaryRow(
          label: AppLocalizations.of(context).estimatedPrice,
          value: TokenAmountFormatter.formatUsd(estimatedPrice),
        ),
      if (preview!.priceUpdated)
        const Text(
          'Price changed. Review the updated estimate before submitting.',
        ),
      const SizedBox(height: 16),
      FilledButton(
        onPressed: reviewing ? null : _submit,
        child: Text(
          reviewing
              ? 'Submitting order…'
              : 'Confirm ${side == TradingSide.buy ? 'Buy' : 'Sell'}',
        ),
      ),
      if (error != null)
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            error!,
            style: TextStyle(
              color: Theme.of(context).extension<AppSemanticColors>()!.loss,
            ),
          ),
        ),
      TextButton(
        onPressed: () => setState(() => preview = null),
        child: const Text('Back'),
      ),
    ],
  );

  Widget _submitted(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Image.asset(
        'assets/figma/trade/order_success.png',
        width: 160,
        height: 160,
      ),
      const SizedBox(height: 8),
      Text(
        submittedOrder!.status == TradingOrderStatus.filled
            ? 'Trade Successful'
            : 'Order submitted',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Text(
        submittedOrder!.status == TradingOrderStatus.filled
            ? 'You can check the order status on the activities page.'
            : 'Your order is being processed. Track its status in Details.',
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 16),
      FilledButton(
        onPressed: submittedOrder!.status == TradingOrderStatus.filled
            ? () => context.goNamed(AppRoutes.activityName)
            : () => Navigator.of(context).pop(),
        child: Text(
          submittedOrder!.status == TradingOrderStatus.filled
              ? 'View History'
              : 'Close & View Later',
        ),
      ),
    ],
  );

  Widget _submitting(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Image.asset(
        'assets/figma/trade/order_submitting.png',
        width: 160,
        height: 160,
      ),
      const SizedBox(height: 8),
      Text(
        AppLocalizations.of(context).submittingOrder,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      const SizedBox(height: 8),
      Text(
        AppLocalizations.of(context).submittingOrderDescription,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
        ),
      ),
      const SizedBox(height: 16),
      OutlinedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(AppLocalizations.of(context).closeViewLater),
      ),
    ],
  );
}

bool _isDecimal(String value) {
  try {
    DecimalValue(value);
    return true;
  } on FormatException {
    return false;
  }
}

String? _availableBalance(Portfolio? portfolio) => portfolio == null
    ? null
    : TokenAmountFormatter.formatUsd(portfolio.availableToTradeUsd);

class _ChoiceRow<T> extends StatelessWidget {
  const _ChoiceRow({
    super.key,
    required this.width,
    required this.values,
    required this.selected,
    required this.label,
    required this.onChanged,
    this.selectedColor,
    this.selectedForeground,
  });
  final double width;
  final List<T> values;
  final T selected;
  final String Function(T value) label;
  final ValueChanged<T> onChanged;
  final Color? selectedColor;
  final Color? selectedForeground;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final widths = width < 140 ? const [56.0, 55.0] : const [77.0, 63.0];
    final selectedIndex = values.indexOf(selected);
    final selectionLeft = selectedIndex == 0 ? 0.0 : widths.first + 4.0;
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Container(
        width: width,
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.subtleSurface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              left: selectionLeft,
              top: 0,
              width: widths[selectedIndex],
              height: 36,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selectedColor ?? colors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var index = 0; index < values.length; index++)
                  SizedBox(
                    width: widths[index],
                    height: 36,
                    child: Semantics(
                      button: true,
                      inMutuallyExclusiveGroup: true,
                      selected: selected == values[index],
                      label: label(values[index]),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => onChanged(values[index]),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOutCubic,
                              style: Theme.of(context).textTheme.labelMedium!
                                  .copyWith(
                                    color: selected == values[index]
                                        ? selectedForeground ??
                                              colors.primaryText
                                        : colors.secondaryText,
                                    fontWeight: selected == values[index]
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                              child: Text(
                                label(values[index]),
                                textAlign: TextAlign.center,
                              ),
                            ),
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

class _PercentageSlider extends StatelessWidget {
  const _PercentageSlider({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return LayoutBuilder(
      builder: (context, constraints) {
        const badgeWidth = 36.0;
        final badgeLeft = (constraints.maxWidth - badgeWidth) * (value / 100);
        return SizedBox(
          height: 20,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: colors.primaryAction,
                  inactiveTrackColor: colors.surface,
                  trackHeight: 8,
                  thumbColor: colors.primaryAction,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 0,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: Slider(
                  key: const Key('bstocks-percentage-slider'),
                  value: value.toDouble(),
                  max: 100,
                  onChanged: onChanged,
                ),
              ),
              for (final stop in const [25.0, 50.0, 75.0])
                Positioned(
                  left: (constraints.maxWidth - 6) * (stop / 100),
                  child: IgnorePointer(
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: colors.subtleSurface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              Positioned(
                left: badgeLeft,
                child: IgnorePointer(
                  child: Container(
                    width: badgeWidth,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.primaryAction,
                      border: Border.all(color: colors.surface, width: 2),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Text(
                      '${value.round()}%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OutlinedSummaryRow extends StatelessWidget {
  const _OutlinedSummaryRow({required this.label, required this.value});

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: colors.secondaryText)),
          value,
        ],
      ),
    );
  }
}

class _LoadingSummaryRow extends StatelessWidget {
  const _LoadingSummaryRow({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        const SkeletonBlock(width: 52, height: 14, radius: 4),
      ],
    ),
  );
}

class _SlippageRow extends StatelessWidget {
  const _SlippageRow({required this.value, required this.onEdit});

  final double value;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Slippage',
              style: TextStyle(color: colors.secondaryText),
            ),
          ),
          Text('$value%', style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(width: 2),
          IconButton(
            key: const Key('bstocks-edit-slippage'),
            tooltip: 'Edit slippage',
            onPressed: onEdit,
            icon: const Icon(Icons.edit_outlined, size: 16),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _SlippageSheet extends StatefulWidget {
  const _SlippageSheet({required this.initialValue});

  final double initialValue;

  @override
  State<_SlippageSheet> createState() => _SlippageSheetState();
}

class _SlippageSheetState extends State<_SlippageSheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue.toString(),
  );
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _confirm() {
    final value = double.tryParse(_controller.text.trim());
    if (value == null || !value.isFinite || value < 0 || value > 100) {
      setState(() => _error = 'Enter a slippage percentage from 0% to 100%.');
      return;
    }
    Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) => Material(
    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
    child: SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          24 + MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Slippage tolerance',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            TextField(
              key: const Key('bstocks-slippage-input'),
              controller: _controller,
              autofocus: true,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                TextInputFormatter.withFunction((oldValue, newValue) {
                  return RegExp(r'^(?:|0|[1-9]\d{0,2})(?:\.\d{0,2})?$')
                          .hasMatch(newValue.text)
                      ? newValue
                      : oldValue;
                }),
              ],
              decoration: InputDecoration(
                labelText: 'Maximum slippage',
                suffixText: '%',
                errorText: _error,
              ),
              onChanged: (_) {
                if (_error != null) setState(() => _error = null);
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                for (final option in const [0.1, 0.5, 1.0])
                  ChoiceChip(
                    label: Text('$option%'),
                    selected: _controller.text == option.toString(),
                    onSelected: (_) => setState(() {
                      _controller.text = option.toString();
                      _error = null;
                    }),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: _confirm,
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    ),
  );
}

class _OrderFailureNotice extends StatelessWidget {
  const _OrderFailureNotice({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 44),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: semantic.loss),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/figma/trade/order_failed.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(message, style: TextStyle(color: colors.primaryText)),
            ),
          ],
        ),
      ),
    );
  }
}
