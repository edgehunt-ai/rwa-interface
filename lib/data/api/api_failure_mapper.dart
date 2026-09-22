import 'package:dio/dio.dart';

import '../../domain/models/api_failure.dart';

final class ApiFailureMapper {
  const ApiFailureMapper();

  ApiFailure fromDio(DioException error) {
    final response = error.response;
    // Some gateways emit duplicate x-request-id values. `Headers.value()`
    // throws when that happens, masking the original API/decoding failure.
    final requestId = response?.headers['x-request-id']?.firstOrNull;
    if (error.type == DioExceptionType.cancel) {
      return CancelledFailure(requestId: requestId);
    }
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      return TimeoutFailure(requestId: requestId);
    }
    if (error.type == DioExceptionType.connectionError) {
      return NetworkFailure(
        requestId: requestId,
        userAction: _transportReason(error),
      );
    }
    final status = response?.statusCode;
    if (status == 401) {
      return AuthenticationFailure(
        requestId: requestId,
        userAction: 'reauthenticate',
      );
    }
    if (error.type == DioExceptionType.unknown && response != null ||
        error.error is FormatException) {
      final reason = error.error?.toString().trim();
      return DecodingFailure(
        requestId: requestId,
        userAction: reason == null || reason.isEmpty ? null : reason,
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
        failureReason: json['failure_reason']?.toString(),
        details: _safeDetails(json['details']),
      );
    }
    return const UnknownFailure();
  }

  String? _transportReason(DioException error) {
    final message = error.message?.trim();
    if (message != null && message.isNotEmpty) return message;
    final cause = error.error?.toString().trim();
    if (cause != null && cause.isNotEmpty && cause != 'null') return cause;
    return null;
  }

  Map<String, Object?> _safeDetails(Object? value) {
    if (value is! Map) return const {};
    const blockedFragments = {
      'token',
      'signature',
      'body',
      'payload',
      'account',
      'amount',
      'price',
      'quantity',
    };
    return {
      for (final entry in value.entries)
        if (entry.key is String &&
            entry.value is String &&
            !blockedFragments.any(
              (fragment) =>
                  (entry.key as String).toLowerCase().contains(fragment),
            ))
          entry.key as String: entry.value,
    };
  }
}
