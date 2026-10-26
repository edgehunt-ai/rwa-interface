import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app.dart';
import 'package:nobell/main.dart' as entrypoint;
import 'package:nobell/data/services/theme_mode_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('initializes Firebase before launching the application', () async {
    SharedPreferences.setMockInitialValues({ThemeModeService.key: 'dark'});
    final events = <String>[];
    AppRoot? launchedApp;

    await entrypoint.runApplication(
      initializeFirebase: true,
      firebaseInitializer: () async => events.add('firebase'),
      applicationLauncher: (app) {
        events.add('runApp');
        launchedApp = app as AppRoot;
      },
    );
    addTearDown(() => launchedApp?.router.dispose());

    expect(events, ['firebase', 'runApp']);
    expect(launchedApp!.initialThemeMode, ThemeMode.dark);
  });

  test(
    'uses the system appearance at bootstrap without a preference',
    () async {
      SharedPreferences.setMockInitialValues({});
      AppRoot? launchedApp;
      await entrypoint.runApplication(
        initializeFirebase: false,
        applicationLauncher: (app) => launchedApp = app as AppRoot,
      );
      addTearDown(() => launchedApp?.router.dispose());
      expect(launchedApp!.initialThemeMode, ThemeMode.system);
    },
  );
}
