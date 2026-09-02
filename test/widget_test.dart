import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app.dart';

void main() {
  testWidgets('renders the application shell', (tester) async {
    await tester.pumpWidget(OrbitApp());

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
