import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

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
