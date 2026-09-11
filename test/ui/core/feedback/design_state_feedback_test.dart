import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/feedback/design_state_feedback.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('shows recoverable failure feedback', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        DesignStateFeedback(
          state: DesignState.failure,
          title: 'Markets unavailable',
          message: 'Try again.',
          onRetry: () {},
        ),
      ),
    );

    expect(find.text('Markets unavailable'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('uses a skeleton for loading', (tester) async {
    await tester.pumpWidget(
      buildTestApp(
        const DesignStateFeedback(
          state: DesignState.loading,
          title: 'Loading markets',
        ),
      ),
    );

    expect(find.byType(DesignStateFeedback), findsOneWidget);
    expect(find.byType(SkeletonBlock), findsNWidgets(20));
  });

  testWidgets('does not add a title placeholder unless requested', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(const LoadingSkeleton(rows: 1, showHeader: true)),
    );

    expect(find.byType(SkeletonBlock), findsNWidgets(5));
  });

  testWidgets('keeps the loading skeleton within a constrained height', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        const SizedBox(
          height: 180,
          child: DesignStateFeedback(
            state: DesignState.loading,
            title: 'Loading assets',
          ),
        ),
      ),
    );

    expect(tester.takeException(), isNull);
    expect(find.byType(SkeletonBlock), findsWidgets);
  });

  testWidgets('shows loading in the retry button while retrying', (
    tester,
  ) async {
    final retry = Completer<void>();
    await tester.pumpWidget(
      buildTestApp(
        DesignStateFeedback(
          state: DesignState.failure,
          title: 'Markets unavailable',
          onRetry: () => retry.future,
        ),
      ),
    );

    expect(find.byType(SkeletonBlock), findsNothing);
    await tester.tap(find.text('Retry'));
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text('Markets unavailable'), findsOneWidget);

    retry.complete();
    await tester.pump();
    expect(find.text('Markets unavailable'), findsOneWidget);
  });
}
