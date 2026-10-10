import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/network/network_icon_assets.dart';

void main() {
  test('maps supported network names and aliases to shared icon assets', () {
    expect(networkKind('Base'), NetworkKind.base);
    expect(networkKind(' base mainnet '), NetworkKind.base);
    expect(networkKind('BNB Smart Chain'), NetworkKind.bsc);
    expect(networkKind('Arbitrum One'), NetworkKind.arbitrum);
    expect(networkIconAssetPath('Base'), NetworkIconAssets.base);
    expect(networkIconAssetPath(' base mainnet '), NetworkIconAssets.base);
    expect(networkIconAssetPath('BSC'), NetworkIconAssets.bsc);
    expect(networkIconAssetPath('BNB Smart Chain'), NetworkIconAssets.bsc);
    expect(networkIconAssetPath('Arbitrum One'), NetworkIconAssets.arbitrum);
    expect(
      networkIconAssetPath('Ethereum Mainnet'),
      NetworkIconAssets.ethereum,
    );
    expect(networkIconAssetPath('Polygon PoS'), NetworkIconAssets.polygon);
    expect(networkIconAssetPath('Hyperliquid'), NetworkIconAssets.hyperliquid);
  });

  test('supports compact marks and rejects unknown networks', () {
    expect(
      networkIconAssetPath('Arbitrum', variant: NetworkIconVariant.mark),
      NetworkIconAssets.arbitrumMark,
    );
    expect(
      networkIconAssetPath('Ethereum', variant: NetworkIconVariant.mark),
      NetworkIconAssets.ethereumMark,
    );
    expect(networkIconAssetPath('Solana'), isNull);
    expect(networkIconAssetPath(null), isNull);
  });
}
