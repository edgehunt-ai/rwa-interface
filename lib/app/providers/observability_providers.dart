import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rwa_interface/app/observability/observability_reporter.dart';

final observabilityReporterProvider = Provider<ObservabilityReporter>(
  (_) => createObservabilityReporter(),
);

ObservabilityReporter createObservabilityReporter({bool isWeb = kIsWeb}) =>
    isWeb ? const NoopObservabilityReporter() : SentryObservabilityReporter();
