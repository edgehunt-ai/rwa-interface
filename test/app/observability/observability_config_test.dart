import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/observability/observability_config.dart';

void main() {
  test('parses valid build-time values', () {
    final config = ObservabilityConfig.fromValues(
      dsn: ' https://public@example.invalid/1 ',
      environment: ' staging ',
      release: ' app@1.2.3 ',
      tracesSampleRate: '0.25',
      profilesSampleRate: '0.5',
    );

    expect(config.dsn, 'https://public@example.invalid/1');
    expect(config.environment, 'staging');
    expect(config.release, 'app@1.2.3');
    expect(config.tracesSampleRate, 0.25);
    expect(config.profilesSampleRate, 0.5);
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
    expect(config.profilesSampleRate, 0.10);
  });
}
