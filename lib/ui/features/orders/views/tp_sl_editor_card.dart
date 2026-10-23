import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:nobell/domain/models/position_operation.dart'
    show percentageQuantity;
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

class TpSlEditorCard extends StatefulWidget {
  const TpSlEditorCard({
    super.key,
    required this.title,
    required this.isLong,
    required this.isTakeProfit,
    required this.controller,
    required this.enabled,
    required this.onEnabledChanged,
    this.referencePrice,
    this.referencePriceListenable,
    this.inputKey,
    this.changeKey,
    this.rulerKey,
  });

  final String title;
  final bool isLong;
  final bool isTakeProfit;
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<bool>? onEnabledChanged;

  /// Price that Win / Loss is measured against —
  /// the mark price for a position, the order price when opening one. Without
  /// it the card can only anchor on whatever the field already held.
  final double? referencePrice;
  final ValueListenable<double?>? referencePriceListenable;
  final Key? inputKey;
  final Key? changeKey;
  final Key? rulerKey;

  @override
  State<TpSlEditorCard> createState() => _TpSlEditorCardState();
}

class _TpSlEditorCardState extends State<TpSlEditorCard> {
  late final double _fallbackReferencePrice = switch (double.tryParse(
    widget.controller.text,
  )) {
    final price? when price.isFinite && price > 0 => price,
    _ => 100,
  };

  double get _referencePrice {
    final price =
        widget.referencePriceListenable?.value ?? widget.referencePrice;
    return price != null && price.isFinite && price > 0
        ? price
        : _fallbackReferencePrice;
  }

  // Long TP / Short SL rise; Short TP / Long SL fall.
  double get _priceDirection => widget.isLong == widget.isTakeProfit ? 1 : -1;
  final _change = TextEditingController();

