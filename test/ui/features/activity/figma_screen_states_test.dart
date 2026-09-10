import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/activity_record.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/repositories/activity_repository.dart';
import 'package:rwa_interface/ui/features/activity/views/activity_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  for (final entry in <ActivityBusinessType?, String?>{
    ActivityBusinessType.opening: 'Opening',
    ActivityBusinessType.closing: 'Closing',
    ActivityBusinessType.takeProfit: 'Take profit',
    ActivityBusinessType.stopLoss: 'Stop loss',
    ActivityBusinessType.unknown: 'Unclassified HIP3 order',
    null: null,
  }.entries) {
    testWidgets(
      'activity preserves server purpose ${entry.key} without inferring from side',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              activityRepositoryProvider.overrideWithValue(
                _Activity(entry.key),
              ),
            ],
            child: buildTestApp(const ActivityScreen()),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('Order event'), findsOneWidget);
        expect(find.textContaining('Long TSLA'), findsOneWidget);
        if (entry.value != null) {
          expect(find.textContaining(entry.value!), findsOneWidget);
        } else {
          expect(find.textContaining('Unclassified HIP3 order'), findsNothing);
          expect(find.textContaining('Opening'), findsNothing);
        }
        expect(tester.takeException(), isNull);
      },
    );
  }
  testWidgets('activity exposes its tabs and loading state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const ActivityScreen())),
    );

    expect(find.text('Activity'), findsWidgets);
    expect(find.text('Orders'), findsOneWidget);
  });

  testWidgets('activity remains usable at 200% text scale', (tester) async {
    await configureDisplay(tester, textScale: 2);
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const ActivityScreen())),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('Approvals'));
    await tester.tap(find.text('Approvals'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });
}

class _Activity implements ActivityRepository {
  _Activity(this.purpose);
  final ActivityBusinessType? purpose;
  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? cursor,
  }) async => DomainPage(
    items: [
      ActivityRecord(
        id: 'one',
        category: ActivityCategory.orders,
        type: 'limit',
        status: ActivityState.success,
        title: 'Order event',
        context: 'Long TSLA',
        businessType: purpose,
        createdAt: DateTime.now().toUtc(),
      ),
    ],
  );
}
