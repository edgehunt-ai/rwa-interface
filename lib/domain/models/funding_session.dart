final class FundingSessionSummary {
  const FundingSessionSummary({
    required this.sessionId,
    required this.status,
    required this.version,
    required this.canConfirmTransfer,
    required this.expiresAt,
    this.requiredTargetBalance,
    this.targetAvailableAmount,
    this.remainingMinimumTopUp,
    this.selectedTargetAmount,
    this.minimumReceived,
    this.fees,
    this.etaSeconds,
    this.targetToken,
    this.targetNetwork,
    this.allocations = const {},
  });
  final String sessionId;
  final String status;
  final int version;
  final bool canConfirmTransfer;
  final DateTime expiresAt;
  final String? requiredTargetBalance;
  final String? targetAvailableAmount;
  final String? remainingMinimumTopUp;
  final String? selectedTargetAmount;
  final String? minimumReceived;
  final FundingSessionFees? fees;
  final int? etaSeconds;
  final String? targetToken;
  final String? targetNetwork;
  final Map<String, String> allocations;
}

final class FundingSessionFees {
  const FundingSessionFees({
    required this.asset,
    required this.bridgeFee,
    required this.networkFee,
    required this.totalFee,
  });

  final String asset;
  final String bridgeFee;
  final String networkFee;
  final String totalFee;
}
