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

  test('maps stable server categories and removes sensitive details', () {
    for (final entry in const {
      403: FailureKind.forbidden,
      409: FailureKind.conflict,
      422: FailureKind.validation,
      429: FailureKind.rateLimited,
      503: FailureKind.unavailable,
    }.entries) {
      final request = RequestOptions(path: '/resource');
      final failure = mapper.fromDio(
        DioException(
          requestOptions: request,
          response: Response(
            requestOptions: request,
            statusCode: entry.key,
            data: {
              'code': 'failure_${entry.key}',
              'details': {'field': 'quantity', 'raw_body': 'secret'},
            },
          ),
          type: DioExceptionType.badResponse,
        ),
      );
      expect(failure.kind, entry.value);
      expect((failure as ServerFailure).details, {'field': 'quantity'});
    }
  });

  test('distinguishes unauthorized, network, and unknown failures', () {
    final request = RequestOptions(path: '/resource');
    final unauthorized = mapper.fromDio(
      DioException(
        requestOptions: request,
        response: Response(requestOptions: request, statusCode: 401),
        type: DioExceptionType.badResponse,
      ),
    );
    expect(unauthorized.kind, FailureKind.unauthorized);
    expect(
      mapper
          .fromDio(
            DioException(
              requestOptions: request,
              type: DioExceptionType.connectionError,
            ),
          )
          .kind,
      FailureKind.network,
    );
    expect(
      mapper
          .fromDio(
            DioException(
              requestOptions: request,
              type: DioExceptionType.unknown,
            ),
          )
          .kind,
      FailureKind.unknown,
    );
  });
}
