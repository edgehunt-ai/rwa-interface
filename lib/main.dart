import 'package:flutter/widgets.dart';
import 'package:rwa_interface/app.dart';
import 'package:rwa_interface/app/observability/observability_config.dart';
import 'package:rwa_interface/app/observability/sentry_bootstrap.dart';

Future<void> main() async {
  await SentryBootstrap.run(
    config: ObservabilityConfig.fromEnvironment(),
    appRunner: () => runApp(AppRoot()),
  );
}
