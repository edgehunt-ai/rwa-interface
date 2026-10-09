import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

/// Shared tabs for HIP-3 order composition and position actions.
class Hip3SegmentedControl<T> extends StatelessWidget {
  const Hip3SegmentedControl({
    super.key,
    required this.width,
    required this.values,
    required this.selected,
    required this.selectedColor,
    required this.label,
    required this.onChanged,
    this.selectedForeground,
  });

  final double width;
  final List<T> values;
  final T selected;
  final Color selectedColor;
  final Color? selectedForeground;
  final String Function(T value) label;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final widths = width < 140 ? const [56.0, 55.0] : const [77.0, 63.0];
    final selectedIndex = values.indexOf(selected);
    final selectionLeft = selectedIndex == 0 ? 0.0 : widths.first + 4.0;
    return Semantics(
      container: true,
      explicitChildNodes: true,
      child: Container(
        width: width,
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: colors.subtleSurface,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOutCubic,
              left: selectionLeft,
              top: 0,
              width: widths[selectedIndex],
              height: 36,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: selectedColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var index = 0; index < values.length; index++)
                  SizedBox(
                    width: widths[index],
                    height: 36,
                    child: Semantics(
                      button: true,
                      enabled: onChanged != null,
                      inMutuallyExclusiveGroup: true,
                      selected: selected == values[index],
                      label: label(values[index]),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: onChanged == null
                              ? null
                              : () => onChanged!(values[index]),
                          child: Center(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 180),
                              curve: Curves.easeOutCubic,
                              style: Theme.of(context).textTheme.labelMedium!
                                  .copyWith(
                                    color: selected == values[index]
                                        ? selectedForeground ??
                                              colors.onPrimaryAction
                                        : colors.secondaryText,
                                    fontWeight: selected == values[index]
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                  ),
                              child: Text(label(values[index])),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
