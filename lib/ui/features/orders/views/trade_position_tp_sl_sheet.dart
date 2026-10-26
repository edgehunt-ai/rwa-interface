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
  bool _fixedQuantity = false;
  double _quantityPercent = 100;
  bool _pending = false;
  Hip3ActionSummary? _result;
  var _closingSuccessfulResult = false;
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
    // Each visit creates new protection; existing orders remain independent.
    _takeProfit = TextEditingController();
    _stopLoss = TextEditingController();
    _takeProfit.addListener(_onProtectionPriceChanged);
    _stopLoss.addListener(_onProtectionPriceChanged);
    _quantity.text = absoluteQuantity(widget.position.quantity.value);
    _loadConsent();
  }

  void _onProtectionPriceChanged() {
    if (mounted) setState(() => _error = null);
  }

  /// Both triggers are set relative to what the position is worth now.
  double? get _positionReference => double.tryParse(
    (widget.position.markPrice ?? widget.position.entryPrice)?.value ?? '',
  );

  @override
  void dispose() {
    _takeProfit.removeListener(_onProtectionPriceChanged);
    _stopLoss.removeListener(_onProtectionPriceChanged);
    _takeProfit.dispose();
    _stopLoss.dispose();
    _quantity.dispose();
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

  String? _priceInputError() {
    final l10n = AppLocalizations.of(context);
    final takeProfit = _takeProfitTrigger;
    final stopLoss = _stopLossTrigger;
    final prices = {l10n.takeProfit: ?takeProfit, l10n.stopLoss: ?stopLoss};
    for (final entry in prices.entries) {
      try {
        requirePositiveDecimal(entry.value);
      } on FormatException {
        return '${entry.key}: ${l10n.tpSlInvalidPrice}';
      } on ArgumentError {
        return '${entry.key}: ${l10n.tpSlInvalidPrice}';
      }
    }
    return _directionError(takeProfit, stopLoss);
  }

  String? _inputError(int sizeDecimals) {
    final l10n = AppLocalizations.of(context);
    if (_priceInputError() case final error?) return error;
    if ((_takeProfitTrigger != null || _stopLossTrigger != null) &&
        _fixedQuantity) {
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
    if (_submitting || _pending) return;
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
      for (final (role, trigger) in [
        ('takeProfit', takeProfit),
        ('stopLoss', stopLoss),
      ]) {
        if (trigger == null) continue;
        changes.add(
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: role,
              triggerPrice: DecimalValue(trigger),
              quantity: _fixedQuantity
                  ? DecimalValue(_quantity.text.trim())
                  : null,
            ),
          ),
        );
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

  Future<void> _resumeProtection(Hip3ActionSummary result) async {
    if (_submitting) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref.read(positionCommandProvider).resumeHip3Action(result.actionId);
    } on Hip3ActionPending {
      // The refreshed action decides whether to wait or request another signature.
    } on Object catch (error) {
      if (mounted) setState(() => _error = _specificErrorMessage(error));
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  bool _resumeScheduled = false;

  void _scheduleProtectionSignature(Hip3ActionSummary result) {
    if (_resumeScheduled || _submitting || _error != null) return;
    _resumeScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _resumeScheduled = false;
      if (!mounted || _result?.actionId != result.actionId) return;
      // The user already confirmed this action in the editor. Continue its
      // released signing steps through the same session-bound command.
      _resumeProtection(result);
    });
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

  @override
  Widget build(BuildContext context) {
    ref.watch(positionCommandProvider);
    final l10n = AppLocalizations.of(context);
    final initialResult = _result;
    final refreshedResult = initialResult == null
        ? null
        : ref.watch(hip3ProtectionActionProvider(initialResult.actionId));
    final result = refreshedResult?.value ?? initialResult;
    // Keep the frozen request locked, but let the user retry its existing action
    // after a cancelled signature or transport failure instead of creating one.
    final retryResult =
        _pending && _error != null && result?.canResumePositionAction == true
        ? result
        : null;
    final waiting = _pending && retryResult == null;
    if (refreshedResult?.isLoading == false &&
        refreshedResult?.hasError == false &&
        result?.status == 'awaitingSignature' &&
        result!.canResumePositionAction) {
      _scheduleProtectionSignature(result);
    }
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
    final locked = _submitting || _pending;
    final rulesError = productId == null || sizeDecimalsState?.hasError == true
        ? l10n.hip3TradingContextUnavailable
        : null;
    final priceError = _priceInputError();
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Material(
        color: colors.surfaceBase,
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
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      _SideBadge(side: widget.position.side),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TpSlEditorCard(
                  title: l10n.takeProfit,
                  isLong: widget.position.side == PositionSide.long,
                  isTakeProfit: true,
                  controller: _takeProfit,
                  enabled: _takeProfitEnabled,
                  referencePrice: _positionReference,
                  inputKey: const Key('position-protection-take-profit'),
                  changeKey: const Key('position-take-profit-percent'),
                  rulerKey: const Key('position-take-profit-ruler'),
                  onEnabledChanged: locked
                      ? null
                      : (value) => setState(() => _takeProfitEnabled = value),
                ),
                const SizedBox(height: 12),
                TpSlEditorCard(
                  title: l10n.stopLoss,
                  isLong: widget.position.side == PositionSide.long,
                  isTakeProfit: false,
                  controller: _stopLoss,
                  enabled: _stopLossEnabled,
                  referencePrice: _positionReference,
                  inputKey: const Key('position-protection-stop-loss'),
                  changeKey: const Key('position-stop-loss-percent'),
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
                if (_error != null ||
                    rulesError != null ||
                    priceError != null) ...[
                  const SizedBox(height: 20),
                  TpSlInlineError(
                    messages: {?priceError, ?_error, ?rulesError}.toList(),
                  ),
                  const SizedBox(height: 8),
                ] else
                  const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: colors.surfaceSubtle,
                          foregroundColor: colors.textPrimary,
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
                          backgroundColor: colors.actionPrimary,
                          foregroundColor: colors.textInverse,
                        ),
                        onPressed: _submitting || waiting
                            ? null
                            : retryResult != null
                            ? () => _resumeProtection(retryResult)
                            : _consentLoading ||
                                  sizeDecimals == null ||
                                  priceError != null
                            ? null
                            : () => _save(sizeDecimals),
                        child: _submitting || waiting
                            ? const SizedBox.square(
                                dimension: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(l10n.signAndConfirm),
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
      PositionSide.short => (l10n.short, semantic.danger),
      PositionSide.none => ('—', colors.textSecondary),
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
