import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nobell/app.dart';
import 'package:nobell/app/observability/http_timeline_logging.dart';
import 'package:nobell/app/observability/observability_config.dart';
import 'package:nobell/app/observability/sentry_bootstrap.dart';
import 'package:nobell/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  enableHttpTimelineLogging();
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS)) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  await SentryBootstrap.run(
    config: ObservabilityConfig.fromEnvironment(),
    appRunner: () => runApp(AppRoot()),
  );
}
