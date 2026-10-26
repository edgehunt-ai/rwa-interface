import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/theme_mode_provider.dart';
import 'package:nobell/data/services/cache_storage_service.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/account/providers/cache_providers.dart';
import 'package:nobell/ui/features/account/views/settings_screen.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';

import '../../../helpers/display_config.dart';

void main() {
  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    for (final scale in [1.0, 2.0]) {
      testWidgets(
        'guest settings fit narrow ${mode.name} mode at $scale text',
        (tester) async {
          await configureDisplay(tester, textScale: scale);
          final container = _container(mode: mode);
          addTearDown(container.dispose);
          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: const _SettingsApp(),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text('Your account'), findsOneWidget);
          expect(find.text('Log in to manage your account'), findsOneWidget);
          for (final label in [
            'Language',
            'Display Mode',
            'Terms of Use',
            'Privacy Policy',
            'Check for Updates',
            'App Version',
            'Cache Size',
          ]) {
            await tester.scrollUntilVisible(find.text(label), 180);
            await tester.ensureVisible(find.text(label));
            await tester.pumpAndSettle();
            expect(find.text(label), findsOneWidget);
          }
          for (final label in [
            'Passkey',
            'Export Private Key',
            'Log Out',
            'Delete Account',
          ]) {
            expect(find.text(label), findsNothing);
          }
        },
      );
    }
  }

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets(
      'language and appearance values have centered chevrons in ${mode.name}',
      (tester) async {
        await configureDisplay(tester, size: const Size(393, 852));
        final container = _container(mode: mode);
        addTearDown(container.dispose);
        container.read(appLocaleProvider.notifier).setGuestLanguage('zh-CN');
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const _SettingsApp(),
          ),
        );
        await tester.pumpAndSettle();
        for (final label in ['简体中文', mode == ThemeMode.dark ? '深色' : '浅色']) {
          final text = find.text(label);
          final row = find.ancestor(of: text, matching: find.byType(Row)).first;
          final chevron = find.descendant(
            of: row,
            matching: find.byWidgetPredicate(
              (widget) =>
                  widget is SvgPicture &&
                  widget.bytesLoader is SvgAssetLoader &&
                  (widget.bytesLoader as SvgAssetLoader).assetName ==
                      'assets/figma/account_activity/chevron_right.svg',
            ),
          );
          expect(chevron, findsOneWidget);
          expect(
            tester.getCenter(text).dy,
            closeTo(tester.getCenter(chevron).dy, 0.01),
          );
          expect(
            tester
                .widget<Text>(text)
                .textHeightBehavior!
                .applyHeightToFirstAscent,
            isFalse,
          );
        }
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('guest changes language locally and saves display mode', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final container = _container();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _SettingsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('language-option-zh-CN')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();
    expect(find.text('设置'), findsOneWidget);
    expect(find.text('简体中文'), findsOneWidget);
    expect(container.read(appLocaleProvider), const Locale('zh'));
    expect(container.exists(settingsCommandProvider), isFalse);
    await tester.tap(find.text('语言'));
    await tester.pumpAndSettle();
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('language-option-zh-CN')),
        matching: find.byIcon(Icons.check),
      ),
      findsOneWidget,
    );
    Navigator.of(
      tester.element(find.byKey(const ValueKey('language-option-zh-CN'))),
    ).pop();
    await tester.pumpAndSettle();
    await tester.tap(find.text('显示模式'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('display-mode-option-dark')));
    await tester.pumpAndSettle();
    expect(container.read(appThemeModeProvider), ThemeMode.dark);
    expect(
      Theme.of(tester.element(find.byType(SettingsScreen))).brightness,
      Brightness.dark,
    );
    expect(
      (await SharedPreferences.getInstance()).getString('app_theme_mode_v1'),
      'dark',
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('guest clears cache without an account', (tester) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final cache = _Cache();
    final container = _container(cache: cache);
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _SettingsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Cache Size'));
    await tester.tap(find.text('Clear'));
    await tester.pumpAndSettle();
    expect(cache.clearCalls, 1);
    expect(find.text('0 B'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

ProviderContainer _container({
  ThemeMode mode = ThemeMode.light,
  _Cache? cache,
}) {
  SharedPreferences.setMockInitialValues({});
  return ProviderContainer(
    overrides: [
      authenticationProvider.overrideWithBuild(
        (_, _) => const AuthenticationUnauthenticated(),
      ),
      initialThemeModeProvider.overrideWithValue(mode),
      accountProvider.overrideWith(
        (_) async => throw StateError('Guest loaded an account'),
      ),
      passkeyProvider.overrideWithBuild(
        (_, _) async => throw StateError('Guest loaded a Passkey'),
      ),
      cacheStorageServiceProvider.overrideWithValue(cache ?? _Cache()),
    ],
  );
}

class _SettingsApp extends ConsumerWidget {
  const _SettingsApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp(
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    themeMode: ref.watch(appThemeModeProvider),
    locale: ref.watch(appLocaleProvider),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const SettingsScreen(),
  );
}

class _Cache implements CacheStorageService {
  int clearCalls = 0;
  @override
  Future<void> clear() async {
    clearCalls++;
  }

  @override
  Future<int> sizeBytes() async => clearCalls == 0 ? 1024 : 0;
}
