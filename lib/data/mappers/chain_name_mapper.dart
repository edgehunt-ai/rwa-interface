/// Converts generated enum names into the stable chain labels used by the
/// domain and presentation layers.
String canonicalChainName(String value) => switch (value.toLowerCase()) {
  'bsc' => 'BSC',
  'arbitrum' => 'Arbitrum',
  'base' || 'base_' => 'Base',
  'ethereum' => 'Ethereum',
  'hyperliquid' => 'Hyperliquid',
  'polygon' => 'Polygon',
  'solana' => 'Solana',
  final other => other,
};

/// Preview responses identify both BSC mainnet (56) and BSC testnet (97) as
/// BSC. Keep the presentation/domain chain identity aligned with accounts,
/// which currently expose the network name rather than the numeric chain ID.
String canonicalSettlementChainName({
  required String network,
  int? chainId,
}) {
  if (network.toLowerCase() == 'bsc' &&
      (chainId == null || chainId == 56 || chainId == 97)) {
    return 'BSC';
  }
  return canonicalChainName(network);
}
