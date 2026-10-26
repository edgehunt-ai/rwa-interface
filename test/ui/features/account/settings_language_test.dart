import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/locale_sync_provider.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/account/providers/cache_providers.dart';
import 'package:nobell/ui/features/account/views/settings_screen.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final cached in [true, false]) {
    for (final language in ['en', 'zh-CN']) {
      testWidgets(
        'settings synchronizes $language with a ${cached ? 'cached' : 'loading'} account',
        (tester) async {
          var savedLanguage = language;
          final initialAccount = Completer<UserAccount>();
          final container = ProviderContainer(
            overrides: [
              authenticatedStateOverride,
              accountProvider.overrideWith(
                (_) => initialAccount.isCompleted
                    ? Future.value(_account(savedLanguage))
                    : initialAccount.future,
              ),
              cacheSizeProvider.overrideWith((_) async => 0),
              passkeyProvider.overrideWithBuild((_, _) async => null),
            ],
          );
          addTearDown(container.dispose);
          final subscription = container.listen(accountProvider, (_, _) {});
          addTearDown(subscription.close);
          if (cached) {
            initialAccount.complete(_account(language));
            await container.read(accountProvider.future);
          }
          container
              .read(appLocaleProvider.notifier)
              .setLanguage(language == 'en' ? 'zh-CN' : 'en');

          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: const _LocalizedSettingsApp(),
            ),
          );
          if (!cached) initialAccount.complete(_account(language));
          await tester.pumpAndSettle();

          final english = language == 'en';
          expect(find.text(english ? 'Settings' : '设置'), findsOneWidget);
          expect(find.text(english ? 'English' : '简体中文'), findsOneWidget);
          expect(
            container.read(appLocaleProvider),
            localeFromLanguageCode(language),
          );
          await tester.tap(find.text(english ? 'Language' : '语言'));
          await tester.pumpAndSettle();
          expect(
            find.descendant(
              of: find.byKey(ValueKey('language-option-$language')),
              matching: find.byIcon(Icons.check),
            ),
            findsOneWidget,
          );
          Navigator.of(
            tester.element(find.byKey(ValueKey('language-option-$language'))),
          ).pop();
          await tester.pumpAndSettle();

          savedLanguage = english ? 'zh-CN' : 'en';
          container.invalidate(accountProvider);
          await tester.pumpAndSettle();
          expect(find.text(english ? '设置' : 'Settings'), findsOneWidget);
          expect(find.text(english ? '简体中文' : 'English'), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }
}

UserAccount _account(String language) => UserAccount(
  userId: 'test-user',
  settings: UserPreferences(
    language: language,
    pushEnabled: false,
    notifyOrderFilled: false,
    notifyOrderFailed: false,
    notifyLiquidationWarning: false,
  ),
);

class _LocalizedSettingsApp extends ConsumerWidget {
  const _LocalizedSettingsApp();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(accountLocaleSyncProvider);
    return MaterialApp(
      theme: AppTheme.light,
      locale: ref.watch(appLocaleProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SettingsScreen(),
    );
  }
}
