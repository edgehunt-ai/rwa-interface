part of 'trade_screen.dart';

class PositionTpSlSheet extends ConsumerStatefulWidget {
  const PositionTpSlSheet({super.key, required this.position});

  final Position position;

  @override
  ConsumerState<PositionTpSlSheet> createState() => _PositionTpSlSheetState();
}

class _PositionTpSlSheetState extends ConsumerState<PositionTpSlSheet> {
  late final TextEditingController _takeProfit;
  late final TextEditingController _stopLoss;
  final _quantity = TextEditingController();
  final _stopLimit = TextEditingController();
  final _takeLimit = TextEditingController();
  bool _takeIsLimit = false;
  bool _stopIsLimit = false;
  bool _fixedQuantity = false;
  double _quantityPercent = 100;
  bool _loadingProtection = false;
  bool _protectionLoadFailed = false;
  bool _pending = false;
  List<Hip3PositionProtectionOrder> _existingOrders = const [];
  final _multipleProtectionRoles = <String>{};
  Hip3ActionSummary? _result;
  var _closingSuccessfulResult = false;
  bool _hadTakeProfit = false;
  bool _hadStopLoss = false;
  var _takeProfitEnabled = true;
  var _stopLossEnabled = true;
  var _submitting = false;
  String? _error;
  var _riskAccepted = false;
  var _consentLoading = true;
  final _consentService = const TpSlRiskConsentService();

  Future<void> _setRiskAccepted(bool value) async {
    setState(() => _riskAccepted = value);
    if (value) await _consentService.record();
  }

