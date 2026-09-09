final class UnsupportedCapability {
  const UnsupportedCapability._({required this.code, required this.resourceId});

  const UnsupportedCapability.orderSignature({required String resourceId})
    : this._(code: 'order_signature_not_supported', resourceId: resourceId);

  const UnsupportedCapability.fundingTransfer({required String resourceId})
    : this._(code: 'funding_transfer_not_supported', resourceId: resourceId);

  final String code;
  final String resourceId;
  String get userAction => 'wait_for_feature';
  bool get retryable => false;
}
