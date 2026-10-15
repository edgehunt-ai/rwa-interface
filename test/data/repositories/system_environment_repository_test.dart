import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/api/api_environment.dart';
import 'package:nobell/data/api/rwa_api_data_source.dart';
import 'package:nobell/data/repositories/system_environment_repository_impl.dart';
import 'package:nobell/data/services/generated_system_service.dart';
import 'package:nobell/domain/models/api_failure.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  SystemEnvironmentRepositoryImpl repository(
    Map<String, Object?> bstocks, {
    int status = 200,
  }) {
    final source = RwaApiDataSource.create(
      tokenProvider: FakePrivyAccessTokenProvider(),
      environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
    );
    source.dio.httpClientAdapter = ControlledApiAdapter([
      ControlledResponse.json(
        method: 'GET',
        path: '/v1/system/environment',
        statusCode: status,
        body: {
          'environment': 'testnet',
          'execution': {'enabled': true, 'signing': true},
          'hip3': {'environment': 'mainnet'},
          'bstocks': bstocks,
        },
      ),
    ]);
    addTearDown(() => source.dio.close());
    return SystemEnvironmentRepositoryImpl(
      GeneratedSystemService(source.client.getSystemApi()),
    );
  }

  test(
    'reads testnet identity and independent HIP-3 environment through the API',
    () async {
      final value = await repository({
        'configured': true,
        'environment': 'testnet',
        'chain_id': 97,
        'quote_token': {
          'symbol': 'TUSDT',
          'contract': '0x0000000000000000000000000000000000000097',
          'decimals': 6,
        },
      }).getEnvironment();
      expect(value.environment, 'testnet');
      expect(value.hip3Environment, 'mainnet');
      expect(value.bstocksSettlementToken!.chainId, 97);
      expect(value.bstocksSettlementToken!.symbol, 'TUSDT');
      expect(value.bstocksSettlementToken!.decimals, 6);
      expect(
        value.bstocksSettlementToken!.contract,
        '0x0000000000000000000000000000000000000097',
      );
    },
  );

  test('mainnet token retains the server contract and precision', () async {
    final value = await repository({
      'configured': true,
      'environment': 'mainnet',
      'chain_id': 56,
      'quote_token': {
        'symbol': 'USDT',
        'contract': '0x55d398326f99059ff775485246999027b3197955',
        'decimals': 18,
      },
    }).getEnvironment();
    expect(value.bstocksSettlementToken!.chainId, 56);
    expect(value.bstocksSettlementToken!.symbol, 'USDT');
    expect(value.bstocksSettlementToken!.decimals, 18);
  });

  test('unconfigured execution has no invented settlement identity', () async {
    final value = await repository({'configured': false}).getEnvironment();
    expect(value.bstocksConfigured, false);
    expect(value.bstocksSettlementToken, isNull);
  });

  test(
    'configured execution without token identity is a stable decoding failure',
    () async {
      await expectLater(
        repository({'configured': true}).getEnvironment(),
        throwsA(isA<DecodingFailure>()),
      );
    },
  );

  test('rejects an invalid token contract', () async {
    await expectLater(
      repository({
        'configured': true,
        'environment': 'testnet',
        'chain_id': 97,
        'quote_token': {
          'symbol': 'TUSDT',
          'contract': 'invalid',
          'decimals': 6,
        },
      }).getEnvironment(),
      throwsA(isA<DecodingFailure>()),
    );
  });
}
