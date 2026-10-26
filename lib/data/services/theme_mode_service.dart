import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists the user's appearance preference between launches.
final class ThemeModeService {
  static const key = 'app_theme_mode_v1';
  static const _appearanceChannel = MethodChannel(
    'global.nobell.app/appearance',
  );

  const ThemeModeService({SharedPreferencesResolver? resolvePreferences})
    : _resolvePreferences = resolvePreferences ?? SharedPreferences.getInstance;

  final SharedPreferencesResolver _resolvePreferences;

  Future<ThemeMode?> read() async {
    final preferences = await _resolvePreferences();
    return parseThemeMode(preferences.getString(key));
  }

  Future<void> write(ThemeMode mode) async {
    final preferences = await _resolvePreferences();
    await preferences.setString(key, mode.name);
    await synchronizeNativeAppearance(mode);
  }

  /// Android 12+ persists the application night mode for the system splash,
  /// which is shown before Dart can read the saved preference.
  Future<void> synchronizeNativeAppearance(ThemeMode mode) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    try {
      await _appearanceChannel.invokeMethod<void>('setThemeMode', mode.name);
    } on MissingPluginException {
      // Allows tests and an older native host to keep using the Flutter theme.
    } on PlatformException catch (error) {
      debugPrint(
        'Unable to synchronize the native appearance: ${error.message}',
      );
    }
  }
}

/// Parses a stored [ThemeMode] name, defaulting to `null` for unknown values
/// so callers can fall back to the system appearance.
ThemeMode? parseThemeMode(String? value) => switch (value) {
  'system' => ThemeMode.system,
  'light' => ThemeMode.light,
  'dark' => ThemeMode.dark,
  _ => null,
};

typedef SharedPreferencesResolver = Future<SharedPreferences> Function();
