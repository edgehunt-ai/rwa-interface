abstract interface class Hip3TypedDataSigner {
  /// Must call the wallet's `eth_signTypedData_v4` equivalent and return the
  /// canonical 65-byte `0x{r}{s}{v}` signature.
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
      throw const FormatException('HIP-3 signature must be 65-byte hex');
    }
    final rawV = int.parse(normalized.substring(130, 132), radix: 16);
    final v = switch (rawV) {
      0 || 1 => rawV + 27,
      27 || 28 => rawV,
      _ => throw const FormatException('HIP-3 signature v is invalid'),
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

  Map<String, Object> toJson() => {'r': r, 's': s, 'v': v};
}
