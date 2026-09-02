import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/core/feedback/app_feedback_state.dart';

import '../../helpers/display_config.dart';
import '../../helpers/test_app.dart';

void main() {
  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    testWidgets('long feedback remains usable at 200% in $mode', (
      tester,
    ) async {
      await configureDisplay(tester, textScale: 2);
      var retried = false;
      await tester.pumpWidget(
        buildTestApp(
          AppFeedbackState.error(
            title: 'A long localized error title that explains the problem clearly',
            message: List.filled(
              8,
              'Detailed recovery guidance for the user.',
            ).join(' '),
            actionLabel: 'Try again',
            onAction: () => retried = true,
          ),
          themeMode: mode,
        ),
      );

      expect(tester.takeException(), isNull);
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Try again'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Try again'));
      expect(retried, isTrue);
    });
  }
}
