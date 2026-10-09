import 'decimal_value.dart';
import 'api_failure.dart';
import 'market_product.dart';
import 'order_intent.dart';

enum TradingOrderStatus {
  pending,
  awaitingConfirmation,
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

enum BstocksOrderActionKind {
  erc20Approval,
  placeGtcOrder,
  executeIocOrder,
  cancelOrder,
  unknown,
}

final class BstocksOrderAction {
  const BstocksOrderAction({
    required this.orderId,
    required this.actionId,
    required this.kind,
    required this.status,
    required this.chainId,
    required this.from,
    required this.to,
    required this.data,
    required this.value,
    required this.payloadHash,
    required this.validUntil,
    this.previewId,
    this.submittedTransactionHash,
    this.confirmedTransactionHash,
    this.failureReason,
  });

  final String orderId;
  final String actionId;
  final BstocksOrderActionKind kind;
  final BstocksOrderActionStatus status;
  final String? previewId;
  final String? submittedTransactionHash;
  final String? confirmedTransactionHash;
  final String? failureReason;
  final int chainId;
  final String from;
  final String to;
  final String data;
  final String value;
  final String payloadHash;
  final DateTime validUntil;
}

enum BstocksOrderActionStatus {
  awaitingSignature,
  submitted,
  confirmed,
  failed,
  manualReview,
  unknown,
}

final class BstocksWalletActionSubmission {
  const BstocksWalletActionSubmission({
    required this.orderId,
    required this.actionId,
    required this.status,
    required this.transactionHash,
    required this.updatedAt,
  });

  final String orderId;
  final String actionId;
  final String status;
  final String transactionHash;
  final DateTime updatedAt;
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
    this.nextAction,
    this.walletActionBlocker,
    this.currentActionId,
    this.requestedAmount,
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
  final BstocksOrderAction? nextAction;
  final String? walletActionBlocker;
  final String? currentActionId;
  final DecimalValue? requestedAmount;
  final String? settlementAsset;

  bool get isOpen =>
      status == TradingOrderStatus.open ||
      status == TradingOrderStatus.partiallyFilled;

  bool get isBstocksCancellable =>
      kind == MarketProductKind.bstock &&
      type == TradingOrderType.limit &&
      isOpen;

  BstocksOrderActionStatus? get actionStatus => nextAction?.status;
  String? get submittedTransactionHash => nextAction?.submittedTransactionHash;
  String? get confirmedTransactionHash => nextAction?.confirmedTransactionHash;

  void checkBstocksExecutionFailure() {
    if (kind == MarketProductKind.bstock &&
        const {
          TradingOrderStatus.failed,
          TradingOrderStatus.ambiguous,
          TradingOrderStatus.manualReview,
        }.contains(status)) {
      throw UnknownFailure(userAction: failureReason ?? 'Order ${status.name}');
    }
  }

  bool get isTerminal => const {
    TradingOrderStatus.filled,
    TradingOrderStatus.cancelled,
    TradingOrderStatus.failed,
  }.contains(status);
}
