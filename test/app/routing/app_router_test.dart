import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/funding/views/withdrawal_screen.dart';
import 'package:rwa_interface/ui/features/home/views/home_screen.dart';
import 'package:rwa_interface/ui/features/orders/views/trade_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('opens a direct route and returns to root', (tester) async {
    final router = AppRouter.create(initialLocation: '/details');
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    expect(find.text('Navigation details'), findsOneWidget);
    router.go('/');
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('unknown route offers recovery to root', (tester) async {
    final router = AppRouter.create(initialLocation: '/unknown');
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    expect(find.text('Page not found'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Return home'));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('opens each Trade/Foundation route directly', (tester) async {
    final router = AppRouter.create(initialLocation: '/trade');
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();
    expect(find.byType(TradeScreen), findsOneWidget);

    router.go('/funding/deposit');
    await tester.pumpAndSettle();
    expect(find.byType(DepositScreen), findsOneWidget);

    router.go('/funding/withdraw');
    await tester.pumpAndSettle();
    expect(find.byType(WithdrawalScreen), findsOneWidget);
  });

  testWidgets('trade deep link selects a symbol and defaults an omitted kind', (
    tester,
  ) async {
    final router = AppRouter.create(initialLocation: '/trade?symbol=TSLA');
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    expect(find.byType(TradeScreen), findsOneWidget);
    expect(find.text('TSLA'), findsWidgets);
    expect(find.text('bStocks'), findsOneWidget);
  });

  testWidgets('trade deep link accepts an explicit perp kind', (tester) async {
    final router = AppRouter.create(
      initialLocation: '/trade?symbol=ETH&kind=perp',
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    expect(find.text('ETH'), findsWidgets);
    expect(find.widgetWithText(FilledButton, 'Long'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Short'), findsOneWidget);
  });

  testWidgets('returns from Trade to its invoking route', (tester) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    router.push('/trade');
    await tester.pumpAndSettle();
    expect(find.byType(TradeScreen), findsOneWidget);

    router.pop();
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('returns from funding routes to their invoking route', (
    tester,
  ) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    router.push('/funding/deposit');
    await tester.pumpAndSettle();
    expect(find.byType(DepositScreen), findsOneWidget);
    router.pop();
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);

    router.push('/funding/withdraw');
    await tester.pumpAndSettle();
    expect(find.byType(WithdrawalScreen), findsOneWidget);
    router.pop();
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
