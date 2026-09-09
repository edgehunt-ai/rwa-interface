import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/repositories/session_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/account/providers/account_providers.dart';
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
    expect(find.text('Export Private Key'), findsOneWidget);

    await tester.tap(find.text('Export Private Key'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Never share your private key'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
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
    await tester.ensureVisible(find.text('Export Private Key'));
    await tester.tap(find.text('Export Private Key'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Never share your private key'), findsOneWidget);
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

    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Log Out'));
    await tester.pumpAndSettle();

    expect(session.endCalls, 1);
    expect(identity.logoutCalls, 1);
    expect(find.text('Sign up or log in\nto start exploring'), findsOneWidget);
  });
}

Widget _settingsApp(
  FakeIdentityAuthGateway identity,
  _SessionRepository session,
) => ProviderScope(
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
  child: MaterialApp(
    theme: AppTheme.light,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const SettingsScreen(),
  ),
);

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
