import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/feedback/app_feedback_state.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('error state invokes recovery action', (tester) async {
    var retried = false;
    await tester.pumpWidget(
      buildTestApp(
        AppFeedbackState.error(
          title: 'Unavailable',
          message: 'Try again later',
          actionLabel: 'Retry',
          onAction: () => retried = true,
        ),
      ),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Retry'));
    expect(retried, isTrue);
  });

  testWidgets('state without callback has no inactive action', (tester) async {
    await tester.pumpWidget(
      buildTestApp(const AppFeedbackState.empty(title: 'No items')),
    );
    expect(find.byType(FilledButton), findsNothing);
  });
}
