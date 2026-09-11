import 'dart:async';

import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

abstract interface class ObservabilityReporter {
  Future<void> setUserId(String userId);
  Future<void> clearUser();
  void recordOperation(String operation, {required String outcome});
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
  });
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
  void recordOperation(String operation, {required String outcome}) {
    unawaited(
      Sentry.addBreadcrumb(
        Breadcrumb(
          category: 'business.operation',
          message: '$operation:$outcome',
        ),
      ),
    );
  }

  @override
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
  }) {
    recordOperation(operation, outcome: 'failed');
    if (!shouldReport(failure)) return;
    unawaited(
      Sentry.captureException(
        failure,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope
            ..setTag('operation', operation)
            ..setTag('failure_kind', failure.kind.name);
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

  static bool shouldReport(ApiFailure failure) => switch (failure) {
    DecodingFailure() || CompatibilityFailure() || UnknownFailure() => true,
    ServerFailure(:final statusCode) when statusCode >= 500 => true,
    _ => false,
  };
}
