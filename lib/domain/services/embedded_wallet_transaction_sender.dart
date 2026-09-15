abstract interface class EmbeddedWalletTransactionSender {
  Future<String> sendTransaction({
    required String expectedSigner,
    required int chainId,
    required String to,
    required String data,
    required String value,
  });
}