  Future<void> _loadConsent() async {
    final accepted = await _consentService.read();
    if (!mounted) return;
    setState(() {
      _riskAccepted = accepted;
      _consentLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _takeProfit = TextEditingController(
      text: widget.position.takeProfitPrice?.value ?? '',
    );
    _stopLoss = TextEditingController(
      text: widget.position.stopLossPrice?.value ?? '',
    );
    _quantity.text = absoluteQuantity(widget.position.quantity.value);
    _stopLimit.text = widget.position.stopLimitPrice?.value ?? '';
    _stopIsLimit = widget.position.stopLimitPrice != null;
    _hadTakeProfit = widget.position.takeProfitPrice != null;
    _hadStopLoss = widget.position.stopLossPrice != null;
    if (_hadTakeProfit || _hadStopLoss) {
      _takeProfitEnabled = _hadTakeProfit;
      _stopLossEnabled = _hadStopLoss;
    }
    if (widget.position.protectionOrderIds.isNotEmpty ||
        widget.position.protectionOrders.isNotEmpty) {
      _loadingProtection = true;
      _loadProtection();
    }
    _loadConsent();
  }

  /// Both triggers are set relative to what the position is worth now.
  double? get _positionReference => double.tryParse(
    (widget.position.markPrice ?? widget.position.entryPrice)?.value ?? '',
  );

  Future<void> _loadProtection() async {
    try {
      var orders = widget.position.protectionOrders;
      if (orders.isEmpty) {
        final legacy = await ref.read(
          positionProtectionOrdersProvider(widget.position).future,
        );
        orders = [
          for (final order in legacy)
            Hip3PositionProtectionOrder(
              orderId: order.orderId,
              protection: Hip3ProtectionParameters(
                role: order.conditional!.role,
                triggerPrice: order.conditional!.triggerPrice,
                triggerReference: order.conditional!.triggerReference,
                quantity: order.conditional!.sizeMode == 'entirePosition'
                    ? null
                    : DecimalValue(order.conditional!.quantity),
                limitPrice: order.conditional!.executionType == 'limit'
                    ? order.limitPrice
                    : null,
              ),
            ),
        ];
      }
      if (!mounted) return;
      if (orders.any(
        (order) =>
            order.protection.triggerReference != 'mark' ||
            !const {'takeProfit', 'stopLoss'}.contains(order.protection.role),
      )) {
        throw const FormatException('Unsupported existing protection');
      }
      setState(() {
        _existingOrders = orders;
        for (final role in ['takeProfit', 'stopLoss']) {
          final matching = orders
              .where((order) => order.protection.role == role)
              .toList();
          if (matching.length == 1) {
            _applyProtection(role, matching.single.protection);
          } else if (matching.length > 1) {
            _multipleProtectionRoles.add(role);
            if (role == 'takeProfit') {
              _hadTakeProfit = true;
              _takeProfitEnabled = true;
            } else {
              _hadStopLoss = true;
              _stopLossEnabled = true;
            }
          } else {
            _clearProtection(role);
          }
        }
        final sizes = orders
            .where(
              (order) =>
                  !_multipleProtectionRoles.contains(order.protection.role),
            )
            .map((order) => order.protection.quantity?.value ?? 'entire')
            .toSet();
        if (sizes.length == 1 && sizes.single != 'entire') {
          _fixedQuantity = true;
          _quantity.text = sizes.single;
          _syncQuantityPercent();
        }
        _loadingProtection = false;
      });
    } on Object {
      if (mounted) {
        setState(() {
          _loadingProtection = false;
          _protectionLoadFailed = true;
          _error = AppLocalizations.of(context).protectionSizesUnavailable;
        });
      }
    }
  }

  void _applyProtection(String role, Hip3ProtectionParameters parameters) {
    if (role == 'takeProfit') {
      _hadTakeProfit = true;
      _takeProfitEnabled = true;
      _takeProfit.text = parameters.triggerPrice.value;
      _takeIsLimit = parameters.limitPrice != null;
      _takeLimit.text = parameters.limitPrice?.value ?? '';
    } else {
      _hadStopLoss = true;
      _stopLossEnabled = true;
      _stopLoss.text = parameters.triggerPrice.value;
      _stopLimit.text = parameters.limitPrice?.value ?? '';
      _stopIsLimit = parameters.limitPrice != null;
    }
    if (parameters.quantity case final quantity?) {
      _fixedQuantity = true;
      _quantity.text = quantity.value;
      _syncQuantityPercent();
    }
  }

  void _clearProtection(String role) {
    if (role == 'takeProfit') {
      _hadTakeProfit = false;
      _takeProfitEnabled = false;
      _takeProfit.clear();
      _takeIsLimit = false;
      _takeLimit.clear();
    } else {
      _hadStopLoss = false;
      _stopLossEnabled = false;
      _stopLoss.clear();
      _stopIsLimit = false;
      _stopLimit.clear();
    }
  }

  @override
  void dispose() {
    _takeProfit.dispose();
    _stopLoss.dispose();
    _quantity.dispose();
    _stopLimit.dispose();
    _takeLimit.dispose();
    super.dispose();
  }

  void _syncQuantityPercent() {
    final quantity = double.tryParse(_quantity.text.trim());
    final available = double.tryParse(
      absoluteQuantity(widget.position.quantity.value),
    );
    _quantityPercent = quantity == null || available == null || available <= 0
        ? 0
        : (quantity / available * 100).clamp(0, 100);
  }

  void _setQuantity(String value) {
    setState(() {
      _fixedQuantity = true;
      _syncQuantityPercent();
      _error = null;
    });
  }

  void _setQuantityPercent(double value, int sizeDecimals) {
    setState(() {
      _quantityPercent = value.roundToDouble();
      _fixedQuantity = _quantityPercent < 100;
      _quantity.text = percentageQuantity(
        widget.position.quantity.value,
        _quantityPercent.round().toString(),
        maxFractionDigits: sizeDecimals,
      );
      _error = null;
    });
  }

  // Zero or an empty trigger means this protection leg is not set. Keep
  // malformed and negative inputs for validation rather than omitting them.
  String? _triggerPrice(String value, {required bool enabled}) {
    final text = value.trim();
    if (!enabled || text.isEmpty || RegExp(r'^-?0(?:\.0+)?$').hasMatch(text)) {
      return null;
    }
    return text;
  }

  String? get _takeProfitTrigger =>
      _triggerPrice(_takeProfit.text, enabled: _takeProfitEnabled);

  String? get _stopLossTrigger =>
      _triggerPrice(_stopLoss.text, enabled: _stopLossEnabled);

  String? _directionError(String? takeProfit, String? stopLoss) {
    final mark = widget.position.markPrice;
    if (mark == null || widget.position.side == PositionSide.none) return null;
    final l10n = AppLocalizations.of(context);
    final isLong = widget.position.side == PositionSide.long;
    final markDisplay = TokenAmountFormatter.formatValue(mark);
    int compare(String price) =>
        DecimalValue(price, asset: mark.asset, unit: mark.unit).compareTo(mark);
    if (takeProfit != null) {
      final comparison = compare(takeProfit);
      if (isLong ? comparison <= 0 : comparison >= 0) {
        return isLong
            ? l10n.positionTakeProfitAboveMark(markDisplay)
            : l10n.positionTakeProfitBelowMark(markDisplay);
      }
    }
    if (stopLoss != null) {
      final comparison = compare(stopLoss);
      if (isLong ? comparison >= 0 : comparison <= 0) {
        return isLong
            ? l10n.positionStopLossBelowMark(markDisplay)
            : l10n.positionStopLossAboveMark(markDisplay);
      }
    }
    return null;
  }

  String? _inputError(int sizeDecimals) {
    final l10n = AppLocalizations.of(context);
    final takeProfit = _takeProfitTrigger;
    final stopLoss = _stopLossTrigger;
    final prices = {
      l10n.takeProfit: ?takeProfit,
      l10n.stopLoss: ?stopLoss,
      if (takeProfit != null && _takeIsLimit)
        l10n.takeProfitLimitPrice: _takeLimit.text.trim(),
      if (stopLoss != null && _stopIsLimit)
        l10n.stopLimitPrice: _stopLimit.text.trim(),
    };
    for (final entry in prices.entries) {
      try {
        requirePositiveDecimal(entry.value);
      } on FormatException {
        return '${entry.key}: ${l10n.tpSlInvalidPrice}';
      } on ArgumentError {
        return '${entry.key}: ${l10n.tpSlInvalidPrice}';
      }
    }
    if (_directionError(takeProfit, stopLoss) case final error?) return error;
    if (prices.isNotEmpty && _fixedQuantity) {
      try {
        requireWithinPosition(
          _quantity.text.trim(),
          widget.position.quantity.value,
          maxFractionDigits: sizeDecimals,
        );
      } on FormatException {
        return l10n.protectionInvalidQuantity;
      } on ArgumentError {
        return l10n.protectionInvalidQuantity;
      }
    }
    return null;
  }

  Future<void> _save(int sizeDecimals) async {
    if (_submitting ||
        _pending ||
        _loadingProtection ||
        _protectionLoadFailed) {
      return;
    }
    if (_consentLoading) return;
    if (!_riskAccepted) {
      final accepted = await showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        builder: (_) => TpSlRiskAgreementSheet(
          initialAccepted: _riskAccepted,
          onChanged: _setRiskAccepted,
          onAccepted: () => Navigator.of(context).pop(true),
        ),
      );
      if (accepted != true || !mounted) return;
      await _consentService.record();
      if (!mounted) return;
      setState(() => _riskAccepted = true);
      return;
    }
    if (_inputError(sizeDecimals) case final error?) {
      setState(() => _error = error);
      return;
    }
    setState(() {
      _error = null;
      _submitting = true;
    });
    try {
      final takeProfit = _takeProfitTrigger;
      final stopLoss = _stopLossTrigger;
      final changes = <Hip3ProtectionChange>[];
      for (final (role, trigger, limit, enabled, rawValue) in [
        (
          'takeProfit',
          takeProfit,
          _takeIsLimit ? _takeLimit.text.trim() : null,
          _takeProfitEnabled,
          _takeProfit.text.trim(),
        ),
        (
          'stopLoss',
          stopLoss,
          _stopIsLimit ? _stopLimit.text.trim() : null,
          _stopLossEnabled,
          _stopLoss.text.trim(),
        ),
      ]) {
        final existing = _existingOrders
            .where((order) => order.protection.role == role)
            .toList(growable: false);
        if (trigger == null) {
          final untouchedAmbiguousRole =
              _multipleProtectionRoles.contains(role) &&
              enabled &&
              rawValue.isEmpty;
          if (!untouchedAmbiguousRole) {
            changes.addAll(
              existing.map(
                (order) => Hip3ProtectionChange.cancel(order.orderId),
              ),
            );
          }
          continue;
        }
        final parameters = Hip3ProtectionParameters(
          role: role,
          triggerPrice: DecimalValue(trigger),
          limitPrice: limit == null ? null : DecimalValue(limit),
          quantity: _fixedQuantity ? DecimalValue(_quantity.text.trim()) : null,
        );
        if (existing.length == 1) {
          final orderId = existing.single.orderId;
          final previous = existing.single.protection;
          if (previous.triggerPrice.value == trigger &&
              previous.limitPrice?.value == limit &&
              previous.quantity?.value == parameters.quantity?.value) {
            continue;
          }
          changes.add(
            Hip3ProtectionChange.modify(
              orderId: orderId,
              protection: parameters,
            ),
          );
        } else if (existing.length > 1) {
          changes.addAll(
            existing.map((order) => Hip3ProtectionChange.cancel(order.orderId)),
          );
          changes.add(Hip3ProtectionChange.create(parameters));
        } else {
          changes.add(Hip3ProtectionChange.create(parameters));
        }
      }
      if (changes.isEmpty) {
        if (mounted) Navigator.of(context).pop();
        return;
      }
      final result = await ref
          .read(positionCommandProvider)
          .manageTpSl(widget.position, changes, confirmBeforeSigning: false);
      if (!mounted) return;
      if (result.isSuccessful) {
        AppToast.showSuccess(
          context,
          AppLocalizations.of(context).protectionConfirmed,
        );
        Navigator.of(context).pop();
      } else {
        setState(() {
          _result = result;
          _pending = !result.isSuccessful;
        });
      }
    } on Hip3ActionPending catch (error) {
      if (mounted) {
        setState(() {
          _pending = true;
          _error = AppLocalizations.of(context)
              .positionProtectionActionPending(error.actionId);
        });
      }
    } on Object catch (error) {
      if (mounted) {
        setState(() => _error = _specificErrorMessage(error));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String _specificErrorMessage(Object error) {
    final l10n = AppLocalizations.of(context);
    final fallback = l10n.tpSlSaveFailed;
    if (error is TimeoutFailure) return l10n.protectionRequestTimedOut;
    if (error is NetworkFailure && (error.userAction?.trim().isEmpty ?? true)) {
      return l10n.networkUnavailableRetry;
    }
    if (error is ApiFailure) {
      return apiFailureMessage(error, fallback: fallback).trim();
    }
    if (error is Hip3SigningFailure) {
      return hip3SigningError(context, error);
    }
    if (error is ArgumentError) {
      final message = error.message?.toString().trim();
      return message == null || message.isEmpty ? fallback : message;
    }
    if (error is FormatException) {
      final message = error.message.trim();
      return message.isEmpty ? fallback : message;
    }
    final message = error.toString().trim();
    if (message.isNotEmpty &&
        message != 'null' &&
        !message.startsWith('Instance of ')) {
      return message;
    }
    return fallback;
  }

  void _closeSuccessfulResult(Hip3ActionSummary result) {
    if (_closingSuccessfulResult) return;
    _closingSuccessfulResult = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _result?.actionId != result.actionId) return;
      AppToast.showSuccess(
        context,
        AppLocalizations.of(context).protectionConfirmed,
      );
      Navigator.of(context).pop();
    });
  }

  Widget _inlineResults(
    Hip3ActionSummary result,
    AsyncValue<Hip3ActionSummary>? refreshed,
  ) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(height: 28),
        Text(
          l10n.protectionBatchResults,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Hip3ProtectionOrderResults(orders: result.protectionOrders),
        if (result.status == 'failed' ||
            result.protectionOrders.any((order) => order.isFailed))
          Text(l10n.protectionPartialFailure),
        if (!result.protectionResultsComplete)
          Text(l10n.protectionWaitingConfirmation),
        if (result.status == 'manualReview') Text(l10n.hip3PendingReview),
        if (result.failureReason case final reason?) Text(reason),
        if (refreshed?.hasError == true) Text(l10n.hip3PendingError),
        if (result.canResumePositionAction)
          OutlinedButton(
            onPressed: _submitting
                ? null
                : () async {
                    setState(() => _submitting = true);
                    try {
                      await ref
                          .read(positionCommandProvider)
                          .resumeHip3Action(result.actionId);
                    } on Object catch (error) {
                      if (mounted) {
                        setState(() => _error = _specificErrorMessage(error));
                      }
                    } finally {
                      if (mounted) {
                        ref.invalidate(
                          hip3ProtectionActionProvider(result.actionId),
                        );
                        setState(() => _submitting = false);
                      }
                    }
                  },
            child: Text(l10n.hip3PendingCheck),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(positionCommandProvider);
    final l10n = AppLocalizations.of(context);
    final initialResult = _result;
    final refreshedResult = initialResult == null
        ? null
        : ref.watch(hip3ProtectionActionProvider(initialResult.actionId));
    final result = refreshedResult?.value ?? initialResult;
    if (result?.isSuccessful == true) _closeSuccessfulResult(result!);
    final productId = widget.position.productId;
    final sizeDecimalsState = productId == null
        ? null
        : ref.watch(positionSizeDecimalsProvider(productId));
    if (productId != null) {
      ref.listen(positionSizeDecimalsProvider(productId), (_, next) {
        next.whenData((decimals) {
          final truncated = truncateQuantity(_quantity.text, decimals);
          if (truncated == _quantity.text) return;
          setState(() {
            _quantity.text = truncated;
            _syncQuantityPercent();
          });
        });
      });
    }
    final sizeDecimals = sizeDecimalsState?.hasError == true
        ? null
        : sizeDecimalsState?.value;
    final locked =
        _submitting || _pending || _loadingProtection || _protectionLoadFailed;
    final rulesError = productId == null || sizeDecimalsState?.hasError == true
        ? l10n.hip3TradingContextUnavailable
        : null;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Material(
        color: colors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
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
                    Expanded(
                      child: Text(
                        l10n.takeProfitStopLossTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          height: 26 / 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 4),
                  child: Row(
                    children: [
                      Text(
                        '${widget.position.symbol}/USDT',
                        style: TextStyle(
                          fontSize: 13,
                          height: 18 / 13,
                          fontWeight: FontWeight.w500,
                          color: colors.secondaryText,
                        ),
                      ),
                      const SizedBox(width: 4),
                      _SideBadge(side: widget.position.side),
                    ],
                  ),
                ),
                if (_loadingProtection) const LinearProgressIndicator(),
                if (result != null && !result.isSuccessful)
                  _inlineResults(result, refreshedResult),
                const SizedBox(height: 16),
                TpSlEditorCard(
                  title: l10n.takeProfit,
                  controller: _takeProfit,
                  enabled: _takeProfitEnabled,
                  referencePrice: _positionReference,
                  inputKey: const Key('position-protection-take-profit'),
                  rulerKey: const Key('position-take-profit-ruler'),
                  onEnabledChanged: locked
                      ? null
                      : (value) => setState(() => _takeProfitEnabled = value),
                ),
                const SizedBox(height: 12),
                TpSlEditorCard(
                  title: l10n.stopLoss,
                  controller: _stopLoss,
                  enabled: _stopLossEnabled,
                  referencePrice: _positionReference,
                  inputKey: const Key('position-protection-stop-loss'),
                  rulerKey: const Key('position-stop-loss-ruler'),
                  onEnabledChanged: locked
                      ? null
                      : (value) => setState(() => _stopLossEnabled = value),
                ),
                const SizedBox(height: 12),
                PositionProtectionQuantityCard(
                  controller: _quantity,
                  symbol: widget.position.symbol,
                  percentage: _quantityPercent,
                  maxFractionDigits: sizeDecimals,
                  onQuantityChanged: locked ? null : _setQuantity,
                  onPercentageChanged: locked || sizeDecimals == null
                      ? null
                      : (value) => _setQuantityPercent(value, sizeDecimals),
                ),
                if (_takeProfitEnabled && _takeIsLimit)
                  TextField(
                    controller: _takeLimit,
                    enabled: !locked,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.takeProfitLimitPrice,
                    ),
                  ),
                if (_stopLossEnabled && _stopIsLimit)
                  TextField(
                    controller: _stopLimit,
                    enabled: !locked,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(labelText: l10n.stopLimitPrice),
                  ),
                const SizedBox(height: 12),
                TpSlConsentRow(
                  accepted: _riskAccepted,
                  onChanged: _setRiskAccepted,
                  onOpenDetails: () async {
                    final accepted = await showModalBottomSheet<bool>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => TpSlRiskAgreementSheet(
                        initialAccepted: _riskAccepted,
                        onChanged: _setRiskAccepted,
                        onAccepted: () => Navigator.of(context).pop(true),
                      ),
                    );
                    if (accepted == true && mounted) {
                      await _consentService.record();
                      setState(() => _riskAccepted = true);
                    }
                  },
                ),
                if (_error != null || rulesError != null) ...[
                  const SizedBox(height: 20),
                  TpSlInlineError(messages: [?_error, ?rulesError]),
                  const SizedBox(height: 8),
                ] else
                  const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: colors.subtleSurface,
                          foregroundColor: colors.primaryText,
                          side: BorderSide.none,
                        ),
                        onPressed: _submitting
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Text(l10n.back),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.primaryAction,
                          foregroundColor: colors.onPrimaryAction,
                        ),
                        onPressed:
                            _submitting ||
                                _pending ||
                                _loadingProtection ||
                                _protectionLoadFailed ||
                                _consentLoading ||
                                sizeDecimals == null
                            ? null
                            : () => _save(sizeDecimals),
                        child: Text(
                          _submitting ? l10n.loadingLabel : l10n.signAndConfirm,
                        ),
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

/// Soft-tinted Long/Short tag that follows the position side.
class _SideBadge extends StatelessWidget {
  const _SideBadge({required this.side});

  final PositionSide side;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final (label, tone) = switch (side) {
      PositionSide.long => (l10n.long, semantic.success),
      PositionSide.short => (l10n.short, kShortTradeColor),
      PositionSide.none => ('—', colors.secondaryText),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(color: tone, fontSize: 11, height: 14 / 11),
      ),
    );
  }
}
