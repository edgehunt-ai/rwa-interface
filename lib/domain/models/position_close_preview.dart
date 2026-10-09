import 'decimal_value.dart';
import 'order_intent.dart';
import 'position.dart';

/// Server estimates for this close, rather than the entire position.
final class PositionClosePreview {
  const PositionClosePreview({
    required this.previewId,
    required this.positionId,
    required this.productId,
    required this.positionVersion,
    required this.environment,
    required this.side,
    required this.type,
    required this.quantity,
    required this.notional,
    required this.entryPrice,
    required this.markPrice,
    required this.estimatedPrice,
    required this.estimatedFee,
    required this.estimatedRealizedPnl,
    required this.expiresAt,
    required this.observedAt,
    this.limitPrice,
    this.liquidationPrice,
  });

  final String previewId;
  final String positionId;
  final String productId;
  final String positionVersion;
  final String environment;
  final PositionSide side;
  final TradingOrderType type;
  final DecimalValue quantity;
  final DecimalValue notional;
  final DecimalValue entryPrice;
  final DecimalValue markPrice;
  final DecimalValue estimatedPrice;
  final DecimalValue estimatedFee;
  final DecimalValue estimatedRealizedPnl;
  final DecimalValue? limitPrice;
  final DecimalValue? liquidationPrice;
  final DateTime expiresAt;
  final DateTime observedAt;

  bool get isExpired => !expiresAt.isAfter(DateTime.now().toUtc());
}
