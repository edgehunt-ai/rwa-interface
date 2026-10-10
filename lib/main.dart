import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:nobell/app.dart';
import 'package:nobell/app/observability/http_timeline_logging.dart';
import 'package:nobell/app/observability/observability_config.dart';
import 'package:nobell/app/observability/sentry_bootstrap.dart';
import 'package:nobell/firebase_options.dart';

typedef ApplicationInitializer = Future<void> Function();
typedef ApplicationLauncher = void Function(Widget app);

Future<void> main() => SentryBootstrap.run(
  config: ObservabilityConfig.fromEnvironment(),
  appRunner: runApplication,
);

@visibleForTesting
Future<void> runApplication({
  ApplicationInitializer firebaseInitializer = _initializeFirebase,
  ApplicationLauncher applicationLauncher = runApp,
  bool? initializeFirebase,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  enableHttpTimelineLogging();
  final shouldInitializeFirebase =
      initializeFirebase ??
      (!kIsWeb &&
          (defaultTargetPlatform == TargetPlatform.android ||
              defaultTargetPlatform == TargetPlatform.iOS));
  if (shouldInitializeFirebase) {
    await firebaseInitializer();
  }
  applicationLauncher(AppRoot());
}

Future<void> _initializeFirebase() =>
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
