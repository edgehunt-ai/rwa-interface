import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/services/generated_portfolio_service.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  test(
    'generated portfolio service covers summary, accounts, and holdings',
    () async {
      final adapter = ControlledApiAdapter([
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/portfolio/summary',
          statusCode: 200,
          body: const {
            'total_value_usd': '10.00',
            'available_to_trade_usd': '8.00',
          },
        ),
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/portfolio/accounts',
          statusCode: 200,
          body: const {'items': <Object?>[]},
        ),
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/portfolio/holdings',
          statusCode: 200,
          body: const {
            'items': <Object?>[],
            'total_value_usd': '0',
            'has_more': false,
          },
        ),
      ]);
      final source = RwaApiDataSource.create(
        tokenProvider: FakePrivyAccessTokenProvider(),
        environment: const ApiEnvironment(
          baseUrl: 'https://controlled.invalid',
        ),
      );
      source.dio.httpClientAdapter = adapter;
      final service = GeneratedPortfolioService(
        source.client.getPortfolioApi(),
      );
      expect((await service.getSummary()).totalValueUsd, '10.00');
      expect((await service.listAccounts()).items, isEmpty);
      expect((await service.listHoldings()).items, isEmpty);
    },
  );
}
