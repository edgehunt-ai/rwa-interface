import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/repositories/funding_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_funding_service.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  test(
    'deposit directory deserializes all available and unavailable rails',
    () async {
      final source = RwaApiDataSource.create(
        tokenProvider: FakePrivyAccessTokenProvider(),
        environment: const ApiEnvironment(
          baseUrl: 'https://controlled.invalid',
        ),
      );
      source.dio.httpClientAdapter = ControlledApiAdapter([
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/deposit-instructions',
          statusCode: 200,
          body: _depositInstructionsJson,
        ),
      ]);
      final service = GeneratedFundingService(source.client.getFundingApi());
      final repository = FundingRepositoryImpl(service);

      final directory = await repository.getDepositDirectory();

      expect(
        directory.walletAddress,
        '0x09920a496942e7aa8c9adabf97cdf035524248c1',
      );
      expect(
        directory.instructions.map((item) => '${item.chain}:${item.token}'),
        ['BSC:USDT', 'BSC:USDC', 'Arbitrum:USDC'],
      );
      expect(directory.instructions.first.tokenDecimals, 18);
    },
  );
}

const Map<String, dynamic> _depositInstructionsJson = {
  'catalog_version': '2026-09-01.v1',
  'updated_at': '2026-09-14T03:40:13Z',
  'wallet': {
    'wallet_id': 'iz5vd6yct95r8jq40q4zya14',
    'address': '0x09920a496942e7aa8c9adabf97cdf035524248c1',
    'custody': 'embedded_wallet',
  },
  'items': [
    {
      'availability': {
        'blockers': ['rpc_unavailable', 'wallet_unavailable'],
        'status': 'unavailable',
      },
      'confirmations_required': 12,
      'credited_to': 'wallet',
      'estimated_arrival_seconds': 180,
      'identity': {
        'asset_id': 'eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48',
        'chain_id': 1,
        'namespace': 'eip155',
        'network': 'Ethereum',
        'provenance': 'circle_native',
        'token': 'USDC',
        'token_contract': '0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48',
        'token_decimals': 6,
      },
      'min_deposit': '1',
      'warning': 'Only send USDC on Ethereum to this wallet.',
    },
    _bscUsdtItem,
    _bscUsdcItem,
    _arbitrumUsdcItem,
  ],
};

const Map<String, dynamic> _bscUsdtItem = {
  'availability': {'blockers': <String>[], 'status': 'available'},
  'confirmations_required': 15,
  'credited_to': 'wallet',
  'estimated_arrival_seconds': 60,
  'identity': {
    'asset_id': 'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955',
    'chain_id': 56,
    'namespace': 'eip155',
    'network': 'BSC',
    'provenance': 'binance_peg',
    'token': 'USDT',
    'token_contract': '0x55d398326f99059ff775485246999027b3197955',
    'token_decimals': 18,
  },
  'min_deposit': '1',
  'qr_payload': 'ethereum:0x55d398326f99059ff775485246999027b3197955@56/transfer?address=0x09920a496942e7aa8c9adabf97cdf035524248c1',
  'warning': 'Only send USDT on BSC to this wallet.',
};

const Map<String, dynamic> _bscUsdcItem = {
  'availability': {'blockers': <String>[], 'status': 'available'},
  'confirmations_required': 15,
  'credited_to': 'wallet',
  'estimated_arrival_seconds': 60,
  'identity': {
    'asset_id': 'eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d',
    'chain_id': 56,
    'namespace': 'eip155',
    'network': 'BSC',
    'provenance': 'binance_peg',
    'token': 'USDC',
    'token_contract': '0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d',
    'token_decimals': 18,
  },
  'min_deposit': '1',
  'qr_payload': 'ethereum:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d@56/transfer?address=0x09920a496942e7aa8c9adabf97cdf035524248c1',
  'warning': 'Only send USDC on BSC to this wallet.',
};

const Map<String, dynamic> _arbitrumUsdcItem = {
  'availability': {'blockers': <String>[], 'status': 'available'},
  'confirmations_required': 20,
  'credited_to': 'wallet',
  'estimated_arrival_seconds': 30,
  'identity': {
    'asset_id': 'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831',
    'chain_id': 42161,
    'namespace': 'eip155',
    'network': 'Arbitrum',
    'provenance': 'circle_native',
    'token': 'USDC',
    'token_contract': '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
    'token_decimals': 6,
  },
  'min_deposit': '1',
  'qr_payload': 'ethereum:0xaf88d065e77c8cc2239327c5edb3a432268e5831@42161/transfer?address=0x09920a496942e7aa8c9adabf97cdf035524248c1',
  'warning': 'Only send USDC on Arbitrum to this wallet.',
};
