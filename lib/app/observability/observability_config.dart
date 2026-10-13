import 'package:flutter/foundation.dart';

@immutable
class ObservabilityConfig {
  const ObservabilityConfig({
    required this.dsn,
    required this.environment,
    required this.tracesSampleRate,
    required this.profilesSampleRate,
    this.smokeTest = false,
    this.performanceDiagnostics = false,
    this.release,
  });

  factory ObservabilityConfig.fromEnvironment() {
    return ObservabilityConfig.fromValues(
      dsn: const String.fromEnvironment('SENTRY_DSN', defaultValue: ''),
      environment: const String.fromEnvironment(
        'SENTRY_ENVIRONMENT',
        defaultValue: kReleaseMode ? 'production' : 'development',
      ),
      release: const String.fromEnvironment('SENTRY_RELEASE'),
      tracesSampleRate: const String.fromEnvironment(
        'SENTRY_TRACES_SAMPLE_RATE',
        defaultValue: '0.10',
      ),
      profilesSampleRate: const String.fromEnvironment(
        'SENTRY_PROFILES_SAMPLE_RATE',
        defaultValue: '0.10',
      ),
      smokeTest: const bool.fromEnvironment('SENTRY_SMOKE_TEST'),
      performanceDiagnostics: const bool.fromEnvironment(
        'SENTRY_PERFORMANCE_DIAGNOSTICS',
      ),
    );
  }

  factory ObservabilityConfig.fromValues({
    required String dsn,
    required String environment,
    String? release,
    String tracesSampleRate = '0.10',
    String profilesSampleRate = '0.10',
    bool smokeTest = false,
    bool performanceDiagnostics = false,
  }) {
    return ObservabilityConfig(
      dsn: dsn.trim(),
      environment: environment.trim().isEmpty ? 'unknown' : environment.trim(),
      release: release?.trim().isEmpty ?? true ? null : release!.trim(),
      tracesSampleRate: _sampleRate(tracesSampleRate, fallback: 0.10),
      profilesSampleRate: _sampleRate(profilesSampleRate, fallback: 0.10),
      smokeTest: smokeTest,
      performanceDiagnostics: performanceDiagnostics,
    );
  }

  final String dsn;
  final String environment;
  final String? release;
  final double tracesSampleRate;
  final double profilesSampleRate;
  final bool smokeTest;
  final bool performanceDiagnostics;

  bool get enabled => dsn.isNotEmpty;

  bool get performanceDiagnosticsEnabled =>
      performanceDiagnostics &&
      kDebugMode &&
      !kIsWeb &&
      defaultTargetPlatform == TargetPlatform.android;

  static double _sampleRate(String value, {required double fallback}) {
    final parsed = double.tryParse(value);
    return parsed != null && parsed >= 0 && parsed <= 1 ? parsed : fallback;
  }
}
