import 'package:flutter/foundation.dart';

@immutable
class ObservabilityConfig {
  const ObservabilityConfig({
    required this.dsn,
    required this.environment,
    required this.tracesSampleRate,
    required this.profilesSampleRate,
    this.release,
  });

  factory ObservabilityConfig.fromEnvironment() {
    return ObservabilityConfig.fromValues(
      dsn: const String.fromEnvironment(
        'SENTRY_DSN',
        defaultValue: 'https://790a3223f0f3addb404c3c1aa2a519fd@o4512015886254080.ingest.de.sentry.io/4512016072310864',
      ),
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
    );
  }

  factory ObservabilityConfig.fromValues({
    required String dsn,
    required String environment,
    String? release,
    String tracesSampleRate = '0.10',
    String profilesSampleRate = '0.10',
  }) {
    return ObservabilityConfig(
      dsn: dsn.trim(),
      environment: environment.trim().isEmpty ? 'unknown' : environment.trim(),
      release: release?.trim().isEmpty ?? true ? null : release!.trim(),
      tracesSampleRate: _sampleRate(tracesSampleRate, fallback: 0.10),
      profilesSampleRate: _sampleRate(profilesSampleRate, fallback: 0.10),
    );
  }

  final String dsn;
  final String environment;
  final String? release;
  final double tracesSampleRate;
  final double profilesSampleRate;

  bool get enabled => dsn.isNotEmpty;

  static double _sampleRate(String value, {required double fallback}) {
    final parsed = double.tryParse(value);
    return parsed != null && parsed >= 0 && parsed <= 1 ? parsed : fallback;
  }
}
