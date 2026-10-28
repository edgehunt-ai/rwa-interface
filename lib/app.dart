import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/routing/app_back_button_dispatcher.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/locale_sync_provider.dart';
import 'package:nobell/app/providers/push_notification_providers.dart';
import 'package:nobell/app/providers/theme_mode_provider.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/motion/launch_animation.dart';
import 'package:nobell/ui/core/layout/foldable_adaptive_shell.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/positions/views/hip3_confirmation_host.dart';
import 'package:nobell/ui/core/feedback/error_message.dart';

class AppRoot extends StatelessWidget {
  AppRoot({super.key, GoRouter? router, this.initialThemeMode})
    : router = router ?? AppRouter.create();

  final GoRouter router;
  final ThemeMode? initialThemeMode;

  @override
  Widget build(BuildContext context) => ProviderScope(
    overrides: [
      if (initialThemeMode != null)
        initialThemeModeProvider.overrideWithValue(initialThemeMode),
    ],
    child: _AppView(router: router),
  );
}

final class _AppView extends ConsumerStatefulWidget {
  const _AppView({required this.router});

  final GoRouter router;

  @override
  ConsumerState<_AppView> createState() => _AppViewState();
}

final class _AppViewState extends ConsumerState<_AppView> {
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  late final _backButtonDispatcher = AppBackButtonDispatcher(
    () => widget.router,
  );

  @override
  void initState() {
    super.initState();
    Future<void>.microtask(
      () => ref.read(authenticationProvider.notifier).bootstrap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(accountLocaleSyncProvider);
    ref.listen<AsyncValue<void>>(accountLocaleSyncProvider, (_, next) {
      if (!next.hasError) return;
      final context = _messengerKey.currentContext;
      if (context == null) return;
      final l10n = AppLocalizations.of(context);
      _messengerKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(
            errorMessage(next.error!, fallback: l10n.settingsUnavailable),
          ),
          action: SnackBarAction(
            label: l10n.retry,
            onPressed: () => ref.invalidate(accountLocaleSyncProvider),
          ),
        ),
      );
    });
    final locale = ref.watch<Locale?>(appLocaleProvider);
    final themeMode = ref.watch(appThemeModeProvider);
    final authentication = ref.watch(authenticationProvider);
    final appReady = authentication is! AuthenticationInitializing;
    ref.listen<AuthenticationState>(authenticationProvider, (_, next) {
      if (next is! AuthenticationAuthenticated) {
        _messengerKey.currentState?.hideCurrentSnackBar();
      }
    });
    ref.listen<AsyncValue<String>>(pushNotificationRouteProvider, (_, next) {
      next.whenData((route) => widget.router.go(route));
    });
    // Authentication restoration runs in the background. Public screens must
    // remain available when there is no cached identity or it has expired.
    return MaterialApp.router(
      scaffoldMessengerKey: _messengerKey,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routeInformationProvider: widget.router.routeInformationProvider,
      routeInformationParser: widget.router.routeInformationParser,
      routerDelegate: widget.router.routerDelegate,
      backButtonDispatcher: _backButtonDispatcher,
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        // Keep the status bar legible as the appearance changes. Without a
        // theme-owned AppBar most screens would keep the platform default,
        // which is unreadable on the dark canvas.
        value:
            (Theme.of(context).brightness == Brightness.dark
                    ? SystemUiOverlayStyle.light
                    : SystemUiOverlayStyle.dark)
                .copyWith(
                  statusBarColor: Colors.transparent,
                  systemNavigationBarColor: Theme.of(context)
                      .scaffoldBackgroundColor,
                ),
        child: LaunchAnimationGate(
          ready: appReady,
          child: FoldableAdaptiveShell(
            child: Hip3ConfirmationHost(
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        ),
      ),
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
