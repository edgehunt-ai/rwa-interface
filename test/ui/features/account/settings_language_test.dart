import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/locale_sync_provider.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/domain/repositories/account_repository.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';
import 'package:nobell/ui/features/account/providers/cache_providers.dart';
import 'package:nobell/ui/features/account/views/settings_screen.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final language in ['en', 'zh-CN']) {
    testWidgets('language confirmation waits for saving from $language', (
      tester,
    ) async {
      final repository = _LanguageRepository(language);
      final container = _container(repository);
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const _LocalizedSettingsApp(),
        ),
      );
      await tester.pumpAndSettle();
      final target = language == 'en' ? 'zh-CN' : 'en';
      await tester.tap(find.text(language == 'en' ? 'Language' : '语言'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(ValueKey('language-option-$target')));
      await tester.tap(find.byKey(const Key('settings-language-confirm')));
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));

      final confirm = find.byKey(const Key('settings-language-confirm'));
      expect(confirm, findsOneWidget);
      expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
      expect(
        find.descendant(
          of: confirm,
          matching: find.byType(CircularProgressIndicator),
        ),
        findsOneWidget,
      );
      expect(
        container.read(appLocaleProvider),
        localeFromLanguageCode(language),
      );
      await tester.tap(confirm);
      await tester.tap(find.byKey(ValueKey('language-option-$language')));
      await tester.tapAt(const Offset(10, 10));
      await tester.binding.handlePopRoute();
      await tester.pump();
      expect(confirm, findsOneWidget);
      expect(repository.updates, [target]);
      expect(
        find.descendant(
          of: find.byKey(ValueKey('language-option-$target')),
          matching: find.byIcon(Icons.check),
        ),
        findsOneWidget,
      );

      repository.pending.complete();
      await tester.pumpAndSettle();
      expect(confirm, findsNothing);
      expect(container.read(appLocaleProvider), localeFromLanguageCode(target));
      expect(find.text(target == 'en' ? 'Settings' : '设置'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('language save failure preserves its reason and supports retry', (
    tester,
  ) async {
    final repository = _LanguageRepository('en');
    final container = _container(repository);
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _LocalizedSettingsApp(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('language-option-zh-CN')));
    final confirm = find.byKey(const Key('settings-language-confirm'));
    await tester.tap(confirm);
    await tester.pump();
    repository.pending.completeError(
      const ServerFailure(
        statusCode: 503,
        code: 'PREFERENCES_UNAVAILABLE',
        message: 'Language preferences are temporarily unavailable.',
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Language preferences are temporarily unavailable.'),
      findsOneWidget,
    );
    expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);
    expect(container.read(appLocaleProvider), const Locale('en'));
    expect(
      find.descendant(
        of: find.byKey(const ValueKey('language-option-zh-CN')),
        matching: find.byIcon(Icons.check),
      ),
      findsOneWidget,
    );

    repository.pending = Completer<void>();
    await tester.tap(confirm);
    await tester.pump();
    expect(
      find.text('Language preferences are temporarily unavailable.'),
      findsNothing,
    );
    repository.pending.complete();
    await tester.pumpAndSettle();
    expect(repository.updates, ['zh-CN', 'zh-CN']);
    expect(confirm, findsNothing);
    expect(find.text('设置'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

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

ProviderContainer _container(_LanguageRepository repository) =>
    ProviderContainer(
      overrides: [
        authenticatedStateOverride,
        accountRepositoryProvider.overrideWithValue(repository),
        cacheSizeProvider.overrideWith((_) async => 0),
        passkeyProvider.overrideWithBuild((_, _) async => null),
      ],
    );

class _LanguageRepository implements AccountRepository {
  _LanguageRepository(this.language);

  String language;
  var pending = Completer<void>();
  final updates = <String>[];

  @override
  Future<UserAccount> getAccount() async => _account(language);

  @override
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch) async {
    updates.add(patch.language!);
    await pending.future;
    language = patch.language!;
    return _account(language).settings;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
