import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/repositories/funding_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_funding_service.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';

import '../helpers/controlled_api_adapter.dart';
import '../helpers/trading_provider_harness.dart';

void main() {
  test('100 controlled queries reach a consumable terminal state under one second p95', () async {
    final adapter = ControlledApiAdapter([
      for (var index = 0; index < 100; index++)
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/funding/catalog',
          statusCode: 200,
          body: _catalogJson,
        ),
    ]);
    final source = RwaApiDataSource.create(
      tokenProvider: FakePrivyAccessTokenProvider(),
      environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
    );
    source.dio.httpClientAdapter = adapter;
    final repository = FundingRepositoryImpl(
      GeneratedFundingService(source.client.getFundingApi()),
    );
    final samples = <Duration>[];

    for (var index = 0; index < 100; index++) {
      final container = ProviderContainer(
        overrides: [fundingRepositoryProvider.overrideWithValue(repository)],
      );
      final subscription = container.listen(fundingCatalogProvider, (_, _) {});
      final watch = Stopwatch()..start();
      final catalog = await container.read(fundingCatalogProvider.future);
      watch.stop();
      samples.add(watch.elapsed);
      expect(catalog.rails.single.network, 'BSC');
      subscription.close();
      container.dispose();
    }

    samples.sort();
    expect(adapter.requests, hasLength(100));
    expect(samples[94], lessThan(const Duration(seconds: 1)));
  });
}

const _catalogJson = {
  'rails': [
    {
      'rail': 'bstock',
      'network': 'BSC',
      'settlement_asset': 'USDC',
      'minimum_amount': '1',
    },
  ],
  'updated_at': '2026-01-01T00:00:00Z',
};
