import 'decimal_value.dart';
import 'market_product.dart';
import 'order_intent.dart';

enum TradingOrderStatus {
  pendingSignature,
  submitted,
  open,
  partiallyFilled,
  filled,
  cancelled,
  failed,
  ambiguous,
  manualReview,
  unknown,
}

final class TradingOrder {
  const TradingOrder({
    required this.orderId,
    required this.symbol,
    required this.kind,
    required this.side,
    required this.type,
    required this.status,
    required this.createdAt,
    this.clientOrderId,
    this.quantity,
    this.filledQuantity,
    this.limitPrice,
    this.averageFillPrice,
    this.orderValue,
    this.fee,
    this.positionId,
    this.txHash,
    this.failureReason,
    this.updatedAt,
  });
  final String orderId;
  final String? clientOrderId;
  final String symbol;
  final MarketProductKind kind;
  final TradingSide side;
  final TradingOrderType type;
  final TradingOrderStatus status;
  final DecimalValue? quantity;
  final DecimalValue? filledQuantity;
  final DecimalValue? limitPrice;
  final DecimalValue? averageFillPrice;
  final DecimalValue? orderValue;
  final DecimalValue? fee;
  final String? positionId;
  final String? txHash;
  final String? failureReason;
  final DateTime createdAt;
  final DateTime? updatedAt;

  bool get isTerminal => const {
    TradingOrderStatus.filled,
    TradingOrderStatus.cancelled,
    TradingOrderStatus.failed,
  }.contains(status);
}
