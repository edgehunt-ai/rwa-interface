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
    this.relayRequestId,
    this.observedLedgerTime,
    this.payoutTxHash,
    this.createdAt,
    this.updatedAt,
    this.submittedAt,
    this.confirmedAt,
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
  final String? relayRequestId;
  final int? observedLedgerTime;
  final String? payoutTxHash;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? submittedAt;
  final DateTime? confirmedAt;

  bool get isCompleted => status == 'completed' && !requiresManualReview;

  bool get isPending => !isCompleted &&
      status != 'awaiting_signature' && status != 'failed' &&
      status != 'expired' && status != 'refunded' && status != 'credited';

  bool get shouldPoll => !requiresManualReview && const {
    'submitting', 'submitted', 'payout', 'refund_pending', 'recovering',
  }.contains(status);

  bool get requiresManualReview => status == 'manual_review' ||
      (failureReason?.contains('requires_manual_review') ?? false);
}
