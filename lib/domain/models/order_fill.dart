import 'decimal_value.dart';

/// A single execution fact, never synthesized from an order's aggregate totals.
/// The current API does not provide per-fill side or realized PnL.
final class TradingOrderFill {
  const TradingOrderFill({
    required this.fillId,
    required this.providerTradeId,
    required this.price,
    required this.quantity,
    required this.fee,
    required this.executedAt,
    this.providerHash,
  });
  final String fillId, providerTradeId;
  final DecimalValue price, quantity, fee;
  final DateTime executedAt;
  final String? providerHash;
}
