import 'decimal_value.dart';

final class PortfolioAsset {
  const PortfolioAsset({
    required this.assetId,
    required this.network,
    required this.symbol,
    required this.decimals,
    required this.balance,
    this.withdrawable = false,
    this.walletId,
    this.contractAddress,
    this.native = false,
  });

  /// Server-issued opaque identifier (`portfolio-…`). It addresses this row and
  /// nothing else: operations that take a canonical asset identity reject it,
  /// so use [canonicalEvmId] for those. See the self-custodial withdrawal
  /// create request.
  final String assetId;
  final String network;
  final String symbol;
  final int decimals;
  final DecimalValue balance;
  final bool withdrawable;
  final String? walletId;
  final String? contractAddress;
  final bool native;

  /// Canonical EVM asset identity, `eip155:<chain id>/erc20:<address>`,
  /// assembled from [network] and [contractAddress] — this is what the contract
  /// means by "canonical asset identity", and passing [assetId] instead is
  /// rejected with 422.
  ///
  /// Null when this asset has no such identity: a native coin, a venue balance
  /// (Hyperliquid), a missing contract address, or a network outside the
  /// four-chain EVM allowlist.
  String? get canonicalEvmId {
    final contract = contractAddress;
    final chainId = evmChainId;
    if (native || chainId == null || contract == null) return null;
    if (!_evmAddress.hasMatch(contract)) return null;
    return 'eip155:$chainId/erc20:${contract.toLowerCase()}';
  }

  /// Decimal EVM chain ID for [network], or null when it is not one of the four
  /// allowlisted EVM chains.
  int? get evmChainId => switch (normalizedNetwork) {
    'ethereum' => 1,
    // Temporary testnet mapping for self-custodial withdrawal asset IDs.
    'arbitrum' => 421614,
    'base' => 8453,
    'bsc' => 97,
    _ => null,
  };

  /// [network] carries a generated enum member name, which gains a trailing
  /// underscore whenever the wire label collides with a Dart keyword or member
  /// (`Base` arrives as `base_`). Compare against this, never the raw value.
  String get normalizedNetwork => normalizeChainLabel(network);
}

/// Strips the trailing underscore that generated enum names carry for labels
/// that would otherwise collide (`base_` -> `base`), and lowercases.
String normalizeChainLabel(String value) {
  final lowered = value.toLowerCase();
  return lowered.endsWith('_')
      ? lowered.substring(0, lowered.length - 1)
      : lowered;
}

final _evmAddress = RegExp(r'^0x[0-9a-fA-F]{40}$');
