import 'dart:async';

import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:rwa_interface/app/observability/observability_config.dart';

typedef ApplicationRunner = FutureOr<void> Function();
typedef MonitoringInitializer = Future<void> Function(
  ObservabilityConfig config,
  ApplicationRunner appRunner,
);

abstract final class SentryBootstrap {
  static Future<void> run({
    required ObservabilityConfig config,
    required ApplicationRunner appRunner,
    MonitoringInitializer initializer = _initialize,
  }) async {
    if (!config.enabled) {
      await appRunner();
      return;
    }

    var started = false;
    FutureOr<void> guardedRunner() {
      started = true;
      return appRunner();
    }

    try {
      await initializer(config, guardedRunner);
    } on Object {
      if (!started) await appRunner();
    }
  }

  static Future<void> _initialize(
    ObservabilityConfig config,
    ApplicationRunner appRunner,
  ) {
    return SentryFlutter.init((options) {
      options
        ..dsn = config.dsn
        ..environment = config.environment
        ..release = config.release
        ..tracesSampleRate = config.tracesSampleRate
        // Profiling is explicitly required; Sentry 9.28 still marks this API experimental.
        // ignore: experimental_member_use
        ..profilesSampleRate = config.profilesSampleRate
        ..sendDefaultPii = false
        ..enableAutoPerformanceTracing = true;
    }, appRunner: appRunner);
  }
}
