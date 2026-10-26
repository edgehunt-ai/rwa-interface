import 'package:flutter/material.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/limit_price_loss.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/formatters/token_amount_formatter.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

String formatLimitPriceDeviation(double value, {bool signed = true}) =>
    TokenAmountFormatter.formatPercent(
      _warningDecimal(value),
      signed: signed,
      maxFractionDigits: 2,
      preserveSmallValues: true,
    );

DecimalValue _warningDecimal(double value) {
  final text = value.toStringAsFixed(8);
  // Dart uses exponential notation even for toStringAsFixed at |value| >= 1e21.
  // DecimalValue requires plain decimal notation.
  final parts = text.split('e');
  if (parts.length == 1) return DecimalValue(text);
  final mantissa = parts.first;
  final separator = mantissa.indexOf('.');
  final fractionDigits = separator == -1 ? 0 : mantissa.length - separator - 1;
  final zeros = int.parse(parts.last) - fractionDigits;
  final digits = mantissa.replaceAll('.', '');
  return DecimalValue(digits.padRight(digits.length + zeros, '0'));
}

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
      _warningDecimal(loss.estimatedLoss),
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
        color: semantic.dangerSoft,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        message,
        style: Theme.of(context).textTheme.labelMedium
            ?.copyWith(color: semantic.danger, fontWeight: FontWeight.w500),
      ),
    );
  }
}
