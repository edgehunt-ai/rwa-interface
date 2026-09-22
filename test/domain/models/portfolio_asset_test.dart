import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/portfolio_asset.dart';

void main() {
  test('canonical identity is built from network and contract, not asset_id', () {
    final asset = _asset(
      // The opaque row id must never reach an operation that wants a canonical
      // identity: the server answers 422.
      assetId: 'portfolio-9f3c1a',
      network: 'arbitrum',
      contractAddress: '0xAF88D065E77C8CC2239327C5EDB3A432268E5831',
    );

    expect(
      asset.canonicalEvmId,
      'eip155:421614/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831',
    );
    expect(asset.canonicalEvmId, isNot(contains('portfolio-')));
  });

  test('every allowlisted EVM chain resolves its decimal chain id', () {
    expect(_asset(network: 'ethereum').evmChainId, 1);
    expect(_asset(network: 'arbitrum').evmChainId, 421614);
    expect(_asset(network: 'bsc').evmChainId, 97);
    // `Base` reaches the domain as the generated enum name `base_`.
    expect(_asset(network: 'base_').evmChainId, 8453);
    expect(_asset(network: 'Base').evmChainId, 8453);
    expect(
      _asset(
        network: 'base_',
        contractAddress: '0x${'ab' * 20}',
      ).canonicalEvmId,
      'eip155:8453/erc20:0x${'ab' * 20}',
    );
  });

  test('assets with no canonical EVM identity return null', () {
    // A venue balance is not an EVM ERC-20.
    expect(_asset(network: 'hyperliquid').canonicalEvmId, isNull);
    // A native coin has no contract.
    expect(
      _asset(native: true, contractAddress: '0x${'ab' * 20}').canonicalEvmId,
      isNull,
    );
    expect(_asset(contractAddress: null).canonicalEvmId, isNull);
    expect(_asset(contractAddress: 'not-an-address').canonicalEvmId, isNull);
    expect(_asset(network: 'polygon').canonicalEvmId, isNull);
  });
}

PortfolioAsset _asset({
  String assetId = 'portfolio-1',
  String network = 'arbitrum',
  String? contractAddress = '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  bool native = false,
}) => PortfolioAsset(
  assetId: assetId,
  network: network,
  symbol: 'USDC',
  decimals: 6,
  balance: DecimalValue('100.000000', asset: 'USDC', unit: 'token'),
  contractAddress: contractAddress,
  native: native,
);