  /// Guards the two-way price <-> change binding from looping.
  var _syncing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onPriceEdited);
    _change.addListener(_onChangeEdited);
    widget.referencePriceListenable?.addListener(_onReferenceChanged);
    _pushChangeFromPrice();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onPriceEdited);
    _change.dispose();
    widget.referencePriceListenable?.removeListener(_onReferenceChanged);
    super.dispose();
  }

  void _onReferenceChanged() {
    _pushChangeFromPrice();
    if (mounted) setState(() {});
  }

  void _onPriceEdited() {
    _pushChangeFromPrice();
    if (mounted) setState(() {});
  }

  @override
  void didUpdateWidget(covariant TpSlEditorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onPriceEdited);
      widget.controller.addListener(_onPriceEdited);
    }
    if (oldWidget.referencePriceListenable != widget.referencePriceListenable) {
      oldWidget.referencePriceListenable?.removeListener(_onReferenceChanged);
      widget.referencePriceListenable?.addListener(_onReferenceChanged);
    }
    if (oldWidget.controller != widget.controller ||
        oldWidget.referencePrice != widget.referencePrice ||
        oldWidget.referencePriceListenable != widget.referencePriceListenable ||
        oldWidget.isLong != widget.isLong ||
        oldWidget.isTakeProfit != widget.isTakeProfit) {
      _pushChangeFromPrice();
    }
  }

  bool get _hasWrongPriceDirection {
    final price = double.tryParse(widget.controller.text);
    return price != null &&
        price.isFinite &&
        price > 0 &&
        (price - _referencePrice) * _priceDirection < 0;
  }

  void _pushChangeFromPrice() {
    if (_syncing) return;
    final price = double.tryParse(widget.controller.text);
    final text =
        price == null ||
            !price.isFinite ||
            price <= 0 ||
            _hasWrongPriceDirection
        ? ''
        : _formatPercent((price / _referencePrice - 1) * 100 * _priceDirection);
    if (_change.text == text) return;
    _syncing = true;
    _change.text = text;
    _syncing = false;
  }

  void _onChangeEdited() {
    if (_syncing) return;
    final percent = double.tryParse(_change.text);
    if (percent != null && (!percent.isFinite || percent < 0)) return;
    final text = percent == null
        ? ''
        : _formatPrice(_referencePrice * (1 + _priceDirection * percent / 100));
    if (widget.controller.text == text) return;
    _syncing = true;
    widget.controller.text = text;
    _syncing = false;
    if (mounted) setState(() {});
  }

  void _onRulerChanged(double value) {
    final percent = value.truncate();
    final price = percentageQuantity(
      _referencePrice.toString(),
      (_priceDirection > 0 ? 100 + percent : 100 - percent).toString(),
      maxFractionDigits: 0,
    );
    // Write the submitted price and displayed ratio together. Manual edits
    // continue through their existing bindings without integer truncation.
    _syncing = true;
    _change.text = percent.toString();
    widget.controller.text = price;
    _syncing = false;
    if (mounted) setState(() {});
  }

  String _formatPercent(double value) => value == 0
      ? '0'
      : value.toStringAsFixed(8).replaceFirst(RegExp(r'\.?0+$'), '');

  String _formatPrice(double value) => value
      .toStringAsFixed(2)
      .replaceFirst(RegExp(r'\.00$'), '')
      .replaceFirstMapped(RegExp(r'(\.\d)0$'), (match) => match.group(1)!);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final percent = double.tryParse(_change.text) ?? 0;
    final decreasingPrice = _priceDirection < 0;
    final editable = widget.enabled && widget.onEnabledChanged != null;
    return Semantics(
      container: true,
      label: widget.title,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: colors.subtleSurface),
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
                _TpSlSwitch(
                  value: widget.enabled,
                  onChanged: widget.onEnabledChanged,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(height: 1, color: colors.subtleSurface),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _TpSlAmount(
                    fieldKey: widget.inputKey,
                    label: l10n.price,
                    controller: widget.controller,
                    enabled: editable,
                    prefix: r'$',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: _TpSlAmount(
                      fieldKey: widget.changeKey,
                      label: widget.isTakeProfit ? l10n.tpSlWin : l10n.tpSlLoss,
                      controller: _change,
                      enabled: editable,
                      suffix: _hasWrongPriceDirection ? null : '%',
                      hintText: _hasWrongPriceDirection ? '—' : '0',
                      positiveOnly: true,
                      maximumExclusive: decreasingPrice ? 100 : null,
                      alignEnd: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TpSlTickRuler(
              key: widget.rulerKey,
              semanticLabel:
                  '${widget.title} ${widget.isTakeProfit ? l10n.tpSlWin : l10n.tpSlLoss}',
              value: percent,
              minimum: 0,
              maximum: decreasingPrice ? 99 : 100,
              divisions: 20,
              unbounded: !decreasingPrice,
              enabled: editable,
              onChanged: _onRulerChanged,
            ),
          ],
        ),
      ),
    );
  }
}

/// Caption plus a borderless number the trader taps straight into, so the
/// keyboard opens without the field reading as a boxed input.
class _TpSlAmount extends StatelessWidget {
  const _TpSlAmount({
    required this.fieldKey,
    required this.label,
    required this.controller,
    required this.enabled,
    this.prefix,
    this.suffix,
    this.hintText = '0',
    this.alignEnd = false,
    this.positiveOnly = false,
    this.maximumExclusive,
  });

