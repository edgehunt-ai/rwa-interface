enum AccountDeletionState {
  requested,
  blocked,
  processing,
  anonymized,
  manualReview,
  failed,
  unknown,
}

enum AccountDeletionBlocker {
  openOrders,
  openPositions,
  fundsInFlight,
  withdrawableAssetsRemaining,
  legalRetention,
  identityReview,
  unknown,
}

final class AccountDeletion {
  const AccountDeletion({
    required this.requestId,
    required this.state,
    required this.blockers,
    required this.requestedAt,
    required this.updatedAt,
    this.failureReason,
    this.anonymizedAt,
  });

  final String requestId;
  final AccountDeletionState state;
  final List<AccountDeletionBlocker> blockers;
  final String? failureReason;
  final DateTime requestedAt;
  final DateTime updatedAt;
  final DateTime? anonymizedAt;
}
