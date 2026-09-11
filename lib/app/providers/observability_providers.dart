import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rwa_interface/app/observability/observability_reporter.dart';

final observabilityReporterProvider = Provider<ObservabilityReporter>(
  (_) => SentryObservabilityReporter(),
);
