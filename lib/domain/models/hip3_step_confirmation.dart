/// Business-only summary of the exact frozen step; never contains signing data.
final class Hip3StepConfirmation {
  const Hip3StepConfirmation({
    required this.actionId,
    required this.stepId,
    required this.productId,
    required this.operation,
    required this.stepKind,
    required this.validUntil,
    required this.details,
  });
  final String actionId;
  final String stepId;
  final String productId;
  final String operation;
  final String stepKind;
  final DateTime validUntil;
  final Map<String, String> details;
}
