enum Hip3AccountAbstractionMode {
  defaultMode,
  unifiedAccount,
  portfolioMargin,
  unknown,
}

enum Hip3AccountAbstractionExecutionMethod { agent, user }

final class Hip3AccountAbstractionStatus {
  const Hip3AccountAbstractionStatus({
    required this.ownerAddress,
    required this.currentMode,
    required this.switchAvailable,
  });

  final String ownerAddress;
  final Hip3AccountAbstractionMode currentMode;
  final bool switchAvailable;

  bool get isUnifiedAccount =>
      currentMode == Hip3AccountAbstractionMode.unifiedAccount;
}

final class Hip3AccountAbstractionPreparation {
  const Hip3AccountAbstractionPreparation({
    required this.ownerAddress,
    required this.executionMethod,
    required this.nonce,
    required this.payloadHash,
    required this.typedDataJson,
    required this.expiresAt,
  });

  final String ownerAddress;
  final Hip3AccountAbstractionExecutionMethod executionMethod;
  final int nonce;
  final String payloadHash;
  final String? typedDataJson;
  final DateTime expiresAt;
}