  final Key? fieldKey;
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final String? prefix;
  final String? suffix;
  final String hintText;
  final bool alignEnd;
  final bool positiveOnly;
  final double? maximumExclusive;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final amountStyle = TextStyle(
      fontSize: 20,
      height: 22 / 20,
      fontWeight: FontWeight.w600,
      color: enabled ? colors.primaryText : colors.tertiaryText,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            height: 22 / 12,
            fontWeight: FontWeight.w500,
            color: colors.tertiaryText,
          ),
        ),
        const SizedBox(width: 4),
        Flexible(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              final textPainter = TextPainter(
                text: TextSpan(
                  text:
                      '${prefix ?? ''}${value.text.isEmpty ? hintText : value.text}${suffix ?? ''}',
                  style: amountStyle,
                ),
                textDirection: Directionality.of(context),
                textScaler: MediaQuery.textScalerOf(context),
              )..layout();
              final fieldWidth = alignEnd
                  ? textPainter.width.ceilToDouble() + 2
                  : 112.0;
              textPainter.dispose();
              return SizedBox(
                width: fieldWidth,
                child: TextField(
                  key: fieldKey,
                  controller: controller,
                  enabled: enabled,
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                    signed: !positiveOnly,
                  ),
                  inputFormatters: positiveOnly
                      ? [
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            if (!RegExp(r'^\d*\.?\d*$')
                                .hasMatch(newValue.text)) {
                              return oldValue;
                            }
                            final number = double.tryParse(newValue.text);
                            if (number != null &&
                                (!number.isFinite ||
                                    (maximumExclusive != null &&
                                        number >= maximumExclusive!))) {
                              return oldValue;
                            }
                            return newValue;
                          }),
                        ]
                      : null,
                  style: amountStyle,
                  cursorColor: colors.primaryText,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: hintText,
                    hintStyle: amountStyle.copyWith(color: colors.tertiaryText),
                    prefixText: prefix,
                    prefixStyle: amountStyle,
                    suffixText: suffix,
                    suffixStyle: amountStyle,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TpSlSwitch extends StatelessWidget {
  const _TpSlSwitch({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    // Scaled down to the design's 44x24, matching the bStocks control.
    return SizedBox(
      width: 44,
      height: 24,
      child: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(.846, .75, 1),
          child: Switch(
            value: value,
            onChanged: onChanged,
            thumbColor: const WidgetStatePropertyAll(Colors.white),
            trackColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? colors.selected
                  : colors.border,
            ),
            trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
            trackOutlineWidth: const WidgetStatePropertyAll(0),
          ),
        ),
      ),
    );
  }
}

class TpSlTickRuler extends StatefulWidget {
  const TpSlTickRuler({
    super.key,
    required this.semanticLabel,
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.divisions,
    required this.onChanged,
    this.enabled = true,
    this.unbounded = false,
    this.step,
  });

  final String semanticLabel;
  final double value;
  final double minimum;
  final double maximum;
  final int divisions;
  final ValueChanged<double> onChanged;
  final bool enabled;
  final bool unbounded;
  final double? step;

  @override
  State<TpSlTickRuler> createState() => _TpSlTickRulerState();
}

class _TpSlTickRulerState extends State<TpSlTickRuler> {
  double? _dragValue;
  double? _dragRange;
  var _dragging = false;

  double get _currentValue {
    final value = _dragValue ?? widget.value;
    return widget.unbounded
        ? value.clamp(widget.minimum, double.infinity)
        : value.clamp(widget.minimum, widget.maximum);
  }

  @override
  void didUpdateWidget(covariant TpSlTickRuler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_dragging &&
        (oldWidget.value != widget.value ||
            oldWidget.minimum != widget.minimum ||
            oldWidget.maximum != widget.maximum)) {
      _dragValue = null;
    }
  }

  void _startDrag() {
    _dragging = true;
    _dragValue = _currentValue;
    _dragRange = _rangeFor(_currentValue);
  }

  void _updateDrag(DragUpdateDetails details, double width) {
    final range = _dragRange ?? _rangeFor(_currentValue);
    if (range <= 0 || width <= 0) return;
    // The ruler ticks move with the finger, so dragging right lowers the
    // value while dragging left raises it.
    final rawNext = _currentValue - details.delta.dx / width * range;
    var next = widget.unbounded
        ? rawNext.clamp(widget.minimum, double.infinity)
        : rawNext.clamp(widget.minimum, widget.maximum);
    if (widget.step case final step? when step > 0) {
      next = (next / step).round() * step;
      next = widget.unbounded
          ? next.clamp(widget.minimum, double.infinity)
          : next.clamp(widget.minimum, widget.maximum);
    }
    if (next == _currentValue) return;
    setState(() => _dragValue = next);
    widget.onChanged(next);
  }

  void _endDrag() {
    _dragging = false;
    _dragValue = null;
    _dragRange = null;
  }

  double _rangeFor(double value) {
    final configuredRange = widget.maximum - widget.minimum;
    if (!widget.unbounded || value <= widget.minimum) return configuredRange;
    return value - widget.minimum;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final current = _currentValue;
    final tickCount = (widget.divisions + 1).clamp(2, 21);
    return Semantics(
      container: true,
      label: widget.semanticLabel,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          dragStartBehavior: DragStartBehavior.down,
          onHorizontalDragStart: widget.enabled ? (_) => _startDrag() : null,
          onHorizontalDragUpdate: widget.enabled
              ? (details) =>
                    _updateDrag(details, (context.size?.width ?? 0) - 24)
              : null,
          onHorizontalDragEnd: widget.enabled ? (_) => _endDrag() : null,
          onHorizontalDragCancel: widget.enabled ? _endDrag : null,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: colors.subtleSurface,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                CustomPaint(
                  painter: _TpSlRulerPainter(
                    value: current,
                    minimum: widget.minimum,
                    maximum: widget.maximum,
                    divisions: widget.divisions,
                    tickCount: tickCount,
                    unbounded: widget.unbounded,
                    tickColor: colors.border,
                    accentColor: colors.selected,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        AppLocalizations.of(context).dragToSet,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 22 / 12,
                          color: Color(0xFF676776),
                        ),
                      ),
                    ),
                  ),
                ),
                if (!widget.unbounded)
                  IgnorePointer(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        disabledActiveTrackColor: Colors.transparent,
                        disabledInactiveTrackColor: Colors.transparent,
                        thumbColor: Colors.transparent,
                        disabledThumbColor: Colors.transparent,
                        overlayColor: Colors.transparent,
                        overlayShape: SliderComponentShape.noOverlay,
                        thumbShape: SliderComponentShape.noThumb,
                        trackHeight: 48,
                      ),
                      child: Slider(
                        value: current,
                        min: widget.minimum,
                        max: widget.maximum,
                        divisions: widget.divisions,
                        onChanged: null,
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
}

