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
    expect(find.byType(SkeletonBlock), findsWidgets);
  });
}
