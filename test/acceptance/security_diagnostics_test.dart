import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_failure_mapper.dart';

void main() {
  test('diagnostic failure representation excludes sensitive payloads', () {
    const secret = 'privy-token-and-signature';
    final request = RequestOptions(path: '/preflight');
    final failure = const ApiFailureMapper().fromDio(
      DioException(
        requestOptions: request,
        response: Response(
          requestOptions: request,
          statusCode: 503,
          headers: Headers.fromMap({
            'x-request-id': ['req-safe'],
          }),
          data: jsonDecode(
            jsonEncode({
              'code': 'service_unconfigured',
              'message': secret,
              'stack': 'trace',
            }),
          ),
        ),
        type: DioExceptionType.badResponse,
      ),
    );
    expect(failure.toString(), isNot(contains(secret)));
    expect(failure.toString(), isNot(contains('trace')));
  });
}
