import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/observability_config.dart';
import 'package:nobell/app/observability/sentry_bootstrap.dart';

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
      isWeb: false,
    );
    expect(starts, 1);
    expect(initializes, 0);
  });

  test('web starts app without initializing SDK', () async {
    var starts = 0;
    var initializes = 0;
    await SentryBootstrap.run(
      config: enabled,
      appRunner: () => starts++,
      initializer: (config, runner) async => initializes++,
      isWeb: true,
    );
    expect(starts, 1);
    expect(initializes, 0);
  });

  test('default monitoring behavior follows the current platform', () async {
    var starts = 0;
    var initializes = 0;
    await SentryBootstrap.run(
      config: enabled,
      appRunner: () => starts++,
      initializer: (config, runner) async {
        initializes++;
        await runner();
      },
    );
    expect(starts, 1);
    expect(initializes, kIsWeb ? 0 : 1);
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
      isWeb: false,
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
      isWeb: false,
    );
    expect(starts, 1);
  });

  test('smoke test reports once before the app starts', () async {
    var starts = 0;
    var reports = 0;
    await SentryBootstrap.run(
      config: const ObservabilityConfig(
        dsn: 'https://public@example.invalid/1',
        environment: 'test',
        tracesSampleRate: 0.1,
        profilesSampleRate: 0.1,
        smokeTest: true,
      ),
      appRunner: () => starts++,
      initializer: (config, runner) => Future.sync(runner),
      smokeTestReporter: () async => reports++,
      isWeb: false,
    );
    expect(reports, 1);
    expect(starts, 1);
  });
}
