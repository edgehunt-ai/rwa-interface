import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late int exits;
  bool? frameworkHandlesBack;

  setUp(() {
    exits = 0;
    frameworkHandlesBack = null;
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'SystemNavigator.pop') exits++;
          if (call.method == 'SystemNavigator.setFrameworkHandlesBack') {
            frameworkHandlesBack = call.arguments as bool;
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });

  Future<void> mount(WidgetTester tester, GoRouter router) async {
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: AppRoot(router: router)));
    await tester.pump();
  }

  List<RouteBase> routes({ExitCallback? onExit}) => [
    GoRoute(
      path: '/',
      builder: (_, _) => const Scaffold(body: Text('Home')),
      routes: [
        GoRoute(
          path: 'details',
          onExit: onExit,
          builder: (_, _) => const Scaffold(body: Text('Details')),
        ),
      ],
    ),
  ];

  testWidgets('Android back stays in Flutter for secondary roots and dialogs', (
    tester,
  ) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final router = GoRouter(
      routes: [
        ...routes(),
        GoRoute(
          path: AppRoutes.marketsPath,
          builder: (_, _) => const Scaffold(body: Text('Markets')),
        ),
      ],
    );
    await mount(tester, router);
    await tester.pumpAndSettle();
    expect(frameworkHandlesBack, isFalse);

    router.go(AppRoutes.marketsPath);
    await tester.pumpAndSettle();
    expect(frameworkHandlesBack, isTrue);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(frameworkHandlesBack, isFalse);

    unawaited(
      showDialog<void>(
        context: tester.element(find.text('Home')),
        builder: (_) => const AlertDialog(content: Text('Dialog')),
      ),
    );
    await tester.pumpAndSettle();
    expect(frameworkHandlesBack, isTrue);
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Dialog'), findsNothing);
    expect(frameworkHandlesBack, isFalse);
    expect(exits, 0);
  });

  for (final (location, destination) in [
    (AppRoutes.marketsPath, AppRoutes.homePath),
    (AppRoutes.assetsPath, AppRoutes.homePath),
    (AppRoutes.activityPath, AppRoutes.homePath),
    (AppRoutes.settingsPath, AppRoutes.homePath),
    (AppRoutes.marketSearchPath, AppRoutes.marketsPath),
    ('/trade?symbol=NVDAB&kind=bstock', AppRoutes.marketsPath),
    ('/trade?symbol=NVDA&kind=perp', AppRoutes.marketsPath),
    ('/activity/missing', AppRoutes.activityPath),
  ]) {
    testWidgets('system back from $location navigates to $destination', (
      tester,
    ) async {
      final router = AppRouter.create();
      await mount(tester, router);
      await tester.pumpAndSettle();
      router.go(location);
      await tester.pumpAndSettle();
      expect(router.canPop(), isFalse);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(router.routeInformationProvider.value.uri.path, destination);
      expect(exits, 0);
      expect(tester.takeException(), isNull);
    });
  }

  for (final blocked in [false, true]) {
    testWidgets('root bottom sheet handles back with canPop=${!blocked}', (
      tester,
    ) async {
      final router = GoRouter(
        initialLocation: AppRoutes.marketsPath,
        routes: [
          ...routes(),
          GoRoute(
            path: AppRoutes.marketsPath,
            builder: (_, _) => const Scaffold(body: Text('Markets')),
          ),
        ],
      );
      await mount(tester, router);
      await tester.pumpAndSettle();
      unawaited(
        showModalBottomSheet<void>(
          context: tester.element(find.text('Markets')),
          builder: (_) =>
              PopScope(canPop: !blocked, child: const Text('Order sheet')),
        ),
      );
      await tester.pumpAndSettle();

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(find.text('Order sheet'), blocked ? findsOneWidget : findsNothing);
      expect(
        router.routeInformationProvider.value.uri.path,
        AppRoutes.marketsPath,
      );
      expect(exits, 0);
      expect(tester.takeException(), isNull);
    });
  }

  for (final kind in ['bstock', 'perp']) {
    testWidgets(
      'cancelling $kind order login returns to trade without exiting',
      (tester) async {
        final router = AppRouter.create(
          initialLocation: '/trade?symbol=NVDA&kind=$kind',
        );
        await mount(tester, router);
        await tester.pumpAndSettle();
        await tester.tap(
          find.widgetWithText(FilledButton, kind == 'bstock' ? 'Buy' : 'Long'),
        );
        await tester.pumpAndSettle();
        expect(find.byType(PrivyLoginScreen), findsOneWidget);

        await tester.binding.handlePopRoute();
        await tester.pumpAndSettle();
        expect(find.byType(PrivyLoginScreen), findsNothing);
        expect(find.byType(TradeScreen), findsOneWidget);
        expect(
          router.routeInformationProvider.value.uri.path,
          AppRoutes.tradePath,
        );
        expect(exits, 0);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('root PopScope blocks fallback navigation', (tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.marketsPath,
      routes: [
        ...routes(),
        GoRoute(
          path: AppRoutes.marketsPath,
          builder: (_, _) => const PopScope(
            canPop: false,
            child: Scaffold(body: Text('Markets')),
          ),
        ),
      ],
    );
    await mount(tester, router);
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoutes.marketsPath,
    );
    expect(exits, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('root onExit guard blocks fallback navigation', (tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.marketsPath,
      routes: [
        ...routes(),
        GoRoute(
          path: AppRoutes.marketsPath,
          onExit: (_, _) => false,
          builder: (_, _) => const Scaffold(body: Text('Markets')),
        ),
      ],
    );
    await mount(tester, router);
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoutes.marketsPath,
    );
    expect(exits, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('system back before initial redirect completes does not crash', (
    tester,
  ) async {
    final redirect = Completer<void>();
    final router = GoRouter(
      routes: routes(),
      redirect: (_, _) async {
        await redirect.future;
        return null;
      },
    );
    await mount(tester, router);
    expect(router.routerDelegate.currentConfiguration.isEmpty, isTrue);

    await tester.binding.handlePopRoute();
    expect(tester.takeException(), isNull);
    expect(exits, 0);

    redirect.complete();
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('system back from an unmatched route does not crash', (
    tester,
  ) async {
    final router = GoRouter(
      routes: routes(),
      initialLocation: '/missing',
      errorBuilder: (_, _) => const Scaffold(body: Text('Page not found')),
    );
    await mount(tester, router);
    await tester.pumpAndSettle();
    expect(find.text('Page not found'), findsOneWidget);
    expect(router.routerDelegate.currentConfiguration.isEmpty, isTrue);

    await tester.binding.handlePopRoute();
    expect(exits, 0);
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('system back pops a normal page and exits only at the root', (
    tester,
  ) async {
    final router = GoRouter(routes: routes());
    await mount(tester, router);
    await tester.pumpAndSettle();
    unawaited(router.push('/details'));
    await tester.pumpAndSettle();
    expect(find.text('Details'), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
    expect(exits, 0);
    await tester.binding.handlePopRoute();
    expect(exits, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty error configuration still dismisses a dialog first', (
    tester,
  ) async {
    final router = GoRouter(
      routes: routes(),
      initialLocation: '/missing',
      errorBuilder: (_, _) => const Scaffold(body: Text('Page not found')),
    );
    await mount(tester, router);
    await tester.pumpAndSettle();
    unawaited(
      showDialog<void>(
        context: tester.element(find.text('Page not found')),
        builder: (_) => const AlertDialog(content: Text('Retry later')),
      ),
    );
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Retry later'), findsNothing);
    expect(find.text('Page not found'), findsOneWidget);
    expect(exits, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('ready routes retain their onExit protection', (tester) async {
    final router = GoRouter(routes: routes(onExit: (_, _) => false));
    await mount(tester, router);
    await tester.pumpAndSettle();
    unawaited(router.push('/details'));
    await tester.pumpAndSettle();

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.text('Details'), findsOneWidget);
    expect(exits, 0);
    expect(tester.takeException(), isNull);
  });
}
