import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/observability_config.dart';
import 'package:nobell/app/observability/sentry_bootstrap.dart';
import 'package:nobell/app/observability/sentry_transaction_diagnostics.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  test('application bootstrap failure is reported once', () async {
    final failure = StateError('firebase unavailable');
    var starts = 0;
    var reports = 0;
    Object? reportedError;

    await SentryBootstrap.run(
      config: enabled,
      appRunner: () {
        starts++;
        throw failure;
      },
      initializer: (config, runner) => Future.sync(runner),
      bootstrapErrorReporter: (error, stackTrace) async {
        reports++;
        reportedError = error;
        expect(stackTrace, isNot(StackTrace.empty));
      },
      isWeb: false,
    );

    expect(starts, 1);
    expect(reports, 1);
    expect(reportedError, same(failure));
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

  test(
    'Android debug diagnostics configure sampling and transaction hook',
    () async {
      debugDefaultTargetPlatformOverride = TargetPlatform.android;
      final originalFlutterError = FlutterError.onError;
      final dispatcher = WidgetsBinding.instance.platformDispatcher;
      final originalPlatformError = dispatcher.onError;
      addTearDown(() async {
        await Sentry.close();
        debugDefaultTargetPlatformOverride = null;
        FlutterError.onError = originalFlutterError;
        dispatcher.onError = originalPlatformError;
      });

      final config = ObservabilityConfig.fromValues(
        dsn: 'https://public@example.invalid/1',
        environment: 'test',
        tracesSampleRate: '0.10',
        performanceDiagnostics: true,
      );
    final configured =
        <({double? sampleRate, SentryLevel logLevel, bool hasHook})>[];

      Future<void> checkOptions(ObservabilityConfig current) async {
        await Sentry.close();
        await SentryBootstrap.initializeForTesting(
          current,
          () {},
          optionsOverride: (options) {
            configured.add((
              sampleRate: options.tracesSampleRate,
              logLevel: options.diagnosticLevel,
              hasHook:
                  options.beforeSendTransaction ==
                  SentryTransactionDiagnostics.inspect,
            ));
            options.autoInitializeNativeSdk = false;
            for (final integration
                in options.integrations.whereType<LoadReleaseIntegration>()) {
              options.removeIntegration(integration);
            }
          },
        );
      }

      await checkOptions(config);
      await checkOptions(
        ObservabilityConfig.fromValues(
          dsn: config.dsn,
          environment: config.environment,
          tracesSampleRate: '0.10',
        ),
      );

      expect(configured, [
        (sampleRate: 1.0, logLevel: SentryLevel.warning, hasHook: true),
        (sampleRate: 0.10, logLevel: SentryLevel.warning, hasHook: false),
      ]);
    },
  );
}
