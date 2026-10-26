import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/auth/authentication.dart';
import '../../domain/models/user_account.dart';
import '../../ui/features/account/providers/account_providers.dart';
import '../../ui/features/session/providers/authentication_provider.dart';
import 'locale_provider.dart';
import 'session_scope.dart';

/// Keeps the app language in sync with the signed-in account on every route.
final accountLocaleSyncProvider = Provider.autoDispose<void>((ref) {
  ref.watch(sessionGenerationProvider);
  final authenticated = ref.watch(
    authenticationProvider.select(
      (state) => state is AuthenticationAuthenticated,
    ),
  );
  if (!authenticated) return;

  ref.listen<AsyncValue<UserAccount>>(accountProvider, (_, next) {
    if (next.isLoading || next.hasError || !next.hasValue) return;
    // Cached data can arrive while MaterialApp is building. Apply it after
    // that build, and read the latest value so queued work cannot replay an
    // older preference or overwrite a successful save during a refresh.
    scheduleMicrotask(() {
      if (!ref.mounted) return;
      final current = ref.read(accountProvider);
      if (current.isLoading || current.hasError) return;
      final account = current.value;
      if (account == null) return;
      ref
          .read(appLocaleProvider.notifier)
          .setLanguage(account.settings.language);
    });
  }, fireImmediately: true);
});
