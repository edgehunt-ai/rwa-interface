import 'decimal_value.dart';

final class PortfolioAsset {
  const PortfolioAsset({
    required this.assetId,
    required this.network,
    required this.symbol,
    required this.decimals,
    required this.balance,
    this.walletId,
    this.contractAddress,
    this.native = false,
  });

  final String assetId;
  final String network;
  final String symbol;
  final int decimals;
  final DecimalValue balance;
  final String? walletId;
  final String? contractAddress;
  final bool native;
}
