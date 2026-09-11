import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/observability/observability_reporter.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

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
}
