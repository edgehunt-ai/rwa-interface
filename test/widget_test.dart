import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/routing/app_router.dart';

import 'helpers/test_app.dart';

void main() {
  testWidgets('renders the application shell', (tester) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