class _TpSlRulerPainter extends CustomPainter {
  const _TpSlRulerPainter({
    required this.value,
    required this.minimum,
    required this.maximum,
    required this.divisions,
    required this.tickCount,
    required this.unbounded,
    required this.tickColor,
    required this.accentColor,
  });

  final double value;
  final double minimum;
  final double maximum;
  final int divisions;
  final int tickCount;
  final bool unbounded;
  final Color tickColor;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final trackLeft = 12.0;
    final trackRight = size.width - 12;
    final trackWidth = trackRight - trackLeft;
    final centerX = size.width / 2;
    final gradient = const LinearGradient(
      colors: [Color(0x1A676776), Color(0x80676776), Color(0x1A676776)],
      stops: [0, 0.5, 1],
    ).createShader(Rect.fromLTWH(trackLeft, 0, trackWidth, size.height));
    final paint = Paint()..shader = gradient;
    // Keep the interval fixed so a changing value scrolls the ticks beneath
    // the center indicator, including when the ruler has no upper bound.
    final tickSpacing = trackWidth / divisions;
    final interval = (maximum - minimum) / divisions;
    final halfTicks = tickCount ~/ 2;
    final rawPosition = (value - minimum) / interval;
    // Only the visible tick phase is needed far from the lower bound. Avoid
    // converting large prices to integers, which can overflow on native Dart.
    final position = unbounded && rawPosition > halfTicks
        ? (value - minimum) % (interval * 5) / interval +
              ((halfTicks + 4) ~/ 5) * 5
        : rawPosition;
    final firstIndex = (position.floor() - halfTicks).clamp(
      0,
      unbounded ? position.ceil() + halfTicks : divisions,
    );
    final lastIndex = (firstIndex + tickCount).clamp(
      0,
      unbounded ? position.ceil() + halfTicks : divisions,
    );
    for (var index = firstIndex; index <= lastIndex; index++) {
      final x = centerX + (index - position) * tickSpacing;
      if (x < trackLeft || x > trackRight) continue;
      final height = index % 5 == 0 ? 25.0 : 18.0;
      canvas.drawRect(
        Rect.fromLTWH(x - .5, (size.height - height) / 2, 1, height),
        paint,
      );
    }
    final indicator = Paint()..color = accentColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(centerX - 2, (size.height - 32) / 2, 4, 32),
        const Radius.circular(2),
      ),
      indicator,
    );
  }

  @override
  bool shouldRepaint(_TpSlRulerPainter oldDelegate) =>
      value != oldDelegate.value ||
      minimum != oldDelegate.minimum ||
      maximum != oldDelegate.maximum ||
      divisions != oldDelegate.divisions ||
      tickCount != oldDelegate.tickCount ||
      unbounded != oldDelegate.unbounded ||
      tickColor != oldDelegate.tickColor ||
      accentColor != oldDelegate.accentColor;
}
