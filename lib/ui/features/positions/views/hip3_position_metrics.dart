import 'package:flutter/material.dart';

import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/position.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../core/formatters/token_amount_formatter.dart';

class Hip3PositionMetrics extends StatelessWidget {
  const Hip3PositionMetrics({
    super.key,
    required this.position,
    this.onEditLeverage,
  });
  final Position position;
  final VoidCallback? onEditLeverage;
  static const unavailable = 'Unavailable';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    String money(DecimalValue? value) =>
        value == null ? unavailable : TokenAmountFormatter.formatUsd(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row(l10n.direction, switch (position.side) {
          PositionSide.long => l10n.long,
          PositionSide.short => l10n.short,
          PositionSide.none => unavailable,
        }),
        _row(
          l10n.leverage,
          position.leverage == null
              ? unavailable
              : '${TokenAmountFormatter.formatValue(position.leverage!)}×',
        ),
        _row(l10n.entryPrice, money(position.entryPrice)),
        _row(l10n.markPrice, money(position.markPrice)),
        _row(l10n.unrealizedPnl, money(position.unrealizedPnl)),
        _row(
          l10n.returnOnEquity,
          position.unrealizedPnlPercent == null
              ? unavailable
              : TokenAmountFormatter.formatPercent(
                  position.unrealizedPnlPercent!,
                  maxFractionDigits: 6,
                ),
        ),
        _row(l10n.margin, money(position.margin)),
        _row(l10n.liquidationPrice, money(position.liquidationPrice)),
        _row(l10n.cumulativeFunding, money(position.fundingPaid)),
        Text(l10n.fundingExplanation),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: onEditLeverage,
            child: Text(l10n.changeLeverage),
          ),
        ),
      ],
    );
  }

  Widget _row(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 12),
        Expanded(child: Text(value, textAlign: TextAlign.end)),
      ],
    ),
  );
}
