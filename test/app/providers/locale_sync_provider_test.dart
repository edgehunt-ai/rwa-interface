import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/locale_sync_provider.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/product_session.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';

void main() {
  test('does not request account data before authentication', () async {
    var requests = 0;
    final container = ProviderContainer(
      overrides: [
        authenticationProvider.overrideWithBuild(
          (_, _) => const AuthenticationUnauthenticated(),
        ),
        accountProvider.overrideWith((_) async {
          requests++;
          return _account('en');
        }),
      ],
    );
    addTearDown(container.dispose);
    container.listen(accountLocaleSyncProvider, (_, _) {});
    await container.pump();

    expect(requests, 0);
    expect(container.read(appLocaleProvider), isNull);
  });

  for (final language in ['en', 'zh-CN']) {
    test('applies cached $language without a settings screen', () async {
      final container = _container((_) async => _account(language));
      final accountSubscription = container.listen(accountProvider, (_, _) {});
      addTearDown(accountSubscription.close);
      await container.read(accountProvider.future);
      container
          .read(appLocaleProvider.notifier)
          .setLanguage(language == 'en' ? 'zh-CN' : 'en');

      container.listen(accountLocaleSyncProvider, (_, _) {});
      await container.pump();

      expect(
        container.read(appLocaleProvider),
        localeFromLanguageCode(language),
      );
    });
  }

  test(
    'preserves a saved language through refresh loading and failure',
    () async {
      var response = Future.value(_account('en'));
      final container = _container((_) => response);
      container.listen(accountLocaleSyncProvider, (_, _) {});
      await container.read(accountProvider.future);
      await container.pump();
      expect(container.read(appLocaleProvider), const Locale('en'));

      final refresh = Completer<UserAccount>();
      response = refresh.future;
      container.read(appLocaleProvider.notifier).setLanguage('zh-CN');
      container.invalidate(accountProvider);
      await container.pump();
      expect(container.read(appLocaleProvider), const Locale('zh'));

      refresh.completeError(StateError('Account refresh unavailable'));
      await container.pump();
      expect(container.read(accountProvider).hasError, isTrue);
      expect(container.read(appLocaleProvider), const Locale('zh'));
    },
  );

  test('ignores a response that arrives after logout', () async {
    final response = Completer<UserAccount>();
    final container = _container((_) => response.future);
    container.read(appLocaleProvider.notifier).setLanguage('zh-CN');
    container.listen(accountLocaleSyncProvider, (_, _) {});
    await container.pump();

    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await container.pump();
    expect(container.read(appLocaleProvider), isNull);

    response.complete(_account('en'));
    await container.pump();
    expect(container.read(appLocaleProvider), isNull);
  });
}

ProviderContainer _container(Future<UserAccount> Function(Ref) account) {
  final container = ProviderContainer(
    overrides: [
      authenticationProvider.overrideWithBuild((ref, _) {
        final generation = ref.watch(sessionGenerationProvider).value;
        if (generation != 0) return const AuthenticationUnauthenticated();
        return AuthenticationAuthenticated(
          ProductSession(
            sessionId: 'session-1',
            createdAt: DateTime.utc(2026),
            expiresAt: DateTime.utc(2030),
            generation: generation,
            accountCreated: false,
            account: _account('zh-CN'),
          ),
          principal: const IdentityPrincipal('user-1'),
        );
      }),
      accountProvider.overrideWith((ref) {
        ref.watch(sessionGenerationProvider);
        return account(ref);
      }),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

UserAccount _account(String language) => UserAccount(
  userId: 'user-1',
  settings: UserPreferences(
    language: language,
    pushEnabled: false,
    notifyOrderFilled: false,
    notifyOrderFailed: false,
    notifyLiquidationWarning: false,
  ),
);
