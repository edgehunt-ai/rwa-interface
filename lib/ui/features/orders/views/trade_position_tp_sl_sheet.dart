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
          _error = 'Could not read existing protection sizes. Close and refresh before editing.';
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
        throw ArgumentError(
          'Existing legs have different sizes. Choose the new protection size explicitly.',
        );
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
          _error =
              'Action ${error.actionId} is still being confirmed. Resume pending actions, then reopen this editor. Changes may be partially applied.';
        });
      }
    } on ArgumentError catch (error) {
      if (mounted) setState(() => _error = '${error.message}');
    } on FormatException catch (error) {
      if (mounted) {
        setState(() => _error = '${error.message}. Refresh before retrying.');
      }
    } on Object {
      if (mounted) {
        setState(
          () => _error = 'Protection update was not completed. A cancellation may already have succeeded. Retry the same edit or check pending actions before changing it.',
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
    return Material(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: l10n.back,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    Expanded(
                      child: Text(
                        l10n.takeProfitStopLoss,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '${widget.position.productId ?? widget.position.symbol} · ${widget.position.side == PositionSide.long ? 'Long' : 'Short'}',
                ),
                if (_loadingProtection) const LinearProgressIndicator(),
                const SizedBox(height: 16),
                _TpSlRiskControl(
                  title: l10n.takeProfit,
                  controller: _takeProfit,
                  enabled: _takeProfitEnabled,
                  onEnabledChanged: locked
                      ? null
                      : (value) => setState(() => _takeProfitEnabled = value),
                ),
                const SizedBox(height: 12),
                _TpSlRiskControl(
                  title: l10n.stopLoss,
                  controller: _stopLoss,
                  enabled: _stopLossEnabled,
                  onEnabledChanged: locked
                      ? null
                      : (value) => setState(() => _stopLossEnabled = value),
                ),
                const SizedBox(height: 12),
                const Text('Protection size'),
                DropdownButton<bool>(
                  key: const Key('protection-size-mode'),
                  value: _fixedQuantity,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: false,
                      child: Text('Entire position (default)'),
                    ),
                    DropdownMenuItem(
                      value: true,
                      child: Text('Fixed quantity'),
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
                      labelText: 'Quantity (${widget.position.symbol})',
                    ),
                  ),
                if (_takeProfitEnabled && _takeIsLimit)
                  TextField(
                    controller: _takeLimit,
                    enabled: !locked,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Take profit limit price (USDC)',
                    ),
                  ),
                if (_stopLossEnabled && _stopIsLimit)
                  TextField(
                    controller: _stopLimit,
                    enabled: !locked,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Stop limit price (USDC)',
                    ),
                  ),
                if (_sizeChoiceRequired)
                  const Text(
                    'Existing protection legs have different sizes. Select the desired size for this edit.',
                  ),
                const SizedBox(height: 12),
                Text(
                  _fixedQuantity
                      ? 'Fixed quantity will not adjust automatically when the position changes.'
                      : 'Entire position protection uses the position size at trigger time.',
                ),
                const Text(
                  'Trigger execution needs no new signature. Changes and cancellations require signing. Switching a leg off cancels it; other edits may require additional signatures.',
                ),
                if (_error case final error?) ...[
                  const SizedBox(height: 12),
                  Text(error),
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _submitting
                            ? null
                            : () => Navigator.of(context).pop(),
                        child: Text(l10n.back),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
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

class _TpSlRiskControl extends StatelessWidget {
  const _TpSlRiskControl({
    required this.title,
    required this.controller,
    required this.enabled,
    required this.onEnabledChanged,
  });

  final String title;
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<bool>? onEnabledChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      container: true,
      label: title,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Switch(value: enabled, onChanged: onEnabledChanged),
              ],
            ),
            const Divider(height: 24),
            TextField(
              controller: controller,
              enabled: enabled && onEnabledChanged != null,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).price,
                prefixText: r'$ ',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
