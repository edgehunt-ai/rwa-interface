import 'package:flutter/material.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/widgets/liquidation_risk_summary.dart';

/// HIP-3 adapter for the reusable liquidation risk summary component.
class Hip3CrossLiquidationImpactsCard extends StatelessWidget {
  const Hip3CrossLiquidationImpactsCard({
    super.key,
    required this.impacts,
    this.marketPrices = const {},
  });

  final List<Hip3CrossLiquidationImpact> impacts;
  final Map<String, DecimalValue> marketPrices;

  @override
  Widget build(BuildContext context) => LiquidationRiskSummaryCard(
    key: key ?? const Key('hip3-cross-liquidation-impacts'),
    positions: [
      for (final impact in impacts)
        LiquidationRiskPosition(
          title: _title(context, impact),
          marketPrice: marketPrices[impact.productId],
          beforeLiquidationPrice: impact.beforeLiquidationPrice,
          afterLiquidationPrice: impact.afterLiquidationPrice,
        ),
    ],
  );

  String _title(BuildContext context, Hip3CrossLiquidationImpact impact) {
    final l10n = AppLocalizations.of(context);
    final side = impact.side == TradingSide.long ? l10n.long : l10n.short;
    return '$side ${impact.productId.split(':').last}';
  }
}
