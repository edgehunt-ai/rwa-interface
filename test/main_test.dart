import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app.dart';
import 'package:nobell/main.dart' as entrypoint;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('initializes Firebase before launching the application', () async {
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
  });
}
