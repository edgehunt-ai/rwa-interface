import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The server-owned language preference for the signed-in account.
///
/// This is intentionally in-memory only. The account response is the source
/// of truth, so the setting is shared across devices without stale local data.
final appLocaleProvider = NotifierProvider<AppLocaleNotifier, Locale?>(
  AppLocaleNotifier.new,
);

final class AppLocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() => null;

  void setLanguage(String language) {
    state = localeFromLanguageCode(language);
  }
}

Locale localeFromLanguageCode(String language) =>
    language.toLowerCase() == 'zh-cn' || language.toLowerCase() == 'zh'
    ? const Locale('zh')
    : const Locale('en');
