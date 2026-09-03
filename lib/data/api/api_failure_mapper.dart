import 'package:dio/dio.dart';

import '../../domain/models/api_failure.dart';

final class ApiFailureMapper {
  const ApiFailureMapper();

  ApiFailure fromDio(DioException error) {
    final response = error.response;
    final requestId = response?.headers.value('x-request-id');
    if (error.type == DioExceptionType.cancel) {
      return CancelledFailure(requestId: requestId);
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return TimeoutFailure(requestId: requestId);
    }
    if (error.type == DioExceptionType.connectionError) {
      return NetworkFailure(requestId: requestId);
    }
    final status = response?.statusCode;
    if (status == 401 || status == 403) {
      return AuthenticationFailure(
        requestId: requestId,
        userAction: 'reauthenticate',
      );
    }
    if (status != null) {
      final body = response?.data;
      final json = body is Map<String, dynamic>
          ? body
          : const <String, dynamic>{};
      return ServerFailure(
        statusCode: status,
        code: json['code']?.toString() ?? 'http_$status',
        requestId: requestId ?? json['request_id']?.toString(),
        retryable: json['retryable'] == true,
        userAction: json['user_action']?.toString(),
        details: json['details'] is Map
            ? Map<String, Object?>.from(json['details'] as Map)
            : const {},
      );
    }
    if (error.error is FormatException ||
        error.type == DioExceptionType.unknown && error.response != null) {
      return DecodingFailure(requestId: requestId);
    }
    return const UnknownFailure();
  }
}
