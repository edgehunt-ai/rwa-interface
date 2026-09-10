import 'decimal_value.dart';

/// A single execution fact, never synthesized from an order's aggregate totals.
final class TradingOrderFill {
  const TradingOrderFill({
    required this.fillId,
    required this.providerTradeId,
    required this.price,
    required this.quantity,
    required this.fee,
    required this.executedAt,
    this.providerHash,
    this.side,
    this.positionEffect,
    this.closedPnl,
  });
  final String fillId, providerTradeId;
  final DecimalValue price, quantity, fee;
  final DateTime executedAt;
  final String? providerHash;
  final FillSide? side;
  final String? positionEffect;

  /// Raw provider closedPnl, not a recomputed net profit.
  final DecimalValue? closedPnl;
}

/// Execution direction, intentionally separate from position long/short.
enum FillSide { buy, sell }
