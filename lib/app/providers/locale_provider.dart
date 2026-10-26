import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'session_scope.dart';

/// The current language survives logout. A manual guest choice takes priority
/// until it has been saved to the next signed-in account.
final appLocaleProvider = NotifierProvider<AppLocaleNotifier, Locale?>(
  AppLocaleNotifier.new,
);

final class AppLocaleNotifier extends Notifier<Locale?> {
  String? _pendingGuestLanguage;

  String? get pendingGuestLanguage => _pendingGuestLanguage;

  @override
  Locale? build() {
    // Clear an unfinished sync on logout or session expiry, retaining the
    // displayed language without carrying intent into another account.
    ref.listen(
      sessionGenerationProvider,
      (_, _) => _pendingGuestLanguage = null,
    );
    return null;
  }

  /// Applies a server preference without replacing an unsaved guest choice.
  void setLanguage(String language) {
    if (_pendingGuestLanguage != null) return;
    state = localeFromLanguageCode(language);
  }

  void setGuestLanguage(String language) {
    _pendingGuestLanguage =
        localeFromLanguageCode(language).languageCode == 'zh' ? 'zh-CN' : 'en';
    state = localeFromLanguageCode(language);
  }

  void acknowledgeGuestLanguage(String language) {
    if (_pendingGuestLanguage == language) _pendingGuestLanguage = null;
  }
}

Locale localeFromLanguageCode(String language) =>
    language.toLowerCase() == 'zh-cn' || language.toLowerCase() == 'zh'
    ? const Locale('zh')
    : const Locale('en');
