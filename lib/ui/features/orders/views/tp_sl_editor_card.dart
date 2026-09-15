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
    this.inputKey,
    this.rulerKey,
  });

  final String title;
  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<bool>? onEnabledChanged;
  final Key? inputKey;
  final Key? rulerKey;

  @override
  State<TpSlEditorCard> createState() => _TpSlEditorCardState();
}

class _TpSlEditorCardState extends State<TpSlEditorCard> {
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
    final editable = widget.enabled && widget.onEnabledChanged != null;
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
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Switch(
                  value: widget.enabled,
                  onChanged: widget.onEnabledChanged,
                ),
              ],
            ),
            Divider(color: colors.subtleSurface),
            Row(
              children: [
                Text(l10n.price, style: TextStyle(color: colors.secondaryText)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    key: widget.inputKey,
                    controller: widget.controller,
                    enabled: editable,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: Theme.of(context).textTheme.titleLarge,
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                Text(
                  '${l10n.change} ${change >= 0 ? '+' : ''}${change.toStringAsFixed(0)}%',
                  style: TextStyle(color: colors.secondaryText),
                ),
              ],
            ),
            const SizedBox(height: 12),
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

class TpSlTickRuler extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final current = value.clamp(minimum, maximum);
    final tickCount = (divisions + 1).clamp(2, 21);
    var dragValue = current;
    var dragStartX = 0.0;
    var dragStartValue = current;
    return Semantics(
      container: true,
      label: semanticLabel,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          dragStartBehavior: DragStartBehavior.down,
          onHorizontalDragStart: enabled
              ? (_) {
                  dragStartX = 0;
                  dragStartValue = current;
                  dragValue = current;
                }
              : null,
          onHorizontalDragUpdate: enabled
              ? (details) {
                  final range = maximum - minimum;
                  final width = (context.size?.width ?? 0) - 24;
                  if (range <= 0 || width <= 0) return;
                  dragStartX += details.delta.dx;
                  dragValue = (dragStartValue + dragStartX / width * range)
                      .clamp(minimum, maximum);
                  onChanged(dragValue);
                }
              : null,
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
                    minimum: minimum,
                    maximum: maximum,
                    divisions: divisions,
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
                        style: const TextStyle(color: Color(0xFF676776)),
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
                      min: minimum,
                      max: maximum,
                      divisions: divisions,
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
