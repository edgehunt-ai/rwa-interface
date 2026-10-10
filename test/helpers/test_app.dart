import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/product_session.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';

Widget buildTestApp(
  Widget child, {
  TargetPlatform platform = TargetPlatform.android,
  ThemeMode themeMode = ThemeMode.light,
  Locale? locale,
}) {
  return MaterialApp(
    theme: AppTheme.light.copyWith(platform: platform),
    darkTheme: AppTheme.dark.copyWith(platform: platform),
    themeMode: themeMode,
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

Widget buildRouterTestApp(
  GoRouter router, {
  TargetPlatform platform = TargetPlatform.android,
  ThemeMode themeMode = ThemeMode.light,
}) {
  return MaterialApp.router(
    theme: AppTheme.light.copyWith(platform: platform),
    darkTheme: AppTheme.dark.copyWith(platform: platform),
    themeMode: themeMode,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    routerConfig: router,
  );
}

final authenticatedStateOverride = authenticationProvider.overrideWithBuild(
  (notifier, ref) => AuthenticationAuthenticated(
    ProductSession(
      sessionId: 'test-session',
      createdAt: DateTime.utc(2026),
      expiresAt: DateTime.utc(2030),
      generation: 1,
      accountCreated: true,
      account: UserAccount(
        userId: 'test-user',
        settings: UserPreferences(
          language: 'en',
          pushEnabled: false,
          notifyOrderFilled: true,
          notifyOrderFailed: true,
          notifyLiquidationWarning: true,
        ),
      ),
    ),
    principal: const IdentityPrincipal('test-user'),
  ),
);
