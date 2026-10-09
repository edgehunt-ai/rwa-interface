import 'decimal_value.dart';

/// Server estimates for this close, rather than the entire position.
final class PositionClosePreview {
  const PositionClosePreview({
    required this.previewId,
    required this.quantity,
    required this.notional,
    required this.entryPrice,
    required this.markPrice,
    required this.estimatedPrice,
    required this.estimatedFee,
    required this.estimatedRealizedPnl,
    required this.expiresAt,
    required this.observedAt,
    this.liquidationPrice,
  });

  final String previewId;
  final DecimalValue quantity;
  final DecimalValue notional;
  final DecimalValue entryPrice;
  final DecimalValue markPrice;
  final DecimalValue estimatedPrice;
  final DecimalValue estimatedFee;
  final DecimalValue estimatedRealizedPnl;
  final DecimalValue? liquidationPrice;
  final DateTime expiresAt;
  final DateTime observedAt;

  bool get isExpired => !expiresAt.isAfter(DateTime.now().toUtc());
}
