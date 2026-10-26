import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nobell/app/providers/theme_mode_provider.dart';
import 'package:nobell/data/services/theme_mode_service.dart';
import 'package:nobell/ui/core/motion/launch_animation.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

/// Run on Android 12+ to exercise the real application night-mode API.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('selected appearance reaches Android and the launch surface', (
    tester,
  ) async {
    const service = ThemeModeService();
    final originalMode = await service.read() ?? ThemeMode.system;
    final container = ProviderContainer(
      overrides: [initialThemeModeProvider.overrideWithValue(originalMode)],
    );
    try {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: Consumer(
            builder: (context, ref, _) => MaterialApp(
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: ref.watch(appThemeModeProvider),
              themeAnimationDuration: Duration.zero,
              home: const MediaQuery(
                data: MediaQueryData(disableAnimations: true),
                child: LaunchAnimation(),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await container
          .read(appThemeModeProvider.notifier)
          .setMode(ThemeMode.system);
      await tester.pumpAndSettle();
      final systemBrightness =
          tester.binding.platformDispatcher.platformBrightness;

      for (final (mode, brightness) in [
        (ThemeMode.dark, Brightness.dark),
        (ThemeMode.light, Brightness.light),
      ]) {
        await container.read(appThemeModeProvider.notifier).setMode(mode);
        await tester.pumpAndSettle();
        // This is the real Android configuration, independent of MaterialApp's
        // explicit themeMode. A Flutter-only change would fail this assertion.
        expect(
          tester.binding.platformDispatcher.platformBrightness,
          brightness,
        );
        expect(
          tester.widget<ColoredBox>(find.byKey(launchSurfaceKey)).color,
          AppTheme.tokensFor(brightness).surfaceCanvas,
        );
        expect(await service.read(), mode);
      }

      // Leave the app on the opposite appearance before clearing the override.
      await container
          .read(appThemeModeProvider.notifier)
          .setMode(
            systemBrightness == Brightness.light
                ? ThemeMode.dark
                : ThemeMode.light,
          );
      await tester.pumpAndSettle();
      await container
          .read(appThemeModeProvider.notifier)
          .setMode(ThemeMode.system);
      await tester.pumpAndSettle();
      expect(await service.read(), ThemeMode.system);
      expect(
        tester.binding.platformDispatcher.platformBrightness,
        systemBrightness,
      );
      expect(
        tester.widget<ColoredBox>(find.byKey(launchSurfaceKey)).color,
        AppTheme.tokensFor(tester.binding.platformDispatcher.platformBrightness)
            .surfaceCanvas,
      );
    } finally {
      await tester.pumpWidget(const SizedBox.shrink());
      container.dispose();
      await service.write(originalMode);
    }
  });
}
