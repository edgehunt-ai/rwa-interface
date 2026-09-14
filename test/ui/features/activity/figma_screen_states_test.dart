import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/ui/features/activity/views/activity_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('activity exposes its tabs and loading state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const ActivityScreen())),
    );
    await tester.pumpAndSettle();

    expect(find.text('Activity'), findsWidgets);
    expect(find.text('Orders'), findsOneWidget);
  });

  testWidgets('activity remains usable at 200% text scale', (tester) async {
    await configureDisplay(tester, textScale: 2);
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const ActivityScreen())),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Funding'));
    await tester.tap(find.text('Funding'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}
