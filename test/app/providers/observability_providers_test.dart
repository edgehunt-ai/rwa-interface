import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/observability/observability_reporter.dart';
import 'package:rwa_interface/app/providers/observability_providers.dart';

void main() {
  test('default reporter follows the current platform', () {
    expect(
      createObservabilityReporter(),
      kIsWeb
          ? isA<NoopObservabilityReporter>()
          : isA<SentryObservabilityReporter>(),
    );
  });

  test('uses no-op observability on web', () {
    expect(
      createObservabilityReporter(isWeb: true),
      isA<NoopObservabilityReporter>(),
    );
  });

  test('uses Sentry observability outside web', () {
    expect(
      createObservabilityReporter(isWeb: false),
      isA<SentryObservabilityReporter>(),
    );
  });
}
