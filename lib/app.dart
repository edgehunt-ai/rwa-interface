import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/app/providers/locale_provider.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/app/providers/push_notification_providers.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_confirmation_host.dart';

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
  late final AppLifecycleListener _hip3Lifecycle;

  @override
  void initState() {
    super.initState();
    _hip3Lifecycle = AppLifecycleListener(
      onStateChange: (state) => ref
          .read(hip3ForegroundProvider.notifier)
          .setForeground(state == AppLifecycleState.resumed),
    );
    Future<void>.microtask(() async {
      if (!mounted) return;
      final lifecycle = WidgetsBinding.instance.lifecycleState;
      ref
          .read(hip3ForegroundProvider.notifier)
          .setForeground(
            lifecycle == null || lifecycle == AppLifecycleState.resumed,
          );
      await ref.read(authenticationProvider.notifier).bootstrap();
    });
  }

  @override
  void dispose() {
    _hip3Lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = ref.watch<Locale?>(appLocaleProvider);
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
      builder: (context, child) =>
          Hip3ConfirmationHost(child: child ?? const SizedBox.shrink()),
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
