import 'dart:async';

import 'package:nobell/domain/models/api_failure.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract interface class ObservabilityReporter {
  Future<void> setUserId(String userId);
  Future<void> clearUser();
  void recordOperation(
    String operation, {
    required String outcome,
    Map<String, String> context = const {},
    Duration? duration,
  });
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
  });

  /// Reports a failure that is not an [ApiFailure], such as a contract
  /// mismatch raised while mapping a response.
  void recordError({
    required String operation,
    required Object error,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
    String failureKind = 'unexpected',
  });
}

final class NoopObservabilityReporter implements ObservabilityReporter {
  const NoopObservabilityReporter();

  @override
  Future<void> clearUser() async {}

  @override
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
  }) {}

  @override
  void recordError({
    required String operation,
    required Object error,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
    String failureKind = 'unexpected',
  }) {}

  @override
  void recordOperation(
    String operation, {
    required String outcome,
    Map<String, String> context = const {},
    Duration? duration,
  }) {}

  @override
  Future<void> setUserId(String userId) async {}
}

final class SentryObservabilityReporter implements ObservabilityReporter {
  @override
  Future<void> setUserId(String userId) async {
    if (userId.trim().isEmpty) return;
    try {
      await Sentry.configureScope(
        (scope) => scope.setUser(SentryUser(id: userId)),
      );
    } on Object {
      // Observability must never affect authentication.
    }
  }

  @override
  Future<void> clearUser() async {
    try {
      await Sentry.configureScope((scope) => scope.setUser(null));
    } on Object {
      // Observability must never prevent sign-out.
    }
  }

  @override
  void recordOperation(
    String operation, {
    required String outcome,
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    final data = <String, dynamic>{
      'operation': operation,
      'outcome': outcome,
      ...context,
      if (duration != null) 'duration_ms': duration.inMilliseconds,
    };
    unawaited(
      Sentry.addBreadcrumb(
        Breadcrumb(
          category: 'business.operation',
          message: '$operation:$outcome',
          data: data,
        ),
      ),
    );
    if (outcome != 'started') {
      Sentry.metrics.count(
        'business.operation',
        1,
        attributes: {
          'operation': SentryAttribute.string(operation),
          'outcome': SentryAttribute.string(outcome),
        },
      );
      if (duration != null) {
        Sentry.metrics.distribution(
          'business.operation.duration',
          duration.inMilliseconds,
          unit: SentryMetricUnit.millisecond,
          attributes: {
            'operation': SentryAttribute.string(operation),
            'outcome': SentryAttribute.string(outcome),
          },
        );
      }
    }
  }

  @override
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    // Connectivity is an expected environmental condition, not an application
    // defect. Do not emit an event, metric, or breadcrumb for it.
    if (isNetworkFailure(failure)) return;

    final failureContext = <String, String>{
      ...context,
      'failure_kind': failure.kind.name,
      'request_id': ?failure.requestId,
      if (failure case final ServerFailure server) ...{
        'http_status': server.statusCode.toString(),
        'api_code': server.code,
      },
    };
    if (failure is CancelledFailure) {
      recordOperation(
        operation,
        outcome: 'cancelled',
        context: failureContext,
        duration: duration,
      );
      return;
    }
    recordOperation(
      operation,
      outcome: 'failed',
      context: failureContext,
      duration: duration,
    );
    if (!shouldReport(failure)) return;
    unawaited(
      Sentry.captureException(
        failure,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope
            ..setTag('operation', operation)
            ..setTag('failure_kind', failure.kind.name)
            ..fingerprint = issueFingerprint(
              operation,
              failure.kind.name,
              classifier: apiFailureClassifier(failure),
            )
            ..setContexts('business_operation', {
              'operation': operation,
              ...failureContext,
              if (duration != null) 'duration_ms': duration.inMilliseconds,
            });
          if (failure.requestId case final requestId?) {
            scope.setTag('request_id', requestId);
          }
          if (failure case final ServerFailure server) {
            scope
              ..setTag('http_status', server.statusCode.toString())
              ..setTag('api_code', server.code);
          }
        },
      ),
    );
  }

  @override
  void recordError({
    required String operation,
    required Object error,
    StackTrace? stackTrace,
    Map<String, String> context = const {},
    Duration? duration,
    String failureKind = 'unexpected',
  }) {
    if (error is ApiFailure) {
      recordApiFailure(
        operation: operation,
        failure: error,
        stackTrace: stackTrace,
        context: context,
        duration: duration,
      );
      return;
    }
    final errorContext = <String, String>{
      ...context,
      'failure_kind': failureKind,
      'error_type': error.runtimeType.toString(),
    };
    recordOperation(
      operation,
      outcome: 'failed',
      context: errorContext,
      duration: duration,
    );
    unawaited(
      Sentry.captureException(
        error,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope
            ..setTag('operation', operation)
            ..setTag('failure_kind', failureKind)
            ..fingerprint = issueFingerprint(
              operation,
              failureKind,
              classifier: error.runtimeType.toString(),
            )
            ..setContexts('business_operation', {
              'operation': operation,
              ...errorContext,
              if (duration != null) 'duration_ms': duration.inMilliseconds,
            });
        },
      ),
    );
  }

  static List<String> issueFingerprint(
    String operation,
    String failureKind, {
    String? classifier,
  }) => [
    'business-operation',
    operation,
    failureKind,
    if (classifier != null && classifier.isNotEmpty) classifier,
  ];

  /// A bounded root-cause discriminator. Resource and request identifiers must
  /// never be used here because they would create one Issue per operation.
  static String apiFailureClassifier(ApiFailure failure) => switch (failure) {
    ServerFailure(:final statusCode, :final code) =>
      'server:$statusCode:${normalizeClassifier(code)}',
    _ => failure.runtimeType.toString(),
  };

  static String normalizeClassifier(String value) {
    final normalized = value.trim().toLowerCase().replaceAll(
      RegExp('[^a-z0-9._-]+'),
      '-',
    );
    if (normalized.isEmpty) return 'unknown';
    return normalized.length <= 64 ? normalized : normalized.substring(0, 64);
  }

  static bool isNetworkFailure(ApiFailure failure) =>
      failure is NetworkFailure || failure is TimeoutFailure;

  static bool shouldReport(ApiFailure failure) => switch (failure) {
    DecodingFailure() || CompatibilityFailure() || UnknownFailure() => true,
    ServerFailure(:final statusCode) when statusCode >= 500 => true,
    _ => false,
  };
}
