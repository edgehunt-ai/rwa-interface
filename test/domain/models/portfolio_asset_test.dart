import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';

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
      'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831',
    );
    expect(asset.canonicalEvmId, isNot(contains('portfolio-')));
  });

  test('every allowlisted EVM chain resolves its decimal chain id', () {
    expect(_asset(network: 'ethereum').evmChainId, 1);
    expect(_asset(network: 'arbitrum').evmChainId, 42161);
    expect(_asset(network: 'bsc').evmChainId, 56);
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

  test('BSC withdrawal availability preserves totals and exact precision', () {
    final asset = _asset(
      network: 'BSC',
      available: '20.000000000000000001',
      status: 'complete',
    );
    expect(asset.balance.value, '100.000000');
    expect(asset.withdrawalAvailableBalance?.value, '20.000000000000000001');
    expect(
      asset.withdrawalAvailableBalance!.compareTo(
        DecimalValue('20.000000000000000002', asset: 'USDC', unit: 'token'),
      ),
      lessThan(0),
    );
    expect(
      _asset(
        network: 'bsc',
        available: '120',
        status: 'partial',
      ).withdrawalAvailableBalance?.value,
      '100.000000',
    );
    expect(
      _asset(
        network: 'bsc',
        available: '0',
        status: 'complete',
      ).withdrawalAvailableBalance?.value,
      '0',
    );
  });

  test('BSC missing, negative, unknown and stale availability fail closed', () {
    for (final asset in [
      _asset(network: 'bsc'),
      _asset(network: 'bsc', status: 'complete'),
      _asset(network: 'bsc', available: '20'),
      _asset(network: 'bsc', available: '-1', status: 'complete'),
      _asset(network: 'bsc', available: '20', status: 'unknown'),
      _asset(network: 'bsc', available: '20', status: 'unavailable'),
      _asset(
        network: 'bsc',
        available: '20',
        status: 'complete',
        freshness: 'stale',
      ),
      _asset(
        network: 'bsc',
        available: '20',
        status: 'complete',
        freshness: 'unavailable',
      ),
      _asset(network: 'bsc', legacyAvailable: '99'),
      _asset(network: 'bsc', status: 'unavailable', legacyAvailable: '99'),
    ]) {
      expect(asset.withdrawalAvailableBalance, isNull);
    }
  });

  test(
    'other networks retain raw balance only without availability evidence',
    () {
      for (final network in ['arbitrum', 'ethereum', 'base_', 'hyperliquid']) {
        expect(
          _asset(network: network).withdrawalAvailableBalance?.value,
          '100.000000',
        );
        expect(
          _asset(
            network: network,
            freshness: 'stale',
          ).withdrawalAvailableBalance,
          isNull,
        );
        expect(
          _asset(
            network: network,
            status: 'unavailable',
          ).withdrawalAvailableBalance,
          isNull,
        );
        expect(
          _asset(
            network: network,
            available: '20',
            status: 'partial',
          ).withdrawalAvailableBalance?.value,
          '20',
        );
      }
    },
  );
}

PortfolioAsset _asset({
  String assetId = 'portfolio-1',
  String network = 'arbitrum',
  String? contractAddress = '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  bool native = false,
  String? available,
  String? status,
  String? freshness,
  String? legacyAvailable,
}) => PortfolioAsset(
  assetId: assetId,
  network: network,
  symbol: 'USDC',
  decimals: 6,
  balance: DecimalValue('100.000000', asset: 'USDC', unit: 'token'),
  contractAddress: contractAddress,
  native: native,
  availableQuantity: available == null
      ? null
      : DecimalValue(available, asset: 'USDC', unit: 'token'),
  availabilityStatus: status,
  freshness: freshness,
  bstocksAvailableQuantity: legacyAvailable == null
      ? null
      : DecimalValue(legacyAvailable, asset: 'USDC', unit: 'token'),
  bstocksAvailabilityStatus: legacyAvailable == null ? null : 'complete',
);
