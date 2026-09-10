import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/services/generated_charts_service.dart';
import 'package:rwa_interface/data/services/generated_markets_service.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  test('HIP3 chart preserves explicit window and interval through generated HTTP client', () async {
    final adapter = ControlledApiAdapter([
      ControlledResponse.json(
        method: 'GET',
        path: '/v1/markets/TSLA/products/perp/candles',
        statusCode: 200,
        body: const {
          'symbol': 'TSLA',
          'kind': 'perp',
          'range': '24h',
          'interval': '1m',
          'points': <Object>[],
        },
      ),
    ]);
    final source = _source(adapter);
    RequestOptions? request;
    source.dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          request = options;
          handler.next(options);
        },
      ),
    );
    final charts = GeneratedChartsService(source.client.getChartsApi());
    final to = DateTime.utc(2026, 9, 10, 10);
    final from = to.subtract(const Duration(hours: 1));
    await charts.getCandles(
      'TSLA',
      api.ProductKind.perp,
      interval: '1m',
      from: from,
      to: to,
    );
    expect(request!.queryParameters['interval'], '1m');
    expect(DateTime.parse(request!.queryParameters['from'].toString()), from);
    expect(DateTime.parse(request!.queryParameters['to'].toString()), to);
    expect(request!.queryParameters.containsKey('range'), isFalse);
  });
  test(
    'generated market and chart services deserialize contract values',
    () async {
      final adapter = ControlledApiAdapter([
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/markets/products',
          statusCode: 200,
          body: const {
            'items': [
              {'symbol': 'NVDA', 'kind': 'bstock', 'price': '123.4500'},
            ],
            'has_more': false,
          },
        ),
        ControlledResponse.json(
          method: 'GET',
          path: '/v1/markets/NVDA/products/bstock/candles',
          statusCode: 200,
          body: const {
            'symbol': 'NVDA',
            'kind': 'bstock',
            'range': '24h',
            'points': [
              {'t': '2026-01-01T00:00:00Z', 'c': '123.4500'},
            ],
          },
        ),
      ]);
      final source = _source(adapter);
      final markets = GeneratedMarketsService(source.client.getMarketsApi());
      final charts = GeneratedChartsService(source.client.getChartsApi());
      expect((await markets.listProducts()).items.single.price, '123.4500');
      expect(
        (await charts.getCandles(
          'NVDA',
          api.ProductKind.bstock,
        )).points.single.c,
        '123.4500',
      );
    },
  );
}

RwaApiDataSource _source(ControlledApiAdapter adapter) {
  final source = RwaApiDataSource.create(
    tokenProvider: FakePrivyAccessTokenProvider(),
    environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
  );
  source.dio.httpClientAdapter = adapter;
  return source;
}
