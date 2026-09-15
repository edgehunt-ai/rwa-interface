import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

class TpSlEditorCard extends StatefulWidget {
  const TpSlEditorCard({
    super.key,
    required this.title,
    required this.controller,
    required this.enabled,
    required this.onEnabledChanged,
    this.referencePrice,
    this.inputKey,
    this.changeKey,
    this.rulerKey,
  });

  final String title;
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<bool>? onEnabledChanged;

  /// Price the ruler ranges around and that `Change` is measured against —
  /// the mark price for a position, the order price when opening one. Without
  /// it the card can only anchor on whatever the field already held.
  final double? referencePrice;
  final Key? inputKey;
  final Key? changeKey;
  final Key? rulerKey;

  @override
  State<TpSlEditorCard> createState() => _TpSlEditorCardState();
}

class _TpSlEditorCardState extends State<TpSlEditorCard> {
  late final double _referencePrice =
      widget.referencePrice ?? double.tryParse(widget.controller.text) ?? 100;
  final _change = TextEditingController();

  /// Guards the two-way price <-> change binding from looping.
  var _syncing = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onPriceEdited);
    _change.addListener(_onChangeEdited);
    _pushChangeFromPrice();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onPriceEdited);
    _change.dispose();
    super.dispose();
  }

  void _onPriceEdited() {
    _pushChangeFromPrice();
    if (mounted) setState(() {});
  }

  void _pushChangeFromPrice() {
    if (_syncing) return;
    final price = double.tryParse(widget.controller.text);
    if (price == null) return;
    final text = (((price / _referencePrice) - 1) * 100).toStringAsFixed(0);
    if (_change.text == text) return;
    _syncing = true;
    _change.text = text;
    _syncing = false;
  }

  void _onChangeEdited() {
    if (_syncing) return;
    final percent = double.tryParse(_change.text);
    if (percent == null) return;
    final text = _formatPrice(_referencePrice * (1 + percent / 100));
    if (widget.controller.text == text) return;
    _syncing = true;
    widget.controller.text = text;
    _syncing = false;
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
                      label: l10n.change,
                      controller: _change,
                      enabled: editable,
                      suffix: '%',
                      alignEnd: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TpSlTickRuler(
              key: widget.rulerKey,
              semanticLabel: '${widget.title} ${l10n.price}',
              value: value,
              minimum: minimum,
              maximum: maximum,
              divisions: 20,
              enabled: editable,
              onChanged: (next) => widget.controller.text = _formatPrice(next),
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
    this.alignEnd = false,
  });

  final Key? fieldKey;
  final String label;
  final TextEditingController controller;
  final bool enabled;
  final String? prefix;
  final String? suffix;
  final bool alignEnd;

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
        SizedBox(
          width: 112,
          child: TextField(
            key: fieldKey,
            controller: controller,
            enabled: enabled,
            textAlign: alignEnd ? TextAlign.end : TextAlign.start,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
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
              hintText: '0',
              hintStyle: amountStyle.copyWith(color: colors.tertiaryText),
              prefixText: prefix,
              prefixStyle: amountStyle,
              suffixText: suffix,
              suffixStyle: amountStyle,
            ),
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
  });

  final String semanticLabel;
  final double value;
  final double minimum;
  final double maximum;
  final int divisions;
  final ValueChanged<double> onChanged;
  final bool enabled;

  @override
  State<TpSlTickRuler> createState() => _TpSlTickRulerState();
}

class _TpSlTickRulerState extends State<TpSlTickRuler> {
  double? _dragValue;
  var _dragging = false;

  double get _currentValue =>
      (_dragValue ?? widget.value).clamp(widget.minimum, widget.maximum);

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
  }

  void _updateDrag(DragUpdateDetails details, double width) {
    final range = widget.maximum - widget.minimum;
    if (range <= 0 || width <= 0) return;
    // The ruler ticks move with the finger, so dragging right lowers the
    // value while dragging left raises it.
    final next = (_currentValue - details.delta.dx / width * range).clamp(
      widget.minimum,
      widget.maximum,
    );
    if (next == _currentValue) return;
    setState(() => _dragValue = next);
    widget.onChanged(next);
  }

  void _endDrag() {
    _dragging = false;
    _dragValue = null;
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
    required this.tickColor,
    required this.accentColor,
  });

  final double value;
  final double minimum;
  final double maximum;
  final int divisions;
  final int tickCount;
  final Color tickColor;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final trackLeft = 12.0;
    final trackRight = size.width - 12;
    final trackWidth = trackRight - trackLeft;
    final centerX = size.width / 2;
    final progress = ((value - minimum) / (maximum - minimum)).clamp(0.0, 1.0);
    final selectedX = trackLeft + progress * trackWidth;
    final gradient = const LinearGradient(
      colors: [Color(0x1A676776), Color(0x80676776), Color(0x1A676776)],
      stops: [0, 0.5, 1],
    ).createShader(Rect.fromLTWH(trackLeft, 0, trackWidth, size.height));
    final paint = Paint()..shader = gradient;
    final tickSpacing = trackWidth / divisions;
    for (var index = 0; index < tickCount; index++) {
      final x = centerX + (trackLeft + index * tickSpacing - selectedX);
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
      maximum != oldDelegate.maximum;
}
