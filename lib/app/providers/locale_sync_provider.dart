import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth/authentication.dart';
import '../../domain/models/user_account.dart';
import '../../ui/features/account/providers/account_providers.dart';
import '../../ui/features/session/providers/authentication_provider.dart';
import 'api_providers.dart';
import 'locale_provider.dart';
import 'session_scope.dart';

/// Reconciles a guest's explicit choice with the next account. Otherwise the
/// account response owns the language, even when a previous user's is retained.
final accountLocaleSyncProvider = FutureProvider.autoDispose<void>((ref) async {
  ref.watch(sessionGenerationProvider);
  final sessionId = ref.watch(
    authenticationProvider.select(
      (state) =>
          state is AuthenticationAuthenticated ? state.session.sessionId : null,
    ),
  );
  if (sessionId == null) return;
  final account = await ref.watch(accountProvider.future);
  // Cached account data may be delivered during MaterialApp's build.
  await Future<void>.value();
  if (!ref.mounted) return;
  final language = account.settings.language;
  final locale = ref.read(appLocaleProvider.notifier);
  final pending = locale.pendingGuestLanguage;
  if (pending == null) {
    locale.setLanguage(language);
    return;
  }
  if (localeFromLanguageCode(pending) == localeFromLanguageCode(language)) {
    locale.acknowledgeGuestLanguage(pending);
    locale.setLanguage(language);
    return;
  }

  // Keep the chosen language and pending intent if saving fails. The provider
  // exposes the original failure for feedback and explicit retry.
  final saved = await ref
      .read(accountRepositoryProvider)
      .updateSettings(UserPreferencesPatch(language: pending));
  if (!ref.mounted || locale.pendingGuestLanguage != pending) return;
  locale.acknowledgeGuestLanguage(pending);
  locale.setLanguage(saved.language);
  ref.invalidate(accountProvider);
}, retry: (retryCount, error) => null);
