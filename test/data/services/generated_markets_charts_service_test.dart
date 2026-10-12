import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/api/api_environment.dart';
import 'package:nobell/data/api/rwa_api_data_source.dart';
import 'package:nobell/data/services/generated_charts_service.dart';
import 'package:nobell/data/services/generated_markets_service.dart';
import 'package:nobell/domain/models/api_failure.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
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

  test('labels market response decoding failures for diagnostics', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) => handler.reject(
          DioException(
            requestOptions: request,
            response: Response<String>(
              requestOptions: request,
              statusCode: 200,
              headers: Headers.fromMap({
                'content-type': ['application/json'],
                'x-request-id': ['market-decode-request'],
              }),
              data: '{"invalid":true}',
            ),
            type: DioExceptionType.unknown,
            error: const FormatException('invalid ProductPage'),
          ),
        ),
      ),
    );
    final service = GeneratedMarketsService(
      api.RwaApiClient(dio: dio).getMarketsApi(),
    );

    await expectLater(
      service.listProducts(),
      throwsA(
        isA<DecodingFailure>().having(
          (failure) => failure.diagnostics,
          'diagnostics',
          (
            apiOperation: 'markets.list_products',
            responseModel: 'ProductPage',
            httpStatus: 200,
            contentType: 'application/json',
            responseBodySize: 16,
            decoderError: 'format_exception',
          ),
        ),
      ),
    );
  });
}

RwaApiDataSource _source(ControlledApiAdapter adapter) {
  final source = RwaApiDataSource.create(
    tokenProvider: FakePrivyAccessTokenProvider(),
    environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
  );
  source.dio.httpClientAdapter = adapter;
  return source;
}
