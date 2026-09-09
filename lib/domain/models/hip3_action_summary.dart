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
  });
  final String actionId;
  final String productId;
  final String operation;
  final String status;
  final bool effectsApplied;
  final bool canResumePositionAction;
  final String? positionId;
  final String? orderId;
}
