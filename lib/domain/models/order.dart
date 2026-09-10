import 'decimal_value.dart';
import 'market_product.dart';
import 'order_intent.dart';
import 'order_fill.dart';

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

final class ConditionalOrder {
  const ConditionalOrder({
    required this.role,
    required this.triggerPrice,
    required this.triggerStatus,
    required this.executionType,
    required this.sizeMode,
    required this.quantity,
    required this.triggerReference,
    this.activationStatus = 'unknown',
    this.warningCode,
    this.parentOrderId,
  });
  final String role;
  final DecimalValue triggerPrice;
  final String triggerStatus;
  final String executionType;
  final String sizeMode;
  final String quantity;
  final String triggerReference;
  final String activationStatus;
  final String? warningCode;
  final String? parentOrderId;
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
    this.productId,
    this.conditional,
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
    this.fills,
    this.realizedPnl,
    this.providerObservedAt,
    this.settlementAsset,
  });
  final String orderId;
  final String? productId;
  final ConditionalOrder? conditional;
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

  /// Null means omitted; an empty array means no fill records in this response.
  /// Neither asserts completeness of the provider's historical executions.
  final List<TradingOrderFill>? fills;
  final DecimalValue? realizedPnl;
  final DateTime? providerObservedAt;
  final String? settlementAsset;

  bool get isTerminal => const {
    TradingOrderStatus.filled,
    TradingOrderStatus.cancelled,
    TradingOrderStatus.failed,
  }.contains(status);
}
