import '../../domain/models/api_failure.dart';

String safeFailureSummary(ApiFailure failure) => switch (failure) {
  ServerFailure(:final statusCode, :final code, :final requestId) =>
    'server status=$statusCode code=$code requestId=${requestId ?? '-'}',
  AuthenticationFailure(:final requestId) =>
    'authentication requestId=${requestId ?? '-'}',
  NetworkFailure(:final requestId) => 'network requestId=${requestId ?? '-'}',
  TimeoutFailure(:final requestId) => 'timeout requestId=${requestId ?? '-'}',
  CancelledFailure(:final requestId) =>
    'cancelled requestId=${requestId ?? '-'}',
  DecodingFailure(:final requestId) => 'decoding requestId=${requestId ?? '-'}',
  CompatibilityFailure(:final requestId) =>
    'compatibility requestId=${requestId ?? '-'}',
  UnknownFailure(:final requestId) => 'unknown requestId=${requestId ?? '-'}',
};
