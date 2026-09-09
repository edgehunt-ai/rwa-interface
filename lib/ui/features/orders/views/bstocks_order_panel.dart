import 'package:flutter/material.dart';
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
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';

part 'bstocks_funding_required.dart';
part 'bstocks_transfer_flow.dart';

DecimalValue _decimalFromCents(int cents) {
  final negative = cents.isNegative;
  final digits = cents.abs().toString().padLeft(3, '0');
  final value =
      '${digits.substring(0, digits.length - 2)}.'
      '${digits.substring(digits.length - 2)}';
  return DecimalValue(negative ? '-$value' : value, asset: 'USD', unit: 'fiat');
}

int? _centsFromPrice(String input) {
  final match = RegExp(r'^(\d+)(?:\.(\d{1,2}))?$').firstMatch(input.trim());
  if (match == null) return null;
  final whole = int.tryParse(match.group(1)!);
  if (whole == null) return null;
  final fraction = (match.group(2) ?? '').padRight(2, '0');
  return whole * 100 + int.parse(fraction);
}

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
  static const _marketPriceCents = 18800;
  final amount = TextEditingController();
  final limitPrice = TextEditingController();
  late TradingSide side;
  var type = TradingOrderType.market;
  var percentage = 20;
  OrderPreview? preview;
  TradingOrder? submittedOrder;
  String? error;
  bool reviewing = false;

  @override
  void initState() {
    super.initState();
    side = widget.initialSide;
  }

  @override
  void dispose() {
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
    DecimalValue? price;
    if (type == TradingOrderType.limit) {
      final rawPrice = limitPrice.text.trim();
      if (rawPrice.isEmpty || !_isDecimal(rawPrice)) {
        setState(() => error = 'Enter a valid limit price.');
        return;
      }
      price = DecimalValue(rawPrice, asset: 'USD', unit: 'fiat');
    }
    final sellsBstocks = side == TradingSide.sell;
    final intent = OrderIntent(
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
      limitPrice: price,
    );
    final requestedAmount = DecimalValue(
      amountValue,
      asset: 'USDT',
      unit: 'token',
    );
    final availableBalance = DecimalValue('1000', asset: 'USDT', unit: 'token');
    if (type == TradingOrderType.market &&
        requestedAmount.compareTo(availableBalance) > 0) {
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (sheetContext) => BstocksFundingRequiredSheet(
          amountNeeded: requestedAmount,
          onInAppTransfer: () async {
            Navigator.of(sheetContext).pop();
            setState(() {
              error = null;
              reviewing = true;
            });
            try {
              final plannedOrder = await ref.read(
                orderPreviewProvider(intent).future,
              );
              final plan = await ref
                  .read(fundingTransferCommandsProvider)
                  .plan(tradePreviewId: plannedOrder.previewId);
              if (!mounted) return;
              await showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => BstocksTransferFlowSheet(
                  amountNeeded: requestedAmount,
                  plan: plan,
                  orderPreview: plannedOrder,
                  symbol: widget.symbol,
                ),
              );
            } on Object {
              if (mounted) {
                setState(() => error = 'Unable to prepare funding. Try again.');
              }
            } finally {
              if (mounted) setState(() => reviewing = false);
            }
          },
          onExternalDeposit: () {
            Navigator.of(sheetContext).pop();
            context.pushNamed(AppRoutes.depositName);
          },
        ),
      );
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

  Future<void> _selectOrderType(TradingOrderType nextType) async {
    if (nextType == type) return;
    if (nextType == TradingOrderType.market) {
      setState(() => type = nextType);
      return;
    }

    final selectedPrice = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      builder: (_) => BstocksLimitPriceSheet(
        marketPriceCents: _marketPriceCents,
        initialPriceCents:
            _centsFromPrice(limitPrice.text) ?? _marketPriceCents,
      ),
    );
    if (!mounted) return;
    setState(() {
      type = TradingOrderType.limit;
      // Back deliberately discards slider changes and uses the current market
      // price, as annotated in the Figma limit-price sheet.
      limitPrice.text = TokenAmountFormatter.formatFixed(
        _decimalFromCents(selectedPrice ?? _marketPriceCents),
        decimals: 2,
      );
    });
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

  Widget _form(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Theme.of(context).extension<AppSemanticColors>()!.success,
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
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _ChoiceRow<TradingSide>(
        values: const [TradingSide.buy, TradingSide.sell],
        selected: side,
        label: (value) => value == TradingSide.buy ? 'Buy' : 'Sell',
        onChanged: (value) => setState(() => side = value),
      ),
      const SizedBox(height: 8),
      _ChoiceRow<TradingOrderType>(
        values: const [TradingOrderType.market, TradingOrderType.limit],
        selected: type,
        label: (value) => value == TradingOrderType.market ? 'Market' : 'Limit',
        onChanged: _selectOrderType,
      ),
      const SizedBox(height: 12),
      TextField(
        controller: amount,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          labelText: type == TradingOrderType.market
              ? side == TradingSide.sell
                    ? 'Amount'
                    : 'Order Value'
              : 'Quantity',
          suffixText: type == TradingOrderType.market && side == TradingSide.buy
              ? 'USDT'
              : widget.symbol,
          helperText: side == TradingSide.sell
              ? 'Balance: 400'
              : 'Balance: 1,000',
        ),
      ),
      Slider(
        value: percentage.toDouble(),
        max: 100,
        divisions: 5,
        label: '$percentage%',
        onChanged: (value) => setState(() => percentage = value.round()),
      ),
      if (type == TradingOrderType.limit) ...[
        TextField(
          controller: limitPrice,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Limit Price',
            prefixText: r'$',
          ),
        ),
      ],
      _BstocksTpSlUnavailable(
        onTap: () => setState(
          () => error = AppLocalizations.of(context).bstocksTpSlUnavailable,
        ),
      ),
      const SizedBox(height: 8),
      _SummaryRow(label: 'You will receive', value: '— ${widget.symbol}'),
      const Divider(),
      const _SummaryRow(label: 'Slippage', value: '0.12%'),
      _SummaryRow(label: 'Estimated Fee', value: '0.5 ${widget.symbol}'),
      if (error case final error?) ...[
        const SizedBox(height: 12),
        _OrderFailureNotice(message: error),
      ],
      const SizedBox(height: 16),
      FilledButton(
        onPressed: reviewing ? null : _review,
        child: Text(
          reviewing
              ? 'Preparing order…'
              : '${side == TradingSide.buy ? 'Buy' : 'Sell'} ${widget.symbol}',
        ),
      ),
    ],
  );

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
        value: TokenAmountFormatter.format(preview!.orderValue, symbol: 'USDT'),
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

