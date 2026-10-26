import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nobell/app.dart';
import 'package:nobell/app/observability/http_timeline_logging.dart';
import 'package:nobell/app/observability/observability_config.dart';
import 'package:nobell/app/observability/sentry_bootstrap.dart';
import 'package:nobell/firebase_options.dart';
import 'package:nobell/data/services/theme_mode_service.dart';

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
  // Restore appearance before the first Flutter frame. Bootstrap may access
  // local preferences directly; application changes still go through Riverpod.
  var initialThemeMode = ThemeMode.system;
  try {
    initialThemeMode =
        await const ThemeModeService().read() ?? ThemeMode.system;
  } on Object catch (error) {
    debugPrint('Unable to restore the initial appearance: $error');
  }
  applicationLauncher(AppRoot(initialThemeMode: initialThemeMode));
}

Future<void> _initializeFirebase() =>
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
