import 'dart:ui' show DisplayFeature, DisplayFeatureState, DisplayFeatureType;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/ui/core/layout/foldable_adaptive_shell.dart';

void main() {
  testWidgets('centers wide content and uses the local viewport for overlays', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1800, 1200);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => FoldableAdaptiveShell(child: child!),
        home: Builder(
          builder: (context) {
            expect(MediaQuery.sizeOf(context), const Size(720, 1200));
            return const Scaffold(key: Key('content'));
          },
        ),
      ),
    );
    expect(tester.getSize(find.byKey(const Key('content'))).width, 720);
    expect(tester.getTopLeft(find.byKey(const Key('content'))).dx, 540);
  });

  for (final horizontal in [false, true]) {
    testWidgets('avoids ${horizontal ? 'horizontal fold' : 'vertical hinge'}', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(840, 900);
      addTearDown(tester.view.reset);
      final feature = DisplayFeature(
        bounds: horizontal
            ? const Rect.fromLTWH(0, 440, 840, 0)
            : const Rect.fromLTWH(410, 0, 20, 900),
        type: horizontal ? DisplayFeatureType.fold : DisplayFeatureType.hinge,
        state: DisplayFeatureState.postureHalfOpened,
      );
      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(displayFeatures: [feature]),
            child: FoldableAdaptiveShell(child: child!),
          ),
          home: const Scaffold(key: Key('content')),
        ),
      );
      final bounds = tester.getRect(find.byKey(const Key('content')));
      if (horizontal) {
        expect(bounds.bottom, 440);
      } else {
        expect(bounds.right, 410);
      }
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('keeps input and scroll position while folding and resizing', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(393, 852);
    addTearDown(tester.view.reset);
    final input = TextEditingController();
    final scroll = ScrollController();
    addTearDown(input.dispose);
    addTearDown(scroll.dispose);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => FoldableAdaptiveShell(child: child!),
        home: Scaffold(
          key: const Key('content'),
          body: SingleChildScrollView(
            controller: scroll,
            child: Column(
              children: [
                TextField(controller: input),
                const SizedBox(height: 3000),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), '123.45');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    scroll.jumpTo(200);
    await tester.pump();
    final originalElement = tester.element(find.byType(TextField));
    for (final size in [
      const Size(840, 900),
      const Size(320, 600),
      const Size(900, 400),
      const Size(393, 852),
    ]) {
      tester.view.physicalSize = size;
      await tester.pumpAndSettle();
      expect(input.text, '123.45');
      expect(scroll.offset, 200);
      expect(tester.element(find.byType(TextField)), same(originalElement));
      expect(
        tester.getSize(find.byKey(const Key('content'))).width,
        size.width.clamp(0, 720),
      );
      expect(tester.takeException(), isNull);
    }
  });
}
