final class FundingSessionSummary {
  const FundingSessionSummary({
    required this.sessionId,
    required this.status,
    required this.version,
    required this.canConfirmTransfer,
    required this.expiresAt,
  });
  final String sessionId;
  final String status;
  final int version;
  final bool canConfirmTransfer;
  final DateTime expiresAt;
}
