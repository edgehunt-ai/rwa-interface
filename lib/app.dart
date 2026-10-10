import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/push_notification_providers.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/motion/launch_animation.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/positions/views/hip3_confirmation_host.dart';

class AppRoot extends StatelessWidget {
  AppRoot({super.key, GoRouter? router})
    : router = router ?? AppRouter.create();

  final GoRouter router;

  @override
  Widget build(BuildContext context) =>
      ProviderScope(child: _AppView(router: router));
}

final class _AppView extends ConsumerStatefulWidget {
  const _AppView({required this.router});

  final GoRouter router;

  @override
  ConsumerState<_AppView> createState() => _AppViewState();
}

final class _AppViewState extends ConsumerState<_AppView> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(
      () => ref.read(authenticationProvider.notifier).bootstrap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch<Locale?>(appLocaleProvider);
    final authentication = ref.watch(authenticationProvider);
    final appReady = authentication is! AuthenticationInitializing;
    ref.listen<AsyncValue<String>>(pushNotificationRouteProvider, (_, next) {
      next.whenData((route) => widget.router.go(route));
    });
    // Authentication restoration runs in the background. Public screens must
    // remain available when there is no cached identity or it has expired.
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.light,
      routerConfig: widget.router,
      builder: (context, child) => LaunchAnimationGate(
        ready: appReady,
        child: Hip3ConfirmationHost(child: child ?? const SizedBox.shrink()),
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
