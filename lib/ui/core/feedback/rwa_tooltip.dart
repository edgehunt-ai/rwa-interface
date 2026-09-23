import 'package:flutter/material.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

class RwaRichTooltip extends StatefulWidget {
  const RwaRichTooltip({super.key, required this.child, required this.message});

  final Widget child;
  final InlineSpan message;

  @override
  State<RwaRichTooltip> createState() => _RwaRichTooltipState();
}

class _RwaRichTooltipState extends State<RwaRichTooltip> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  void _toggleTooltip() {
    if (_overlayEntry != null) {
      _removeTooltip();
      return;
    }

    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (context) => _RwaTooltipOverlay(
        layerLink: _layerLink,
        message: widget.message,
        onDismiss: _removeTooltip,
      ),
    );
    _overlayEntry = entry;
    overlay.insert(entry);
  }

  void _removeTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _toggleTooltip,
        child: widget.child,
      ),
    );
  }
}

class _RwaTooltipOverlay extends StatelessWidget {
  const _RwaTooltipOverlay({
    required this.layerLink,
    required this.message,
    required this.onDismiss,
  });

  final LayerLink layerLink;
  final InlineSpan message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onDismiss,
          ),
        ),
        CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          targetAnchor: Alignment.topRight,
          followerAnchor: Alignment.bottomRight,
          offset: const Offset(0, -8),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 240,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    border: Border.all(color: colors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RichText(text: message),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Transform.translate(
                      offset: const Offset(0, -1),
                      child: SizedBox(
                        width: 16,
                        height: 8,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: 2,
                              child: ColoredBox(color: colors.surface),
                            ),
                            CustomPaint(
                              size: const Size(16, 8),
                              painter: _TooltipArrowPainter(
                                color: colors.surface,
                                borderColor: colors.border,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TooltipArrowPainter extends CustomPainter {
  const _TooltipArrowPainter({required this.color, required this.borderColor});

  final Color color;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, Paint()..color = color);
    final borderPath = Path()
      ..moveTo(0.5, 0)
      ..lineTo(size.width / 2, size.height - 0.5)
      ..lineTo(size.width - 0.5, 0);
    canvas.drawPath(
      borderPath,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  @override
  bool shouldRepaint(_TooltipArrowPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.borderColor != borderColor;
}
