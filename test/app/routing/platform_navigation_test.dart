import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/ui/features/home/views/home_screen.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('secondary route exposes standard back navigation', (
    tester,
  ) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    router.push('/details');
    await tester.pumpAndSettle();
    expect(find.byType(BackButton), findsOneWidget);

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}