class BstocksLimitPriceSheet extends StatefulWidget {
  const BstocksLimitPriceSheet({
    super.key,
    required this.marketPriceCents,
    required this.initialPriceCents,
  });

  final int marketPriceCents;
  final int initialPriceCents;

  @override
  State<BstocksLimitPriceSheet> createState() => _BstocksLimitPriceSheetState();
}

class _BstocksLimitPriceSheetState extends State<BstocksLimitPriceSheet> {
  static const _minimumPriceCents = 15000;
  static const _maximumPriceCents = 22600;
  late int priceCents;

  @override
  void initState() {
    super.initState();
    priceCents = widget.initialPriceCents.clamp(
      _minimumPriceCents,
      _maximumPriceCents,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final deviationBasisPoints =
        ((priceCents - widget.marketPriceCents) * 10000) ~/
        widget.marketPriceCents;
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.chevron_left),
                    tooltip: l10n.back,
                  ),
                  Text(
                    l10n.limitPrice,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(l10n.limitPrice, textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Text(
                TokenAmountFormatter.formatUsd(_decimalFromCents(priceCents)),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Center(child: Chip(label: Text(l10n.market))),
              const SizedBox(height: 20),
              Semantics(
                label: l10n.dragToSet,
                child: Slider(
                  value: priceCents.toDouble(),
                  min: _minimumPriceCents.toDouble(),
                  max: _maximumPriceCents.toDouble(),
                  divisions: 76 * 100,
                  label: TokenAmountFormatter.formatUsd(
                    _decimalFromCents(priceCents),
                  ),
                  onChanged: (value) =>
                      setState(() => priceCents = value.round()),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${l10n.market} ${TokenAmountFormatter.formatUsd(_decimalFromCents(widget.marketPriceCents))}',
                  ),
                  Text(
                    '${l10n.priceDeviation} ${TokenAmountFormatter.formatPercent(DecimalValue((deviationBasisPoints ~/ 100).toString(), asset: '%', unit: 'percent'))}',
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.back),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).pop(priceCents),
                      child: Text(l10n.confirm),
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
}

class _BstocksTpSlUnavailable extends StatelessWidget {
  const _BstocksTpSlUnavailable({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.takeProfitStopLoss,
      child: TextButton.icon(
        onPressed: onTap,
        icon: const Icon(Icons.add_circle_outline, size: 20),
        label: Text('${l10n.takeProfitStopLoss} · ${l10n.add}'),
      ),
    );
  }
}

bool _isDecimal(String value) {
  try {
    DecimalValue(value);
    return true;
  } on FormatException {
    return false;
  }
}

class _ChoiceRow<T> extends StatelessWidget {
  const _ChoiceRow({
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
  Widget build(BuildContext context) => Row(
    children: [
      for (final value in values)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: ChoiceChip(
              label: Text(label(value)),
              selected: selected == value,
              onSelected: (_) => onChanged(value),
            ),
          ),
        ),
    ],
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
