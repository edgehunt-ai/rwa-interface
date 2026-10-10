import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

enum LiquidationRiskLevel { safe, caution, high, unknown }

const _safeRiskIcon = 'assets/figma/common/liquidation_risk_safe.svg';
const _cautionRiskIcon = 'assets/figma/common/liquidation_risk_caution.svg';
const _highRiskIcon = 'assets/figma/common/liquidation_risk_high.svg';
const _chevronDownIcon =
    'assets/figma/common/liquidation_risk_chevron_down.svg';

/// A display-only position used by [LiquidationRiskSummaryCard].
///
/// Keeping this model separate from an API response lets funding and trading
/// surfaces render the same risk summary without depending on order models.
final class LiquidationRiskPosition {
  const LiquidationRiskPosition({
    required this.title,
    this.marketPrice,
    this.beforeLiquidationPrice,
    this.afterLiquidationPrice,
  });

  final String title;
  final DecimalValue? marketPrice;
  final DecimalValue? beforeLiquidationPrice;
  final DecimalValue? afterLiquidationPrice;
}

LiquidationRiskLevel liquidationRiskLevel(LiquidationRiskPosition position) {
  final distance = _liquidationDistance(
    position.marketPrice,
    position.afterLiquidationPrice,
  );
  if (distance == null || !distance.isFinite) {
    return LiquidationRiskLevel.unknown;
  }
  if (distance >= .10) return LiquidationRiskLevel.safe;
  if (distance >= .05) return LiquidationRiskLevel.caution;
  return LiquidationRiskLevel.high;
}

class LiquidationRiskSummaryCard extends StatefulWidget {
  const LiquidationRiskSummaryCard({
    super.key,
    required this.positions,
    this.affectedLabel,
    this.initiallyExpanded = false,
  });

  final List<LiquidationRiskPosition> positions;
  final String? affectedLabel;
  final bool initiallyExpanded;

  @override
  State<LiquidationRiskSummaryCard> createState() =>
      _LiquidationRiskSummaryCardState();
}

class _LiquidationRiskSummaryCardState
    extends State<LiquidationRiskSummaryCard> {
  late bool _expanded = widget.initiallyExpanded;

  LiquidationRiskLevel get _risk {
    final levels = widget.positions.map(liquidationRiskLevel).toList();
    if (levels.isEmpty ||
        levels.any((level) => level == LiquidationRiskLevel.unknown)) {
      return LiquidationRiskLevel.unknown;
    }
    return levels.reduce(_moreUrgent);
  }

  static LiquidationRiskLevel _moreUrgent(
    LiquidationRiskLevel left,
    LiquidationRiskLevel right,
  ) {
    const priority = {
      LiquidationRiskLevel.safe: 0,
      LiquidationRiskLevel.caution: 1,
      LiquidationRiskLevel.high: 2,
      LiquidationRiskLevel.unknown: 3,
    };
    return priority[left]! >= priority[right]! ? left : right;
  }

  @override
  void didUpdateWidget(covariant LiquidationRiskSummaryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initiallyExpanded != oldWidget.initiallyExpanded) {
      _expanded = widget.initiallyExpanded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final palette = _RiskPalette.from(context, _risk);
    final affectedLabel =
        widget.affectedLabel ??
        l10n.crossPositionsAffected(widget.positions.length);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SummaryHeader(
              affectedLabel: affectedLabel,
              palette: palette,
              expanded: _expanded,
              secondaryTextColor: colors.secondaryText,
            ),
            if (_expanded) ...[
              const SizedBox(height: 8),
              _DetailsCard(positions: widget.positions, colors: colors),
            ],
          ],
        ),
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  const _SummaryHeader({
    required this.affectedLabel,
    required this.palette,
    required this.expanded,
    required this.secondaryTextColor,
  });

  final String affectedLabel;
  final _RiskPalette palette;
  final bool expanded;
  final Color secondaryTextColor;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          affectedLabel,
          style: TextStyle(
            color: secondaryTextColor,
            fontSize: 13,
            height: 18 / 13,
          ),
        ),
      ),
      _RiskBadge(palette: palette),
      const SizedBox(width: 2),
      AnimatedRotation(
        turns: expanded ? .5 : 0,
        duration: const Duration(milliseconds: 160),
        child: SvgPicture.asset(
          _chevronDownIcon,
          width: 14,
          height: 14,
          colorFilter: ColorFilter.mode(secondaryTextColor, BlendMode.srcIn),
        ),
      ),
    ],
  );
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.positions, required this.colors});

  final List<LiquidationRiskPosition> positions;
  final AppRwaColors colors;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: colors.subtleSurface,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        for (var index = 0; index < positions.length; index++) ...[
          _PositionRow(position: positions[index], colors: colors),
          if (index != positions.length - 1) ...[
            const SizedBox(height: 8),
            Container(height: 1, color: colors.surface),
            const SizedBox(height: 8),
          ],
        ],
      ],
    ),
  );
}

class _PositionRow extends StatelessWidget {
  const _PositionRow({required this.position, required this.colors});

