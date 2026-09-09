final class Hip3OrderAction {
  const Hip3OrderAction({
    required this.orderId,
    required this.actionId,
    required this.expectedSigner,
    required this.typedData,
    required this.signingDigest,
    required this.validUntil,
  });

  factory Hip3OrderAction.fromOrderJson(Map<String, Object?> json) {
    final rawAction = json['hip3_action'];
    if (rawAction is! Map<String, Object?>) {
      throw const FormatException('Order has no HIP-3 action');
    }
    final typedData = rawAction['signing_typed_data'];
    return Hip3OrderAction(
      orderId: _string(json, 'order_id'),
      actionId: _string(rawAction, 'action_id'),
      expectedSigner: _string(rawAction, 'expected_signer').toLowerCase(),
      typedData: Map<String, Object?>.unmodifiable(
        (typedData as Map).cast<String, Object?>(),
      ),
      signingDigest: _string(rawAction, 'signing_digest').toLowerCase(),
      validUntil: DateTime.parse(_string(rawAction, 'valid_until')).toUtc(),
    );
  }

  final String orderId;
  final String actionId;
  final String expectedSigner;
  final Map<String, Object?> typedData;
  final String signingDigest;
  final DateTime validUntil;

  bool isExpiredAt(DateTime now) => !now.toUtc().isBefore(validUntil);
}

String _string(Map<String, Object?> json, String key) {
  final value = json[key];
  if (value is! String || value.isEmpty) {
    throw FormatException('Missing $key');
  }
  return value;
}

final class Hip3SubmissionResult {
  const Hip3SubmissionResult({
    required this.orderId,
    required this.status,
    this.providerOrderId,
  });

  final String orderId;
  final String status;
  final String? providerOrderId;
}
