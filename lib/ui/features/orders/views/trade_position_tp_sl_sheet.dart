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
  double _bstocksQuantityPercent = 20;
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
            quantity: hasSet && widget.position.kind == MarketProductKind.bstock
                ? percentageQuantity(
                    widget.position.quantity.value,
                    _bstocksQuantityPercent.round().toString(),
                  )
                : hasSet && _fixedQuantity
                ? _quantity.text.trim()
                : null,
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
    if (widget.position.kind == MarketProductKind.bstock) {
      return _BstocksTpSlEditor(
        position: widget.position,
        takeProfit: _takeProfit,
        stopLoss: _stopLoss,
        takeProfitEnabled: _takeProfitEnabled,
        stopLossEnabled: _stopLossEnabled,
        quantityPercent: _bstocksQuantityPercent,
        locked: locked,
        submitting: _submitting,
        error: _error,
        onTakeProfitEnabledChanged: (value) =>
            setState(() => _takeProfitEnabled = value),
        onStopLossEnabledChanged: (value) =>
            setState(() => _stopLossEnabled = value),
        onQuantityPercentChanged: (value) =>
            setState(() => _bstocksQuantityPercent = value),
        onBack: () => Navigator.of(context).pop(),
        onConfirm: _save,
      );
    }
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28, top: 4),
                  child: Text(
                    '${widget.position.symbol}/USDT  ${widget.position.side == PositionSide.long ? l10n.buy : l10n.sell}',
                    style: TextStyle(color: colors.secondaryText),
                  ),
                ),
                if (_loadingProtection) const LinearProgressIndicator(),
                const SizedBox(height: 16),
                TpSlEditorCard(
                  title: l10n.takeProfit,
                  controller: _takeProfit,
                  enabled: _takeProfitEnabled,
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

class _BstocksTpSlEditor extends StatelessWidget {
  const _BstocksTpSlEditor({
    required this.position,
    required this.takeProfit,
    required this.stopLoss,
    required this.takeProfitEnabled,
    required this.stopLossEnabled,
    required this.quantityPercent,
    required this.locked,
    required this.submitting,
    required this.error,
    required this.onTakeProfitEnabledChanged,
    required this.onStopLossEnabledChanged,
    required this.onQuantityPercentChanged,
    required this.onBack,
    required this.onConfirm,
  });

  final Position position;
  final TextEditingController takeProfit;
  final TextEditingController stopLoss;
  final bool takeProfitEnabled;
  final bool stopLossEnabled;
  final double quantityPercent;
  final bool locked;
  final bool submitting;
  final String? error;
  final ValueChanged<bool> onTakeProfitEnabledChanged;
  final ValueChanged<bool> onStopLossEnabledChanged;
  final ValueChanged<double> onQuantityPercentChanged;
  final VoidCallback onBack;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final tradeSymbol = position.symbol.endsWith('B')
        ? position.symbol
        : '${position.symbol}B';
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
                      width: 20,
                      height: 20,
                      child: IconButton(
                        tooltip: l10n.back,
                        onPressed: onBack,
                        icon: const Icon(Icons.chevron_left, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(
                          width: 20,
                          height: 20,
                        ),
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
                  child: Row(
                    children: [
                      Text(
                        '$tradeSymbol/USDT',
                        style: TextStyle(color: colors.secondaryText),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9F8F4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          position.side == PositionSide.short
                              ? l10n.sell
                              : l10n.buy,
                          style: const TextStyle(
                            color: Color(0xFF04A08B),
                            fontSize: 11,
                            height: 14 / 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                _BstocksRiskControl(
                  title: l10n.takeProfit,
                  controller: takeProfit,
                  enabled: takeProfitEnabled,
                  onEnabledChanged: locked ? null : onTakeProfitEnabledChanged,
                ),
                const SizedBox(height: 12),
                _BstocksRiskControl(
                  title: l10n.stopLoss,
                  controller: stopLoss,
                  enabled: stopLossEnabled,
                  onEnabledChanged: locked ? null : onStopLossEnabledChanged,
                ),
                const SizedBox(height: 12),
                _BstocksQuantityControl(
                  symbol: position.symbol,
                  value: quantityPercent,
                  enabled: !locked,
                  onChanged: onQuantityPercentChanged,
                ),
                if (error case final message?) ...[
                  const SizedBox(height: 12),
                  Text(message),
                ],
                const SizedBox(height: 28),
                Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: colors.subtleSurface,
                          side: BorderSide(color: colors.border),
                        ),
                        onPressed: submitting ? null : onBack,
                        child: Text(l10n.back),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: locked ? null : onConfirm,
                        child: Text(
                          submitting ? l10n.loadingLabel : l10n.confirm,
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

class _BstocksRiskControl extends StatefulWidget {
  const _BstocksRiskControl({
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
  State<_BstocksRiskControl> createState() => _BstocksRiskControlState();
}

class _BstocksRiskControlState extends State<_BstocksRiskControl> {
  late final double _referencePrice =
      double.tryParse(widget.controller.text) ?? 100;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_refresh);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  String _formatPrice(double value) => value
      .toStringAsFixed(2)
      .replaceFirst(RegExp(r'\.00$'), '')
      .replaceFirst(RegExp(r'(\.\d)0$'), r'$1');

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final minimum = _referencePrice * .9;
    final maximum = _referencePrice * 1.1;
    final price = double.tryParse(widget.controller.text) ?? _referencePrice;
    final value = price.clamp(minimum, maximum);
    final change = ((value / _referencePrice) - 1) * 100;
    return Semantics(
      container: true,
      label: widget.title,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colors.border),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 22 / 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 44,
                  height: 24,
                  child: Center(
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.diagonal3Values(.846, .75, 1),
                      child: Switch(
                        value: widget.enabled,
                        activeTrackColor: colors.selected,
                        activeThumbColor: Colors.white,
                        onChanged: widget.onEnabledChanged,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Divider(height: 1, color: colors.subtleSurface),
            ),
            Row(
              children: [
                Text(l10n.price, style: TextStyle(color: colors.tertiaryText)),
                const SizedBox(width: 4),
                Expanded(
                  child: TextField(
                    controller: widget.controller,
                    enabled: widget.enabled && widget.onEnabledChanged != null,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: const TextStyle(
                      fontSize: 20,
                      height: 22 / 20,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      prefixText: r'$ ',
                      hintText: '0',
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                Text(l10n.change, style: TextStyle(color: colors.tertiaryText)),
                const SizedBox(width: 4),
                Text(
                  '${change >= 0 ? '' : '-'}${change.abs().toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 20,
                    height: 22 / 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _BstocksTickRuler(
              semanticLabel: '${widget.title} ${l10n.price}',
              value: value,
              minimum: minimum,
              maximum: maximum,
              enabled: widget.enabled && widget.onEnabledChanged != null,
              onChanged: (next) => widget.controller.text = _formatPrice(next),
            ),
          ],
        ),
      ),
    );
  }
}

class _BstocksTickRuler extends StatelessWidget {
  const _BstocksTickRuler({
    required this.semanticLabel,
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.enabled,
    required this.onChanged,
  });

  final String semanticLabel;
  final double value;
  final double minimum;
  final double maximum;
  final bool enabled;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Semantics(
      label: semanticLabel,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: colors.subtleSurface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            IgnorePointer(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    for (var index = 0; index < 21; index++)
                      Expanded(
                        child: Align(
                          child: Container(
                            width: 1,
                            height: index % 5 == 0 ? 25 : 18,
                            color: colors.border,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 12,
              child: Text(
                AppLocalizations.of(context).dragToSet,
                style: TextStyle(color: colors.secondaryText),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.transparent,
                inactiveTrackColor: Colors.transparent,
                trackHeight: 0,
                thumbColor: colors.selected,
                overlayShape: SliderComponentShape.noOverlay,
                thumbShape: const _BstocksRulerThumbShape(),
              ),
              child: Slider(
                value: value,
                min: minimum,
                max: maximum,
                divisions: 20,
                onChanged: enabled ? onChanged : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BstocksRulerThumbShape extends SliderComponentShape {
  const _BstocksRulerThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(4, 32);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required ui.TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 4, height: 32),
        const Radius.circular(2),
      ),
      Paint()..color = sliderTheme.thumbColor!,
    );
  }
}

class _BstocksQuantityControl extends StatelessWidget {
  const _BstocksQuantityControl({
    required this.symbol,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final String symbol;
  final double value;
  final bool enabled;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context).quantity,
                style: TextStyle(
                  color: colors.tertiaryText,
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                symbol,
                style: const TextStyle(
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _BstocksPercentageSlider(
            value: value,
            enabled: enabled,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class _BstocksPercentageSlider extends StatelessWidget {
  const _BstocksPercentageSlider({
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  final double value;
  final bool enabled;
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
                  key: const Key('bstocks-tp-sl-quantity-slider'),
                  value: value,
                  max: 100,
                  divisions: 100,
                  onChanged: enabled ? onChanged : null,
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
