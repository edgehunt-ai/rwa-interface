import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app.dart';
import 'package:rwa_interface/app/routing/app_router.dart';

void main() {
  testWidgets('secondary route exposes standard back navigation', (
    tester,
  ) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    await tester.pumpWidget(OrbitApp(router: router));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Open details'));
    await tester.pumpAndSettle();
    expect(find.byType(BackButton), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.text('Orbit foundation'), findsOneWidget);
  });
}
