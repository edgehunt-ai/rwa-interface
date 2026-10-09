import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:rwa_interface/app/observability/observability_config.dart';
import 'package:rwa_interface/app/observability/sentry_event_sanitizer.dart';

typedef ApplicationRunner = FutureOr<void> Function();
typedef MonitoringInitializer = Future<void> Function(
  ObservabilityConfig config,
  ApplicationRunner appRunner,
);
typedef SmokeTestReporter = Future<void> Function();

abstract final class SentryBootstrap {
  static Future<void> run({
    required ObservabilityConfig config,
    required ApplicationRunner appRunner,
    MonitoringInitializer initializer = _initialize,
    SmokeTestReporter smokeTestReporter = _reportSmokeTest,
    bool isWeb = kIsWeb,
  }) async {
    if (isWeb || !config.enabled) {
      await appRunner();
      return;
    }

    var started = false;
    Future<void> guardedRunner() async {
      started = true;
      if (config.smokeTest) await smokeTestReporter();
      await appRunner();
    }

    try {
      await initializer(config, guardedRunner);
    } on Object catch (error, stackTrace) {
      if (config.smokeTest) {
        debugPrint('Sentry smoke-test initialization failed: $error');
        debugPrintStack(stackTrace: stackTrace);
      }
      if (!started) await appRunner();
    }
  }

  static Future<void> _reportSmokeTest() => Sentry.captureMessage(
    'Android Sentry smoke test',
    level: SentryLevel.info,
    withScope: (scope) {
      scope
        ..setTag('diagnostic', 'android-smoke')
        ..setTag('smoke_test', 'true');
    },
  );

  static Future<void> _initialize(
    ObservabilityConfig config,
    ApplicationRunner appRunner,
  ) {
    return SentryFlutter.init((options) {
      options
        ..dsn = config.dsn
        ..environment = config.smokeTest ? 'android-smoke' : config.environment
        ..release = config.release
        ..tracesSampleRate = config.smokeTest ? 1.0 : config.tracesSampleRate
        // Profiling is explicitly required; Sentry 9.28 still marks this API experimental.
        // ignore: experimental_member_use
        ..profilesSampleRate = config.profilesSampleRate
        ..sendDefaultPii = false
        ..beforeSend = SentryEventSanitizer.sanitize
        ..enableAutoPerformanceTracing = true;
      if (config.smokeTest) {
        options
          ..debug = true
          ..diagnosticLevel = SentryLevel.debug;
      }
    }, appRunner: appRunner);
  }
}
