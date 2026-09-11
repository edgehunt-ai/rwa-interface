import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
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
    final available = double.tryParse(
      _availableAmount(
            side: side,
            symbol: widget.symbol,
            portfolio: ref.read(portfolioSummaryProvider).value,
            holdings: ref.read(holdingsProvider(null)).value?.items,
          )?.value ??
          '',
    );
    final entered = double.tryParse(amount.text.trim());
    final nextPercentage =
        available == null ||
            available <= 0 ||
            entered == null ||
            !entered.isFinite ||
            entered < 0
        ? 0.0
        : (entered / available * 100).clamp(0.0, 100.0);
    setState(() => percentage = nextPercentage);
    _scheduleQuote();
  }

  void _updateAmountFromPercentage(
    double value,
    Portfolio? portfolio,
    List<HoldingGroup>? holdings,
  ) {
    final available = double.tryParse(
      _availableAmount(
            side: side,
            symbol: widget.symbol,
            portfolio: portfolio,
            holdings: holdings,
          )?.value ??
          '',
    );
    if (available == null) {
      setState(() => percentage = value);
      return;
    }
    if (available <= 0) {
      setState(() => percentage = 0);
      return;
    }

    final nextAmount = available * value / 100;
    final nextText = _formatInputAmount(nextAmount);
    amount.value = TextEditingValue(
      text: nextText,
      selection: TextSelection.collapsed(offset: nextText.length),
    );
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
      await _prepareConfirmation(cachedQuote!);
      return;
    }
    setState(() {
      error = null;
      reviewing = true;
    });
    try {
      final next = await ref.read(orderPreviewProvider(intent).future);
      await _prepareConfirmation(next);
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

  Future<void> _prepareConfirmation(OrderPreview next) async {
    if (_hasSufficientDisplayedBalance(next)) {
      if (mounted) {
        setState(() {
          error = null;
          preview = next;
        });
      }
      return;
    }

    try {
      final plan = await ref
          .read(fundingTransferCommandsProvider)
          .plan(tradePreviewId: next.previewId);
      if (!mounted) return;
      if (plan.status == FundingPlanState.alreadyFunded) {
        setState(() {
          error = null;
          preview = next;
        });
        return;
      }
      await _showFundingRequired(plan: plan, orderPreview: next);
    } on Object {
      if (mounted) {
        setState(() {
          error = 'Unable to prepare funding for this order. Try again.';
        });
      }
    }
  }

  bool _hasSufficientDisplayedBalance(OrderPreview next) {
    final available = ref
        .read(portfolioSummaryProvider)
        .value
        ?.availableToTradeUsd;
    if (available == null) return true;
    try {
      final orderValueUsd = DecimalValue(
        next.orderValue.value,
        asset: 'USD',
        unit: 'fiat',
      );
      return available.compareTo(orderValueUsd) >= 0;
    } on ArgumentError {
      return true;
    }
  }

  Future<void> _showFundingRequired({
    required FundingPlan plan,
    required OrderPreview orderPreview,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => BstocksFundingRequiredSheet(
        amountNeeded: plan.shortfall,
        onInAppTransfer: plan.isActionable
            ? () {
                Navigator.of(sheetContext).pop();
                _showTransfer(plan: plan, orderPreview: orderPreview);
              }
            : null,
        onExternalDeposit: () {
          Navigator.of(sheetContext).pop();
          GoRouter.of(context).pushNamed(
            AppRoutes.depositName,
            queryParameters: const {'chain': 'BSC', 'token': 'USDT'},
          );
        },
      ),
    );
  }

  Future<void> _showTransfer({
    required FundingPlan plan,
    required OrderPreview orderPreview,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => BstocksTransferFlowSheet(
      amountNeeded: plan.shortfall,
      plan: plan,
      orderPreview: orderPreview,
      symbol: widget.symbol,
      onClose: () => Navigator.of(context).pop(),
    ),
  );

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
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final success = Theme.of(context).extension<AppSemanticColors>()!.success;
    final isBuy = side == TradingSide.buy;
    final amountAsset = type == TradingOrderType.market && isBuy
        ? quotePreview?.settlementAsset ?? 'USDT'
        : widget.symbol;
    final enteredAmount = amount.text.trim();
    final buttonAmount = enteredAmount.isEmpty ? '0' : enteredAmount;
    final portfolio = ref.watch(portfolioSummaryProvider);
    final holdings = ref.watch(holdingsProvider(null));
    final availableAmount = _availableAmount(
      side: side,
      symbol: widget.symbol,
      portfolio: portfolio.value,
      holdings: holdings.value?.items,
    );
    final balance = availableAmount == null
        ? null
        : isBuy
        ? TokenAmountFormatter.formatUsd(availableAmount)
        : '${TokenAmountFormatter.formatValue(availableAmount)} ${widget.symbol}';
    final balanceLoading = isBuy ? portfolio.isLoading : holdings.isLoading;
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
                '${side == TradingSide.buy ? l10n.buy : l10n.sell} ${widget.symbol}',
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
                label: (value) => value == TradingSide.buy ? l10n.buy : l10n.sell,
                onChanged: (value) {
                  setState(() => side = value);
                  amount.clear();
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
                          ? l10n.orderValue
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
                          '${l10n.balance}: ',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (balanceLoading)
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
                  onChanged: (value) => _updateAmountFromPercentage(
                    value,
                    portfolio.value,
                    holdings.value?.items,
                  ),
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
                labelText: l10n.limitPrice,
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
                            symbol: receive.asset ?? widget.symbol,
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
            _LoadingSummaryRow(label: l10n.estimatedFee)
          else
            _SummaryRow(
              label: l10n.estimatedFee,
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
                    : '${isBuy ? l10n.buy : l10n.sell} ${widget.symbol} · ${isBuy ? '\$' : ''}$buttonAmount',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _preview(BuildContext context) {
    final current = preview!;
    final isBuy = current.intent.side == TradingSide.buy;
    final action = isBuy ? 'Buy' : 'Sell';
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final success = Theme.of(context).extension<AppSemanticColors>()!.success;
    final settlementAsset =
        current.orderValue.asset ?? current.settlementAsset ?? 'USDT';
    final marketPrice = current.marketPrice;
    final marketPriceDisplay = marketPrice == null
        ? null
        : switch (current.estimatedPrice) {
            final estimatedPrice?
                when estimatedPrice.value != marketPrice.value =>
              '${TokenAmountFormatter.formatUsd(marketPrice)} → ${TokenAmountFormatter.formatUsd(estimatedPrice)}',
            _ => TokenAmountFormatter.formatUsd(marketPrice),
          };

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: colors.secondaryText.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          '$action ${widget.symbol}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Divider(color: colors.subtleSurface),
        const SizedBox(height: 16),
        Text(
          '$action ${widget.symbol} · ${current.intent.type == TradingOrderType.market ? 'Market' : 'Limit'}',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        _BstocksConfirmationConversion(
          payment: TokenAmountFormatter.format(
            current.orderValue,
            symbol: settlementAsset,
          ),
          paymentAsset: settlementAsset,
          receive: current.estimatedQuantity == null
              ? '—'
              : TokenAmountFormatter.format(
                  current.estimatedQuantity!,
                  symbol: current.estimatedQuantity!.asset ?? widget.symbol,
                ),
          receiveAsset: widget.symbol,
        ),
        const SizedBox(height: 12),
        _SummaryRow(
          label: 'Order Type',
          value: current.intent.type == TradingOrderType.market
              ? 'Market'
              : 'Limit',
        ),
        if (marketPriceDisplay case final price?)
          _SummaryRow(
            label: AppLocalizations.of(context).marketPrice,
            value: price,
          ),
        _SummaryRow(
          label: 'Slippage',
          value: '${current.intent.slippage?.value ?? slippage}%',
        ),
        if (current.fee case final fee?)
          _SummaryRow(
            label: 'Estimated Fee',
            value: TokenAmountFormatter.format(
              fee,
              symbol: fee.asset ?? widget.symbol,
            ),
          ),
        if (current.priceUpdated) ...[
          const SizedBox(height: 8),
          const Text(
            'Price changed. Review the updated estimate before submitting.',
          ),
        ],
        if (error case final message?) ...[
          const SizedBox(height: 8),
          _OrderFailureNotice(message: message),
        ],
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: OutlinedButton(
                  onPressed: () => setState(() => preview = null),
                  child: const Text('Back'),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: success),
                  onPressed: reviewing ? null : _submit,
                  child: Text(
                    reviewing ? 'Submitting order…' : 'Confirm $action',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

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

DecimalValue? _availableAmount({
  required TradingSide side,
  required String symbol,
  required Portfolio? portfolio,
  required List<HoldingGroup>? holdings,
}) {
  if (side == TradingSide.buy) return portfolio?.availableToTradeUsd;
  if (holdings == null) return null;
  final underlying = symbol.endsWith('B')
      ? symbol.substring(0, symbol.length - 1)
      : symbol;
  final quantities = holdings
      .where(
        (holding) => holding.symbol == underlying || holding.symbol == symbol,
      )
      .expand((holding) => holding.positions)
      .map((position) => position.quantity)
      .toList(growable: false);
  if (quantities.isEmpty) {
    return DecimalValue('0', asset: symbol, unit: 'token');
  }
  final scale = quantities.fold<int>(
    0,
    (current, quantity) => current > quantity.scale ? current : quantity.scale,
  );
  var total = BigInt.zero;
  for (final quantity in quantities) {
    final parts = quantity.value.split('.');
    final digits = '${parts.first}${parts.length == 1 ? '' : parts.last}'
        .padRight(parts.first.length + scale, '0');
    total += BigInt.parse(digits);
  }
  final digits = total.toString().padLeft(scale + 1, '0');
  final value = scale == 0
      ? digits
      : '${digits.substring(0, digits.length - scale)}.'
            '${digits.substring(digits.length - scale)}';
  return DecimalValue(value, asset: symbol, unit: 'token');
}

String _formatInputAmount(double value) {
  final fixed = value.toStringAsFixed(8);
  return fixed.replaceFirst(RegExp(r'\.?0+$'), '');
}

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            softWrap: true,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

class _BstocksConfirmationConversion extends StatelessWidget {
  const _BstocksConfirmationConversion({
    required this.payment,
    required this.paymentAsset,
    required this.receive,
    required this.receiveAsset,
  });

  final String payment;
  final String paymentAsset;
  final String receive;
  final String receiveAsset;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: _BstocksConfirmationAmountCard(
                value: payment,
                asset: paymentAsset,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _BstocksConfirmationAmountCard(
                value: receive,
                asset: receiveAsset,
                alignEnd: true,
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Theme.of(context).extension<AppRwaColors>()!.canvas,
          border: Border.all(
            color: Theme.of(context).extension<AppRwaColors>()!.surface,
            width: 4,
          ),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_forward, size: 16),
      ),
    ],
  );
}

class _BstocksConfirmationAmountCard extends StatelessWidget {
  const _BstocksConfirmationAmountCard({
    required this.value,
    required this.asset,
    this.alignEnd = false,
  });

  final String value;
  final String asset;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      constraints: const BoxConstraints(minHeight: 74),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.canvas,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: alignEnd
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: alignEnd
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!alignEnd) _BstocksConfirmationAssetMark(asset: asset),
              if (!alignEnd) const SizedBox(width: 4),
              Flexible(
                child: Text(
                  value,
                  textAlign: alignEnd ? TextAlign.end : TextAlign.start,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (alignEnd) const SizedBox(width: 4),
              if (alignEnd) _BstocksConfirmationAssetMark(asset: asset),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            asset,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.secondaryText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _BstocksConfirmationAssetMark extends StatelessWidget {
  const _BstocksConfirmationAssetMark({required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    if (asset == 'USDT') {
      return Image.asset(
        'assets/figma/trade/usdt_mark.png',
        width: 20,
        height: 20,
      );
    }
    if (asset == 'NVDAB' || asset == 'NVDA') {
      return Container(
        width: 20,
        height: 20,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: colors.border),
        ),
        child: SvgPicture.asset(
          'assets/figma/trade/nvidia.svg',
          width: 11,
          height: 11,
        ),
      );
    }
    return Container(
      width: 20,
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: colors.surface, shape: BoxShape.circle),
      child: Text(asset.substring(0, 1), style: const TextStyle(fontSize: 10)),
    );
  }
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
