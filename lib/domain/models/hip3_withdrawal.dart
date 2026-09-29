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
    this.failureReason,
    this.typedDataJson,
    this.payloadHash,
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
  final String? failureReason;
  final String? typedDataJson;
  final String? payloadHash;

  bool get isPending => status == 'submitted' || status == 'payout';
}
