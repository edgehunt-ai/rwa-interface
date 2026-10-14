import 'package:flutter/material.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/limit_price_loss.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

String formatLimitPriceDeviation(double value, {bool signed = true}) =>
    TokenAmountFormatter.formatPercent(
      DecimalValue(value.toStringAsFixed(8)),
      signed: signed,
      maxFractionDigits: 2,
      preserveSmallValues: true,
    );

class LimitPriceLossNotice extends StatelessWidget {
  const LimitPriceLossNotice({
    required this.loss,
    required this.settlementAsset,
    super.key,
  });

  final LimitPriceLoss loss;
  final String settlementAsset;

  @override
  Widget build(BuildContext context) {
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;
    final l10n = AppLocalizations.of(context);
    final deviation = formatLimitPriceDeviation(
      loss.deviationPercent,
      signed: false,
    );
    final estimatedLoss = TokenAmountFormatter.formatValue(
      DecimalValue(loss.estimatedLoss.toStringAsFixed(8)),
    );
    final message = switch (loss.direction) {
      LimitPriceLossDirection.aboveMarket => l10n.limitPriceLossWarningAbove(
        deviation,
        estimatedLoss,
        settlementAsset,
      ),
      LimitPriceLossDirection.belowMarket => l10n.limitPriceLossWarningBelow(
        deviation,
        estimatedLoss,
        settlementAsset,
      ),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: semantic.lossSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: semantic.loss, fontWeight: FontWeight.w500),
      ),
    );
  }
}
