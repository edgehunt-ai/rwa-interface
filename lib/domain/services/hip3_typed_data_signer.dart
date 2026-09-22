enum Hip3SigningFailureCode {
  invalidPayload,
  actionNotReady,
  actionExpired,
  walletUnavailable,
  walletMismatch,
  rejected,
}

final class Hip3SigningFailure implements Exception {
  const Hip3SigningFailure(this.code, {this.retryable = false, this.reason});

  final Hip3SigningFailureCode code;
  final bool retryable;

  /// The server's `failure_reason` for a terminal action or step.
  ///
  /// It names why this particular signature was refused, which the generic
  /// code cannot; prefer it over the code's fallback copy when present.
  final String? reason;
}

abstract interface class Hip3TypedDataSigner {
  /// Signs the server-frozen EIP-712 payload with the exact expected wallet.
  /// Implementations must never fall back to personal_sign or eth_sign.
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  });
}

final class Hip3RsvSignature {
  const Hip3RsvSignature({required this.r, required this.s, required this.v});

  factory Hip3RsvSignature.fromCompactHex(String signature) {
    final normalized = signature.toLowerCase();
    if (!RegExp(r'^0x[0-9a-f]{130}$').hasMatch(normalized)) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    final rawV = int.parse(normalized.substring(130, 132), radix: 16);
    final v = switch (rawV) {
      0 || 1 => rawV + 27,
      27 || 28 => rawV,
      _ => throw const Hip3SigningFailure(
        Hip3SigningFailureCode.invalidPayload,
      ),
    };
    return Hip3RsvSignature(
      r: '0x${normalized.substring(2, 66)}',
      s: '0x${normalized.substring(66, 130)}',
      v: v,
    );
  }

  final String r;
  final String s;
  final int v;
}
