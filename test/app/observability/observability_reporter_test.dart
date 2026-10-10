import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/observability_reporter.dart';
import 'package:nobell/domain/models/api_failure.dart';

void main() {
  test('reports only non-recoverable API failures', () {
    expect(
      SentryObservabilityReporter.shouldReport(const NetworkFailure()),
      isFalse,
    );
    expect(
      SentryObservabilityReporter.shouldReport(
        const ServerFailure(statusCode: 422, code: 'invalid_input'),
      ),
      isFalse,
    );
    expect(
      SentryObservabilityReporter.shouldReport(
        const ServerFailure(statusCode: 503, code: 'unavailable'),
      ),
      isTrue,
    );
    expect(
      SentryObservabilityReporter.shouldReport(const DecodingFailure()),
      isTrue,
    );
    expect(
      SentryObservabilityReporter.shouldReport(const UnknownFailure()),
      isTrue,
    );
  });

  test('uses a stable low-cardinality issue fingerprint', () {
    expect(
      SentryObservabilityReporter.issueFingerprint(
        'create_order',
        FailureKind.compatibility.name,
        classifier: 'FormatException',
      ),
      [
        'business-operation',
        'create_order',
        'compatibility',
        'FormatException',
      ],
    );
  });

  test(
    'server classifier separates stable API causes without resource IDs',
    () {
      expect(
        SentryObservabilityReporter.apiFailureClassifier(
          const ServerFailure(
            statusCode: 503,
            code: 'Matching Engine/Unavailable',
            requestId: 'request-123',
          ),
        ),
        'server:503:matching-engine-unavailable',
      );
    },
  );

  test(
    'identifies network and timeout failures as non-reportable telemetry',
    () {
      expect(
        SentryObservabilityReporter.isNetworkFailure(const NetworkFailure()),
        isTrue,
      );
      expect(
        SentryObservabilityReporter.isNetworkFailure(const TimeoutFailure()),
        isTrue,
      );
      expect(
        SentryObservabilityReporter.isNetworkFailure(const UnknownFailure()),
        isFalse,
      );
    },
  );
}
