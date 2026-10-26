import 'package:flutter/material.dart';
import 'package:nobell/ui/core/widgets/app_svg_icon.dart';

import '../theme/app_theme.dart';

class AppFilterOption<T> {
  const AppFilterOption({required this.value, required this.label});
  final T value;
  final String label;
}

class AppFilterMenu<T> extends StatelessWidget {
  const AppFilterMenu({
    super.key,
    required this.value,
    required this.options,
    required this.label,
    required this.onChanged,
    this.width = 135,
  });

  final T value;
  final List<AppFilterOption<T>> options;
  final String label;
  final ValueChanged<T> onChanged;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    // PopupMenuButton treats a null selected value as menu dismissal, so a
    // nullable filter option ("All") can never be selected directly. Use a
    // non-null option index for the menu value and forward the actual filter
    // value, including null, through onChanged.
    return Theme(
      data: Theme.of(context).copyWith(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: PopupMenuButton<int>(
        tooltip: label,
        color: colors.surfaceBase,
        constraints: const BoxConstraints.tightFor(width: 168),
        menuPadding: const EdgeInsets.all(4),
        offset: const Offset(0, 40),
        onSelected: (index) => onChanged(options[index].value),
        itemBuilder: (context) => options
            .asMap()
            .entries
            .map(
              (entry) => PopupMenuItem<int>(
                value: entry.key,
                height: 40,
                padding: EdgeInsets.zero,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: entry.value.value == value ? colors.brandSoft : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    entry.value.label,
                    style: TextStyle(
                      color: entry.value.value == value
                          ? Theme.of(context).colorScheme.onSecondaryContainer
                          : colors.textPrimary,
                    ),
                  ),
                ),
              ),
            )
            .toList(growable: false),
        child: _FilterButton(width: width, label: label),
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({required this.label, required this.width});

  final String label;
  final double width;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return SizedBox(
      width: width,
      height: 36,
      child: OutlinedButton(
        onPressed: null,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(width, 36),
          maximumSize: Size(width, 36),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: colors.surfaceBase,
          disabledBackgroundColor: colors.surfaceBase,
          disabledForegroundColor: colors.textPrimary,
          side: BorderSide(color: colors.borderSubtle),
          textStyle: const TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            AppSvgIcon(
              'assets/figma/home_markets/chevron_down.svg',
              color: context.appColors.iconSecondary,
              width: 20,
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
