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
