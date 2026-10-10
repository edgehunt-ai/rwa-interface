enum NetworkIconVariant { full, mark }

enum NetworkKind { base, bsc, arbitrum, ethereum, polygon, hyperliquid }

abstract final class NetworkIconAssets {
  static const base = 'assets/figma/common/network_base.svg';
  static const bsc = 'assets/figma/common/network_bsc.svg';
  static const arbitrum = 'assets/figma/funding/arbitrum.svg';
  static const arbitrumMark =
      'assets/figma/portfolio/network_arbitrum_mark.svg';
  static const ethereum = 'assets/figma/funding/eth.svg';
  static const ethereumMark =
      'assets/figma/portfolio/network_ethereum_mark.svg';
  static const polygon = 'assets/figma/funding/polygon.svg';
  static const hyperliquid = 'assets/figma/home_markets/venue_hyperliquid.svg';
}

String? networkIconAssetPath(
  String? network, {
  NetworkIconVariant variant = NetworkIconVariant.full,
}) => switch (networkKind(network)) {
  NetworkKind.base => NetworkIconAssets.base,
  NetworkKind.bsc => NetworkIconAssets.bsc,
  NetworkKind.arbitrum => switch (variant) {
    NetworkIconVariant.full => NetworkIconAssets.arbitrum,
    NetworkIconVariant.mark => NetworkIconAssets.arbitrumMark,
  },
  NetworkKind.ethereum => switch (variant) {
    NetworkIconVariant.full => NetworkIconAssets.ethereum,
    NetworkIconVariant.mark => NetworkIconAssets.ethereumMark,
  },
  NetworkKind.polygon => NetworkIconAssets.polygon,
  NetworkKind.hyperliquid => NetworkIconAssets.hyperliquid,
  _ => null,
};

NetworkKind? networkKind(String? network) =>
    switch (network?.trim().toLowerCase()) {
      'base' || 'base mainnet' => NetworkKind.base,
      'bsc' || 'bnb chain' || 'bnb smart chain' => NetworkKind.bsc,
      'arbitrum' || 'arbitrum one' => NetworkKind.arbitrum,
      'ethereum' || 'ethereum mainnet' => NetworkKind.ethereum,
      'polygon' || 'polygon pos' => NetworkKind.polygon,
      'hyperliquid' => NetworkKind.hyperliquid,
      _ => null,
    };
