final class Hip3Withdrawal {
  const Hip3Withdrawal({
    required this.id,
    required this.ownerAddress,
    required this.destinationAddress,
    required this.amount,
    required this.fee,
    required this.minimumReceived,
    required this.status,
    required this.rail,
    required this.expiresAt,
    this.payoutChainId,
    this.payoutAsset,
    this.failureReason,
    this.typedDataJson,
    this.payloadHash,
    this.nonceMappingTypedDataJson,
    this.nonceMappingPayloadHash,
  });

  final String id;
  final String ownerAddress;
  final String destinationAddress;
  final String amount;
  final String fee;
  final String minimumReceived;
  final String status;
  final String rail;
  final DateTime expiresAt;
  final int? payoutChainId;
  final String? payoutAsset;
  final String? failureReason;
  final String? typedDataJson;
  final String? payloadHash;
  final String? nonceMappingTypedDataJson;
  final String? nonceMappingPayloadHash;

  bool get isPending =>
      status == 'submitting' || status == 'submitted' || status == 'payout';

  bool get requiresManualReview =>
      isPending && (failureReason?.contains('requires_manual_review') ?? false);
}
