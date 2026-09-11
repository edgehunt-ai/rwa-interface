import 'package:flutter/material.dart';
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
    return Semantics(
      container: true,
      label: semanticLabel,
      child: ExcludeSemantics(
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
                      for (var index = 0; index < tickCount; index++)
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
                left: 8,
                child: Text(AppLocalizations.of(context).dragToSet),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.transparent,
                  inactiveTrackColor: Colors.transparent,
                  trackHeight: 0,
                  thumbColor: colors.selected,
                  overlayShape: SliderComponentShape.noOverlay,
                  thumbShape: const _TpSlRulerThumbShape(),
                ),
                child: Slider(
                  value: current,
                  min: minimum,
                  max: maximum,
                  divisions: divisions,
                  onChanged: enabled ? onChanged : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TpSlRulerThumbShape extends SliderComponentShape {
  const _TpSlRulerThumbShape();

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
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final paint = Paint()..color = sliderTheme.thumbColor!;
    context.canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 4, height: 32),
        const Radius.circular(2),
      ),
      paint,
    );
  }
}
