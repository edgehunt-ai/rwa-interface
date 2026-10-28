import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late int exits;

  setUp(() {
    exits = 0;
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'SystemNavigator.pop') exits++;
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
    expect(exits, 1);

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
    expect(exits, 1);
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
