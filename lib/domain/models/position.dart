import 'decimal_value.dart';
import 'market_product.dart';

enum PositionSide { long, short, none }

enum PositionMarginMode { cross, isolated, unknown }

final class Position {
  const Position({
    required this.positionId,
    required this.symbol,
    required this.kind,
    required this.quantity,
    required this.valueUsd,
    this.productId,
    this.positionVersion,
    this.hip3ActionId,
    this.protectionOrderIds = const [],
    this.marginMode,
    this.side = PositionSide.none,
    this.entryPrice,
    this.markPrice,
    this.unrealizedPnl,
    this.unrealizedPnlPercent,
    this.fundingPaid,
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

  /// Full venue:coin identifier; never infer this from the display symbol.
  final String? productId;
  final String? positionVersion;
  final String? hip3ActionId;
  final List<String> protectionOrderIds;
  final PositionMarginMode? marginMode;
  final String symbol;
  final MarketProductKind kind;
  final PositionSide side;
  final DecimalValue quantity;
  final DecimalValue valueUsd;
  final DecimalValue? entryPrice;
  final DecimalValue? markPrice;
  final DecimalValue? unrealizedPnl;
  final DecimalValue? unrealizedPnlPercent;

  /// Signed cumulative funding: negative paid, positive received.
  final DecimalValue? fundingPaid;
  final DecimalValue? realizedPnl;
  final DecimalValue? leverage;
  final DecimalValue? margin;
  final DecimalValue? liquidationPrice;
  final DecimalValue? takeProfitPrice;
  final DecimalValue? stopLossPrice;
  final DecimalValue? stopLimitPrice;
  final DateTime? updatedAt;
}
