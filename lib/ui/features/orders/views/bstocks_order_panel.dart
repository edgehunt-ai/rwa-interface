import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/funding_transfer.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/application_state.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:nobell/ui/core/motion/animated_number_text.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/orders/providers/order_providers.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/funding/providers/funding_transfer_providers.dart';
import 'package:nobell/ui/features/funding/providers/deposit_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

import 'order_funding_sheet.dart';
import 'order_funding_confirmation_header.dart';
import 'slippage_controls.dart';
import 'tp_sl_editor_card.dart';

part 'bstocks_funding_required.dart';
part 'bstocks_transfer_flow.dart';

enum _BstocksErrorSource { quote, operation }

class BstocksOrderPanel extends ConsumerStatefulWidget {
  const BstocksOrderPanel({
    super.key,
    this.symbol = 'NVDAB',
    this.productId,
    this.initialSide = TradingSide.buy,
    this.onViewPosition,
  });
  final String symbol;
  final String? productId;
  final TradingSide initialSide;
  final ValueChanged<TradingOrder>? onViewPosition;

  @override
  ConsumerState<BstocksOrderPanel> createState() => _BstocksOrderPanelState();
}

class _BstocksOrderPanelState extends ConsumerState<BstocksOrderPanel> {
  static const _rejectedPreviewCodes = {
    'preview_expired',
    'bstocks_preview_changed',
    'bstocks_preview_already_consumed',
  };

  final amount = TextEditingController();
  final quantity = TextEditingController();
  final orderValue = TextEditingController();
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
  _BstocksErrorSource? _errorSource;
  bool reviewing = false;
  bool _approving = false;
  bool _recoveringRejectedPreview = false;
  bool _approvalNeedsPreviewRefresh = false;
  bool _fundingRechecking = false;
  bool _confirmationFromFunding = false;
  Timer? _quoteDebounce;
  Timer? _previewPollingTimer;
  var _quoteGeneration = 0;
  var _previewPollingGeneration = 0;
  var _refreshingPreview = false;
  var _quoting = false;
  var _syncingLimitFields = false;
  double? _percentageAvailable;
  double? _lastPercentageAvailable;
  int? _settlementDecimals;
  int? _bstockDecimals;
  String? _sellAvailabilityRefreshCheckedFor;
  DecimalValue? _liveMarketPrice;
  String? _currentMarketPrice;
  late final OrderCommandNotifier _orderCommands;

