import 'decimal_value.dart';
import 'market_product.dart';
import 'order_intent.dart';

enum PositionSide { long, short, none }

final class Position {
  const Position({
    required this.positionId,
    required this.symbol,
    required this.kind,
    required this.quantity,
    required this.valueUsd,
    this.side = PositionSide.none,
    this.productId,
    this.positionVersion,
    this.marginMode,
    this.entryPrice,
    this.markPrice,
    this.unrealizedPnl,
    this.realizedPnl,
    this.leverage,
    this.margin,
    this.liquidationPrice,
    this.takeProfitPrice,
    this.stopLossPrice,
    this.stopLimitPrice,
    this.updatedAt,
  });
  final String positionId;
  final String symbol;
  final MarketProductKind kind;
  final PositionSide side;
  final String? productId;
  final String? positionVersion;
  final TradingMarginMode? marginMode;
  final DecimalValue quantity;
  final DecimalValue valueUsd;
  final DecimalValue? entryPrice;
  final DecimalValue? markPrice;
  final DecimalValue? unrealizedPnl;
  final DecimalValue? realizedPnl;
  final DecimalValue? leverage;
  final DecimalValue? margin;
  final DecimalValue? liquidationPrice;
  final DecimalValue? takeProfitPrice;
  final DecimalValue? stopLossPrice;
  final DecimalValue? stopLimitPrice;
  final DateTime? updatedAt;
}
