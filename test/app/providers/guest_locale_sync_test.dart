import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/app.dart';
import 'package:nobell/app/config/privy_configuration.dart';
import 'package:nobell/app/providers/auth_providers.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/locale_sync_provider.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/product_session.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/domain/repositories/account_repository.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';

import '../../helpers/fake_identity_auth_gateway.dart';

void main() {
  testWidgets('sync failure displays its reason and offers a working retry', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final harness = _Harness();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: Text('Home')),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: harness.container,
        child: AppRoot(router: router),
      ),
    );
    await tester.pumpAndSettle();
    harness.locale.setGuestLanguage('en');
    harness.repository.failure = StateError(
      'Language update temporarily unavailable',
    );
    final login = expectLater(harness.login('first', 'zh-CN'), throwsStateError);
    await tester.pumpAndSettle();
    await login;
    expect(
      find.textContaining('Language update temporarily unavailable'),
      findsOneWidget,
    );
    expect(find.text('Retry'), findsOneWidget);
    harness.repository.failure = null;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(harness.repository.languages['first'], 'en');
    expect(harness.locale.pendingGuestLanguage, isNull);
    expect(tester.takeException(), isNull);
  });

  test(
    'guest choice is saved once to the next account and retained after logout',
    () async {
      final harness = _Harness();
      harness.locale.setGuestLanguage('zh-CN');
      await harness.login('first', 'en');
      expect(harness.repository.updates, ['first:zh-CN']);
      expect(harness.container.read(appLocaleProvider), const Locale('zh'));
      expect(harness.locale.pendingGuestLanguage, isNull);

      harness.logout();
      await harness.container.pump();
      expect(harness.container.read(appLocaleProvider), const Locale('zh'));
      // Retaining the previous user's language is not a manual guest choice.
      await harness.login('second', 'en');
      expect(harness.container.read(appLocaleProvider), const Locale('en'));
      expect(harness.repository.updates, ['first:zh-CN']);
    },
  );

  test(
    'matching guest language needs no write, including zh and zh-CN aliases',
    () async {
      final harness = _Harness();
      harness.locale.setGuestLanguage('zh-CN');
      await harness.login('first', 'zh');
      expect(harness.repository.updates, isEmpty);
      expect(harness.locale.pendingGuestLanguage, isNull);
      harness.logout();
      await harness.login('second', 'en');
      expect(harness.container.read(appLocaleProvider), const Locale('en'));
      expect(harness.repository.updates, isEmpty);
    },
  );

  test(
    'a new guest choice after logout takes priority for the next account',
    () async {
      final harness = _Harness();
      await harness.login('first', 'zh-CN');
      harness.logout();
      harness.locale.setGuestLanguage('en');
      await harness.login('second', 'zh-CN');
      expect(harness.repository.updates, ['second:en']);
      expect(harness.container.read(appLocaleProvider), const Locale('en'));
    },
  );

  test('failed synchronization keeps the selection and exposes the reason for retry', () async {
    final harness = _Harness();
    harness.locale.setGuestLanguage('zh-CN');
    harness.repository.failure = StateError(
      'Language update temporarily unavailable',
    );
    await expectLater(harness.login('first', 'en'), throwsStateError);
    final sync = harness.container.read(accountLocaleSyncProvider);
    expect(
      sync.error.toString(),
      contains('Language update temporarily unavailable'),
    );
    expect(harness.locale.pendingGuestLanguage, 'zh-CN');
    expect(harness.container.read(appLocaleProvider), const Locale('zh'));

    harness.repository.failure = null;
    harness.container.invalidate(accountLocaleSyncProvider);
    await harness.settle();
    expect(harness.repository.languages['first'], 'zh-CN');
    expect(harness.locale.pendingGuestLanguage, isNull);
  });

  test(
    'an old account save cannot replace the next account language',
    () async {
      final harness = _Harness();
      final started = Completer<void>();
      final release = Completer<void>();
      harness.repository.started = started;
      harness.repository.barrier = release.future;
      harness.locale.setGuestLanguage('zh-CN');
      final oldLogin = harness.login('first', 'en');
      await started.future;
      harness.logout();
      harness.repository.started = null;
      harness.repository.barrier = null;
      await harness.login('second', 'en');
      release.complete();
      await oldLogin;
      await harness.container.pump();
      expect(harness.container.read(appLocaleProvider), const Locale('en'));
      expect(harness.repository.updates, ['first:zh-CN']);
    },
  );
}

final _authState = NotifierProvider<_AuthState, AuthenticationState>(
  _AuthState.new,
);

class _AuthState extends Notifier<AuthenticationState> {
  @override
  AuthenticationState build() => const AuthenticationUnauthenticated();
  void set(AuthenticationState value) => state = value;
}

class _Harness {
  _Harness() {
    container = ProviderContainer(
      overrides: [
        identityAuthGatewayProvider.overrideWithValue(
          FakeIdentityAuthGateway(),
        ),
        privyConfigurationProvider.overrideWithValue(
          const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
        ),
        authenticationProvider.overrideWithBuild((ref, _) {
          final state = ref.watch(_authState);
          final generation = ref.watch(sessionGenerationProvider).value;
          if (state is AuthenticationAuthenticated &&
              state.session.generation != generation) {
            return const AuthenticationUnauthenticated();
          }
          return state;
        }),
        accountRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    container.listen(accountLocaleSyncProvider, (_, _) {});
  }

  final repository = _Accounts();
  late final ProviderContainer container;
  AppLocaleNotifier get locale => container.read(appLocaleProvider.notifier);

  Future<void> login(String user, String language) async {
    repository.user = user;
    repository.languages[user] = language;
    locale.setLanguage(language);
    container
        .read(_authState.notifier)
        .set(
          AuthenticationAuthenticated(
            ProductSession(
              sessionId: user,
              createdAt: DateTime.utc(2026),
              expiresAt: DateTime.utc(2030),
              generation: container.read(sessionGenerationProvider).value,
              accountCreated: false,
              account: await repository.getAccount(),
            ),
            principal: IdentityPrincipal(user),
          ),
        );
    await settle();
  }

  Future<void> settle() async {
    await container.pump();
    await container.read(accountProvider.future);
    await container.pump();
    await container.read(accountLocaleSyncProvider.future);
    await container.pump();
  }

  void logout() {
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    container
        .read(_authState.notifier)
        .set(const AuthenticationUnauthenticated());
  }
}

class _Accounts implements AccountRepository {
  String user = 'first';
  final languages = <String, String>{};
  final updates = <String>[];
  Object? failure;
  Completer<void>? started;
  Future<void>? barrier;

  UserPreferences preferences(String language) => UserPreferences(
    language: language,
    pushEnabled: false,
    notifyOrderFilled: false,
    notifyOrderFailed: false,
    notifyLiquidationWarning: false,
  );

  @override
  Future<UserAccount> getAccount() async =>
      UserAccount(userId: user, settings: preferences(languages[user] ?? 'en'));

  @override
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch) async {
    final account = user;
    updates.add('$account:${patch.language}');
    started?.complete();
    await barrier;
    if (failure case final failure?) throw failure;
    languages[account] = patch.language!;
    return preferences(patch.language!);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
