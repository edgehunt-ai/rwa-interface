import 'package:flutter/material.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

/// The market-open indicator, with a breathing outline around a solid dot.
class MarketCountdownDot extends StatefulWidget {
  const MarketCountdownDot({super.key});

  @override
  State<MarketCountdownDot> createState() => _MarketCountdownDotState();
}

class _MarketCountdownDotState extends State<MarketCountdownDot>
    with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
      _controller.value = 1;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).extension<AppRwaColors>()!.primaryAction;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => Container(
        key: const Key('market-countdown-dot'),
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: Curves.easeInOut.transform(_controller.value) * 0.1,
              ),
              spreadRadius: 3,
            ),
          ],
        ),
      ),
    );
  }
}
