import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/data/services/cache_storage_service.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/domain/models/account_deletion.dart';
import 'package:rwa_interface/domain/repositories/account_repository.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/repositories/session_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/account/providers/account_providers.dart';
import 'package:rwa_interface/ui/features/account/providers/cache_providers.dart';
import 'package:rwa_interface/ui/features/account/views/settings_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/fake_identity_auth_gateway.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('settings exposes account settings data', (tester) async {
    final identity = FakeIdentityAuthGateway();
    final session = _SessionRepository();
    await tester.pumpWidget(_settingsApp(identity, session));
    await tester.pump();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('RWA user'), findsOneWidget);
    expect(find.text('Passkey'), findsOneWidget);
    expect(find.text('Export Private Key'), findsOneWidget);
    expect(find.text('Terms & Conditions'), findsOneWidget);

    await tester.tap(find.text('Export Private Key'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Never share your private key'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    expect(find.text('Are you sure you want to log out?'), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Cancel'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Log Out'));
    await tester.pumpAndSettle();
    expect(session.endCalls, 1);
    expect(identity.logoutCalls, 1);
  });

  testWidgets('settings warning remains usable at 200% text scale', (
    tester,
  ) async {
    await configureDisplay(tester, textScale: 2);
    await tester.pumpWidget(
      _settingsApp(FakeIdentityAuthGateway(), _SessionRepository()),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    await tester.drag(find.byType(ListView), const Offset(0, -360));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Export Private Key'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Never share your private key'), findsOneWidget);
  });

  testWidgets('settings links and removes a Privy passkey', (tester) async {
    final identity = FakeIdentityAuthGateway();
    await tester.pumpWidget(_settingsApp(identity, _SessionRepository()));
    await tester.pumpAndSettle();

    expect(find.text('Not set up'), findsOneWidget);
    await tester.tap(find.text('Passkey'));
    await tester.pumpAndSettle();
    expect(find.text('Set Up Passkey'), findsOneWidget);
    expect(
      find.text(
        'Sign in faster using Face ID, Touch ID, or your device security.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Set Up'));
    await tester.pumpAndSettle();
    expect(identity.linkPasskeyCalls, 1);
    expect(find.text('Enabled'), findsOneWidget);

    await tester.tap(find.text('Passkey'));
    await tester.pumpAndSettle();
    expect(find.text('Passkey is enabled for this account.'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Remove Passkey'));
    await tester.pumpAndSettle();

    expect(identity.unlinkPasskeyCalls, 1);
    expect(find.text('Not set up'), findsOneWidget);
  });

  testWidgets('language sheet maps zh-CN and shows the selected control', (
    tester,
  ) async {
    await tester.pumpWidget(
      _settingsApp(
        FakeIdentityAuthGateway(),
        _SessionRepository(),
        language: 'zh-CN',
      ),
    );
    await tester.pump();

    expect(find.text('Simplified Chinese'), findsOneWidget);
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();

    expect(find.text('English'), findsOneWidget);
    expect(find.text('中文 (Chinese)'), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('language-option-zh-CN')),
        matching: find.byIcon(Icons.check),
      ),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const ValueKey('language-option-en')));
    await tester.pump();
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('language-option-en')),
        matching: find.byIcon(Icons.check),
      ),
      findsOneWidget,
    );
  });

  testWidgets('clears the device cache and refreshes its displayed size', (
    tester,
  ) async {
    final cache = _CacheStorageService(size: 7680);
    await tester.pumpWidget(
      _settingsApp(
        FakeIdentityAuthGateway(),
        _SessionRepository(),
        cache: cache,
      ),
    );
    await tester.pump();

    expect(find.text('7.5 KB'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -260));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();

    expect(cache.clearCalls, 1);
    expect(find.text('0 B'), findsOneWidget);
  });

  testWidgets('logout routes from settings to login', (tester) async {
    final identity = FakeIdentityAuthGateway();
    final session = _SessionRepository();
    final router = AppRouter.create(initialLocation: '/settings');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(identity),
          sessionRepositoryProvider.overrideWithValue(session),
          accountProvider.overrideWith(
            (_) async => const UserAccount(
              userId: 'account-1',
              displayName: 'RWA user',
              settings: UserPreferences(
                language: 'English',
                pushEnabled: true,
                notifyOrderFilled: true,
                notifyOrderFailed: true,
                notifyLiquidationWarning: true,
              ),
            ),
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Log Out'));
    await tester.pumpAndSettle();

    expect(session.endCalls, 1);
    expect(identity.logoutCalls, 1);
    expect(find.text('Sign up or log in\nto start exploring'), findsOneWidget);
  });

  testWidgets('requests account deletion after confirmation', (tester) async {
    final identity = FakeIdentityAuthGateway();
    final session = _SessionRepository();
    final account = _DeletionAccountRepository();
    await tester.pumpWidget(
      _settingsApp(identity, session, accountRepository: account),
    );
    await tester.pump();

    await tester.drag(find.byType(ListView), const Offset(0, -500));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete Account'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('permanent deletion of your product account'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Delete Account'));
    await tester.pumpAndSettle();

    expect(account.deletionRequests, 1);
    expect(identity.logoutCalls, 1);
    expect(session.endCalls, 1);
  });
}

Widget _settingsApp(
  FakeIdentityAuthGateway identity,
  _SessionRepository session, {
  String language = 'en',
  CacheStorageService? cache,
  AccountRepository? accountRepository,
}) => ProviderScope(
  overrides: [
    identityAuthGatewayProvider.overrideWithValue(identity),
    sessionRepositoryProvider.overrideWithValue(session),
    if (accountRepository != null)
      accountRepositoryProvider.overrideWithValue(accountRepository),
    cacheStorageServiceProvider.overrideWithValue(
      cache ?? _CacheStorageService(),
    ),
    accountProvider.overrideWith(
      (_) async => UserAccount(
        userId: 'account-1',
        displayName: 'RWA user',
        settings: UserPreferences(
          language: language,
          pushEnabled: true,
          notifyOrderFilled: true,
          notifyOrderFailed: true,
          notifyLiquidationWarning: true,
        ),
      ),
    ),
  ],
  child: MaterialApp(
    theme: AppTheme.light,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const SettingsScreen(),
  ),
);

final class _DeletionAccountRepository implements AccountRepository {
  var deletionRequests = 0;

  @override
  Future<AccountDeletion> requestAccountDeletion({
    required String idempotencyKey,
  }) async {
    deletionRequests += 1;
    final now = DateTime.utc(2026);
    return AccountDeletion(
      requestId: 'delete-1',
      state: AccountDeletionState.requested,
      blockers: const [],
      requestedAt: now,
      updatedAt: now,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _SessionRepository implements SessionRepository {
  var endCalls = 0;

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) => throw UnimplementedError();

  @override
  Future<void> endSession() async {
    endCalls++;
  }
}

final class _CacheStorageService implements CacheStorageService {
  _CacheStorageService({this.size = 0});

  int size;
  int clearCalls = 0;

  @override
  Future<void> clear() async {
    clearCalls++;
    size = 0;
  }

  @override
  Future<int> sizeBytes() async => size;
}
