import 'dart:convert';

import 'package:dio/dio.dart';

import '../../domain/models/api_failure.dart';

final class ApiFailureMapper {
  const ApiFailureMapper();

  DecodingFailure fromMissingBody<T>(
    Response<T> response, {
    String? apiOperation,
    String? responseModel,
  }) => DecodingFailure(
    requestId: response.headers['x-request-id']?.firstOrNull,
    userAction: 'Missing response body',
    diagnostics: (
      apiOperation: apiOperation,
      responseModel: responseModel,
      httpStatus: response.statusCode,
      contentType: _contentType(response.headers),
      responseBodySize: _responseBodySize(response),
      decoderError: 'missing_body',
    ),
  );

  ApiFailure fromDio(
    DioException error, {
    String? apiOperation,
    String? responseModel,
  }) {
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
      return TimeoutFailure(
        requestId: requestId,
        userAction: _transportReason(error),
      );
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
        diagnostics: _decodeDiagnostics(
          error,
          apiOperation: apiOperation,
          responseModel: responseModel,
        ),
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
        message: json['message']?.toString(),
        failureReason: json['failure_reason']?.toString(),
        details: _safeDetails(json['details']),
      );
    }
    return UnknownFailure(retryable: true, userAction: _transportReason(error));
  }

  ApiDecodeDiagnostics _decodeDiagnostics(
    DioException error, {
    required String? apiOperation,
    required String? responseModel,
  }) {
    final response = error.response;
    return (
      apiOperation: apiOperation,
      responseModel: responseModel,
      httpStatus: response?.statusCode,
      contentType: _contentType(response?.headers),
      responseBodySize: _responseBodySize(response),
      decoderError: switch (error.error) {
        FormatException() => 'format_exception',
        TypeError() => 'type_error',
        StateError() => 'state_error',
        _ => 'generated_client',
      },
    );
  }

  String? _contentType(Headers? headers) {
    final raw = headers?['content-type']?.firstOrNull;
    if (raw == null) return null;
    final value = raw.split(';').first.trim().toLowerCase();
    if (!RegExp(r'^[a-z0-9.+-]+/[a-z0-9.+-]+$').hasMatch(value)) return null;
    return value;
  }

  int? _responseBodySize(Response<dynamic>? response) {
    if (response == null) return null;
    final declared = int.tryParse(
      response.headers['content-length']?.firstOrNull ?? '',
    );
    if (declared != null && declared >= 0) return declared;
    return switch (response.data) {
      final String value => utf8.encode(value).length,
      final List<int> value => value.length,
      _ => null,
    };
  }

  String? _transportReason(DioException error) {
    final cause = error.error?.toString().trim();
    if (cause != null && cause.isNotEmpty && cause != 'null') return cause;
    final message = error.message?.trim();
    if (message != null && message.isNotEmpty) return message;
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