  @override
  void initState() {
    super.initState();
    _orderCommands = ref.read(orderCommandProvider.notifier);
    side = widget.initialSide;
    amount.addListener(_refreshAmount);
    quantity.addListener(_refreshLimitFromQuantity);
    orderValue.addListener(_refreshLimitFromOrderValue);
    limitPrice.addListener(_onLimitPriceChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // The first build starts these requests. Invalidating an in-flight
        // FutureProvider here disposes its future before it can emit a value,
        // which surfaces as a Riverpod state error on Web. Refresh only a
        // settled request; an initial load is already the fresh request.
        final accounts = ref.read(tradingAccountsProvider);
        final balance = ref.read(bstocksOrderAvailableBalanceProvider);
        if (accounts.isLoading ||
            accounts.isRefreshing ||
            balance.isLoading ||
            balance.isRefreshing) {
          return;
        }
        ref.invalidate(tradingAccountsProvider);
        ref.invalidate(bstocksOrderAvailableBalanceProvider);
      }
    });
  }

  void _refreshAmount() {
    if (type == TradingOrderType.limit) return;
    _percentageWaitingForAmount = false;
    final available = _percentageAvailable;
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

  void _onLimitPriceChanged() {
    if (type == TradingOrderType.limit) _syncLimitFieldsFromPrice();
    _scheduleQuote();
  }

  void _refreshLimitFromQuantity() {
    if (type != TradingOrderType.limit || _syncingLimitFields) return;
    if (side == TradingSide.sell) _refreshLimitPercentage(quantity.text);
    _syncLimitFields(() {
      final q = double.tryParse(quantity.text.trim());
      final p = double.tryParse(limitPrice.text.trim());
      if (q != null && p != null && q >= 0 && p > 0) {
        _setControllerText(
          orderValue,
          _formatDecimalForToken(q * p, _settlementDecimals),
        );
      }
    });
    _scheduleQuote();
  }

  void _refreshLimitFromOrderValue() {
    if (type != TradingOrderType.limit || _syncingLimitFields) return;
    if (side == TradingSide.buy) _refreshLimitPercentage(orderValue.text);
    _syncLimitFields(() {
      final value = double.tryParse(orderValue.text.trim());
      final p = double.tryParse(limitPrice.text.trim());
      if (value != null && p != null && p > 0 && value >= 0) {
        _setControllerText(
          quantity,
          _formatDecimalForToken(value / p, _bstockDecimals),
        );
      }
    });
    _scheduleQuote();
  }

  void _refreshLimitPercentage([String? text]) {
    final available = _percentageAvailable;
    final entered = double.tryParse((text ?? orderValue.text).trim());
    final next =
        available == null ||
            available <= 0 ||
            entered == null ||
            !entered.isFinite ||
            entered < 0
        ? 0.0
        : (entered / available * 100).clamp(0.0, 100.0);
    if (mounted && percentage != next) {
      setState(() => percentage = next);
    }
  }

  void _scheduleLimitPercentageSync(double? available) {
    if (type != TradingOrderType.limit || available == null) return;
    if (_lastPercentageAvailable == available || _percentageSyncScheduled) {
      return;
    }
    _lastPercentageAvailable = available;
    _percentageSyncScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _percentageSyncScheduled = false;
      if (!mounted || type != TradingOrderType.limit) return;
      _refreshLimitPercentage(
        side == TradingSide.buy ? orderValue.text : quantity.text,
      );
    });
  }

  void _refreshCachedSellAvailability(
    String productId,
    AsyncValue<BstocksSellAvailability?> availability,
  ) {
    if (_sellAvailabilityRefreshCheckedFor == productId) return;
    _sellAvailabilityRefreshCheckedFor = productId;
    if (availability.isLoading || availability.isRefreshing) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || side != TradingSide.sell) return;
      ref.invalidate(bstocksSellAvailabilityProvider(productId));
    });
  }

  void _syncLimitFieldsFromPrice() {
    if (type != TradingOrderType.limit || _syncingLimitFields) return;
    final p = double.tryParse(limitPrice.text.trim());
    if (p == null || p <= 0) return;
    final q = double.tryParse(quantity.text.trim());
    final value = double.tryParse(orderValue.text.trim());
    if (q != null && q >= 0) {
      _syncLimitFields(
        () => _setControllerText(
          orderValue,
          _formatDecimalForToken(q * p, _settlementDecimals),
        ),
      );
    } else if (value != null && value >= 0) {
      _syncLimitFields(
        () => _setControllerText(
          quantity,
          _formatDecimalForToken(value / p, _bstockDecimals),
        ),
      );
    }
  }

  void _syncLimitFields(VoidCallback action) {
    _syncingLimitFields = true;
    action();
    _syncingLimitFields = false;
  }

  void _setControllerText(TextEditingController controller, String text) {
    if (controller.text == text) return;
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  void _updateAmountFromPercentage(
    double value,
    DecimalValue? availableAmount,
    int? decimals,
  ) {
    final available = double.tryParse(availableAmount?.value ?? '');
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

    final nextText = _formatInputAmount(
      availableAmount!,
      percentage: value,
      decimals: decimals,
    );
    _percentageWaitingForAmount = false;
    if (mounted) setState(() => percentage = value);
    final controller = type == TradingOrderType.limit
        ? (side == TradingSide.buy ? orderValue : quantity)
        : amount;
    controller.value = TextEditingValue(
      text: nextText,
      selection: TextSelection.collapsed(offset: nextText.length),
    );
  }

  void _schedulePendingPercentageSync(
    DecimalValue? availableAmount,
    int? decimals,
  ) {
    if (!_percentageWaitingForAmount || _percentageSyncScheduled) return;
    final available = double.tryParse(availableAmount?.value ?? '');
    if (available == null || available <= 0) return;
    _percentageSyncScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _percentageSyncScheduled = false;
      if (!mounted || !_percentageWaitingForAmount) return;
      _updateAmountFromPercentage(percentage, availableAmount, decimals);
    });
  }

  void _schedulePrecisionSync({
    required int? settlementDecimals,
    required int? bstockDecimals,
  }) {
    if (_settlementDecimals == settlementDecimals &&
        _bstockDecimals == bstockDecimals) {
      return;
    }
    _settlementDecimals = settlementDecimals;
    _bstockDecimals = bstockDecimals;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (settlementDecimals != null) {
        _truncateController(orderValue, settlementDecimals);
        if (type == TradingOrderType.market && side == TradingSide.buy) {
          _truncateController(amount, settlementDecimals);
        }
      }
      if (bstockDecimals != null) {
        _truncateController(quantity, bstockDecimals);
        if (type == TradingOrderType.market && side == TradingSide.sell) {
          _truncateController(amount, bstockDecimals);
        }
      }
    });
  }

  void _truncateController(TextEditingController controller, int decimals) {
    final text = _truncateDecimal(controller.text, decimals);
    if (text == controller.text) return;
    _setControllerText(controller, text);
  }

  void _scheduleQuote() {
    _quoteDebounce?.cancel();
    final generation = ++_quoteGeneration;
    final intent = _intentFromFields();
    if (intent == null) {
      if (mounted) {
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
            _clearError(source: _BstocksErrorSource.quote);
          });
        }
      } on Object catch (quoteError) {
        if (mounted && generation == _quoteGeneration) {
          setState(() {
            quotePreview = null;
            _quoting = false;
            _setError(
              _errorMessage(
                error: quoteError,
                fallback: AppLocalizations.of(context).prepareOrderFailed,
              ),
              source: _BstocksErrorSource.quote,
            );
          });
        }
      }
    });
  }

  @override
  void dispose() {
    // Modal route removal unmounts this widget while Flutter is finalizing a
    // frame. Reset the shared command state immediately after that frame so
    // Riverpod is not mutated during widget-tree teardown.
    scheduleMicrotask(_orderCommands.cancelSubmission);
    _quoteDebounce?.cancel();
    _previewPollingTimer?.cancel();
    amount.removeListener(_refreshAmount);
    quantity.removeListener(_refreshLimitFromQuantity);
    orderValue.removeListener(_refreshLimitFromOrderValue);
    limitPrice.removeListener(_onLimitPriceChanged);
    amount.dispose();
    quantity.dispose();
    orderValue.dispose();
    limitPrice.dispose();
    super.dispose();
  }

  Future<void> _review() async {
    final inputValue = type == TradingOrderType.limit
        ? quantity.text.trim()
        : amount.text.trim();
    if (!_isPositiveDecimal(inputValue)) {
      setState(
        () => _setError(
          AppLocalizations.of(context).validOrderValue,
          source: _BstocksErrorSource.operation,
        ),
      );
      return;
    }
    if (type == TradingOrderType.limit &&
        !_isPositiveDecimal(limitPrice.text.trim())) {
      setState(
        () => _setError(
          AppLocalizations.of(context).validLimitPrice,
          source: _BstocksErrorSource.operation,
        ),
      );
      return;
    }
    final intent = _intentFromFields()!;
    if (reviewing) return;
    final cachedQuote = quotePreview;
    setState(() {
      _clearError();
      reviewing = true;
      _confirmationFromFunding = false;
    });
    try {
      var completedFundingFlow = false;
      if (intent.side == TradingSide.buy) {
        while (true) {
          final funding = await ref
              .read(fundingTransferCommandsProvider)
              .session(intent: intent);
          if (!mounted) return;
          final plan = funding.plan;
          if (plan.status == FundingPlanState.alreadyFunded) break;
          final funded = await showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            enableDrag: false,
            builder: (_) => OrderFundingSheet(
              plan: plan,
              kind: intent.kind,
              canConfirmTransfer: funding.canConfirmTransfer,
              slippage: intent.slippage,
            ),
          );
          if (!mounted || funded != true) return;
          setState(() => _fundingRechecking = true);
          completedFundingFlow = true;
        }
      }
      if (completedFundingFlow) {
        ref.invalidate(orderPreviewProvider(intent));
      }
      final next =
          !completedFundingFlow &&
              cachedQuote?.intent.fingerprint == intent.fingerprint &&
              cachedQuote?.isExpired == false
          ? cachedQuote!
          : await ref.read(orderPreviewProvider(intent).future);
      if (!mounted) return;
      _showConfirmation(next, fromFunding: completedFundingFlow);
    } on Object catch (error) {
      if (mounted) {
        setState(
          () => _setError(
            _errorMessage(
              error: error,
              fallback: AppLocalizations.of(context).prepareOrderFailed,
            ),
            source: _BstocksErrorSource.operation,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          reviewing = false;
          _fundingRechecking = false;
        });
      }
    }
  }

  String _errorMessage({required Object error, required String fallback}) {
    if (error is ApiFailure) {
      return apiFailureMessage(error, fallback: fallback);
    }
    final message = error.toString().trim();
    return message.isEmpty ? fallback : message;
  }

  void _setError(String message, {required _BstocksErrorSource source}) {
    error = message;
    _errorSource = source;
  }

  void _clearError({_BstocksErrorSource? source}) {
    if (source != null && _errorSource != source) return;
    error = null;
    _errorSource = null;
  }

  Future<void> _approveConfirmation() async {
    final initial = preview;
    if (initial == null ||
        !initial.approvalRequired ||
        _approving ||
        reviewing ||
        _recoveringRejectedPreview) {
      return;
    }
    var current = initial;
    var approvalCompleted = false;
    _stopPreviewPolling();
    setState(() {
      _clearError();
      _approving = true;
    });
    try {
      if (_approvalNeedsPreviewRefresh || current.isExpired) {
        final provider = orderPreviewProvider(current.intent);
        ref.invalidate(provider);
        current = await ref.read(provider.future);
        if (!mounted) return;
        if (current.isExpired) {
          throw UnknownFailure(
            retryable: true,
            userAction: AppLocalizations.of(context).orderQuoteUnavailable,
          );
        }
        setState(() {
          preview = current;
          quotePreview = current;
          _liveMarketPrice = current.marketPrice;
        });
        _approvalNeedsPreviewRefresh = false;
        if (!current.executionReady || !current.approvalRequired) {
          _showConfirmation(current, fromFunding: _confirmationFromFunding);
          return;
        }
      }
      final approved = await _orderCommands.approve(
        current.intent,
        previewId: current.previewId,
      );
      if (!mounted) return;
      if (approved == null) {
        final state = ref.read(orderCommandProvider);
        throw state is CommandFailure<OrderIntent, ResourceResult<TradingOrder>>
            ? state.failure
            : const CompatibilityFailure();
      }
      approvalCompleted = true;

      // Approval only changes allowance. Keep the user at confirmation until
      // a fresh preview verifies that a separate order submission is ready.
      var refreshed = current;
      for (var attempt = 0; attempt < 5; attempt++) {
        final provider = orderPreviewProvider(current.intent);
        ref.invalidate(provider);
        refreshed = await ref.read(provider.future);
        if (!mounted) return;
        if (!refreshed.approvalRequired) break;
        if (attempt < 4) await Future<void>.delayed(const Duration(seconds: 1));
      }
      if (!mounted) return;
      if (refreshed.approvalRequired) {
        throw const UnknownFailure(
          retryable: true,
          userAction: 'Approval confirmed, but the refreshed quote still requires approval',
        );
      }
      setState(() => quotePreview = refreshed);
      _showConfirmation(refreshed, fromFunding: _confirmationFromFunding);
    } on Object catch (approvalError) {
      if (mounted) {
        _approvalNeedsPreviewRefresh = true;
        final l10n = AppLocalizations.of(context);
        final reason = _errorMessage(
          error: approvalError,
          fallback: approvalCompleted
              ? l10n.prepareOrderFailed
              : l10n.orderSubmissionFailed,
        );
        setState(() {
          _setError(
            approvalCompleted
                ? '${l10n.approvalCompletedQuoteRefreshFailed} $reason'
                : reason,
            source: _BstocksErrorSource.operation,
          );
        });
      }
    } finally {
      if (mounted) {
        setState(() => _approving = false);
        final currentPreview = preview;
        if (currentPreview != null && _previewPollingTimer == null) {
          _startPreviewPolling(currentPreview);
        }
      }
    }
  }

  void _showConfirmation(
    OrderPreview next, {
    required bool fromFunding,
    bool clearError = true,
  }) {
    if (!next.executionReady) {
      setState(() {
        quotePreview = next;
        preview = null;
        _setError(
          '预览费用和预估数量可用，但缺少下单所需的确认绑定，暂时不能提交订单。',
          source: _BstocksErrorSource.operation,
        );
      });
      return;
    }
    _previewPollingTimer?.cancel();
    _previewPollingGeneration++;
    _liveMarketPrice = next.marketPrice;
    setState(() {
      if (clearError) _clearError();
      preview = next;
      _confirmationFromFunding = fromFunding;
    });
    _startPreviewPolling(next);
  }

  void _startPreviewPolling(OrderPreview next) {
    if (next.intent.type != TradingOrderType.market) return;
    final generation = ++_previewPollingGeneration;

    Future<void> refresh() async {
      if (!mounted ||
          preview?.intent.fingerprint != next.intent.fingerprint ||
          generation != _previewPollingGeneration ||
          _refreshingPreview) {
        return;
      }
      _refreshingPreview = true;
      OrderPreview? refreshed;
      try {
        final provider = orderPreviewProvider(next.intent);
        ref.invalidate(provider);
        refreshed = await ref.read(provider.future);
      } on Object {
        // Keep the last confirmed preview price when a transient refresh fails.
      }
      if (!mounted ||
          preview?.intent.fingerprint != next.intent.fingerprint ||
          generation != _previewPollingGeneration) {
        if (generation == _previewPollingGeneration) {
          _refreshingPreview = false;
        }
        return;
      }
      // The preview ID binds the quote used by both the initial order
      // creation and the post-approval order recreation. Keep the full
      // refreshed preview, not only its display price, so submissions do not
      // send an expired or stale preview ID. A failed refresh leaves the last
      // confirmed values on screen.
      final confirmed = refreshed;
      if (confirmed != null) {
        setState(() {
          preview = confirmed;
          _liveMarketPrice = confirmed.marketPrice;
        });
      }
      _refreshingPreview = false;
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
    _refreshingPreview = false;
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

  OrderIntent? _intentFromFields() {
    final amountValue = amount.text.trim();
    final rawPrice = limitPrice.text.trim();
    if (type == TradingOrderType.limit && !_isPositiveDecimal(rawPrice)) {
      return null;
    }
    final limitQuantity = quantity.text.trim();
    if (type == TradingOrderType.limit) {
      if (!_isPositiveDecimal(limitQuantity)) return null;
    } else if (!_isPositiveDecimal(amountValue)) {
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
          ? DecimalValue(
              type == TradingOrderType.limit ? limitQuantity : amountValue,
              asset: widget.symbol,
              unit: 'token',
            )
          : null,
      limitPrice: type == TradingOrderType.limit
          ? DecimalValue(rawPrice, asset: 'USD', unit: 'fiat')
          : null,
      // A limit order rests as GTC and must not carry a slippage tolerance;
      // only the IOC market order is bounded by it.
      slippage: type == TradingOrderType.limit
          ? null
          : DecimalValue(slippage.toString(), unit: 'percent'),
    );
  }

  String get _settlementAssetForInput =>
      quotePreview?.settlementAsset ?? 'USDT';

  Future<void> _submit() async {
    final current = preview;
    if (current == null ||
        reviewing ||
        _approving ||
        _recoveringRejectedPreview) {
      return;
    }
    if (current.approvalRequired) {
      await _approveConfirmation();
      return;
    }
    debugPrint(
      'bStocks submit: started preview=${current.previewId} '
      'intent=${current.intent.fingerprint}',
    );
    _stopPreviewPolling();
    setState(() {
      _clearError();
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
    if (result != null) {
      setState(() {
        reviewing = false;
        submittedOrder = result.resource;
      });
      return;
    }

    final state = ref.read(orderCommandProvider);
    final failure =
        state is CommandFailure<OrderIntent, ResourceResult<TradingOrder>>
        ? state.failure
        : const CompatibilityFailure();
    final failureMessage = apiFailureMessage(
      failure,
      fallback: AppLocalizations.of(context).orderSubmissionFailed,
    );
    if (failure is ServerFailure &&
        _rejectedPreviewCodes.contains(failure.code)) {
      await _recoverFromRejectedPreview(
        current: current,
        failureMessage: failureMessage,
      );
      return;
    }

    setState(() {
      reviewing = false;
      _setError(failureMessage, source: _BstocksErrorSource.operation);
    });
    // An uncertain submission keeps its original idempotency key and preview
    // binding in OrderCommandNotifier. Keep the visible quote frozen as well,
    // so the terms shown to the trader still match that exact retry request.
  }

  Future<void> _recoverFromRejectedPreview({
    required OrderPreview current,
    required String failureMessage,
  }) async {
    setState(() {
      reviewing = false;
      _recoveringRejectedPreview = true;
      _setError(failureMessage, source: _BstocksErrorSource.operation);
    });
    final provider = orderPreviewProvider(current.intent);
    try {
      ref.invalidate(provider);
      final refreshed = await ref.read(provider.future);
      if (!mounted) return;
      setState(() {
        quotePreview = refreshed;
        _recoveringRejectedPreview = false;
      });
      _showConfirmation(
        refreshed,
        fromFunding: _confirmationFromFunding,
        clearError: false,
      );
    } on Object catch (refreshError) {
      if (!mounted) return;
      // Do not leave a rejected preview actionable. Returning to the form gives
      // the trader an explicit retry path, which will request a new preview.
      ref.invalidate(provider);
      setState(() {
        reviewing = false;
        _recoveringRejectedPreview = false;
        preview = null;
        quotePreview = null;
        _setError(
          _errorMessage(
            error: refreshError,
            fallback: AppLocalizations.of(context).prepareOrderFailed,
          ),
          source: _BstocksErrorSource.operation,
        );
      });
    }
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

  Future<String?> _loadBstocksMarketPrice() async {
    if (_currentMarketPrice != null) return _currentMarketPrice;
    final product = MarketProductRef(
      symbol: widget.symbol,
      kind: MarketProductKind.bstock,
    );
    try {
      final snapshot = await ref.read(marketSnapshotProvider(product).future);
      _currentMarketPrice = snapshot.price.value;
    } on Object {
      try {
        final marketProduct = await ref.read(
          marketProductProvider(product).future,
        );
        _currentMarketPrice = marketProduct.price.value;
      } on Object {
        // The limit-price editor can still be used without a market quote.
      }
    }
    return _currentMarketPrice;
  }

  Future<void> _setOrderType(TradingOrderType next) async {
    if (next == type) return;
    if (next == TradingOrderType.limit) {
      final marketPrice = await _loadBstocksMarketPrice();
      if (!mounted) return;
      final value = await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        builder: (_) => _BstocksLimitPriceSheet(
          initialPrice: limitPrice.text.trim().isNotEmpty
              ? limitPrice.text.trim()
              : marketPrice ?? '',
          marketPrice: marketPrice,
        ),
      );
      if (!mounted || value == null) return;
      setState(() => type = next);
      _setControllerText(limitPrice, value);
      _setControllerText(quantity, '');
      _setControllerText(orderValue, '');
      _scheduleQuote();
      return;
    }
    setState(() => type = next);
    quantity.clear();
    orderValue.clear();
    limitPrice.clear();
    _scheduleQuote();
  }

  Future<void> _editLimitPrice() async {
    final marketPrice = await _loadBstocksMarketPrice();
    if (!mounted) return;
    final value = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) => _BstocksLimitPriceSheet(
        initialPrice: limitPrice.text.trim(),
        marketPrice: marketPrice,
      ),
    );
    if (!mounted || value == null) return;
    _setControllerText(limitPrice, value);
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
              : _fundingRechecking
              ? OrderFundingPendingContent(
                  onClose: () => Navigator.of(context).pop(),
                )
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
    final actionColor = isBuy ? success : kShortTradeColor;
    final settlementAsset = quotePreview?.settlementAsset ?? 'USDT';
    final snapshot = ref.watch(
      marketSnapshotProvider(
        MarketProductRef(symbol: widget.symbol, kind: MarketProductKind.bstock),
      ),
    );
    _currentMarketPrice =
        quotePreview?.marketPrice?.value ?? snapshot.value?.price.value;
    final settlementBalance = ref.watch(
      bstocksSettlementBalanceProvider(settlementAsset),
    );
    final settlementDecimals = ref.watch(
      bstocksSettlementTokenDecimalsProvider(settlementAsset),
    );
    final catalogBstockDecimals = ref
        .watch(bstocksTokenDecimalsProvider(widget.symbol))
        .value;
    final amountAsset = type == TradingOrderType.market
        ? (isBuy ? settlementAsset : widget.symbol)
        : settlementAsset;
    final enteredAmount = type == TradingOrderType.limit
        ? (isBuy ? orderValue.text.trim() : quantity.text.trim())
        : amount.text.trim();
    final buttonAmount = enteredAmount.isEmpty ? '0' : enteredAmount;
    final hasExplicitInvalidAmount =
        enteredAmount.isNotEmpty && !_isPositiveDecimal(enteredAmount);
    final availableBalance = settlementBalance;
    final sellProductId = isBuy
        ? null
        : widget.productId ??
              snapshot.value?.productId ??
              ref.watch(
                marketProductIdProvider(
                  MarketProductRef(
                    symbol: widget.symbol,
                    kind: MarketProductKind.bstock,
                  ),
                ),
              );
    final AsyncValue<BstocksSellAvailability?> sellAvailability;
    if (isBuy || sellProductId == null) {
      sellAvailability = const AsyncData(null);
    } else {
      sellAvailability = ref.watch(
        bstocksSellAvailabilityProvider(sellProductId),
      );
      _refreshCachedSellAvailability(sellProductId, sellAvailability);
    }
    final availableAmount = isBuy
        ? availableBalance.value
        : sellAvailability.value?.quantity;
    final bstockDecimals =
        sellAvailability.value?.decimals ?? catalogBstockDecimals;
    final amountDecimals = isBuy ? settlementDecimals : bstockDecimals;
    _schedulePrecisionSync(
      settlementDecimals: settlementDecimals,
      bstockDecimals: bstockDecimals,
    );
    _schedulePendingPercentageSync(availableAmount, amountDecimals);
    _percentageAvailable = double.tryParse(availableAmount?.value ?? '');
    _scheduleLimitPercentageSync(_percentageAvailable);
    final balance = availableAmount == null
        ? null
        : isBuy
        ? '${TokenAmountFormatter.formatValue(availableAmount)} $settlementAsset'
        : '${TokenAmountFormatter.formatValue(availableAmount)} ${widget.symbol}';
    final balanceLoading = isBuy
        ? availableBalance.isLoading || availableBalance.isRefreshing
        : availableAmount == null && sellAvailability.isLoading;
    final receive =
        quotePreview?.estimatedReceive ?? quotePreview?.estimatedQuantity;
    final fee = quotePreview?.fee;
    final showFee = _hasNonZeroValue(fee);
    final quoteLoading = _quoting && quotePreview == null;
    final formHeight =
        (type == TradingOrderType.limit ? 579.0 : 560.0) +
        // The failure notice is normally one compact row. Its text scrolls
        // internally when a server returns a longer message, so it must not
        // reserve the old fixed 190px block in the whole order sheet.
        (error != null ? 60 : 0);
    return SizedBox(
      height: formHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                key: const Key('bstocks-side-indicator'),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: actionColor,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ChoiceRow<TradingSide>(
                key: const Key('bstocks-side-tabs'),
                width: 123,
                values: const [TradingSide.buy, TradingSide.sell],
                selected: side,
                selectedColor: actionColor,
                selectedForeground: Colors.white,
                label: (value) =>
                    value == TradingSide.buy ? l10n.buy : l10n.sell,
                onChanged: (value) {
                  setState(() => side = value);
                  _percentageWaitingForAmount = false;
                  amount.clear();
                  quantity.clear();
                  orderValue.clear();
                  _scheduleQuote();
                },
              ),
              _ChoiceRow<TradingOrderType>(
                key: const Key('bstocks-order-type-tabs'),
                width: 151,
                values: const [TradingOrderType.market, TradingOrderType.limit],
                selected: type,
                label: (value) =>
                    value == TradingOrderType.market ? l10n.market : l10n.limit,
                onChanged: _setOrderType,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (type == TradingOrderType.limit) ...[
            Row(
              children: [
                Expanded(
                  child: _LimitInput(
                    cardKey: const Key('bstocks-limit-price-card'),
                    controller: limitPrice,
                    label: l10n.limitPrice,
                    suffix: 'USDT',
                    onTap: _editLimitPrice,
                    inputKey: const Key('bstocks-limit-price-input'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _LimitInput(
                    cardKey: const Key('bstocks-limit-quantity-card'),
                    controller: quantity,
                    label: l10n.quantity,
                    suffix: widget.symbol,
                    inputFormatters: bstockDecimals == null
                        ? null
                        : [_decimalTruncatingFormatter(bstockDecimals)],
                    inputKey: const Key('bstocks-limit-quantity-input'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
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
                          ? l10n.orderValue
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
                          controller: type == TradingOrderType.limit
                              ? orderValue
                              : amount,
                          key: type == TradingOrderType.limit
                              ? const Key('bstocks-limit-order-value-input')
                              : const Key('bstocks-market-amount-input'),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: amountDecimals == null
                              ? null
                              : [_decimalTruncatingFormatter(amountDecimals)],
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
                    availableAmount,
                    amountDecimals,
                  ),
                ),
              ],
            ),
          ),
          if (type == TradingOrderType.limit) ...[
            if (showFee) ...[
              const SizedBox(height: 16),
              Divider(color: colors.subtleSurface),
              const SizedBox(height: 14),
              _AnimatedAmountSummaryRow(
                label: l10n.estimatedFee,
                value: TokenAmountFormatter.formatValue(fee!),
                symbol: settlementAsset,
                valueKey: const Key('bstocks-order-form-fee-value'),
              ),
            ],
          ] else ...[
            const SizedBox(height: 8),
            _OutlinedSummaryRow(
              label: l10n.willReceive,
              value: quoteLoading
                  ? const SkeletonBlock(width: 76, height: 14, radius: 4)
                  : _AnimatedAmountText(
                      value: receive == null
                          ? '-'
                          : TokenAmountFormatter.formatValue(receive),
                      symbol: receive?.asset ?? widget.symbol,
                      valueKey: const Key('bstocks-order-form-receive-value'),
                    ),
            ),
            const SizedBox(height: 16),
            Divider(color: colors.subtleSurface),
            const SizedBox(height: 14),
            SlippageRow(
              value: slippage,
              onEdit: _editSlippage,
              editKey: const Key('bstocks-edit-slippage'),
            ),
            if (showFee) ...[
              const SizedBox(height: 8),
              _AnimatedAmountSummaryRow(
                label: l10n.estimatedFee,
                padding: EdgeInsets.zero,
                value: TokenAmountFormatter.formatValue(fee!),
                symbol: settlementAsset,
                valueKey: const Key('bstocks-order-form-fee-value'),
              ),
            ],
          ],
          if (error case final error?) ...[
            const SizedBox(height: 8),
            _OrderFailureNotice(message: error),
          ],
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              key: const Key('bstocks-primary-order-action'),
              style: FilledButton.styleFrom(
                backgroundColor: !isBuy
                    ? actionColor
                    : type == TradingOrderType.limit
                    ? colors.primaryAction
                    : actionColor,
                foregroundColor: isBuy && type == TradingOrderType.limit
                    ? colors.onPrimaryAction
                    : Colors.white,
              ),
              onPressed: reviewing || hasExplicitInvalidAmount ? null : _review,
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
    final actionColor = isBuy ? semantic.success : kShortTradeColor;
    final settlementAsset =
        current.orderValue.asset ?? current.settlementAsset ?? 'USDT';
    final quantity = current.estimatedQuantity ?? current.intent.quantity;
    final fee = current.fee;
    final showFee = _hasNonZeroValue(fee);
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
        if (_confirmationFromFunding)
          OrderFundingConfirmationHeader(
            title: '$action ${widget.symbol}',
            stepKey: const Key('bstocks-funding-confirmation-step-3'),
          )
        else
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
          padding: const EdgeInsets.symmetric(vertical: 4),
        ),
        if (marketPrice case final price?)
          _MarketPriceSummaryRow(
            key: const Key('bstocks-confirmation-market-price'),
            label: l10n.marketPrice,
            original: price,
            current: marketPriceChanged ? liveMarketPrice : null,
            padding: const EdgeInsets.symmetric(vertical: 4),
          ),
        if (marketPrice == null)
          _SummaryRow(
            key: const Key('bstocks-confirmation-market-price'),
            label: l10n.marketPrice,
            value: '—',
            padding: const EdgeInsets.symmetric(vertical: 4),
          ),
        if (current.intent.type == TradingOrderType.market)
          _SummaryRow(
            label: l10n.slippage,
            value:
                '${current.intent.slippage == null ? TokenAmountFormatter.formatValue(DecimalValue(slippage.toString())) : TokenAmountFormatter.formatValue(current.intent.slippage!)}%',
            padding: const EdgeInsets.symmetric(vertical: 4),
          ),
        if (showFee)
          _AnimatedAmountSummaryRow(
            key: const Key('bstocks-confirmation-fee'),
            label: l10n.estimatedFee,
            value: TokenAmountFormatter.formatValue(fee!),
            symbol: settlementAsset,
            valueKey: const Key('bstocks-confirmation-fee-value'),
            padding: const EdgeInsets.symmetric(vertical: 4),
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
                  onPressed:
                      _approving || reviewing || _recoveringRejectedPreview
                      ? null
                      : () {
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
                  onPressed:
                      reviewing || _approving || _recoveringRejectedPreview
                      ? null
                      : current.approvalRequired
                      ? _approveConfirmation
                      : _submit,
                  child: _approving
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(
                            key: Key('bstocks-approval-loading'),
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          reviewing
                              ? l10n.submittingOrder
                              : current.approvalRequired
                              ? l10n.approve
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
    final current = submittedOrder!;
    final canViewResult =
        current.status == TradingOrderStatus.filled ||
        (current.type == TradingOrderType.limit &&
            const {
              TradingOrderStatus.open,
              TradingOrderStatus.partiallyFilled,
            }.contains(current.status));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
          'assets/figma/trade/order_success.webp',
          width: 120,
          height: 120,
          fit: BoxFit.contain,
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
          key: const Key('bstocks-order-result-action'),
          onPressed: canViewResult
              ? () {
                  final onViewPosition = widget.onViewPosition;
                  if (onViewPosition != null) {
                    onViewPosition(current);
                  } else {
                    Navigator.of(context).pop();
                  }
                }
              : () => Navigator.of(context).pop(),
          child: Text(
            canViewResult
                ? l10n.viewPosition
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
        'assets/figma/trade/order_submitting.webp',
        width: 120,
        height: 120,
        fit: BoxFit.contain,
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

bool _isPositiveDecimal(String value) {
  try {
    return DecimalValue(value).compareMagnitudeTo(DecimalValue('0')) > 0;
  } on FormatException {
    return false;
  }
}

String _formatInputAmount(
  DecimalValue available, {
  required double percentage,
  int? decimals,
}) {
  final numericAvailable = double.parse(available.value);
  final value = numericAvailable * percentage / 100;
  final shouldKeepDecimals = numericAvailable <= 2 || percentage >= 100;
  if (!shouldKeepDecimals) {
    return value.floor().toString();
  }
  final truncated = _truncateDecimal(
    _scaleDecimalByPercentage(available.value, percentage),
    decimals,
  );
  return truncated.contains('.')
      ? truncated.replaceFirst(RegExp(r'\.?0+$'), '')
      : truncated;
}

String _scaleDecimalByPercentage(String amount, double percentage) {
  final negative = amount.startsWith('-');
  final unsignedAmount = negative ? amount.substring(1) : amount;
  final amountParts = unsignedAmount.split('.');
  final amountScale = amountParts.length == 1 ? 0 : amountParts.last.length;
  final amountDigits = BigInt.parse(
    '${amountParts.first}${amountParts.length == 1 ? '' : amountParts.last}',
  );

  final percentageText = percentage
      .clamp(0.0, 100.0)
      .toStringAsFixed(6)
      .replaceFirst(RegExp(r'\.?0+$'), '');
  final percentageParts = percentageText.split('.');
  final percentageScale = percentageParts.length == 1
      ? 0
      : percentageParts.last.length;
  final percentageDigits = BigInt.parse(
    '${percentageParts.first}'
    '${percentageParts.length == 1 ? '' : percentageParts.last}',
  );

  final product = amountDigits * percentageDigits;
  final scale = amountScale + percentageScale + 2;
  final digits = product.toString().padLeft(scale + 1, '0');
  final split = digits.length - scale;
  final raw = scale == 0
      ? digits
      : '${digits.substring(0, split)}.${digits.substring(split)}';
  final normalized = raw.replaceFirst(RegExp(r'\.?0+$'), '');
  if (normalized == '0') return normalized;
  return '${negative ? '-' : ''}$normalized';
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
        children: [
          Text(label, style: TextStyle(color: colors.secondaryText)),
          const SizedBox(width: 12),
          Expanded(
            child: Align(alignment: Alignment.centerRight, child: value),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    super.key,
    required this.label,
    required this.value,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
  });
  final String label;
  final String value;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(color: Color(0xFF676776))),
        ),
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

class _AnimatedAmountSummaryRow extends StatelessWidget {
  const _AnimatedAmountSummaryRow({
    super.key,
    required this.label,
    required this.value,
    required this.symbol,
    required this.valueKey,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
  });

  final String label;
  final String value;
  final String symbol;
  final Key valueKey;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
    padding: padding,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(label, style: const TextStyle(color: Color(0xFF676776))),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: _AnimatedAmountText(
              value: value,
              symbol: symbol,
              valueKey: valueKey,
            ),
          ),
        ),
      ],
    ),
  );
}

class _AnimatedAmountText extends StatelessWidget {
  const _AnimatedAmountText({
    required this.value,
    required this.symbol,
    required this.valueKey,
  });

  final String value;
  final String symbol;
  final Key valueKey;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(
        child: AnimatedNumberText(
          value,
          key: valueKey,
          textAlign: TextAlign.end,
          softWrap: true,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      const SizedBox(width: 4),
      Text(symbol, style: const TextStyle(fontWeight: FontWeight.w600)),
    ],
  );
}

class _MarketPriceSummaryRow extends StatelessWidget {
  const _MarketPriceSummaryRow({
    super.key,
    required this.label,
    required this.original,
    this.current,
    this.padding = const EdgeInsets.symmetric(vertical: 6),
  });

  final String label;
  final DecimalValue original;
  final DecimalValue? current;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF676776)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: current == null
                  ? AnimatedNumberText(
                      TokenAmountFormatter.formatUsd(original),
                      key: const Key('bstocks-confirmation-market-price-value'),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          TokenAmountFormatter.formatUsd(original),
                          style: TextStyle(color: colors.secondaryText),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: colors.secondaryText,
                          ),
                        ),
                        AnimatedNumberText(
                          TokenAmountFormatter.formatUsd(current!),
                          key: const Key(
                            'bstocks-confirmation-market-price-value',
                          ),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
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
                key: const Key('bstocks-confirmation-receive-card'),
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
    super.key,
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
              if (alignEnd)
                _BstocksConfirmationAssetMark(
                  key: const Key('bstocks-confirmation-receive-mark'),
                  asset: asset,
                ),
              if (alignEnd) const SizedBox(width: 4),
              Flexible(
                child: alignEnd
                    ? AnimatedNumberText(
                        value,
                        key: const Key('bstocks-confirmation-receive-value'),
                        style: Theme.of(context).textTheme.titleMedium!,
                        textAlign: TextAlign.end,
                        softWrap: true,
                      )
                    : Text(
                        value,
                        textAlign: TextAlign.start,
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
            key: alignEnd
                ? const Key('bstocks-confirmation-receive-symbol')
                : null,
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
  const _BstocksConfirmationAssetMark({super.key, required this.asset});

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

class _LimitInput extends StatefulWidget {
  const _LimitInput({
    required this.cardKey,
    required this.controller,
    required this.label,
    required this.suffix,
    this.onTap,
    this.inputKey,
    this.inputFormatters,
  });
  final Key cardKey;
  final TextEditingController controller;
  final String label;
  final String suffix;
  final VoidCallback? onTap;
  final Key? inputKey;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<_LimitInput> createState() => _LimitInputState();
}

class _LimitInputState extends State<_LimitInput> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Material(
      key: widget.cardKey,
      color: colors.subtleSurface,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: widget.onTap ?? _focusNode.requestFocus,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
          child: SizedBox(
            height: 42,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: colors.secondaryText),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 22,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          key: widget.inputKey,
                          controller: widget.controller,
                          focusNode: _focusNode,
                          onTap: widget.onTap,
                          readOnly: widget.onTap != null,
                          showCursor: widget.onTap == null,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: widget.inputFormatters,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            hintText: widget.onTap == null ? '0.0' : null,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: false,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            constraints: BoxConstraints.tightFor(height: 22),
                          ),
                        ),
                      ),
                      Text(
                        widget.suffix,
                        style: Theme.of(context).textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BstocksLimitPriceSheet extends StatefulWidget {
  const _BstocksLimitPriceSheet({required this.initialPrice, this.marketPrice});

  final String initialPrice;
  final String? marketPrice;

  @override
  State<_BstocksLimitPriceSheet> createState() =>
      _BstocksLimitPriceSheetState();
}

class _BstocksLimitPriceSheetState extends State<_BstocksLimitPriceSheet> {
  late final TextEditingController _controller;
  late double _deviation;
  double? _rulerPrice;

  double? get _market => double.tryParse(widget.marketPrice ?? '');

  @override
  void initState() {
    super.initState();
    final market = _market;
    final initial = double.tryParse(widget.initialPrice);
    final initialPrice = initial ?? market;
    _controller = TextEditingController(
      text: initialPrice == null ? '' : _formatDecimal(initialPrice),
    );
    _rulerPrice = initialPrice;
    _deviation = market == null || market <= 0 || initialPrice == null
        ? 0
        : ((initialPrice / market) - 1) * 100;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setLimitPriceFromRuler(double value) {
    _rulerPrice = value;
    final formattedPrice = _formatDraggedLimitPrice(value);
    final nextPrice = double.parse(formattedPrice);
    setState(() {
      _controller.text = formattedPrice;
      if (_market case final market? when market > 0) {
        _deviation = ((nextPrice / market) - 1) * 100;
      }
    });
  }

  void _priceChanged(String value) {
    final market = _market;
    final price = double.tryParse(value);
    _rulerPrice = price;
    if (market != null && market > 0 && price != null) {
      _deviation = ((price / market) - 1) * 100;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final price = double.tryParse(_controller.text);
    final market = _market;
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final displayedPrice = _rulerPrice ?? price ?? market ?? 0;

    return SizedBox(
      height: 543 + bottomInset,
      child: Material(
        key: const Key('bstocks-limit-price-sheet'),
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 24 + bottomInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 34,
                child: Row(
                  children: [
                    InkResponse(
                      key: const Key('bstocks-limit-price-back-icon'),
                      onTap: () => Navigator.pop(context),
                      radius: 20,
                      child: const SizedBox(
                        width: 20,
                        height: 34,
                        child: Icon(Icons.chevron_left, size: 24),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context).limitPrice,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 56),
              Text(
                AppLocalizations.of(context).limitPrice,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.tertiaryText,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              _CenteredLimitPriceInput(
                controller: _controller,
                onChanged: _priceChanged,
              ),
              const SizedBox(height: 8),
              if (market != null && market > 0)
                Center(
                  child: Material(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colors.border),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      key: const Key('bstocks-limit-use-market-price'),
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          _controller.text = _formatDecimal(market);
                          _rulerPrice = market;
                          _deviation = 0;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          AppLocalizations.of(context).market,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 40),
              TpSlTickRuler(
                semanticLabel: AppLocalizations.of(context).dragToSet,
                value: displayedPrice,
                minimum: 0,
                maximum: 20,
                divisions: 20,
                unbounded: true,
                onChanged: _setLimitPriceFromRuler,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _LimitPriceFact(
                    label: AppLocalizations.of(context).market,
                    value: market == null ? '-' : '\$${_formatDecimal(market)}',
                  ),
                  _LimitPriceFact(
                    label: 'Price Deviation',
                    value:
                        '${_deviation >= 0 ? '+' : ''}${_deviation.toStringAsFixed(0)}%',
                    valueColor: _deviation >= 0
                        ? semantic.success
                        : colors.primaryText,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  SizedBox(
                    width: 160,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AppLocalizations.of(context).back),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: price == null || price <= 0
                          ? null
                          : () => Navigator.pop(context, _formatDecimal(price)),
                      child: Text(AppLocalizations.of(context).confirm),
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

class _CenteredLimitPriceInput extends StatelessWidget {
  const _CenteredLimitPriceInput({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.headlineMedium
        ?.copyWith(fontSize: 28, height: 34 / 28, fontWeight: FontWeight.w600);
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final painter = TextPainter(
          text: TextSpan(
            text: value.text.isEmpty ? '0' : value.text,
            style: style,
          ),
          textDirection: TextDirection.ltr,
          maxLines: 1,
        )..layout();
        final inputWidth = (painter.width + 8).clamp(24.0, 220.0);
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(r'$', style: style),
              SizedBox(
                width: inputWidth,
                child: TextField(
                  key: const Key('bstocks-limit-price-sheet-input'),
                  controller: controller,
                  textAlign: TextAlign.left,
                  autofocus: false,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  style: style,
                  decoration: const InputDecoration(
                    isDense: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: onChanged,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LimitPriceFact extends StatelessWidget {
  const _LimitPriceFact({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.tertiaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: valueColor ?? colors.primaryText,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

String _formatDecimal(double value) {
  final text = value.toStringAsFixed(8);
  return text.replaceFirst(RegExp(r'\.?0+$'), '');
}

bool _hasNonZeroValue(DecimalValue? value) =>
    value != null && RegExp(r'[1-9]').hasMatch(value.value);

String _formatDecimalForToken(double value, int? decimals) =>
    _truncateDecimal(_formatDecimal(value), decimals);

TextInputFormatter _decimalTruncatingFormatter(int decimals) =>
    TextInputFormatter.withFunction((oldValue, newValue) {
      if (!RegExp(r'^\d*\.?\d*$').hasMatch(newValue.text)) return oldValue;
      final separator = newValue.text.indexOf('.');
      if (separator == -1 || newValue.text.length <= separator + 1 + decimals) {
        return newValue;
      }
      final text = newValue.text.substring(0, separator + 1 + decimals);
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: newValue.selection.end.clamp(0, text.length),
        ),
      );
    });

String _truncateDecimal(String value, int? decimals) {
  if (decimals == null || decimals < 0) return value;
  final separator = value.indexOf('.');
  if (separator == -1) return value;
  if (decimals == 0) return value.substring(0, separator);
  final end = separator + 1 + decimals;
  return value.length <= end ? value : value.substring(0, end);
}

String _formatDraggedLimitPrice(double value) {
  if (value.abs() >= 1) return value.round().toString();
  return _formatDecimal(value);
}