  final LiquidationRiskPosition position;
  final AppRwaColors colors;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final level = liquidationRiskLevel(position);
    final palette = _RiskPalette.from(context, level);
    final statusColor = palette.foreground;
    final beforeDistance = _liquidationDistance(
      position.marketPrice,
      position.beforeLiquidationPrice,
    );
    final afterDistance = _liquidationDistance(
      position.marketPrice,
      position.afterLiquidationPrice,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      position.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: colors.primaryText,
                        fontSize: 13,
                        height: 16 / 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  _RiskIcon(palette: palette),
                ],
              ),
              const SizedBox(height: 1),
              Text(
                '${l10n.marketPriceShort} ${_price(position.marketPrice, l10n.unavailable)}',
                style: TextStyle(
                  color: colors.tertiaryText,
                  fontSize: 11,
                  height: 18 / 11,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _PositionValues(
          beforeDistance: beforeDistance,
          afterDistance: afterDistance,
          afterColor: statusColor,
          beforePrice: position.beforeLiquidationPrice,
          afterPrice: position.afterLiquidationPrice,
          colors: colors,
        ),
      ],
    );
  }
}

class _PositionValues extends StatelessWidget {
  const _PositionValues({
    required this.beforeDistance,
    required this.afterDistance,
    required this.afterColor,
    required this.beforePrice,
    required this.afterPrice,
    required this.colors,
  });

  final double? beforeDistance;
  final double? afterDistance;
  final Color afterColor;
  final DecimalValue? beforePrice;
  final DecimalValue? afterPrice;
  final AppRwaColors colors;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final muted = TextStyle(
      color: colors.tertiaryText,
      fontSize: 11,
      height: 18 / 11,
    );
    final previousValue = TextStyle(
      color: colors.tertiaryText,
      fontSize: 11,
      height: 18 / 11,
      fontWeight: FontWeight.w600,
    );
    final value = TextStyle(
      color: colors.primaryText,
      fontSize: 11,
      height: 18 / 11,
      fontWeight: FontWeight.w600,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: '${l10n.toLiquidation} ', style: muted),
              TextSpan(text: _percent(beforeDistance), style: previousValue),
              TextSpan(text: ' →', style: value),
              TextSpan(
                text: _percent(afterDistance),
                style: value.copyWith(color: afterColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:
                    '${l10n.liquidationPriceShort.replaceFirst(' Price', '')} ',
                style: muted,
              ),
              TextSpan(
                text: _price(beforePrice, l10n.unavailable),
                style: previousValue,
              ),
              TextSpan(text: ' → ', style: value),
              TextSpan(
                text: _price(afterPrice, l10n.unavailable),
                style: value,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RiskBadge extends StatelessWidget {
  const _RiskBadge({required this.palette});

  final _RiskPalette palette;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: palette.background,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _RiskIcon(palette: palette),
        const SizedBox(width: 4),
        Text(
          palette.label,
          style: TextStyle(
            color: palette.foreground,
            fontSize: 12,
            height: 16 / 12,
          ),
        ),
      ],
    ),
  );
}

class _RiskIcon extends StatelessWidget {
  const _RiskIcon({required this.palette});

  final _RiskPalette palette;

  @override
  Widget build(BuildContext context) {
    final asset = palette.iconAsset;
    if (asset == null) {
      return Icon(Icons.info_outline, size: 14, color: palette.foreground);
    }
    return SvgPicture.asset(
      asset,
      width: 14,
      height: 14,
      colorFilter: ColorFilter.mode(palette.foreground, BlendMode.srcIn),
    );
  }
}

final class _RiskPalette {
  const _RiskPalette({
    required this.foreground,
    required this.background,
    required this.iconAsset,
    required this.label,
  });

  final Color foreground;
  final Color background;
  final String? iconAsset;
  final String label;

  static _RiskPalette from(BuildContext context, LiquidationRiskLevel level) {
    final l10n = AppLocalizations.of(context);
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    return switch (level) {
      LiquidationRiskLevel.safe => _RiskPalette(
        foreground: Color(0xFF04A08B),
        background: Color(0xFFE9F8F4),
        iconAsset: _safeRiskIcon,
        label: l10n.safe,
      ),
      LiquidationRiskLevel.caution => _RiskPalette(
        foreground: Color(0xFFB45309),
        background: Color(0xFFFFF7ED),
        iconAsset: _cautionRiskIcon,
        label: l10n.liquidationRisk,
      ),
      LiquidationRiskLevel.high => _RiskPalette(
        foreground: Color(0xFFDE596E),
        background: Color(0xFFFFF0F2),
        iconAsset: _highRiskIcon,
        label: l10n.highLiquidationRisk,
      ),
      LiquidationRiskLevel.unknown => _RiskPalette(
        foreground: colors.secondaryText,
        background: colors.subtleSurface,
        iconAsset: null,
        label: l10n.unavailable,
      ),
    };
  }
}

double? _liquidationDistance(
  DecimalValue? marketPrice,
  DecimalValue? liquidationPrice,
) {
  final market = double.tryParse(marketPrice?.value ?? '');
  final liquidation = double.tryParse(liquidationPrice?.value ?? '');
  if (market == null || liquidation == null || market == 0) return null;
  return (market - liquidation).abs() / market.abs();
}

String _percent(double? value) =>
    value == null ? '—' : '${(value * 100).toStringAsFixed(1)}%';

String _price(DecimalValue? value, String unavailable) => value == null
    ? unavailable
    : '\$${TokenAmountFormatter.formatValue(value)}';
