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

  Future<void> _save() async {
    if (_submitting ||
        _pending ||
        _loadingProtection ||
        _protectionLoadFailed) {
      return;
    }
    setState(() {
      _error = null;
      _submitting = true;
    });
    try {
      if (_takeProfitEnabled) requirePositiveDecimal(_takeProfit.text.trim());
      if (_stopLossEnabled) requirePositiveDecimal(_stopLoss.text.trim());
      if (_takeProfitEnabled && _takeIsLimit) {
        requirePositiveDecimal(_takeLimit.text.trim());
      }
      if (_stopLossEnabled && _stopIsLimit) {
        requirePositiveDecimal(_stopLimit.text.trim());
      }
      final hasSet = _takeProfitEnabled || _stopLossEnabled;
      if (hasSet && _sizeChoiceRequired) {
        throw ArgumentError(AppLocalizations.of(context).protectionSizesDiffer);
      }
      if (hasSet && _fixedQuantity) {
        requireWithinPosition(
          _quantity.text.trim(),
          widget.position.quantity.value,
        );
      }
      final clearTake = _hadTakeProfit && !_takeProfitEnabled;
      final clearStop = _hadStopLoss && !_stopLossEnabled;
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
            takeProfit: !_takeProfitEnabled || _takeProfit.text.trim().isEmpty
                ? null
                : _takeProfit.text.trim(),
            stopLoss: !_stopLossEnabled || _stopLoss.text.trim().isEmpty
                ? null
                : _stopLoss.text.trim(),
            stopLimit: _stopLossEnabled && _stopLimit.text.trim().isNotEmpty
                ? _stopLimit.text.trim()
                : null,
            quantity: hasSet && _fixedQuantity ? _quantity.text.trim() : null,
            clearScope: clearScope,
            takeLimit: _takeProfitEnabled && _takeIsLimit
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
    } on ArgumentError catch (error) {
      if (mounted) setState(() => _error = '${error.message}');
    } on FormatException {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context).protectionUpdateRetry,
        );
      }
    } on Object {
      if (mounted) {
        setState(
          () => _error = AppLocalizations.of(context).protectionUpdateFailed,
        );
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
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
                    Text(
                      l10n.takeProfitStopLossTitle,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 26 / 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.2,
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
                Text(l10n.protectionSize),
                DropdownButton<bool>(
                  key: const Key('protection-size-mode'),
                  value: _fixedQuantity,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      value: false,
                      child: Text(l10n.entirePositionDefault),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text(l10n.fixedQuantity),
                    ),
                  ],
                  onChanged: locked
                      ? null
                      : (value) => setState(() {
                          _fixedQuantity = value!;
                          _sizeChoiceRequired = false;
                        }),
                ),
                if (_fixedQuantity)
                  TextField(
                    key: const Key('protection-quantity'),
                    controller: _quantity,
                    enabled: !locked,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.quantitySymbol(widget.position.symbol),
                    ),
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
                if (_sizeChoiceRequired) Text(l10n.protectionSizesDiffer),
                const SizedBox(height: 12),
                Text(
                  _fixedQuantity
                      ? l10n.fixedQuantityNotice
                      : l10n.entirePositionProtectionNotice,
                ),
                Text(l10n.protectionSignatureNotice),
                if (_error case final error?) ...[
                  const SizedBox(height: 12),
                  Text(error),
                ],
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
                                _protectionLoadFailed
                            ? null
                            : _save,
                        child: Text(
                          _submitting ? l10n.loadingLabel : l10n.confirm,
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
    final tone = short ? semantic.loss : semantic.success;
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
