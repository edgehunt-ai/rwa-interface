abstract interface class EmbeddedWalletTransactionSender {
  /// Known failures before a broadcast request use
  /// WalletTransactionNotBroadcastFailure. Errors after issuing the wallet RPC
  /// remain uncertain unless the provider supplies a structured rejection.
  Future<String> sendTransaction({
    required String expectedSigner,
    required int chainId,
    required String to,
    required String data,
    required String value,
  });
}
