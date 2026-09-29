import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/mappers/chain_name_mapper.dart';

void main() {
  test('maps generated enum names to stable chain labels', () {
    expect(canonicalChainName('BSC'), 'BSC');
    expect(canonicalChainName('arbitrum'), 'Arbitrum');
    expect(canonicalChainName('base_'), 'Base');
    expect(canonicalChainName('ethereum'), 'Ethereum');
  });

  test('normalizes already canonical labels', () {
    expect(canonicalChainName('Arbitrum'), 'Arbitrum');
    expect(canonicalChainName('SOLANA'), 'Solana');
  });

  test(
    'maps BSC chain ids to BSC without inferring a chain id from the label',
    () {
      expect(canonicalSettlementChainName(network: 'BSC', chainId: 56), 'BSC');
      expect(canonicalSettlementChainName(network: 'BSC', chainId: 97), 'BSC');
      expect(
        canonicalSettlementChainName(network: 'Arbitrum', chainId: 42161),
        'Arbitrum',
      );
    },
  );
}
