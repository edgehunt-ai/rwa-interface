import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class PositionProtectionQuantityCard extends StatelessWidget {
  const PositionProtectionQuantityCard({
    super.key,
    required this.controller,
    required this.symbol,
    required this.percentage,
    required this.onQuantityChanged,
    required this.onPercentageChanged,
  });

  final TextEditingController controller;
  final String symbol;
  final double percentage;
  final ValueChanged<String>? onQuantityChanged;
  final ValueChanged<double>? onPercentageChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final style = TextStyle(
      fontSize: 17,
      height: 22 / 17,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.1,
      color: colors.primaryText,
    );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      decoration: BoxDecoration(
        color: colors.subtleSurface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Semantics(
                  label: l10n.quantitySymbol(symbol),
                  child: TextField(
                    key: const Key('protection-quantity'),
                    controller: controller,
                    enabled: onQuantityChanged != null,
                    onChanged: onQuantityChanged,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    style: style,
                    decoration: InputDecoration(
                      hintText: l10n.quantity,
                      hintStyle: style.copyWith(color: colors.tertiaryText),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      filled: false,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    symbol,
                    style: style,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LayoutBuilder(
            builder: (context, constraints) {
              final badgeWidth = constraints.maxWidth < 42
                  ? constraints.maxWidth
                  : 42.0;
              final badgeLeft =
                  (constraints.maxWidth * percentage / 100 - badgeWidth / 2)
                      .clamp(0.0, constraints.maxWidth - badgeWidth);
              return SizedBox(
                height: 24,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: colors.primaryAction,
                        inactiveTrackColor: colors.surface,
                        disabledActiveTrackColor: colors.tertiaryText,
                        disabledInactiveTrackColor: colors.surface,
                        trackHeight: 8,
                        thumbShape: SliderComponentShape.noThumb,
                        overlayShape: SliderComponentShape.noOverlay,
                        tickMarkShape: SliderTickMarkShape.noTickMark,
                      ),
                      child: Slider(
                        key: const Key('protection-percentage-slider'),
                        padding: EdgeInsets.zero,
                        value: percentage,
                        max: 100,
                        divisions: 100,
                        semanticFormatterCallback: (value) =>
                            '${value.round()}%',
                        onChanged: onPercentageChanged,
                      ),
                    ),
                    for (final stop in const [25.0, 50.0, 75.0])
                      Positioned(
                        left: (constraints.maxWidth - 6) * stop / 100,
                        child: IgnorePointer(
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: colors.subtleSurface,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      left: badgeLeft,
                      child: IgnorePointer(
                        child: Container(
                          width: badgeWidth,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: onPercentageChanged == null
                                ? colors.tertiaryText
                                : colors.primaryAction,
                            border: Border.all(color: colors.surface, width: 2),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            '${percentage.round()}%',
                            style: TextStyle(
                              fontSize: 12,
                              height: 16 / 12,
                              fontWeight: FontWeight.w600,
                              color: colors.onPrimaryAction,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
