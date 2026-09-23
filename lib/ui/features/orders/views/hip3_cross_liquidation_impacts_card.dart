import 'package:flutter/material.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

class Hip3CrossLiquidationImpactsCard extends StatefulWidget {
  const Hip3CrossLiquidationImpactsCard({super.key, required this.impacts});

  final List<Hip3CrossLiquidationImpact> impacts;

  @override
  State<Hip3CrossLiquidationImpactsCard> createState() =>
      _Hip3CrossLiquidationImpactsCardState();
}

class _Hip3CrossLiquidationImpactsCardState
    extends State<Hip3CrossLiquidationImpactsCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final warningColor = Theme.of(context).brightness == Brightness.dark
        ? Theme.of(context).extension<AppSemanticColors>()!.warning
        : const Color(0xFFB45309);
    final background = Theme.of(context).brightness == Brightness.dark
        ? warningColor.withValues(alpha: .12)
        : const Color(0xFFFFF7ED);

    return Material(
      key: const Key('hip3-cross-liquidation-impacts'),
      color: background,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.crossPositionsAffected(widget.impacts.length),
                      style: TextStyle(
                        color: warningColor,
                        fontSize: 13,
                        height: 18 / 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? .5 : 0,
                    duration: const Duration(milliseconds: 160),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 14,
                      color: warningColor,
                    ),
                  ),
                ],
              ),
              if (_expanded) ...[
                const SizedBox(height: 16),
                for (var index = 0; index < widget.impacts.length; index++) ...[
                  _ImpactRow(impact: widget.impacts[index]),
                  if (index != widget.impacts.length - 1)
                    const SizedBox(height: 4),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ImpactRow extends StatelessWidget {
  const _ImpactRow({required this.impact});

  final Hip3CrossLiquidationImpact impact;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppRwaColors>()!;
    final l10n = AppLocalizations.of(context);
    final side = impact.side == TradingSide.long ? l10n.long : l10n.short;
    final symbol = impact.productId.split(':').last;
    final before = impact.beforeLiquidationPrice?.value;
    final after = impact.afterLiquidationPrice?.value;

    return Row(
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: side,
                  style: TextStyle(
                    color: colors.tertiaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: ' $symbol ${l10n.liquidationPriceShort}',
                  style: TextStyle(color: colors.secondaryText),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, height: 16 / 12),
          ),
        ),
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: before == null ? l10n.unavailable : '\$$before',
                style: TextStyle(color: colors.tertiaryText),
              ),
              TextSpan(
                text: after == null ? '' : ' → \$$after',
                style: TextStyle(color: colors.primaryText),
              ),
            ],
          ),
          style: const TextStyle(
            fontSize: 12,
            height: 18 / 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
