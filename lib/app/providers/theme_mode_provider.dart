import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/theme_mode_service.dart';

final themeModeServiceProvider = Provider<ThemeModeService>(
  (ref) => const ThemeModeService(),
);

/// Supplied by bootstrap so the first Flutter frame already matches Settings.
final initialThemeModeProvider = Provider<ThemeMode?>((ref) => null);

/// The appearance selected in Settings. Defaults to the platform appearance
/// until the stored preference has been restored.
final appThemeModeProvider = NotifierProvider<AppThemeModeNotifier, ThemeMode>(
  AppThemeModeNotifier.new,
);

final class AppThemeModeNotifier extends Notifier<ThemeMode> {
  bool _hasUserSelection = false;

  @override
  ThemeMode build() {
    final initialMode = ref.watch(initialThemeModeProvider);
    unawaited(_restore(initialMode));
    return initialMode ?? ThemeMode.system;
  }

  Future<void> _restore(ThemeMode? initialMode) async {
    try {
      final service = ref.read(themeModeServiceProvider);
      final stored = initialMode ?? await service.read() ?? ThemeMode.system;
      if (!ref.mounted || _hasUserSelection) return;
      if (initialMode == null) state = stored;
      await service.synchronizeNativeAppearance(stored);
    } on Object catch (error) {
      // A missing or corrupted preference must not block startup: the system
      // appearance remains the fallback.
      debugPrint('Unable to restore the theme preference: $error');
    }
  }

  Future<void> setMode(ThemeMode mode) async {
    _hasUserSelection = true;
    state = mode;
    try {
      await ref.read(themeModeServiceProvider).write(mode);
    } on Object catch (error) {
      debugPrint('Unable to persist the theme preference: $error');
    }
  }
}
