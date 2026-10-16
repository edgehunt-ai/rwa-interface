import 'package:flutter/material.dart';

/// A single-pane baseline for resizable windows and separating hinges.
///
/// Keep the same subtree during resizing so routes, input and scroll state
/// survive folding. A future two-pane layout can replace this policy.
class FoldableAdaptiveShell extends StatelessWidget {
  const FoldableAdaptiveShell({super.key, required this.child});

  final Widget child;

  static const maxContentWidth = 720.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: DisplayFeatureSubScreen(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth.clamp(0.0, maxContentWidth);
            final left = (constraints.maxWidth - width) / 2;
            final media = MediaQuery.of(context)
                .copyWith(size: constraints.biggest);
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: width,
                height: constraints.maxHeight,
                // Overlays and screens must measure the same usable viewport.
                child: MediaQuery(
                  data: media
                      .removeDisplayFeatures(
                        Rect.fromLTWH(left, 0, width, constraints.maxHeight),
                      )
                      .copyWith(size: Size(width, constraints.maxHeight)),
                  child: child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
