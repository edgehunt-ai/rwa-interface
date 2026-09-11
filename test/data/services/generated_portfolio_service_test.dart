import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/services/generated_portfolio_service.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  test('generated portfolio service covers summary, history, accounts, and holdings', () async {
    final adapter = ControlledApiAdapter([
      ControlledResponse.json(
        method: 'GET',
        path: '/v1/portfolio/history',
        statusCode: 200,
        body: const {
          'range': '1w',
          'interval': '1h',
          'points': [
            {
              'timestamp': '2026-01-01T00:00:00Z',
              'total_value_usd': '10.25',
              'net_external_cash_flow_usd': '0',
              'pnl_usd': '0',
              'pnl_percent': '0',
            },
          ],
          'data_status': 'complete',
          'freshness': 'live',
          'calculated_at': '2026-01-01T00:00:00Z',
          'warnings': <Object?>[],
          'sources': <Object?>[],
        },
      ),
      ControlledResponse.json(
        method: 'GET',
        path: '/v1/portfolio/summary',
        statusCode: 200,
        body: const {
          'total_value_usd': '10.00',
          'available_to_trade_usd': '8.00',
          'margin_in_use_usd': '0',
          'unvalued_asset_count': 0,
          'data_status': 'complete',
          'freshness': 'live',
          'calculated_at': '2026-01-01T00:00:00Z',
          'warnings': <Object?>[],
          'sources': <Object?>[],
        },
      ),
      ControlledResponse.json(
        method: 'GET',
        path: '/v1/portfolio/accounts',
        statusCode: 200,
        body: const {
          'scope': 'internal_ledger',
          'items': <Object?>[],
          'reconciled': true,
          'freshness': 'live',
          'blockers': <Object?>[],
        },
      ),
      ControlledResponse.json(
        method: 'GET',
        path: '/v1/portfolio/holdings',
        statusCode: 200,
        body: const {
          'items': <Object?>[],
          'total_equity_usd': '0',
          'has_more': false,
          'data_status': 'empty',
          'freshness': 'live',
          'calculated_at': '2026-01-01T00:00:00Z',
          'warnings': <Object?>[],
          'sources': <Object?>[],
        },
      ),
    ]);
    final source = RwaApiDataSource.create(
      tokenProvider: FakePrivyAccessTokenProvider(),
      environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
    );
    source.dio.httpClientAdapter = adapter;
    final service = GeneratedPortfolioService(source.client.getPortfolioApi());
    expect((await service.getSummary()).totalValueUsd, '10.00');
    expect(
      (await service.getHistory(
        range: '1w',
        interval: '1h',
      )).points.single.totalValueUsd,
      '10.25',
    );
    expect((await service.listAccounts()).items, isEmpty);
    expect((await service.listHoldings()).items, isEmpty);
  });
}
