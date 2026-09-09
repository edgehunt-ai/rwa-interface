import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({super.key, this.rows = 5, this.padding});

  final int rows;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return Padding(
      padding: padding ?? const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonBlock(width: 136, height: 24),
          const SizedBox(height: 20),
          for (var index = 0; index < rows; index++) ...[
            Row(
              children: [
                SkeletonBlock(width: 40, height: 40, radius: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonBlock(
                        width: index.isEven ? 152 : 116,
                        height: 14,
                      ),
                      const SizedBox(height: 8),
                      SkeletonBlock(width: index.isEven ? 92 : 124, height: 12),
                    ],
                  ),
                ),
                SkeletonBlock(width: 58, height: 16),
              ],
            ),
            if (index != rows - 1) ...[
              const SizedBox(height: 16),
              Divider(height: 1, color: colors.border),
              const SizedBox(height: 16),
            ],
          ],
        ],
      ),
    );
  }
}

class SkeletonBlock extends StatelessWidget {
  const SkeletonBlock({
    super.key,
    required this.width,
    required this.height,
    this.radius = 6,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.subtleSurface,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
