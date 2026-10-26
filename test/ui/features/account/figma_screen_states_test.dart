import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/auth_providers.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/data/services/cache_storage_service.dart';
import 'package:nobell/domain/models/product_session.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/account_deletion.dart';
import 'package:nobell/domain/repositories/account_repository.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/domain/repositories/session_repository.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/widgets/account_avatar.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/account/providers/cache_providers.dart';
import 'package:nobell/ui/features/account/views/settings_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/fake_identity_auth_gateway.dart';
import '../../../helpers/test_app.dart';

void main() {
  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('settings action icons match their text in ${mode.name} mode', (
      tester,
    ) async {
      await tester.pumpWidget(
        _settingsApp(
          FakeIdentityAuthGateway(),
          _SessionRepository(),
          themeMode: mode,
        ),
      );
      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0, -500));
      await tester.pumpAndSettle();

      final theme = mode == ThemeMode.dark ? AppTheme.dark : AppTheme.light;
      for (final (label, asset, expected) in [
        ('Log Out', 'logout.svg', theme.extension<AppSemanticColors>()!.danger),
        (
          'Delete Account',
          'delete_account.svg',
          theme.extension<AppRwaColors>()!.textPrimary,
        ),
      ]) {
        final text = tester.widget<Text>(find.text(label));
        final svg = tester.widget<SvgPicture>(
          find.byWidgetPredicate(
            (widget) =>
                widget is SvgPicture &&
                widget.bytesLoader is SvgAssetLoader &&
                (widget.bytesLoader as SvgAssetLoader).assetName ==
                    'assets/figma/account_activity/$asset',
          ),
        );
        expect(text.style!.color, expected);
        expect(
          (svg.bytesLoader as SvgAssetLoader).theme!.currentColor,
          text.style!.color,
        );
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('settings exposes account settings data', (tester) async {
    final identity = FakeIdentityAuthGateway();
    final session = _SessionRepository();
    await tester.pumpWidget(_settingsApp(identity, session));
    await tester.pump();

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('RWA user'), findsOneWidget);
    expect(find.text('Passkey'), findsOneWidget);
    expect(find.text('Export Private Key'), findsOneWidget);
    expect(find.text('Terms Of Use'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    final avatar = tester.widget<AccountAvatar>(
      find.byKey(const Key('settings-account-avatar')),
    );
    expect(avatar.avatarUri, isNull);
    final fallback = tester.widget<Image>(find.byType(Image).first);
    expect(
      (fallback.image as AssetImage).assetName,
      'assets/figma/home_markets/account_avatar.webp',
    );

    await tester.tap(find.text('Export Private Key'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Sign in on the web to export'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in on the web'));
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

  testWidgets('settings prefers the account avatar URL', (tester) async {
    final avatarUri = Uri.parse('https://cdn.example.com/avatar.png');
    await tester.pumpWidget(
      _settingsApp(
        FakeIdentityAuthGateway(),
        _SessionRepository(),
        avatarUri: avatarUri,
      ),
    );
    await tester.pump();

    final avatar = tester.widget<CachedNetworkImage>(
      find.descendant(
        of: find.byKey(const Key('settings-account-avatar')),
        matching: find.byType(CachedNetworkImage),
      ),
    );
    expect(avatar.imageUrl, avatarUri.toString());
    expect(avatar.cacheKey, avatarUri.toString());
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
    await tester.drag(find.byType(ListView), const Offset(0, -520));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Export Private Key'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Export Private Key'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.textContaining('Sign in on the web to export'), findsOneWidget);
  });

  testWidgets('settings switches the display mode from its bottom sheet', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      _settingsApp(FakeIdentityAuthGateway(), _SessionRepository()),
    );
    await tester.pumpAndSettle();

    expect(find.text('Display Mode'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);

    await tester.tap(find.text('Display Mode'));
    await tester.pumpAndSettle();

    expect(find.text('All stocks'), findsNothing);
    expect(
      find.byKey(const ValueKey('display-mode-option-light')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('display-mode-option-dark')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('display-mode-option-system')),
      findsOneWidget,
    );
    expect(find.text('Always use light mode on this device'), findsOneWidget);
    expect(find.text('Always use dark mode on this device'), findsOneWidget);
    expect(find.text('Follow this device’s system setting'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('display-mode-option-dark')));
    await tester.pumpAndSettle();

    // Selecting a row applies it immediately and closes the sheet.
    expect(find.text('Display Mode'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString('app_theme_mode_v1'), 'dark');
  });

  testWidgets('the display mode sheet closes without changing the mode', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      _settingsApp(FakeIdentityAuthGateway(), _SessionRepository()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Display Mode'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('display-mode-close')));
    await tester.pumpAndSettle();

    expect(find.text('Display Mode'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);
    expect(
      (await SharedPreferences.getInstance()).getString('app_theme_mode_v1'),
      isNull,
    );
  });

  testWidgets('the display mode sheet fits a narrow viewport at 200% text', (
    tester,
  ) async {
    await configureDisplay(tester, textScale: 2);
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      _settingsApp(FakeIdentityAuthGateway(), _SessionRepository()),
    );
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Display Mode'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Display Mode'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    await tester.ensureVisible(
      find.byKey(const ValueKey('display-mode-option-system')),
    );
    await tester.tap(find.byKey(const ValueKey('display-mode-option-system')));
    await tester.pumpAndSettle();

    expect(find.text('Display Mode'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('display mode rows follow the design geometry', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      _settingsApp(FakeIdentityAuthGateway(), _SessionRepository()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Display Mode'));
    await tester.pumpAndSettle();

    final sheet = find.byType(SingleChildScrollView);
    expect(sheet, findsOneWidget);
    expect(tester.getSize(sheet).width, greaterThan(0));

    for (final mode in ['light', 'dark', 'system']) {
      final row = find.byKey(ValueKey('display-mode-option-$mode'));
      expect(row, findsOneWidget);
      expect(tester.getSize(row).height, 72);
    }

    // The selected row is highlighted with the subtle surface token.
    final theme = Theme.of(tester.element(sheet));
    final colors = theme.extension<AppRwaColors>()!;
    final selected = tester.widget<Container>(
      find
          .descendant(
            of: find.byKey(const ValueKey('display-mode-option-system')),
            matching: find.byType(Container),
          )
          .first,
    );
    expect((selected.decoration! as BoxDecoration).color, colors.surfaceSubtle);

    // Only the selected row renders a visible check indicator.
    final checks = tester
        .widgetList<AnimatedOpacity>(
          find.descendant(
            of: find.byType(SingleChildScrollView),
            matching: find.byType(AnimatedOpacity),
          ),
        )
        .toList();
    expect(checks.map((widget) => widget.opacity), [0.0, 0.0, 1.0]);
  });

  testWidgets('the system display mode is labelled System in Chinese', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      _settingsApp(
        FakeIdentityAuthGateway(),
        _SessionRepository(),
        language: 'zh-CN',
        locale: const Locale('zh'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('显示模式'));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(SingleChildScrollView),
        matching: find.text('系统'),
      ),
      findsOneWidget,
    );
    expect(find.text('跟随系统'), findsNothing);
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

  testWidgets('passkey setup shows the SDK reason and allows retry', (
    tester,
  ) async {
    final identity = FakeIdentityAuthGateway()
      ..passkeyFailure = const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
        reason: '[50152] RP ID cannot be validated.',
      );
    await tester.pumpWidget(_settingsApp(identity, _SessionRepository()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Passkey'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Set Up'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('[50152] RP ID cannot be validated.'), findsOneWidget);
    expect(find.text('Passkey setup failed. Please try again.'), findsNothing);
    expect(find.text('Set Up Passkey'), findsOneWidget);

    identity.passkeyFailure = null;
    await tester.tap(find.widgetWithText(FilledButton, 'Set Up'));
    await tester.pumpAndSettle();
    expect(identity.linkPasskeyCalls, 2);
    expect(find.text('Enabled'), findsOneWidget);
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

  testWidgets('settings opens both legal pages, returns, and logs out', (
    tester,
  ) async {
    final identity = FakeIdentityAuthGateway();
    final session = _SessionRepository();
    final router = AppRouter.create(initialLocation: '/settings');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
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
    for (final entry in [
      ('Terms Of Use', 'Term of Use'),
      ('Privacy Policy', 'Privacy Policy'),
    ]) {
      await tester.ensureVisible(find.text(entry.$1));
      await tester.tap(find.text(entry.$1));
      await tester.pumpAndSettle();
      expect(find.text(entry.$2), findsOneWidget);
      await tester.tap(find.byKey(const Key('legal-back')));
      await tester.pumpAndSettle();
      expect(find.byType(SettingsScreen), findsOneWidget);
    }
    await tester.ensureVisible(find.text('Log Out'));
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Log Out'));
    await tester.pumpAndSettle();

    expect(session.endCalls, 1);
    expect(identity.logoutCalls, 1);
    expect(router.routeInformationProvider.value.uri.path, '/');
  });

  testWidgets('logout confirmation disables actions while logout is pending', (
    tester,
  ) async {
    final logoutStarted = Completer<void>();
    final releaseLogout = Completer<void>();
    final identity = FakeIdentityAuthGateway();
    final session = _SessionRepository()
      ..logoutStarted = logoutStarted
      ..logoutBarrier = releaseLogout.future;
    await tester.pumpWidget(_settingsApp(identity, session));
    await tester.pump();

    await tester.drag(find.byType(ListView), const Offset(0, -400));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Log Out'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('settings-logout-confirm')));
    await logoutStarted.future;
    await tester.pump();

    expect(
      tester
          .widget<FilledButton>(
            find.byKey(const Key('settings-logout-confirm')),
          )
          .onPressed,
      isNull,
    );
    expect(find.byKey(const Key('settings-logout-progress')), findsOneWidget);
    expect(find.widgetWithText(OutlinedButton, 'Cancel'), findsOneWidget);
    expect(
      tester
          .widget<OutlinedButton>(find.widgetWithText(OutlinedButton, 'Cancel'))
          .onPressed,
      isNull,
    );
    expect(session.endCalls, 1);

    releaseLogout.complete();
    await tester.pumpAndSettle();
    expect(identity.logoutCalls, 1);
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
    expect(
      find.textContaining('permanent deletion of your product account'),
      findsNothing,
    );
  });
}

Widget _settingsApp(
  FakeIdentityAuthGateway identity,
  _SessionRepository session, {
  String language = 'en',
  CacheStorageService? cache,
  AccountRepository? accountRepository,
  Uri? avatarUri,
  Locale? locale,
  ThemeMode themeMode = ThemeMode.light,
}) => ProviderScope(
  overrides: [
    authenticatedStateOverride,
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
        avatarUri: avatarUri,
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
    darkTheme: AppTheme.dark,
    themeMode: themeMode,
    locale: locale,
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
  Completer<void>? logoutStarted;
  Future<void>? logoutBarrier;

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) => throw UnimplementedError();

  @override
  Future<void> endSession() async {
    endCalls++;
    logoutStarted?.complete();
    await logoutBarrier;
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
