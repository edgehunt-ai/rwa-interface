import 'hip3_protection.dart';

/// Recoverable server workflow metadata, without wallet signing material.
final class Hip3ActionSummary {
  const Hip3ActionSummary({
    required this.actionId,
    required this.productId,
    required this.operation,
    required this.status,
    required this.effectsApplied,
    required this.canResumePositionAction,
    this.positionId,
    this.orderId,
    this.failureCode,
    this.userAction,
    this.failureReason,
    this.protectionOrders = const [],
    this.protectionResultsComplete = true,
  });
  final String actionId;
  final String productId;
  final String operation;
  final String status;
  final bool effectsApplied;
  final bool canResumePositionAction;
  final String? positionId;
  final String? orderId;
  final String? failureCode;
  final String? userAction;
  final String? failureReason;
  final List<Hip3ProtectionOrderResult> protectionOrders;
  final bool protectionResultsComplete;

  bool get isSuccessful =>
      status == 'succeeded' &&
      protectionResultsComplete &&
      protectionOrders.every((order) => order.isConfirmed);
}
