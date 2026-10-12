import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/api/api_failure_mapper.dart';
import 'package:nobell/domain/models/api_failure.dart';

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
  test('uses server failure_reason as the user-facing message', () {
    final request = RequestOptions(path: '/submissions');
    final failure = mapper.fromDio(
      DioException(
        requestOptions: request,
        response: Response(
          requestOptions: request,
          statusCode: 422,
          data: {
            'code': 'submission_failed',
            'failure_reason': 'Position is already closed',
          },
        ),
        type: DioExceptionType.badResponse,
      ),
    ) as ServerFailure;

    expect(
      apiFailureMessage(failure, fallback: 'fallback'),
      'Position is already closed',
    );
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
    final unknown = mapper.fromDio(
      DioException(
        requestOptions: request,
        type: DioExceptionType.unknown,
        message: 'Dio wrapped the request failure',
        error: Exception('TLS connection closed unexpectedly'),
      ),
    );
    expect(unknown.kind, FailureKind.unknown);
    expect(unknown.userAction, 'Exception: TLS connection closed unexpectedly');
  });

  test(
    'maps a successful response that fails decoding as decoding failure',
    () {
      final request = RequestOptions(path: '/v1/funding/catalog');
      final failure = mapper.fromDio(
        DioException(
          requestOptions: request,
          response: Response(
            requestOptions: request,
            statusCode: 200,
            headers: Headers.fromMap({
              'content-type': ['application/json; charset=utf-8'],
              'content-length': ['37'],
              'x-request-id': ['decode-request-1'],
            }),
            data: '{"sensitive":"must-not-be-reported"}',
          ),
          type: DioExceptionType.unknown,
          error: const FormatException('Unexpected response shape'),
        ),
        apiOperation: 'funding.get_catalog',
        responseModel: 'FundingCatalog',
      );

      expect(failure, isA<DecodingFailure>());
      final decoding = failure as DecodingFailure;
      expect(decoding.requestId, 'decode-request-1');
      expect(decoding.diagnostics, (
        apiOperation: 'funding.get_catalog',
        responseModel: 'FundingCatalog',
        httpStatus: 200,
        contentType: 'application/json',
        responseBodySize: 37,
        decoderError: 'format_exception',
      ));
      expect(decoding.toString(), isNot(contains('sensitive')));
    },
  );

  test('does not expose an invalid content type or structured response', () {
    final request = RequestOptions(path: '/v1/markets/products');
    final failure = mapper.fromDio(
      DioException(
        requestOptions: request,
        response: Response(
          requestOptions: request,
          statusCode: 200,
          headers: Headers.fromMap({
            'content-type': ['text/plain token=secret'],
          }),
          data: {'token': 'secret'},
        ),
        type: DioExceptionType.unknown,
        error: StateError('decoder rejected payload'),
      ),
    ) as DecodingFailure;

    expect(failure.diagnostics?.contentType, isNull);
    expect(failure.diagnostics?.responseBodySize, isNull);
    expect(failure.diagnostics?.decoderError, 'state_error');
  });

  test('maps a missing response body with safe response metadata', () {
    final request = RequestOptions(path: '/v1/markets/products');
    final failure = mapper.fromMissingBody(
      Response<void>(
        requestOptions: request,
        statusCode: 204,
        headers: Headers.fromMap({
          'content-type': ['application/json'],
          'content-length': ['0'],
          'x-request-id': ['empty-request-1'],
        }),
      ),
      apiOperation: 'markets.list_products',
      responseModel: 'ProductPage',
    );

    expect(failure.requestId, 'empty-request-1');
    expect(failure.diagnostics, (
      apiOperation: 'markets.list_products',
      responseModel: 'ProductPage',
      httpStatus: 204,
      contentType: 'application/json',
      responseBodySize: 0,
      decoderError: 'missing_body',
    ));
  });
}
