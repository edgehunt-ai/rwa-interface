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
import 'package:rwa_interface/app/providers/observability_providers.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:rwa_interface/ui/features/orders/views/tp_sl_editor_card.dart';

import 'hip3_preview_details.dart';
import '../../../../domain/models/hip3_opening_protection.dart';
import '../../../../domain/models/hip3_opening_context.dart';
import '../../../../app/providers/session_scope.dart';

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
  final _protectionPrices = List.generate(4, (_) => TextEditingController());
  var _side = TradingSide.long;
  final _type = TradingOrderType.market;
  final _inputNotional = true;
  var _marginMode = TradingMarginMode.cross;
  var _leverage = 20;
  Hip3OpeningContext? _context;
  var _contextLoading = true;
  Object? _contextError;
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
  Timer? _previewExpiry;
  var _quoteGeneration = 0;

  @override
  void initState() {
    super.initState();
    _side = widget.initialSide;
    _reduceOnly = widget.initialReduceOnly;
    _amount.addListener(_onAmountChanged);
    _limitPrice.addListener(_scheduleQuote);
    for (final controller in _protectionPrices) {
      controller.addListener(_scheduleQuote);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.invalidate(tradingAccountsProvider);
        ref.invalidate(hip3OrderAvailableBalanceProvider);
        _loadContext();
      }
    });
  }

  Future<void> _loadContext() async {
    final generation = ref.read(sessionGenerationProvider);
    setState(() => _contextLoading = true);
    try {
      ref.invalidate(hip3OpeningContextProvider(widget.symbol));
      final context = await ref.read(
        hip3OpeningContextProvider(widget.symbol).future,
      );
      if (!mounted || ref.read(sessionGenerationProvider) != generation) return;
      setState(() {
        _context = context;
        _contextError = null;
        _leverage = context.currentLeverage ?? 20;
        _marginMode = context.currentMarginMode ?? TradingMarginMode.cross;
        _error = null;
      });
      _scheduleQuote();
    } on Object catch (error, stackTrace) {
      // Without a context there is no quote and no submission; surface it
      // instead of leaving the panel silently inert.
      ref
          .read(observabilityReporterProvider)
          .recordError(
            operation: 'hip3.trading_context.load',
            error: error,
            stackTrace: stackTrace,
          );
      if (mounted && ref.read(sessionGenerationProvider) == generation) {
        setState(() {
          _contextError = error;
          _error = AppLocalizations.of(context).hip3TradingContextUnavailable;
        });
      }
    } finally {
      if (mounted && ref.read(sessionGenerationProvider) == generation) {
        setState(() => _contextLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _quoteDebounce?.cancel();
    _previewExpiry?.cancel();
    _amount.removeListener(_onAmountChanged);
    _limitPrice.removeListener(_scheduleQuote);
    _amount.dispose();
    _limitPrice.dispose();
    for (final controller in _protectionPrices) {
      controller.removeListener(_scheduleQuote);
      controller.dispose();
    }
    super.dispose();
  }

  OrderIntent? _intentFromFields() {
    final rawAmount = _amount.text.trim();
    if (rawAmount.isEmpty) return null;
    final rawLimitPrice = _limitPrice.text.trim();
    if (_type == TradingOrderType.limit && rawLimitPrice.isEmpty) return null;
    try {
      if (DecimalValue(rawAmount).compareTo(DecimalValue('0')) <= 0) {
        return null;
      }
      return OrderIntent(
        symbol: widget.symbol,
        kind: MarketProductKind.perp,
        side: _side,
        type: _type,
        amount: _inputNotional
            ? DecimalValue(rawAmount, asset: 'USDC', unit: 'token')
            : null,
        quantity: !_inputNotional
            ? DecimalValue(rawAmount, asset: widget.symbol, unit: 'token')
            : null,
        limitPrice: _type == TradingOrderType.limit
            ? DecimalValue(rawLimitPrice, asset: 'USD', unit: 'fiat')
            : null,
        leverage: DecimalValue('$_leverage', asset: 'x', unit: 'multiple'),
        marginMode: _marginMode,
        reduceOnly: _reduceOnly,
        openingProtection: _openingProtection(),
      );
    } on FormatException {
      return null;
    } on ArgumentError {
      return null;
    }
  }

  Hip3OpeningProtection? _openingProtection() {
    if (!_showTpSl) return null;
    Hip3OpeningProtectionLeg? leg(int index) {
      final trigger = _protectionPrices[index].text.trim();
      final limit = _protectionPrices[index + 1].text.trim();
      if (trigger.isEmpty) {
        if (limit.isNotEmpty) {
          throw const FormatException('A limit needs its trigger');
        }
        return null;
      }
      return Hip3OpeningProtectionLeg(
        triggerPrice: DecimalValue(trigger, asset: 'USDC', unit: 'price'),
        limitPrice: limit.isEmpty
            ? null
            : DecimalValue(limit, asset: 'USDC', unit: 'price'),
      );
    }

    return Hip3OpeningProtection(takeProfit: leg(0), stopLoss: leg(2));
  }

  /// A limit order prices its protection off the limit; a market order off
  /// the live quote.
  double? _protectionReference() {
    if (_type == TradingOrderType.limit) {
      final limit = double.tryParse(_limitPrice.text.trim());
      if (limit != null) return limit;
    }
    final snapshot = ref
        .read(
          marketSnapshotProvider(
            MarketProductRef(
              symbol: widget.symbol,
              kind: MarketProductKind.perp,
            ),
          ),
        )
        .value;
    return double.tryParse(snapshot?.price.value ?? '');
  }

  Future<void> _editTpSl() async {
    final result = await showModalBottomSheet<_Hip3TpSlSelection>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _Hip3TpSlSheet(
        symbol: widget.symbol,
        side: _side,
        takeProfit: _protectionPrices[0].text,
        stopLoss: _protectionPrices[2].text,
        referencePrice: _protectionReference(),
      ),
    );
    if (result == null || !mounted) return;
    setState(() {
      _showTpSl = result.hasProtection;
      _protectionPrices[0].text = result.takeProfit ?? '';
      _protectionPrices[1].clear();
      _protectionPrices[2].text = result.stopLoss ?? '';
      _protectionPrices[3].clear();
      _quotePreview = null;
    });
    _scheduleQuote();
  }

  void _removeTpSl() {
    setState(() {
      _showTpSl = false;
      _quotePreview = null;
      for (final controller in _protectionPrices) {
        controller.clear();
      }
    });
    _scheduleQuote();
  }

  void _scheduleQuote() {
    _quoteDebounce?.cancel();
    final generation = ++_quoteGeneration;
    final intent = _intentFromFields();
    _syncPercentageFromAmount();
    // Update the entered amount/unit immediately, even before a quote returns.
    setState(() {
      if (_quotePreview?.intent.fingerprint != intent?.fingerprint) {
        _quotePreview = null;
      }
    });
    if (_context == null || intent == null) return;
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

  /// The trading context never arrived, so the product rules are unknown and
  /// the order cannot be validated locally.
  void _reportUnavailableContext() {
    ref
        .read(observabilityReporterProvider)
        .recordError(
          operation: 'hip3.order.review_without_context',
          error:
              _contextError ??
              StateError(
                'HIP3 trading context unavailable for ${widget.symbol}',
              ),
          stackTrace: StackTrace.current,
        );
    final message = AppLocalizations.of(context).hip3TradingContextUnavailable;
    AppToast.showFailure(context, message);
    setState(() => _error = message);
  }

  (double, double)? _amountBounds(DecimalValue? balance) {
    final rules = _context;
    if (rules == null || balance == null) return null;
    final minimum = double.tryParse(rules.minimumNotional.value);
    final affordable = double.tryParse(balance.value);
    if (minimum == null || affordable == null) return null;
    final maximumRule = rules.maximumNotional == null
        ? double.infinity
        : double.tryParse(rules.maximumNotional!.value) ?? 0;
    final maximum = affordable.clamp(0, maximumRule).toDouble();
    return (minimum, maximum < minimum ? minimum : maximum);
  }

  void _onAmountChanged() {
    _scheduleQuote();
    if (_error != null && mounted) setState(() => _error = null);
  }

  String? _amountError(DecimalValue? balance) {
    final rules = _context;
    final available = balance == null ? null : double.tryParse(balance.value);
    final amount = double.tryParse(_amount.text.trim());
    if (rules == null || available == null || amount == null) return null;
    if (amount > available) {
      return AppLocalizations.of(context).hip3InsufficientBalance;
    }
    final maximum = rules.maximumNotional == null
        ? null
        : double.tryParse(rules.maximumNotional!.value);
    if (maximum != null && amount > maximum) {
      return AppLocalizations.of(context)
          .hip3NotionalAboveMaximum(rules.maximumNotional!.value);
    }
    return null;
  }

  void _syncPercentageFromAmount() {
    final bounds = _amountBounds(
      ref.read(hip3OrderAvailableBalanceProvider).value,
    );
    if (bounds == null) return;
    final amount = double.tryParse(_amount.text.trim());
    final next = amount == null || amount <= bounds.$1 || bounds.$2 <= bounds.$1
        ? 0.0
        : ((amount - bounds.$1) / (bounds.$2 - bounds.$1)).clamp(0.0, 1.0);
    if ((next - _percentage).abs() > 0.001 && mounted) {
      setState(() => _percentage = next);
    }
  }

  /// Checks the composed order against the server's product rules so an
  /// unsupported combination is refused before a signature is requested.
  String? _ruleViolation(Hip3OpeningContext rules) {
    final l10n = AppLocalizations.of(context);
    if (_leverage < 1 || _leverage > rules.maximumLeverage) {
      return l10n.hip3LeverageAboveMaximum('${rules.maximumLeverage}');
    }
    if (!rules.marginModes.contains(_marginMode)) {
      return l10n.hip3MarginModeUnsupported;
    }
    if (!_inputNotional) return null;
    final DecimalValue notional;
    try {
      notional = DecimalValue(_amount.text.trim());
    } on Object {
      return null; // Malformed input is reported by the existing intent check.
    }
    if (notional.compareTo(rules.minimumNotional) < 0) {
      return l10n.hip3NotionalBelowMinimum(rules.minimumNotional.value);
    }
    if (rules.maximumNotional case final maximum?) {
      if (notional.compareTo(maximum) > 0) {
        return l10n.hip3NotionalAboveMaximum(maximum.value);
      }
    }
    return null;
  }

  Future<void> _review() async {
    final generation = ref.read(sessionGenerationProvider);
    bool isCurrent() =>
        mounted && ref.read(sessionGenerationProvider) == generation;
    if (_contextLoading) return;
    if (_context == null) {
      _reportUnavailableContext();
      return;
    }
    if (_context!.isExpired) {
      await _loadContext();
      if (!mounted || !isCurrent()) return;
      if (_context == null || _context!.isExpired) {
        _reportUnavailableContext();
        return;
      }
    }
    if (_amountError(ref.read(hip3OrderAvailableBalanceProvider).value) !=
        null) {
      return;
    }
    if (_ruleViolation(_context!) case final violation?) {
      AppToast.showFailure(context, violation);
      setState(() => _error = violation);
      return;
    }
    final rawAmount = _amount.text.trim();
    if (rawAmount.isEmpty) {
      setState(() => _error = AppLocalizations.of(context).enterOrderValue);
      return;
    }
    final rawLimitPrice = _limitPrice.text.trim();
    if (_type == TradingOrderType.limit && rawLimitPrice.isEmpty) {
      setState(() => _error = AppLocalizations.of(context).validLimitPrice);
      return;
    }
    try {
      final intent = _intentFromFields();
      if (intent == null) {
        setState(
          () => _error = _showTpSl
              ? AppLocalizations.of(context).hip3InvalidOrderWithProtection
              : AppLocalizations.of(context).hip3InvalidOrderInputs,
        );
        return;
      }
      setState(() {
        _error = null;
        _submitting = true;
      });
      final cachedQuote = _quotePreview;
      final preview =
          cachedQuote?.intent.fingerprint == intent.fingerprint &&
              cachedQuote?.isExpired == false
          ? cachedQuote
          : await ref.read(orderPreviewProvider(intent).future);
      if (isCurrent()) {
        setState(() => _preview = preview);
        _previewExpiry?.cancel();
        final expiry = preview?.expiresAt;
        if (expiry != null && expiry.isAfter(DateTime.now().toUtc())) {
          _previewExpiry = Timer(expiry.difference(DateTime.now().toUtc()), () {
            if (isCurrent()) setState(() {});
          });
        }
      }
    } on FormatException {
      if (isCurrent()) {
        setState(
          () => _error = AppLocalizations.of(context).enterValidOrderValues,
        );
      }
    } on Object {
      if (isCurrent()) {
        setState(
          () => _error = AppLocalizations.of(context).prepareOrderFailed,
        );
      }
    } finally {
      if (isCurrent()) {
        setState(() => _submitting = false);
      }
    }
  }

  Future<void> _submit() async {
    final generation = ref.read(sessionGenerationProvider);
    bool isCurrent() =>
        mounted && ref.read(sessionGenerationProvider) == generation;
    final preview = _preview;
    if (preview == null) return;
    if (_pendingOrderId == null &&
        (preview.hip3Execution == null ||
            !preview.openingProtectionMatchesIntent ||
            preview.expiresAt == null ||
            preview.isExpired)) {
      setState(
        () => _error = AppLocalizations.of(context).orderQuoteUnavailable,
      );
      return;
    }
    setState(() => _submitting = true);
    try {
      var submitted = _pendingOrderId != null
          ? await ref
                .read(hip3OrderExecutionRepositoryProvider)
                .awaitActionAndSubmit(_pendingOrderId!)
          : await ref
                .read(orderCommandProvider.notifier)
                .submit(preview.intent, previewId: preview.previewId);
      if (!isCurrent()) return;
      if (submitted?.resource.status == TradingOrderStatus.pendingSignature) {
        _pendingOrderId = submitted!.resource.orderId;
        submitted = await ref
            .read(hip3OrderExecutionRepositoryProvider)
            .awaitActionAndSubmit(_pendingOrderId!);
      }
      if (!isCurrent()) return;
      ref.invalidate(hip3OrdersProvider);
      setState(() {
        _submitted = submitted?.resource;
        _error = submitted == null
            ? AppLocalizations.of(context).orderSubmissionFailed
            : null;
      });
    } on Hip3ExecutionPending catch (pending) {
      if (!isCurrent()) return;
      setState(() {
        _pendingOrderId = pending.orderId;
        _error = pending.requiresReview
            ? AppLocalizations.of(context).hip3OrderNeedsReview
            : AppLocalizations.of(context).hip3OrderConfirming;
      });
    } on Hip3SigningFailure catch (failure) {
      if (!isCurrent()) return;
      setState(() => _error = _signingError(failure));
    } on Object {
      if (!isCurrent()) return;
      setState(() => _error = AppLocalizations.of(context).prepareOrderFailed);
    } finally {
      if (isCurrent()) setState(() => _submitting = false);
    }
  }

  String _signingError(Hip3SigningFailure failure) => switch (failure.code) {
    Hip3SigningFailureCode.walletMismatch => AppLocalizations.of(
      context,
    ).walletConnectRequired,
    Hip3SigningFailureCode.actionExpired => AppLocalizations.of(
      context,
    ).hip3SigningRequestExpired,
    Hip3SigningFailureCode.rejected => AppLocalizations.of(
      context,
    ).signatureCancelled,
    Hip3SigningFailureCode.actionNotReady => AppLocalizations.of(
      context,
    ).hip3OrderStillPreparing,
    Hip3SigningFailureCode.walletUnavailable => AppLocalizations.of(
      context,
    ).hip3SigningWalletUnavailable,
    Hip3SigningFailureCode.invalidPayload => AppLocalizations.of(
      context,
    ).hip3SigningRequestInvalid,
  };

  @override
  Widget build(BuildContext context) {
    ref.listen(sessionGenerationProvider, (previous, next) {
      if (previous == next) return;
      _quoteDebounce?.cancel();
      _previewExpiry?.cancel();
      ++_quoteGeneration;
      setState(() {
        _context = null;
        _preview = null;
        _quotePreview = null;
        _submitted = null;
        _pendingOrderId = null;
        _error = null;
        _submitting = false;
        _amount.clear();
        _limitPrice.clear();
        _showTpSl = false;
        for (final controller in _protectionPrices) {
          controller.clear();
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadContext();
      });
    });
    if (_submitted != null) return _result(context);
    if (_preview != null) return _confirmation(context);
    return IgnorePointer(ignoring: _submitting, child: _form(context));
  }

  Widget _form(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final isShort = _side == TradingSide.short || _reduceOnly;
    final actionColor = isShort ? semantic.loss : semantic.success;
    final amount = _amount.text.trim();
    final settlementAsset = _quotePreview?.settlementAsset ?? 'USDC';
    final availableBalance = ref.watch(hip3OrderAvailableBalanceProvider);
    final formError = _amountError(availableBalance.value) ?? _error;
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              24 + MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Hip3SheetHeader(
                  title: _reduceOnly
                      ? l10n.closePosition
                      : '${_side == TradingSide.long ? l10n.long : l10n.short} ${widget.symbol}',
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
                            value == TradingSide.long ? l10n.long : l10n.short,
                        onChanged: (value) {
                          setState(() => _side = value);
                          _scheduleQuote();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                if (_reduceOnly) const SizedBox(height: 12),
                _Hip3ModeLeverageCard(
                  marginMode: _marginMode,
                  leverage: _leverage,
                  maximumLeverage: _context?.maximumLeverage,
                  minimumAmount: _context?.minimumNotional.value,
                  amountBounds: _amountBounds(availableBalance.value),
                  limitPrice: null,
                  controller: _amount,
                  settlementAsset: settlementAsset,
                  inputAsset: _inputNotional ? settlementAsset : widget.symbol,
                  quantityInput: !_inputNotional,
                  availableMargin: availableBalance.value?.value,
                  availableMarginLoading: availableBalance.value == null,
                  percentage: _percentage,
                  onMarginModeTap: () async {
                    if (_submitting) return;
                    final modes =
                        _context?.marginModes ??
                        TradingMarginMode.values.toSet();
                    final generation = ref.read(sessionGenerationProvider);
                    final mode = await showModalBottomSheet<TradingMarginMode>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => Hip3MarginModeSheet(
                        initialMode: _marginMode,
                        availableModes: modes,
                      ),
                    );
                    if (mode == null ||
                        !mounted ||
                        ref.read(sessionGenerationProvider) != generation ||
                        mode == _marginMode) {
                      return;
                    }
                    setState(() {
                      _marginMode = mode;
                      _quotePreview = null;
                      _error = null;
                    });
                    _scheduleQuote();
                  },
                  onLeverageTap: () async {
                    final generation = ref.read(sessionGenerationProvider);
                    final rules = _context;
                    if (_submitting) return;
                    final leverage = await showModalBottomSheet<int>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => Hip3LeverageSheet(
                        initialLeverage: _leverage,
                        maximumLeverage: rules?.maximumLeverage ?? 20,
                      ),
                    );
                    if (leverage != null &&
                        mounted &&
                        ref.read(sessionGenerationProvider) == generation) {
                      setState(() {
                        _leverage = leverage;
                        _quotePreview = null;
                        _error = null;
                      });
                      _scheduleQuote();
                    }
                  },
                  onPercentageChanged: (value) {
                    // A percentage of spendable balance needs no quote, so the
                    // slider works before an amount has been typed.
                    final balance = availableBalance.value;
                    if (balance == null) {
                      setState(() => _percentage = value);
                      return;
                    }
                    final bounds = _amountBounds(balance);
                    if (bounds == null) return;
                    final input = bounds.$1 + (bounds.$2 - bounds.$1) * value;
                    setState(() {
                      _percentage = value;
                      _amount.text = input.toString();
                      _error = null;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Divider(color: colors.subtleSurface),
                const SizedBox(height: 16),
                _Hip3RiskSummary(
                  settlementAsset: settlementAsset,
                  execution: _quotePreview?.hip3Execution,
                  showTpSl: _showTpSl,
                  allowProtection: !_reduceOnly,
                  onTpSlTap: () {
                    if (_reduceOnly) return;
                    if (_showTpSl) {
                      _removeTpSl();
                    } else {
                      _editTpSl();
                    }
                  },
                ),
                if (formError case final error?) ...[
                  const SizedBox(height: 16),
                  _Hip3OrderFailureNotice(
                    key: const Key('hip3-form-error'),
                    message: error,
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: actionColor),
                    // Stays enabled without a context or against unsupported
                    // rules: _review explains the reason instead of leaving a
                    // dead grey button.
                    onPressed:
                        _submitting || _contextLoading || formError != null
                        ? null
                        : _review,
                    child: Text(
                      _submitting
                          ? l10n.preparingOrder
                          : '${_reduceOnly
                                ? l10n.close
                                : _side == TradingSide.long
                                ? l10n.long
                                : l10n.short} ${widget.symbol} · ${_inputNotional ? '\$${amount.isEmpty ? '0' : amount}' : '${amount.isEmpty ? '0' : amount} ${widget.symbol}'}',
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
              title: AppLocalizations.of(context).reviewOrder(
                _preview!.intent.side == TradingSide.long
                    ? AppLocalizations.of(context).long
                    : AppLocalizations.of(context).short,
                _preview!.intent.symbol,
              ),
              leverage:
                  int.tryParse(_preview!.hip3Execution?.leverage.value ?? '') ??
                  _leverage,
              color: _side == TradingSide.short
                  ? Theme.of(context).extension<AppSemanticColors>()!.loss
                  : Theme.of(context).extension<AppSemanticColors>()!.success,
              onClose: () => Navigator.of(context).pop(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Hip3PreviewDetails(preview: _preview!),
              ),
            ),
            if (_pendingOrderId == null &&
                (_preview!.isExpired ||
                    _preview!.hip3Execution == null ||
                    _preview!.expiresAt == null))
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(AppLocalizations.of(context).orderQuoteUnavailable),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _submitting || _pendingOrderId != null
                        ? null
                        : () {
                            _previewExpiry?.cancel();
                            setState(() {
                              _preview = null;
                              _quotePreview = null;
                            });
                            _scheduleQuote();
                          },
                    child: Text(AppLocalizations.of(context).back),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: _actionStyle(context),
                    onPressed:
                        _submitting ||
                            (_pendingOrderId == null &&
                                (_preview!.isExpired ||
                                    _preview!.hip3Execution == null ||
                                    !_preview!.openingProtectionMatchesIntent ||
                                    _preview!.expiresAt == null))
                        ? null
                        : _submit,
                    child: Text(
                      _submitting
                          ? (_pendingOrderId == null
                                ? AppLocalizations.of(context).submitting
                                : AppLocalizations.of(context).checkingOrder)
                          : (_pendingOrderId == null
                                ? AppLocalizations.of(context).confirm
                                : AppLocalizations.of(context)
                                      .checkOrderStatus),
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
                ? AppLocalizations.of(context).tradeSuccessful
                : AppLocalizations.of(context).orderSubmitted,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (_preview?.intent.openingProtection != null)
            Text(AppLocalizations.of(context).openingProtectionPendingNotice),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(AppLocalizations.of(context).closeViewLater),
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

class _Hip3TpSlSelection {
  const _Hip3TpSlSelection({this.takeProfit, this.stopLoss});

  final String? takeProfit;
  final String? stopLoss;
  bool get hasProtection => takeProfit != null || stopLoss != null;
}

class _Hip3TpSlSheet extends StatefulWidget {
  const _Hip3TpSlSheet({
    required this.symbol,
    required this.side,
    required this.takeProfit,
    required this.stopLoss,
    required this.referencePrice,
  });

  final String symbol;
  final TradingSide side;
  final String takeProfit;
  final String stopLoss;
  final double? referencePrice;

  @override
  State<_Hip3TpSlSheet> createState() => _Hip3TpSlSheetState();
}

class _Hip3TpSlSheetState extends State<_Hip3TpSlSheet> {
  late final _takeProfit = TextEditingController(text: widget.takeProfit);
  late final _stopLoss = TextEditingController(text: widget.stopLoss);
  late var _takeProfitEnabled = true;
  late var _stopLossEnabled = true;

  @override
  void dispose() {
    _takeProfit.dispose();
    _stopLoss.dispose();
    super.dispose();
  }

  void _confirm() => Navigator.of(context).pop(
    _Hip3TpSlSelection(
      takeProfit: _takeProfitEnabled && _takeProfit.text.trim().isNotEmpty
          ? _takeProfit.text.trim()
          : null,
      stopLoss: _stopLossEnabled && _stopLoss.text.trim().isNotEmpty
          ? _stopLoss.text.trim()
          : null,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        tooltip: l10n.back,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.chevron_left, size: 24),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.takeProfitStopLossTitle,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 4),
                  child: Text(
                    '${widget.symbol}/USDT  ${widget.side == TradingSide.long ? l10n.buy : l10n.sell}',
                    style: TextStyle(color: colors.secondaryText),
                  ),
                ),
                const SizedBox(height: 16),
                TpSlEditorCard(
                  title: l10n.takeProfit,
                  controller: _takeProfit,
                  enabled: _takeProfitEnabled,
                  referencePrice: widget.referencePrice,
                  inputKey: const Key('opening-protection-0'),
                  rulerKey: const Key('take-profit-ruler'),
                  onEnabledChanged: (value) =>
                      setState(() => _takeProfitEnabled = value),
                ),
                const SizedBox(height: 12),
                TpSlEditorCard(
                  title: l10n.stopLoss,
                  controller: _stopLoss,
                  enabled: _stopLossEnabled,
                  referencePrice: widget.referencePrice,
                  inputKey: const Key('opening-protection-2'),
                  rulerKey: const Key('stop-loss-ruler'),
                  onEnabledChanged: (value) =>
                      setState(() => _stopLossEnabled = value),
                ),
                const SizedBox(height: 48),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: colors.subtleSurface,
                          foregroundColor: colors.primaryText,
                          side: BorderSide.none,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(l10n.back),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        key: const Key('hip3-tp-sl-confirm'),
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.primaryAction,
                          foregroundColor: colors.onPrimaryAction,
                        ),
                        onPressed: _confirm,
                        child: Text(l10n.confirm),
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

class _Hip3RiskSummary extends StatelessWidget {
  const _Hip3RiskSummary({
    required this.settlementAsset,
    required this.showTpSl,
    required this.onTpSlTap,
    this.execution,
    this.allowProtection = true,
  });

  final String settlementAsset;
  final bool showTpSl;
  final VoidCallback onTpSlTap;
  final Hip3PreviewExecution? execution;
  final bool allowProtection;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      _Hip3RiskRow(
        AppLocalizations.of(context).liquidationPrice,
        execution?.liquidationPrice?.value ??
            AppLocalizations.of(context).unavailable,
      ),
      const SizedBox(height: 8),
      _Hip3RiskRow(
        AppLocalizations.of(context).marginRequired,
        '${execution?.marginRequired.value ?? '—'} $settlementAsset',
      ),
      if (execution case final value?)
        _Hip3RiskRow(
          AppLocalizations.of(context).maximumQuantity,
          value.maximumQuantity.value,
        ),
      const SizedBox(height: 8),
      if (allowProtection)
        InkWell(
          key: const Key('hip3-tp-sl-toggle'),
          onTap: onTpSlTap,
          borderRadius: BorderRadius.circular(8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  AppLocalizations.of(context).takeProfitStopLoss,
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
                child: Icon(
                  showTpSl ? Icons.remove : Icons.add,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                showTpSl
                    ? AppLocalizations.of(context).remove
                    : AppLocalizations.of(context).add,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
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
      Expanded(
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
      const SizedBox(width: 4),
      _Hip3Badge('$leverage×'),
      const SizedBox(width: 4),
      _Hip3Badge(AppLocalizations.of(context).hip3Perps),
      IconButton(
        tooltip: AppLocalizations.of(context).close,
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

class _Hip3OrderFailureNotice extends StatelessWidget {
  const _Hip3OrderFailureNotice({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 40),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEEF0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(color: semantic.loss, fontSize: 12),
        ),
      ),
    );
  }
}

class _Hip3ModeLeverageCard extends StatelessWidget {
  const _Hip3ModeLeverageCard({
    required this.marginMode,
    required this.leverage,
    this.maximumLeverage,
    this.minimumAmount,
    this.amountBounds,
    this.limitPrice,
    required this.controller,
    required this.settlementAsset,
    required this.inputAsset,
    required this.quantityInput,
    this.availableMargin,
    required this.availableMarginLoading,
    required this.percentage,
    required this.onMarginModeTap,
    required this.onLeverageTap,
    required this.onPercentageChanged,
  });

  final TradingMarginMode marginMode;
  final int leverage;
  final int? maximumLeverage;
  final String? minimumAmount;
  final (double, double)? amountBounds;

  /// Non-null only for a limit order, which cannot be submitted without it.
  final TextEditingController? limitPrice;
  final TextEditingController controller;
  final String settlementAsset;
  final String inputAsset;
  final bool quantityInput;
  final String? availableMargin;
  final bool availableMarginLoading;
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
                              ? AppLocalizations.of(context).cross
                              : AppLocalizations.of(context).isolated,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
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
                        if (maximumLeverage case final maximum?) ...[
                          const SizedBox(width: 4),
                          Text(
                            AppLocalizations.of(context)
                                .hip3MaximumLeverageHint('$maximum'),
                            key: const Key('hip3-maximum-leverage'),
                            style: TextStyle(
                              fontSize: 11,
                              color: colors.secondaryText,
                            ),
                          ),
                        ],
                        const Icon(Icons.keyboard_arrow_down, size: 18),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: colors.surface),
          if (limitPrice case final controller?) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context).limitPrice,
                    style: TextStyle(fontSize: 11, color: colors.secondaryText),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      key: const Key('hip3-limit-price'),
                      controller: controller,
                      textAlign: TextAlign.end,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,8}'),
                        ),
                      ],
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      decoration: InputDecoration(
                        hintText: '0.0',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: colors.tertiaryText,
                        ),
                        isDense: true,
                        filled: false,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'USDC',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(height: 1, color: colors.surface),
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      quantityInput
                          ? AppLocalizations.of(context).quantity
                          : AppLocalizations.of(context).orderValue,
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.secondaryText,
                      ),
                    ),
                    if (availableMarginLoading || availableMargin == null)
                      const SizedBox(
                        key: Key('hip3-margin-loading'),
                        width: 12,
                        height: 12,
                        child: CircularProgressIndicator(strokeWidth: 1.5),
                      )
                    else
                      Text(
                        AppLocalizations.of(context)
                            .marginValue(availableMargin!),
                        style: const TextStyle(
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
                            hintText: minimumAmount == null
                                ? '0.0'
                                : AppLocalizations.of(context)
                                      .minimumAmountPlaceholder(minimumAmount!),
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
                        inputAsset,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                _Hip3AmountRail(
                  value:
                      amountBounds == null ||
                          amountBounds!.$2 <= amountBounds!.$1
                      ? 0
                      : percentage,
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

  /// Quarter marks are a visual reference only; the slider itself steps by 1%.
  static const _referenceStops = [0.0, 0.25, 0.5, 0.75, 1.0];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      height: 20,
      child: Stack(
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: colors.primaryAction,
              inactiveTrackColor: colors.surface,
              trackHeight: 8,
              thumbColor: colors.primaryAction,
              overlayShape: SliderComponentShape.noOverlay,
              tickMarkShape: SliderTickMarkShape.noTickMark,
              valueIndicatorColor: colors.primaryAction,
              showValueIndicator: ShowValueIndicator.onDrag,
            ),
            child: Slider(
              value: value,
              divisions: 100,
              label: '${(value * 100).round()}%',
              onChanged: onChanged,
            ),
          ),
          // Drawn above the track, inset by the thumb radius so the marks line
          // up with the positions the thumb can actually reach.
          Positioned.fill(
            child: IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: LayoutBuilder(
                  builder: (context, constraints) => Stack(
                    children: [
                      for (final stop in _referenceStops)
                        Positioned(
                          left: (constraints.maxWidth - 4) * stop,
                          top: (constraints.maxHeight - 4) / 2,
                          child: Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: stop <= value
                                  ? colors.onPrimaryAction
                                  : colors.secondaryText,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Hip3MarginModeSheet extends StatelessWidget {
  const Hip3MarginModeSheet({
    super.key,
    required this.initialMode,
    required this.availableModes,
  });

  final TradingMarginMode initialMode;
  final Set<TradingMarginMode> availableModes;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.secondaryText.withValues(alpha: .45),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.marginMode,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.close,
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Divider(color: colors.subtleSurface),
              const SizedBox(height: 12),
              Text(
                l10n.chooseMarginMode,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              _MarginModeOption(
                mode: TradingMarginMode.cross,
                selected: initialMode == TradingMarginMode.cross,
                enabled: availableModes.contains(TradingMarginMode.cross),
                title: l10n.cross,
                description: l10n.crossMarginDescription,
                icon: Icons.account_tree_outlined,
                onTap: () => Navigator.of(context).pop(TradingMarginMode.cross),
              ),
              const SizedBox(height: 12),
              _MarginModeOption(
                mode: TradingMarginMode.isolated,
                selected: initialMode == TradingMarginMode.isolated,
                enabled: availableModes.contains(TradingMarginMode.isolated),
                title: l10n.isolated,
                description: l10n.isolatedMarginDescription,
                icon: Icons.view_agenda_outlined,
                onTap: () =>
                    Navigator.of(context).pop(TradingMarginMode.isolated),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MarginModeOption extends StatelessWidget {
  const _MarginModeOption({
    required this.mode,
    required this.selected,
    required this.enabled,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final TradingMarginMode mode;
  final bool selected;
  final bool enabled;
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      button: enabled,
      selected: selected,
      label: title,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: selected ? colors.selected : colors.subtleSurface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colors.primaryText),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: selected
                            ? colors.primaryText
                            : colors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle, color: Colors.black, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class Hip3LeverageSheet extends StatefulWidget {
  const Hip3LeverageSheet({
    super.key,
    required this.initialLeverage,
    required this.maximumLeverage,
  });

  final int initialLeverage;
  final int maximumLeverage;

  @override
  State<Hip3LeverageSheet> createState() => _Hip3LeverageSheetState();
}

class _Hip3LeverageSheetState extends State<Hip3LeverageSheet> {
  late var _leverage = widget.initialLeverage.clamp(1, widget.maximumLeverage);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final options = [
      for (final option in const [2, 5, 10, 20])
        if (option <= widget.maximumLeverage) option,
      if (![2, 5, 10, 20].contains(widget.maximumLeverage))
        widget.maximumLeverage,
    ];
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
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        tooltip: AppLocalizations.of(context).back,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.chevron_left, size: 24),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      AppLocalizations.of(context).leverage,
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
                TpSlTickRuler(
                  semanticLabel: AppLocalizations.of(context).dragToSetLeverage,
                  value: _leverage.toDouble(),
                  minimum: 1,
                  maximum: widget.maximumLeverage.toDouble(),
                  divisions: widget.maximumLeverage - 1,
                  onChanged: (value) =>
                      setState(() => _leverage = value.round()),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    for (final (index, option) in options.indexed) ...[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: index == options.length - 1 ? 0 : 8,
                          ),
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
                        style: OutlinedButton.styleFrom(
                          backgroundColor: colors.subtleSurface,
                          foregroundColor: colors.primaryText,
                          side: BorderSide.none,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(AppLocalizations.of(context).back),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.primaryAction,
                          foregroundColor: colors.onPrimaryAction,
                        ),
                        onPressed: () => Navigator.of(context).pop(_leverage),
                        child: Text(AppLocalizations.of(context).confirm),
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
      label: AppLocalizations.of(context).setLeverageTo(value),
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
              fontSize: 15,
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
