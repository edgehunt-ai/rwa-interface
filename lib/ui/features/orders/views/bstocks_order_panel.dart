import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/application_state.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

import 'order_funding_sheet.dart';
import 'slippage_controls.dart';

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
  var _percentageWaitingForAmount = false;
  var _percentageSyncScheduled = false;
  var slippage = 0.12;
  OrderPreview? preview;
  OrderPreview? quotePreview;
  TradingOrder? submittedOrder;
  String? error;
  bool reviewing = false;
  Timer? _quoteDebounce;
  Timer? _previewPollingTimer;
  var _quoteGeneration = 0;
  var _previewPollingGeneration = 0;
  var _refreshingPreview = false;
  var _quoting = false;
  DecimalValue? _liveMarketPrice;
  late final OrderCommandNotifier _orderCommands;

  @override
  void initState() {
    super.initState();
    _orderCommands = ref.read(orderCommandProvider.notifier);
    side = widget.initialSide;
    amount.addListener(_refreshAmount);
    limitPrice.addListener(_scheduleQuote);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.invalidate(tradingAccountsProvider);
        ref.invalidate(bstocksOrderAvailableBalanceProvider);
      }
    });
  }

  void _refreshAmount() {
    _percentageWaitingForAmount = false;
    final available = double.tryParse(
      _availableAmount(
            side: side,
            symbol: widget.symbol,
            availableBalance: ref
                .read(bstocksOrderAvailableBalanceProvider)
                .value,
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
    DecimalValue? availableBalance,
    List<HoldingGroup>? holdings,
  ) {
    final available = double.tryParse(
      _availableAmount(
            side: side,
            symbol: widget.symbol,
            availableBalance: availableBalance,
            holdings: holdings,
          )?.value ??
          '',
    );
    if (available == null) {
      setState(() {
        percentage = value;
        _percentageWaitingForAmount = true;
      });
      return;
    }
    if (available <= 0) {
      setState(() {
        percentage = 0;
        _percentageWaitingForAmount = false;
      });
      return;
    }

    final nextAmount = available * value / 100;
    final nextText = _formatInputAmount(
      nextAmount,
      available: available,
      percentage: value,
    );
    _percentageWaitingForAmount = false;
    amount.value = TextEditingValue(
      text: nextText,
      selection: TextSelection.collapsed(offset: nextText.length),
    );
  }

  void _schedulePendingPercentageSync({
    required DecimalValue? availableBalance,
    required List<HoldingGroup>? holdings,
  }) {
    if (!_percentageWaitingForAmount || _percentageSyncScheduled) return;
    final available = double.tryParse(
      _availableAmount(
            side: side,
            symbol: widget.symbol,
            availableBalance: availableBalance,
            holdings: holdings,
          )?.value ??
          '',
    );
    if (available == null || available <= 0) return;
    _percentageSyncScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _percentageSyncScheduled = false;
      if (!mounted || !_percentageWaitingForAmount) return;
      _updateAmountFromPercentage(percentage, availableBalance, holdings);
    });
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
      } on Object catch (quoteError) {
        if (mounted && generation == _quoteGeneration) {
          setState(() {
            quotePreview = null;
            _quoting = false;
            error = _errorMessage(
              error: quoteError,
              fallback: AppLocalizations.of(context).prepareOrderFailed,
            );
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _orderCommands.cancelSubmission();
    _quoteDebounce?.cancel();
    _previewPollingTimer?.cancel();
    amount.removeListener(_refreshAmount);
    limitPrice.removeListener(_scheduleQuote);
    amount.dispose();
    limitPrice.dispose();
    super.dispose();
  }

  Future<void> _review() async {
    final amountValue = amount.text.trim();
    if (amountValue.isEmpty || !_isDecimal(amountValue)) {
      setState(() => error = AppLocalizations.of(context).validOrderValue);
      return;
    }
    if (type == TradingOrderType.limit &&
        (limitPrice.text.trim().isEmpty ||
            !_isDecimal(limitPrice.text.trim()))) {
      setState(() => error = AppLocalizations.of(context).validLimitPrice);
      return;
    }
    final intent = _intentFromFields()!;
    if (reviewing) return;
    final cachedQuote = quotePreview;
    setState(() {
      error = null;
      reviewing = true;
    });
    try {
      final next =
          cachedQuote?.intent.fingerprint == intent.fingerprint &&
              cachedQuote?.isExpired == false
          ? cachedQuote!
          : await ref.read(orderPreviewProvider(intent).future);
      if (!mounted) return;
      if (!next.executionReady) {
        setState(() {
          quotePreview = next;
          error = '预览费用和预估数量可用，但缺少下单所需的确认绑定，暂时不能提交订单。';
        });
        return;
      }
      await _prepareConfirmation(next);
    } on Object catch (error) {
      if (mounted) {
        setState(
          () => this.error = _errorMessage(
            error: error,
            fallback: AppLocalizations.of(context).prepareOrderFailed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => reviewing = false);
      }
    }
  }

  Future<void> _prepareConfirmation(OrderPreview next) async {
    if (next.intent.side == TradingSide.sell) {
      if (mounted) {
        _showConfirmation(next);
      }
      return;
    }

    try {
      final accounts = await _readTradingAccountsForFundingCheck();
      final sufficient = _hasSufficientSettlementBalance(next, accounts);
      debugPrint(
        'bStocks prepare: preview=${next.previewId} '
        'asset=${next.settlementAsset} chain=${next.settlementChain} '
        'orderValue=${next.orderValue.value}/${next.orderValue.asset}/${next.orderValue.unit} '
        'fee=${next.fee?.value}/${next.fee?.asset}/${next.fee?.unit} '
        'accounts=${accounts.length} sufficient=$sufficient',
      );
      if (sufficient) {
        if (mounted) {
          _showConfirmation(next);
        }
        return;
      }
      debugPrint(
        'bStocks prepare: requesting funding plan '
        'preview=${next.previewId}',
      );
      final plan = await ref
          .read(fundingTransferCommandsProvider)
          .plan(tradePreviewId: next.previewId);
      if (!mounted) return;
      if (plan.status == FundingPlanState.alreadyFunded) {
        _showConfirmation(next);
        return;
      }
      final funded = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false,
        builder: (_) => OrderFundingSheet(plan: plan, kind: next.intent.kind),
      );
      if (!mounted || funded != true) return;
      ref.invalidate(orderPreviewProvider(next.intent));
      final refreshed = await ref.read(
        orderPreviewProvider(next.intent).future,
      );
      if (mounted) await _prepareConfirmation(refreshed);
    } on Object {
      rethrow;
    }
  }

  String _errorMessage({required Object error, required String fallback}) {
    if (error is ApiFailure) {
      return apiFailureMessage(error, fallback: fallback);
    }
    final message = error.toString().trim();
    return message.isEmpty ? fallback : message;
  }

  void _showConfirmation(OrderPreview next) {
    _previewPollingTimer?.cancel();
    _previewPollingGeneration++;
    _liveMarketPrice = next.marketPrice;
    setState(() {
      error = null;
      preview = next;
    });
    _startPreviewPolling(next);
  }

  void _startPreviewPolling(OrderPreview next) {
    if (next.intent.type != TradingOrderType.market) return;
    final generation = ++_previewPollingGeneration;

    Future<void> refresh() async {
      if (!mounted ||
          preview?.previewId != next.previewId ||
          generation != _previewPollingGeneration ||
          _refreshingPreview) {
        return;
      }
      _refreshingPreview = true;
      try {
        final provider = orderPreviewProvider(next.intent);
        ref.invalidate(provider);
        final refreshed = await ref.read(provider.future);
        if (mounted &&
            preview?.previewId == next.previewId &&
            generation == _previewPollingGeneration) {
          // The preview ID binds the quote used by both the initial order
          // creation and the post-approval order recreation. Keep the full
          // refreshed preview, not only its display price, so submissions do
          // not send an expired or stale preview ID.
          setState(() {
            preview = refreshed;
            _liveMarketPrice = refreshed.marketPrice;
          });
        }
      } on Object {
        // Keep the last confirmed preview price when a transient refresh fails.
      } finally {
        _refreshingPreview = false;
      }
    }

    refresh();
    _previewPollingTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => refresh(),
    );
  }

  void _stopPreviewPolling() {
    _previewPollingTimer?.cancel();
    _previewPollingTimer = null;
    _previewPollingGeneration++;
    _liveMarketPrice = null;
  }

  bool _samePrice(DecimalValue left, DecimalValue right) {
    try {
      return DecimalValue(left.value)
              .compareMagnitudeTo(DecimalValue(right.value)) ==
          0;
    } on ArgumentError {
      return left.value == right.value;
    }
  }

  bool _hasSufficientSettlementBalance(
    OrderPreview preview,
    List<TradingAccount> accounts,
  ) {
    // bStocks settles through the BSC account. Match both the asset and chain
    // so a same-symbol balance on another network cannot satisfy the check.
    final asset = preview.settlementAsset ?? preview.orderValue.asset;
    if (asset == null) {
      debugPrint(
        'bStocks funding check skipped: missing settlement asset '
        'previewAsset=${preview.settlementAsset} '
        'orderValueAsset=${preview.orderValue.asset} '
        'settlementChain=${preview.settlementChain}',
      );
      return false;
    }
    try {
      final fee = preview.fee;
      // fee_asset belongs to network_fee. The fee field itself is included
      // when it is denominated in the settlement asset.
      final required =
          fee == null ||
              fee.asset?.toLowerCase() !=
                  preview.orderValue.asset?.toLowerCase()
          ? preview.orderValue
          : preview.orderValue.plusMagnitude(fee);
      final balances = accounts
          .where(
            (account) =>
                account.kind == TradingAccountKind.bstocks &&
                _sameChain(account.chain, preview.settlementChain),
          )
          .expand((account) => account.balances)
          .where(
            (balance) =>
                balance.symbol.toLowerCase() == asset.toLowerCase() &&
                _sameChain(balance.chain, preview.settlementChain),
          )
          .map((balance) => balance.balance);
      final balance = balances.firstOrNull;
      final sufficient =
          balance != null && balance.compareMagnitudeTo(required) >= 0;
      debugPrint(
        'bStocks funding check: '
        'asset=$asset required=${required.value} '
        'matchedBalance=${balance?.value} sufficient=$sufficient '
        'accounts=${accounts.map((account) => '${account.kind}:'
            '${account.balances.map((item) => '${item.symbol}@${item.chain}=${item.balance.value}').join(',')}').join(';')}',
      );
      return sufficient;
    } on ArgumentError {
      // Different units cannot prove that the settlement balance is enough.
      // Fall through to the server funding plan instead of failing locally.
      return false;
    }
  }

  bool _sameChain(String? left, String? right) {
    if (right == null || right.isEmpty) return true;
    if (left == null || left.isEmpty) return false;
    return left.toLowerCase() == right.toLowerCase();
  }

  Future<List<TradingAccount>> _readTradingAccountsForFundingCheck() async {
    try {
      return await ref.read(tradingAccountsProvider.future);
    } on Object catch (failure) {
      debugPrint(
        'bStocks prepare: trading account check unavailable: $failure',
      );
      return const [];
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
          ? DecimalValue(
              amountValue,
              asset: _settlementAssetForInput,
              unit: 'token',
            )
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

  String get _settlementAssetForInput =>
      quotePreview?.settlementAsset ?? 'TUSDT';

  Future<void> _submit() async {
    final current = preview;
    if (current == null) return;
    debugPrint(
      'bStocks submit: started preview=${current.previewId} '
      'intent=${current.intent.fingerprint}',
    );
    _stopPreviewPolling();
    setState(() {
      error = null;
      reviewing = true;
    });
    final result = await ref
        .read(orderCommandProvider.notifier)
        .submit(current.intent, previewId: current.previewId);
    debugPrint(
      'bStocks submit: completed preview=${current.previewId} '
      'success=${result != null}',
    );
    if (!mounted) return;
    setState(() {
      reviewing = false;
      if (result == null) {
        final state = ref.read(orderCommandProvider);
        final failure =
            state is CommandFailure<OrderIntent, ResourceResult<TradingOrder>>
            ? state.failure
            : const CompatibilityFailure();
        error = apiFailureMessage(
          failure,
          fallback: AppLocalizations.of(context).orderSubmissionFailed,
        );
      } else {
        submittedOrder = result.resource;
      }
    });
  }

  Future<void> _editSlippage() async {
    final next = await showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SlippageSheet(
        initialValue: slippage,
        inputKey: const Key('bstocks-slippage-input'),
      ),
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
    final settlementAsset = quotePreview?.settlementAsset ?? 'TUSDT';
    final settlementBalance = ref.watch(
      bstocksSettlementBalanceProvider(settlementAsset),
    );
    final amountAsset = type == TradingOrderType.market && isBuy
        ? settlementAsset
        : widget.symbol;
    final enteredAmount = amount.text.trim();
    final buttonAmount = enteredAmount.isEmpty ? '0' : enteredAmount;
    final availableBalance = settlementBalance;
    final holdings = ref.watch(holdingsProvider(null));
    _schedulePendingPercentageSync(
      availableBalance: availableBalance.value,
      holdings: holdings.value?.items,
    );
    final availableAmount = _availableAmount(
      side: side,
      symbol: widget.symbol,
      availableBalance: availableBalance.value,
      holdings: holdings.value?.items,
    );
    final balance = availableAmount == null
        ? null
        : isBuy
        ? '${TokenAmountFormatter.formatValue(availableAmount)} $settlementAsset'
        : '${TokenAmountFormatter.formatValue(availableAmount)} ${widget.symbol}';
    final balanceLoading = isBuy
        ? availableBalance.isLoading || availableBalance.isRefreshing
        : holdings.isLoading;
    final receive =
        quotePreview?.estimatedReceive ?? quotePreview?.estimatedQuantity;
    final fee = quotePreview?.fee;
    final formHeight =
        490.0 +
        (type == TradingOrderType.limit ? 64 : 0) +
        // Keep enough room for the bounded, scrollable error notice without
        // allowing a long server message to overflow the form column.
        (error != null ? 190 : 0);
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
                label: (value) =>
                    value == TradingSide.buy ? l10n.buy : l10n.sell,
                onChanged: (value) {
                  setState(() => side = value);
                  _percentageWaitingForAmount = false;
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
                          ? l10n.quantity
                          : l10n.amount,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: colors.secondaryText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${l10n.spotBalance}: ',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (balanceLoading)
                          const SizedBox(
                            key: Key('bstocks-balance-loading'),
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(strokeWidth: 1.5),
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
                    availableBalance.value,
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
              decoration: InputDecoration(
                labelText: l10n.limitPrice,
                prefixText: r'$',
              ),
            ),
          ],
          const SizedBox(height: 8),
          _OutlinedSummaryRow(
            label: l10n.willReceive,
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
          SlippageRow(
            value: slippage,
            onEdit: _editSlippage,
            editKey: const Key('bstocks-edit-slippage'),
          ),
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
                    ? l10n.preparingOrder
                    : '${isBuy ? l10n.buy : l10n.sell} ${widget.symbol} · ${isBuy ? '\$' : ''}$buttonAmount',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _preview(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = preview!;
    final isBuy = current.intent.side == TradingSide.buy;
    final action = isBuy ? l10n.buy : l10n.sell;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final actionColor = isBuy ? semantic.success : semantic.loss;
    final settlementAsset =
        current.orderValue.asset ?? current.settlementAsset ?? 'USDT';
    final quantity = current.estimatedQuantity ?? current.intent.quantity;
    final marketPrice = current.marketPrice;
    final liveMarketPrice = _liveMarketPrice;
    final marketPriceChanged =
        marketPrice != null &&
        liveMarketPrice != null &&
        !_samePrice(marketPrice, liveMarketPrice);

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
          '$action ${widget.symbol} · ${current.intent.type == TradingOrderType.market ? l10n.market : l10n.limit}',
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        _BstocksConfirmationConversion(
          left: isBuy
              ? TokenAmountFormatter.formatValue(current.orderValue)
              : quantity == null
              ? '—'
              : TokenAmountFormatter.formatValue(quantity),
          leftAsset: isBuy ? settlementAsset : quantity?.asset ?? widget.symbol,
          right: isBuy
              ? quantity == null
                    ? '—'
                    : TokenAmountFormatter.formatValue(quantity)
              : TokenAmountFormatter.formatValue(current.orderValue),
          rightAsset: isBuy
              ? quantity?.asset ?? widget.symbol
              : settlementAsset,
        ),
        const SizedBox(height: 12),
        _SummaryRow(
          label: l10n.orderType,
          value: current.intent.type == TradingOrderType.market
              ? l10n.market
              : l10n.limit,
        ),
        if (marketPrice case final price?)
          _MarketPriceSummaryRow(
            label: AppLocalizations.of(context).marketPrice,
            original: price,
            current: marketPriceChanged ? liveMarketPrice : null,
          ),
        _SummaryRow(
          label: l10n.slippage,
          value: '${current.intent.slippage?.value ?? slippage}%',
        ),
        if (current.fee case final fee?)
          _SummaryRow(
            label: l10n.estimatedFee,
            value: TokenAmountFormatter.format(
              fee,
              symbol: fee.asset ?? widget.symbol,
            ),
          ),
        if (current.priceUpdated || marketPriceChanged) ...[
          const SizedBox(height: 8),
          Text(AppLocalizations.of(context).priceChangedReview),
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
                  onPressed: () {
                    _stopPreviewPolling();
                    setState(() => preview = null);
                  },
                  child: Text(l10n.back),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: SizedBox(
                height: 48,
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: actionColor),
                  onPressed: reviewing ? null : _submit,
                  child: Text(
                    reviewing
                        ? l10n.submittingOrder
                        : '${l10n.confirm} $action',
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _submitted(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
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
              ? AppLocalizations.of(context).tradeSuccessful
              : AppLocalizations.of(context).orderSubmitted,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          submittedOrder!.status == TradingOrderStatus.filled
              ? l10n.orderStatusInActivity
              : l10n.orderProcessingInDetails,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: submittedOrder!.status == TradingOrderStatus.filled
              ? () => context.goNamed(AppRoutes.activityName)
              : () => Navigator.of(context).pop(),
          child: Text(
            submittedOrder!.status == TradingOrderStatus.filled
                ? l10n.viewHistory
                : AppLocalizations.of(context).closeViewLater,
          ),
        ),
      ],
    );
  }

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
  required DecimalValue? availableBalance,
  required List<HoldingGroup>? holdings,
}) {
  if (side == TradingSide.buy) return availableBalance;
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

String _formatInputAmount(
  double value, {
  double? available,
  double? percentage,
}) {
  final shouldKeepDecimals =
      available == null ||
      percentage == null ||
      available <= 2 ||
      percentage >= 100;
  if (!shouldKeepDecimals) {
    return value.floor().toString();
  }
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

class _MarketPriceSummaryRow extends StatelessWidget {
  const _MarketPriceSummaryRow({
    required this.label,
    required this.original,
    this.current,
  });

  final String label;
  final DecimalValue original;
  final DecimalValue? current;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label)),
          const SizedBox(width: 16),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: TokenAmountFormatter.formatUsd(original),
                    style: current == null
                        ? const TextStyle(fontWeight: FontWeight.w600)
                        : TextStyle(color: colors.secondaryText),
                  ),
                  if (current case final updated?) ...[
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          Icons.arrow_forward,
                          size: 14,
                          color: colors.secondaryText,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: TokenAmountFormatter.formatUsd(updated),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ],
              ),
              textAlign: TextAlign.end,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

class _BstocksConfirmationConversion extends StatelessWidget {
  const _BstocksConfirmationConversion({
    required this.left,
    required this.leftAsset,
    required this.right,
    required this.rightAsset,
  });

  final String left;
  final String leftAsset;
  final String right;
  final String rightAsset;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: Alignment.center,
    children: [
      IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _BstocksConfirmationAmountCard(
                value: left,
                asset: leftAsset,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _BstocksConfirmationAmountCard(
                value: right,
                asset: rightAsset,
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
        child: Icon(
          Icons.arrow_forward,
          size: 16,
          color: Theme.of(context).extension<AppRwaColors>()!.secondaryText,
        ),
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
              if (alignEnd) _BstocksConfirmationAssetMark(asset: asset),
              if (alignEnd) const SizedBox(width: 4),
              Flexible(
                child: Text(
                  value,
                  textAlign: alignEnd ? TextAlign.end : TextAlign.start,
                  softWrap: true,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (!alignEnd) const SizedBox(width: 4),
              if (!alignEnd) _BstocksConfirmationAssetMark(asset: asset),
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 160),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(
                      message,
                      style: TextStyle(color: colors.primaryText),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
