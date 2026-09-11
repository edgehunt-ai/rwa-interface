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
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';

import 'hip3_preview_details.dart';
import 'hip3_opening_protection_fields.dart';
import '../../../../domain/models/hip3_opening_protection.dart';
import '../../../../domain/models/hip3_opening_context.dart';
import '../../../../domain/models/hip3_opening_size.dart';
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
  var _type = TradingOrderType.market;
  var _inputNotional = true;
  var _marginMode = TradingMarginMode.cross;
  var _leverage = 1;
  Hip3OpeningContext? _context;
  var _contextLoading = true;
  String? _settingKey;
  (int, TradingMarginMode)? _pendingSetting;
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
    _amount.addListener(_scheduleQuote);
    _limitPrice.addListener(_scheduleQuote);
    for (final controller in _protectionPrices) {
      controller.addListener(_scheduleQuote);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _loadContext();
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
        _leverage = context.currentLeverage ?? 1;
        _marginMode = context.currentMarginMode ?? TradingMarginMode.cross;
        if (!context.orderTypes.contains(_type) &&
            context.orderTypes.isNotEmpty) {
          _type = context.orderTypes.first;
        }
        _error = context.blocker;
      });
      _scheduleQuote();
    } on Object {
      if (mounted && ref.read(sessionGenerationProvider) == generation) {
        setState(
          () => _error = AppLocalizations.of(context).loadingTradingRules,
        );
      }
    } finally {
      if (mounted && ref.read(sessionGenerationProvider) == generation) {
        setState(() => _contextLoading = false);
      }
    }
  }

  Future<void> _applySettings(int leverage, TradingMarginMode mode) async {
    final openingContext = _context;
    if (openingContext == null || _submitting) return;
    if (leverage < 1 ||
        leverage > openingContext.maximumLeverage ||
        !openingContext.marginModes.contains(mode) ||
        !openingContext.operations.contains('setLeverage')) {
      setState(
        () => _error = AppLocalizations.of(context).chooseMarginLeverage,
      );
      return;
    }
    final generation = ref.read(sessionGenerationProvider);
    final setting = (leverage, mode);
    if (_pendingSetting != null && _pendingSetting != setting) return;
    _pendingSetting = setting;
    _settingKey ??= 'hip3-leverage-${DateTime.now().microsecondsSinceEpoch}';
    setState(() {
      _submitting = true;
      _quotePreview = null;
    });
    try {
      final refreshed = await ref
          .read(hip3OpeningRepositoryProvider)
          .setLeverage(
            openingContext.productId,
            leverage,
            mode,
            idempotencyKey: _settingKey!,
          );
      if (!mounted || ref.read(sessionGenerationProvider) != generation) return;
      setState(() {
        _context = refreshed;
        _leverage = refreshed.currentLeverage!;
        _marginMode = refreshed.currentMarginMode!;
        _pendingSetting = null;
        _settingKey = null;
        _error = null;
      });
      _scheduleQuote();
    } on Object {
      if (mounted && ref.read(sessionGenerationProvider) == generation) {
        setState(
          () => _error = AppLocalizations.of(context).settingsNotConfirmed,
        );
      }
    } finally {
      if (mounted && ref.read(sessionGenerationProvider) == generation) {
        setState(() => _submitting = false);
      }
    }
  }

  @override
  void dispose() {
    _quoteDebounce?.cancel();
    _previewExpiry?.cancel();
    _amount.removeListener(_scheduleQuote);
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

  void _scheduleQuote() {
    _quoteDebounce?.cancel();
    final generation = ++_quoteGeneration;
    final intent = _intentFromFields();
    // Update the entered amount/unit immediately, even before a quote returns.
    setState(() {
      if (_quotePreview?.intent.fingerprint != intent?.fingerprint) {
        _quotePreview = null;
      }
    });
    if (_context == null || _pendingSetting != null || intent == null) return;
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
    final generation = ref.read(sessionGenerationProvider);
    bool isCurrent() =>
        mounted && ref.read(sessionGenerationProvider) == generation;
    if (_context == null || _contextLoading || _pendingSetting != null) return;
    if (_context!.isExpired) {
      await _loadContext();
      if (!isCurrent() || _context == null || _context!.isExpired) return;
    }
    final rawAmount = _amount.text.trim();
    if (rawAmount.isEmpty) {
      setState(() => _error = AppLocalizations.of(context).enterOrderValue);
      return;
    }
    final rawLimitPrice = _limitPrice.text.trim();
    if (_type == TradingOrderType.limit && rawLimitPrice.isEmpty) {
      setState(() => _error = 'Enter a valid limit price.');
      return;
    }
    try {
      final intent = _intentFromFields();
      if (intent == null) {
        setState(
          () => _error = _showTpSl
              ? 'Enter valid order values and at least one positive protection trigger. Each protection limit needs its trigger.'
              : 'Enter a positive quantity or order value and a valid limit price.',
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
            ? 'Order was not submitted. Try again.'
            : null;
      });
    } on Hip3ExecutionPending catch (pending) {
      if (!isCurrent()) return;
      setState(() {
        _pendingOrderId = pending.orderId;
        _error = pending.requiresReview
            ? 'This order needs review. Do not place a replacement order.'
            : 'Confirming this order. Retry to check the same order; do not place a replacement.';
      });
    } on Hip3SigningFailure catch (failure) {
      if (!isCurrent()) return;
      setState(() => _error = _signingError(failure));
    } on Object {
      if (!isCurrent()) return;
      setState(() => _error = 'Unable to sign this order. Try again.');
    } finally {
      if (isCurrent()) setState(() => _submitting = false);
    }
  }

  String _signingError(Hip3SigningFailure failure) => switch (failure.code) {
    Hip3SigningFailureCode.walletMismatch => AppLocalizations.of(
      context,
    ).walletConnectRequired,
    Hip3SigningFailureCode.actionExpired =>
      'This signing request expired. Prepare the order again.',
    Hip3SigningFailureCode.rejected => AppLocalizations.of(
      context,
    ).signatureCancelled,
    Hip3SigningFailureCode.actionNotReady =>
      'The order is still being prepared. Try again.',
    Hip3SigningFailureCode.walletUnavailable =>
      'The signing wallet is unavailable. Reconnect and try again.',
    Hip3SigningFailureCode.invalidPayload =>
      'The signing request is invalid. Prepare the order again.',
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
        _pendingSetting = null;
        _settingKey = null;
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
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
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
                if (_contextLoading)
                  Text(AppLocalizations.of(context).loadingTradingRules),
                if (_context == null && !_contextLoading)
                  TextButton(
                    onPressed: _loadContext,
                    child: Text(AppLocalizations.of(context).retryTradingRules),
                  ),
                if (_context case final rules?) ...[
                  if (rules.orderTypes.length > 1)
                    _Hip3SegmentedControl<TradingOrderType>(
                      values: rules.orderTypes.toList(),
                      selected: _type,
                      selectedColor: actionColor,
                      label: (type) => type == TradingOrderType.market
                          ? AppLocalizations.of(context).market
                          : AppLocalizations.of(context).limit,
                      onChanged: (type) {
                        if (_submitting) return;
                        setState(() {
                          _type = type;
                          _inputNotional = type == TradingOrderType.market;
                          _amount.clear();
                          _quotePreview = null;
                        });
                      },
                    ),
                  if (_type == TradingOrderType.limit)
                    TextField(
                      controller: _limitPrice,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: InputDecoration(
                        labelText: '${l10n.limitPrice} (USDC)',
                      ),
                    ),
                ],
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
                const SizedBox(height: 12),
                _Hip3SegmentedControl<bool>(
                  values: const [true, false],
                  selected: _inputNotional,
                  selectedColor: actionColor,
                  label: (notional) =>
                      notional ? '${l10n.amount} (USDC)' : l10n.quantity,
                  onChanged: (notional) {
                    if (_submitting) return;
                    setState(() {
                      _inputNotional = notional;
                      _amount.clear();
                      _quotePreview = null;
                      _percentage = 0;
                    });
                  },
                ),
                const SizedBox(height: 12),
                _Hip3ModeLeverageCard(
                  marginMode: _marginMode,
                  leverage: _leverage,
                  controller: _amount,
                  settlementAsset: settlementAsset,
                  inputAsset: _inputNotional ? settlementAsset : widget.symbol,
                  quantityInput: !_inputNotional,
                  availableMargin: _context?.availableMargin.value,
                  percentage: _percentage,
                  onMarginModeTap: () {
                    final rules = _context;
                    if (rules == null ||
                        _pendingSetting != null ||
                        _submitting) {
                      return;
                    }
                    final generation = ref.read(sessionGenerationProvider);
                    showModalBottomSheet<TradingMarginMode>(
                      context: context,
                      builder: (_) => Hip3MarginModeSheet(
                        selectedMode: _marginMode,
                        availableModes: rules.marginModes,
                      ),
                    ).then((mode) {
                      if (mode != null &&
                          mounted &&
                          mode != _marginMode &&
                          ref.read(sessionGenerationProvider) == generation) {
                        _applySettings(_leverage, mode);
                      }
                    });
                  },
                  onLeverageTap: () async {
                    final generation = ref.read(sessionGenerationProvider);
                    final rules = _context;
                    if (rules == null ||
                        _submitting ||
                        _pendingSetting != null) {
                      return;
                    }
                    final leverage = await showModalBottomSheet<int>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => Hip3LeverageSheet(
                        initialLeverage: _leverage,
                        maximumLeverage: rules.maximumLeverage,
                      ),
                    );
                    if (leverage != null &&
                        mounted &&
                        ref.read(sessionGenerationProvider) == generation) {
                      await _applySettings(leverage, _marginMode);
                    }
                  },
                  onPercentageChanged: (value) {
                    final quote = _quotePreview;
                    final rules = _context;
                    if (quote?.hip3Execution == null ||
                        quote!.isExpired ||
                        rules == null) {
                      setState(
                        () => _error = 'Enter an amount to get a current maximum quantity before using the percentage slider.',
                      );
                      return;
                    }
                    final input = hip3OpeningPercentage(
                      quote.hip3Execution!,
                      (value * 100).round(),
                      rules.sizeDecimals,
                      notional: _inputNotional,
                    );
                    setState(() {
                      _percentage = value;
                      _amount.text = input;
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
                    setState(() => _showTpSl = !_showTpSl);
                    _scheduleQuote();
                  },
                ),
                if (_showTpSl)
                  Hip3OpeningProtectionFields(controllers: _protectionPrices),
                if (_error case final error?) ...[
                  const SizedBox(height: 8),
                  Text(
                    error,
                    style: TextStyle(color: semantic.loss, fontSize: 12),
                  ),
                ],
                if (_pendingSetting case final setting?)
                  TextButton(
                    onPressed: _submitting
                        ? null
                        : () => _applySettings(setting.$1, setting.$2),
                    child: Text(l10n.retry),
                  ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: actionColor),
                    onPressed:
                        _submitting ||
                            _contextLoading ||
                            _context == null ||
                            _pendingSetting != null ||
                            _context?.blocker != null ||
                            !_context!.operations.contains('placeOrder') ||
                            !_context!.orderTypes.contains(_type) ||
                            !_context!.marginModes.contains(_marginMode)
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
              title:
                  'Review ${_preview!.intent.side == TradingSide.long ? AppLocalizations.of(context).long : AppLocalizations.of(context).short} ${_preview!.intent.symbol}',
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
                ? AppLocalizations.of(context).tradeSuccessful
                : AppLocalizations.of(context).orderSubmitted,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          if (_preview?.intent.openingProtection != null)
            const Text(
              'Attached protection is not confirmed active. Check protection orders for the current status.',
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
        'Liquidation Price',
        execution?.liquidationPrice?.value ?? 'Unavailable',
      ),
      const SizedBox(height: 8),
      _Hip3RiskRow(
        'Margin Required',
        '${execution?.marginRequired.value ?? '—'} $settlementAsset',
      ),
      if (execution case final value?)
        _Hip3RiskRow('Maximum quantity', value.maximumQuantity.value),
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
                  'TP/SL',
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
                showTpSl ? 'Remove' : 'Add',
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
      const _Hip3Badge('HIP-3 Perps'),
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
    required this.inputAsset,
    required this.quantityInput,
    this.availableMargin,
    required this.percentage,
    required this.onMarginModeTap,
    required this.onLeverageTap,
    required this.onPercentageChanged,
  });

  final TradingMarginMode marginMode;
  final int leverage;
  final TextEditingController controller;
  final String settlementAsset;
  final String inputAsset;
  final bool quantityInput;
  final String? availableMargin;
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
                      quantityInput ? 'Quantity' : 'Order Value',
                      style: TextStyle(
                        fontSize: 11,
                        color: colors.secondaryText,
                      ),
                    ),
                    Text(
                      'Margin: ${availableMargin ?? '—'} USDC',
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

class Hip3MarginModeSheet extends StatelessWidget {
  const Hip3MarginModeSheet({
    super.key,
    required this.selectedMode,
    required this.availableModes,
  });

  final TradingMarginMode selectedMode;
  final Set<TradingMarginMode> availableModes;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Material(
      color: colors.surface,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Margin mode',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              for (final mode in TradingMarginMode.values)
                _MarginModeOption(
                  mode: mode,
                  selected: mode == selectedMode,
                  enabled: availableModes.contains(mode),
                  onTap: () => Navigator.of(context).pop(mode),
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
    required this.onTap,
  });

  final TradingMarginMode mode;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final label = mode == TradingMarginMode.cross ? 'Cross' : 'Isolated';
    return Semantics(
      button: enabled,
      selected: selected,
      label: '$label margin mode',
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: selected ? colors.selected : colors.subtleSurface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: enabled ? null : colors.tertiaryText,
                  ),
                ),
              ),
              if (selected) const Icon(Icons.check, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// Leverage selection is kept inside the HIP-3 presentation layer so its
/// result remains local UI state until an order preview is requested.
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
                      max: widget.maximumLeverage.toDouble(),
                      divisions: widget.maximumLeverage > 1
                          ? widget.maximumLeverage - 1
                          : null,
                      label: '${_leverage}x',
                      onChanged: (value) =>
                          setState(() => _leverage = value.round()),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    for (final option in {
                      1,
                      2,
                      5,
                      10,
                      widget.maximumLeverage,
                    }.where((n) => n <= widget.maximumLeverage)) ...[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: option == widget.maximumLeverage ? 0 : 8,
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
