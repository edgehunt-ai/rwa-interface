import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_failure_mapper.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

void main() {
  const mapper = ApiFailureMapper();
  test('maps declared server error and request ID', () {
    final request = RequestOptions(path: '/orders');
    final failure = mapper.fromDio(
      DioException(
        requestOptions: request,
        response: Response(
          requestOptions: request,
          statusCode: 409,
          headers: Headers.fromMap({
            'x-request-id': ['req-1'],
          }),
          data: {'code': 'idempotency_conflict', 'retryable': false},
        ),
        type: DioExceptionType.badResponse,
      ),
    );
    expect(failure, isA<ServerFailure>());
    expect(failure.requestId, 'req-1');
    expect((failure as ServerFailure).code, 'idempotency_conflict');
  });
  test('maps timeout and cancellation', () {
    final request = RequestOptions(path: '/');
    expect(
      mapper.fromDio(
        DioException(
          requestOptions: request,
          type: DioExceptionType.receiveTimeout,
        ),
      ),
      isA<TimeoutFailure>(),
    );
    expect(
      mapper.fromDio(
        DioException(requestOptions: request, type: DioExceptionType.cancel),
      ),
      isA<CancelledFailure>(),
    );
  });
}
