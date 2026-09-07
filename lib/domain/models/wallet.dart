enum WalletState { active, verificationRequired, disabled, unknown }

final class Wallet {
  const Wallet({
    required this.walletId,
    required this.address,
    required this.chain,
    required this.status,
    required this.createdAt,
  });

  final String walletId;
  final String address;
  final String chain;
  final WalletState status;
  final DateTime createdAt;
}
