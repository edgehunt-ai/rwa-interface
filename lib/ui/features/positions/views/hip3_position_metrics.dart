import 'package:flutter/material.dart';

import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/position.dart';
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
    String money(DecimalValue? value) =>
        value == null ? unavailable : TokenAmountFormatter.formatUsd(value);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row('Direction', switch (position.side) {
          PositionSide.long => 'Long',
          PositionSide.short => 'Short',
          PositionSide.none => unavailable,
        }),
        _row(
          'Leverage',
          position.leverage == null
              ? unavailable
              : '${TokenAmountFormatter.formatValue(position.leverage!)}×',
        ),
        _row('Entry price', money(position.entryPrice)),
        _row('Mark price', money(position.markPrice)),
        _row('Unrealized PnL', money(position.unrealizedPnl)),
        _row(
          'Return on equity',
          position.unrealizedPnlPercent == null
              ? unavailable
              : TokenAmountFormatter.formatPercent(
                  position.unrealizedPnlPercent!,
                ),
        ),
        _row('Margin', money(position.margin)),
        _row('Liquidation price', money(position.liquidationPrice)),
        _row('Cumulative funding', money(position.fundingPaid)),
        const Text('Funding: negative = paid; positive = received.'),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: onEditLeverage,
            child: const Text('Change leverage'),
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
