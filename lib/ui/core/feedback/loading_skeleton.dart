import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({
    super.key,
    this.rows = 5,
    this.padding,
    this.showHeader = false,
  });

  final int rows;
  final EdgeInsetsGeometry? padding;
  final bool showHeader;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final resolvedPadding = (padding ?? const EdgeInsets.all(20)).resolve(
      Directionality.of(context),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.hasBoundedHeight
            ? math
                  .max(0, constraints.maxHeight - resolvedPadding.vertical)
                  .toDouble()
            : double.infinity;
        final visibleRows = _visibleRows(availableHeight);
        final canShowHeader =
            showHeader && (availableHeight >= 24 || !availableHeight.isFinite);
        return Padding(
          padding: resolvedPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (canShowHeader) const SkeletonBlock(width: 136, height: 24),
              if (canShowHeader && visibleRows > 0) const SizedBox(height: 20),
              for (var index = 0; index < visibleRows; index++) ...[
                Row(
                  children: [
                    const SkeletonBlock(width: 40, height: 40, radius: 20),
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
                          SkeletonBlock(
                            width: index.isEven ? 92 : 124,
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                    const SkeletonBlock(width: 58, height: 16),
                  ],
                ),
                if (index != visibleRows - 1) ...[
                  const SizedBox(height: 16),
                  Divider(height: 1, color: colors.border),
                  const SizedBox(height: 16),
                ],
              ],
            ],
          ),
        );
      },
    );
  }

  int _visibleRows(double availableHeight) {
    if (!availableHeight.isFinite) return rows;
    final headerHeight = showHeader ? 44 : 0;
    if (availableHeight < headerHeight + 40) return 0;
    return math.min(rows, 1 + ((availableHeight - headerHeight - 40) ~/ 73));
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
