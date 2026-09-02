import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/observability/observability_config.dart';
import 'package:rwa_interface/app/observability/sentry_bootstrap.dart';

void main() {
  const enabled = ObservabilityConfig(
    dsn: 'https://public@example.invalid/1',
    environment: 'test',
    tracesSampleRate: 0.1,
    profilesSampleRate: 0.1,
  );

  test('disabled monitoring starts app without initializing SDK', () async {
    var starts = 0;
    var initializes = 0;
    await SentryBootstrap.run(
      config: const ObservabilityConfig(
        dsn: '',
        environment: 'test',
        tracesSampleRate: 0.1,
        profilesSampleRate: 0.1,
      ),
      appRunner: () => starts++,
      initializer: (config, runner) async => initializes++,
    );
    expect(starts, 1);
    expect(initializes, 0);
  });

  test('initializer receives config and starts app once', () async {
    var starts = 0;
    ObservabilityConfig? received;
    await SentryBootstrap.run(
      config: enabled,
      appRunner: () => starts++,
      initializer: (config, runner) async {
        received = config;
        await runner();
      },
    );
    expect(received, same(enabled));
    expect(starts, 1);
  });

  test('initialization failure still starts app once', () async {
    var starts = 0;
    await SentryBootstrap.run(
      config: enabled,
      appRunner: () => starts++,
      initializer: (config, runner) => throw StateError('unavailable'),
    );
    expect(starts, 1);
  });
}
