import 'package:flutter/material.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

class RwaRichTooltip extends StatefulWidget {
  const RwaRichTooltip({
    super.key,
    required this.child,
    required this.message,
    this.alignToCenter = false,
    this.autoFlipVertically = false,
    this.borderColor,
    this.tooltipKey,
  });

  final Widget child;
  final InlineSpan message;
  final bool alignToCenter;
  final bool autoFlipVertically;
  final Color? borderColor;
  final Key? tooltipKey;

  @override
  State<RwaRichTooltip> createState() => _RwaRichTooltipState();
}

class _RwaRichTooltipState extends State<RwaRichTooltip> {
  final _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _showBelow = false;

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
    final targetBox = context.findRenderObject()! as RenderBox;
    final overlayBox = overlay.context.findRenderObject()! as RenderBox;
    final targetTop = targetBox.localToGlobal(
      Offset.zero,
      ancestor: overlayBox,
    );
    _showBelow = widget.autoFlipVertically && targetTop.dy < 280;
    final entry = OverlayEntry(
      builder: (context) => _RwaTooltipOverlay(
        layerLink: _layerLink,
        message: widget.message,
        alignToCenter: widget.alignToCenter,
        borderColor: widget.borderColor,
        tooltipKey: widget.tooltipKey,
        showBelow: _showBelow,
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
    required this.alignToCenter,
    required this.borderColor,
    required this.tooltipKey,
    required this.showBelow,
    required this.onDismiss,
  });

  final LayerLink layerLink;
  final InlineSpan message;
  final bool alignToCenter;
  final Color? borderColor;
  final Key? tooltipKey;
  final bool showBelow;
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
          targetAnchor: showBelow
              ? (alignToCenter ? Alignment.bottomCenter : Alignment.bottomRight)
              : (alignToCenter ? Alignment.topCenter : Alignment.topRight),
          followerAnchor: showBelow
              ? (alignToCenter ? Alignment.topCenter : Alignment.topRight)
              : (alignToCenter
                    ? Alignment.bottomCenter
                    : Alignment.bottomRight),
          offset: Offset(0, showBelow ? 8 : -8),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: alignToCenter
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.end,
              children: [
                if (showBelow)
                  _TooltipArrow(
                    pointsUp: true,
                    color: colors.surface,
                    borderColor: borderColor ?? colors.border,
                    alignToCenter: alignToCenter,
                  ),
                Container(
                  key: tooltipKey,
                  width: 240,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.surface,
                    border: Border.all(color: borderColor ?? colors.border),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: RichText(text: message),
                ),
                if (!showBelow)
                  _TooltipArrow(
                    pointsUp: false,
                    color: colors.surface,
                    borderColor: borderColor ?? colors.border,
                    alignToCenter: alignToCenter,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _TooltipArrow extends StatelessWidget {
  const _TooltipArrow({
    required this.pointsUp,
    required this.color,
    required this.borderColor,
    required this.alignToCenter,
  });

  final bool pointsUp;
  final Color color;
  final Color borderColor;
  final bool alignToCenter;

  @override
  Widget build(BuildContext context) => Align(
    alignment: alignToCenter ? Alignment.center : Alignment.centerRight,
    child: Padding(
      padding: EdgeInsets.only(right: alignToCenter ? 0 : 12),
      child: Transform.translate(
        offset: Offset(0, pointsUp ? 1 : -1),
        child: SizedBox(
          width: 16,
          height: 8,
          child: Stack(
            children: [
              Positioned(
                top: pointsUp ? null : 0,
                bottom: pointsUp ? 0 : null,
                left: 0,
                right: 0,
                height: 2,
                child: ColoredBox(color: color),
              ),
              CustomPaint(
                size: const Size(16, 8),
                painter: _TooltipArrowPainter(
                  color: color,
                  borderColor: borderColor,
                  pointsUp: pointsUp,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _TooltipArrowPainter extends CustomPainter {
  const _TooltipArrowPainter({
    required this.color,
    required this.borderColor,
    required this.pointsUp,
  });

  final Color color;
  final Color borderColor;
  final bool pointsUp;

  @override
  void paint(Canvas canvas, Size size) {
    final path = pointsUp
        ? (Path()
            ..moveTo(0, size.height)
            ..lineTo(size.width / 2, 0)
            ..lineTo(size.width, size.height)
            ..close())
        : (Path()
            ..moveTo(0, 0)
            ..lineTo(size.width / 2, size.height)
            ..lineTo(size.width, 0)
            ..close());
    canvas.drawPath(path, Paint()..color = color);
    final borderPath = pointsUp
        ? (Path()
            ..moveTo(0.5, size.height)
            ..lineTo(size.width / 2, 0.5)
            ..lineTo(size.width - 0.5, size.height))
        : (Path()
            ..moveTo(0.5, 0)
            ..lineTo(size.width / 2, size.height - 0.5)
            ..lineTo(size.width - 0.5, 0));
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
      oldDelegate.color != color ||
      oldDelegate.borderColor != borderColor ||
      oldDelegate.pointsUp != pointsUp;
}
