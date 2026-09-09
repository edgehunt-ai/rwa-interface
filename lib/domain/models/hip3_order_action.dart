final class Hip3OrderAction {
  const Hip3OrderAction({
    required this.orderId,
    required this.actionId,
    required this.expectedSigner,
    required this.typedData,
    required this.validUntil,
  });

  final String orderId;
  final String actionId;
  final String expectedSigner;
  final Map<String, Object?> typedData;
  final DateTime validUntil;

  bool isExpiredAt(DateTime now) => !now.toUtc().isBefore(validUntil.toUtc());
}
