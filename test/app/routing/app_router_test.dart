import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app.dart';
import 'package:rwa_interface/app/routing/app_router.dart';

void main() {
  testWidgets('opens a direct route and returns to root', (tester) async {
    final router = AppRouter.create(initialLocation: '/details');
    addTearDown(router.dispose);
    await tester.pumpWidget(OrbitApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Navigation details'), findsOneWidget);
    router.go('/');
    await tester.pumpAndSettle();
    expect(find.text('Orbit foundation'), findsOneWidget);
  });

  testWidgets('unknown route offers recovery to root', (tester) async {
    final router = AppRouter.create(initialLocation: '/unknown');
    addTearDown(router.dispose);
    await tester.pumpWidget(OrbitApp(router: router));
    await tester.pumpAndSettle();

    expect(find.text('Page not found'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Return home'));
    await tester.pumpAndSettle();
    expect(find.text('Orbit foundation'), findsOneWidget);
  });
}
