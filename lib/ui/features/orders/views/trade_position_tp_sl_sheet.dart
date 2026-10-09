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
  bool _sizeChoiceRequired = false;
  bool _pending = false;
  bool _hadTakeProfit = false;
  bool _hadStopLoss = false;
  var _takeProfitEnabled = true;
  var _stopLossEnabled = true;
  var _submitting = false;
  String? _error;
  var _riskAccepted = false;
  var _consentLoading = true;
  final _consentService = const TpSlRiskConsentService();

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
    _stopLimit.text = widget.position.stopLimitPrice?.value ?? '';
    _stopIsLimit = widget.position.stopLimitPrice != null;
    _hadTakeProfit = widget.position.takeProfitPrice != null;
    _hadStopLoss = widget.position.stopLossPrice != null;
    if (_hadTakeProfit || _hadStopLoss) {
      _takeProfitEnabled = _hadTakeProfit;
      _stopLossEnabled = _hadStopLoss;
    }
    if (widget.position.protectionOrderIds.isNotEmpty) {
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
      final orders = await ref.read(
        positionProtectionOrdersProvider(widget.position).future,
      );
      if (!mounted) return;
      final legs = orders.map((o) => o.conditional!).toList();
      if (legs.map((leg) => leg.role).toSet().length != legs.length ||
          legs.any(
            (leg) =>
                leg.triggerReference != 'mark' ||
                !const ['market', 'limit'].contains(leg.executionType) ||
                !const [
                  'entirePosition',
                  'quantity',
                  'percent',
                ].contains(leg.sizeMode),
          )) {
        throw const FormatException(
          'Unsupported or ambiguous existing protection',
        );
      }
      for (final order in orders) {
        final leg = order.conditional!;
        if (leg.role == 'takeProfit') {
          _takeProfit.text = leg.triggerPrice.value;
          _takeIsLimit = leg.executionType == 'limit';
          _takeLimit.text = _takeIsLimit ? order.limitPrice?.value ?? '' : '';
        } else if (leg.role == 'stopLoss') {
          _stopLoss.text = leg.triggerPrice.value;
          _stopLimit.text = leg.executionType == 'limit'
              ? order.limitPrice?.value ?? ''
              : '';
          _stopIsLimit = leg.executionType == 'limit';
        } else {
          throw const FormatException('Unknown protection type');
        }
      }
      final sizes = legs
          .map(
            (leg) => leg.sizeMode == 'entirePosition' ? 'entire' : leg.quantity,
          )
          .toSet();
      setState(() {
        _hadTakeProfit = legs.any((leg) => leg.role == 'takeProfit');
        _hadStopLoss = legs.any((leg) => leg.role == 'stopLoss');
        _takeProfitEnabled = _hadTakeProfit;
        _stopLossEnabled = _hadStopLoss;
        _sizeChoiceRequired = sizes.length > 1;
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
      _sizeChoiceRequired = false;
      _syncQuantityPercent();
      _error = null;
    });
  }

  void _setQuantityPercent(double value) {
    setState(() {
      _quantityPercent = value.roundToDouble();
      _fixedQuantity = _quantityPercent < 100;
      _quantity.text = _fixedQuantity
          ? percentageQuantity(
              widget.position.quantity.value,
              _quantityPercent.round().toString(),
            )
          : '';
      _sizeChoiceRequired = false;
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

  String? _inputError() {
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
        );
      } on FormatException {
        return l10n.protectionInvalidQuantity;
      } on ArgumentError {
        return l10n.protectionInvalidQuantity;
      }
    }
    return null;
  }

  Future<void> _save() async {
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
          onAccepted: () => Navigator.of(context).pop(true),
        ),
      );
      if (accepted != true || !mounted) return;
      await _consentService.record();
      if (!mounted) return;
      setState(() => _riskAccepted = true);
      return;
    }
    if (_inputError() case final error?) {
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
      final hasSet = takeProfit != null || stopLoss != null;
      if (hasSet && _sizeChoiceRequired) {
        throw ArgumentError(AppLocalizations.of(context).protectionSizesDiffer);
      }
      final clearTake = _hadTakeProfit && takeProfit == null;
      final clearStop = _hadStopLoss && stopLoss == null;
      final clearScope = clearTake && clearStop
          ? ProtectionClearScope.both
          : clearTake
          ? ProtectionClearScope.takeProfit
          : clearStop
          ? ProtectionClearScope.stopLoss
          : null;
      if (!hasSet && clearScope == null) {
        Navigator.of(context).pop();
        return;
      }
      await ref
          .read(positionCommandProvider)
          .updateTpSl(
            widget.position,
            takeProfit: takeProfit,
            stopLoss: stopLoss,
            stopLimit: stopLoss != null && _stopIsLimit
                ? _stopLimit.text.trim()
                : null,
            quantity: hasSet && _fixedQuantity ? _quantity.text.trim() : null,
            clearScope: clearScope,
            confirmBeforeSigning: false,
            takeLimit: takeProfit != null && _takeIsLimit
                ? _takeLimit.text.trim()
                : null,
          );
      if (mounted) Navigator.of(context).pop();
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

  @override
  Widget build(BuildContext context) {
    ref.watch(positionCommandProvider);
    final l10n = AppLocalizations.of(context);
    final locked =
        _submitting || _pending || _loadingProtection || _protectionLoadFailed;
    final colors = Theme.of(context).extension<AppRwaColors>()!;
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
                  onQuantityChanged: locked ? null : _setQuantity,
                  onPercentageChanged: locked ? null : _setQuantityPercent,
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
                if (_sizeChoiceRequired)
                  TpSlInlineError(messages: [l10n.protectionSizesDiffer]),
                if (_error case final error?) ...[
                  const SizedBox(height: 12),
                  TpSlInlineError(messages: [error]),
                ],
                const SizedBox(height: 12),
                TpSlConsentRow(
                  accepted: _riskAccepted,
                  onChanged: (value) async {
                    setState(() => _riskAccepted = value);
                    if (value) await _consentService.record();
                  },
                  onOpenDetails: () async {
                    final accepted = await showModalBottomSheet<bool>(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => TpSlRiskAgreementSheet(
                        onAccepted: () => Navigator.of(context).pop(true),
                      ),
                    );
                    if (accepted == true && mounted) {
                      await _consentService.record();
                      setState(() => _riskAccepted = true);
                    }
                  },
                ),
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
                                _consentLoading
                            ? null
                            : _save,
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

/// Soft-tinted Buy/Sell tag that follows the position side.
class _SideBadge extends StatelessWidget {
  const _SideBadge({required this.side});

  final PositionSide side;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final short = side == PositionSide.short;
    final tone = short ? kShortTradeColor : semantic.success;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        short ? l10n.sell : l10n.buy,
        style: TextStyle(color: tone, fontSize: 11, height: 14 / 11),
      ),
    );
  }
}
