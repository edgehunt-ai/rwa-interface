import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'controlled_api_adapter.dart';

void main() {
  group('ControlledApiAdapter', () {
    test('matches method and path and records a sanitized request', () async {
      final adapter = ControlledApiAdapter([
        ControlledResponse.json(
          method: 'POST',
          path: '/v1/orders',
          statusCode: 201,
          body: const {'order_id': 'ord-1'},
        ),
      ]);
      final dio = Dio(BaseOptions(baseUrl: 'https://controlled.invalid'))
        ..httpClientAdapter = adapter;

      final response = await dio.post<Map<String, dynamic>>(
        '/v1/orders',
        data: {'quantity': '1.25'},
        options: Options(headers: {'authorization': 'Bearer secret'}),
      );

      expect(response.data, {'order_id': 'ord-1'});
      expect(adapter.requests.single.method, 'POST');
      expect(adapter.requests.single.path, '/v1/orders');
      expect(adapter.requests.single.body, utf8.encode('{"quantity":"1.25"}'));
      expect(adapter.requests.single.headers, isNot(contains('authorization')));
    });

    test('rejects undeclared requests without leaking query secrets', () async {
      final dio = Dio(BaseOptions(baseUrl: 'https://controlled.invalid'))
        ..httpClientAdapter = ControlledApiAdapter();

      await expectLater(
        dio.get<void>('/missing', queryParameters: {'token': 'secret'}),
        throwsA(
          isA<DioException>().having(
            (error) => error.error.toString(),
            'safe error',
            allOf(contains('GET /missing'), isNot(contains('secret'))),
          ),
        ),
      );
    });
  });
}
