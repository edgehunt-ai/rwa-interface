import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/theme_mode_provider.dart';
import 'package:nobell/data/services/theme_mode_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('global.nobell.app/appearance');
  final nativeModes = <String>[];
  setUp(() {
    nativeModes.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          expect(call.method, 'setThemeMode');
          nativeModes.add(call.arguments as String);
          return null;
        });
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('defaults to the system appearance when nothing is stored', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appThemeModeProvider), ThemeMode.system);
    await Future<void>.delayed(Duration.zero);
    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });

  test('restores the stored appearance', () async {
    SharedPreferences.setMockInitialValues({ThemeModeService.key: 'dark'});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(appThemeModeProvider);
    await Future<void>.delayed(Duration.zero);
    expect(container.read(appThemeModeProvider), ThemeMode.dark);
    expect(nativeModes, ['dark']);
  });

  test('ignores an unknown stored value', () async {
    SharedPreferences.setMockInitialValues({ThemeModeService.key: 'sepia'});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.read(appThemeModeProvider);
    await Future<void>.delayed(Duration.zero);
    expect(container.read(appThemeModeProvider), ThemeMode.system);
  });

  test('persists the selected appearance', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container
        .read(appThemeModeProvider.notifier)
        .setMode(ThemeMode.light);

    expect(container.read(appThemeModeProvider), ThemeMode.light);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString(ThemeModeService.key), 'light');
    expect(nativeModes.last, 'light');
  });

  for (final mode in ThemeMode.values) {
    test(
      'selected ${mode.name} appearance restores in a fresh app container',
      () async {
        SharedPreferences.setMockInitialValues({});
        final first = ProviderContainer();
        await first.read(appThemeModeProvider.notifier).setMode(mode);
        first.dispose();
        final restarted = ProviderContainer();
        addTearDown(restarted.dispose);
        restarted.read(appThemeModeProvider);
        await Future<void>.delayed(Duration.zero);
        expect(restarted.read(appThemeModeProvider), mode);
        expect(nativeModes.last, mode.name);
      },
    );
  }

  test('uses the bootstrapped theme for the first provider read', () async {
    SharedPreferences.setMockInitialValues({ThemeModeService.key: 'light'});
    final container = ProviderContainer(
      overrides: [initialThemeModeProvider.overrideWithValue(ThemeMode.dark)],
    );
    addTearDown(container.dispose);

    expect(container.read(appThemeModeProvider), ThemeMode.dark);
    await container.pump();
    expect(container.read(appThemeModeProvider), ThemeMode.dark);
    expect(nativeModes, ['dark']);
  });

  test('returning to System clears the native appearance override', () async {
    SharedPreferences.setMockInitialValues({ThemeModeService.key: 'dark'});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    container.listen(appThemeModeProvider, (_, _) {});
    container.read(appThemeModeProvider);
    await Future<void>.delayed(Duration.zero);
    expect(container.read(appThemeModeProvider), ThemeMode.dark);

    await container
        .read(appThemeModeProvider.notifier)
        .setMode(ThemeMode.system);

    expect(nativeModes, ['dark', 'system']);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString(ThemeModeService.key), 'system');
  });

  for (final mode in [ThemeMode.dark, ThemeMode.system]) {
    test(
      'late restoration cannot replace the selected ${mode.name} mode',
      () async {
        SharedPreferences.setMockInitialValues({ThemeModeService.key: 'light'});
        final pendingRead = Completer<SharedPreferences>();
        var preferenceRequests = 0;
        final container = ProviderContainer(
          overrides: [
            themeModeServiceProvider.overrideWithValue(
              ThemeModeService(
                resolvePreferences: () {
                  preferenceRequests++;
                  return preferenceRequests == 1
                      ? pendingRead.future
                      : SharedPreferences.getInstance();
                },
              ),
            ),
          ],
        );
        addTearDown(container.dispose);
        container.read(appThemeModeProvider);
        await container.read(appThemeModeProvider.notifier).setMode(mode);
        pendingRead.complete(await SharedPreferences.getInstance());
        await container.pump();

        expect(container.read(appThemeModeProvider), mode);
        expect(nativeModes, [mode.name]);
      },
    );
  }

  test('parses only known appearance names', () {
    expect(parseThemeMode('system'), ThemeMode.system);
    expect(parseThemeMode('light'), ThemeMode.light);
    expect(parseThemeMode('dark'), ThemeMode.dark);
    expect(parseThemeMode(null), isNull);
    expect(parseThemeMode(''), isNull);
  });
}
