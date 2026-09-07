import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

class AppRoot extends StatelessWidget {
  AppRoot({super.key, GoRouter? router})
    : router = router ?? AppRouter.create();

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: _AppView(router: router));
  }
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
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: widget.router,
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
