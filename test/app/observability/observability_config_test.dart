import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/observability_config.dart';

void main() {
  test('parses valid build-time values', () {
    final config = ObservabilityConfig.fromValues(
      dsn: ' https://public@example.invalid/1 ',
      environment: ' staging ',
      release: ' app@1.2.3 ',
      tracesSampleRate: '0.25',
      profilesSampleRate: '0.5',
      smokeTest: true,
      performanceDiagnostics: true,
    );

    expect(config.dsn, 'https://public@example.invalid/1');
    expect(config.environment, 'staging');
    expect(config.release, 'app@1.2.3');
    expect(config.tracesSampleRate, 0.25);
    expect(config.profilesSampleRate, 0.5);
    expect(config.performanceDiagnostics, isTrue);
    expect(config.smokeTest, isTrue);
  });

  test('empty DSN disables monitoring and invalid rates use defaults', () {
    final config = ObservabilityConfig.fromValues(
      dsn: ' ',
      environment: '',
      tracesSampleRate: '2',
      profilesSampleRate: 'invalid',
    );

    expect(config.enabled, isFalse);
    expect(config.environment, 'unknown');
    expect(config.tracesSampleRate, 0.10);
    expect(config.performanceDiagnosticsEnabled, isFalse);
    expect(config.profilesSampleRate, 0.10);
  });

  test('performance diagnostics require an explicit Android debug build', () {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    final enabled = ObservabilityConfig.fromValues(
      dsn: 'https://public@example.invalid/1',
      environment: 'test',
      performanceDiagnostics: true,
    );
    final disabled = ObservabilityConfig.fromValues(
      dsn: 'https://public@example.invalid/1',
      environment: 'test',
    );

    expect(enabled.performanceDiagnosticsEnabled, kDebugMode && !kIsWeb);
    expect(disabled.performanceDiagnosticsEnabled, isFalse);
  });
}
