import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/activity_record.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/repositories/activity_repository.dart';
import 'package:nobell/ui/features/activity/providers/activity_provider.dart';

void main() {
  test(
    'activity history preserves a status-filtered copyable reference',
    () async {
      final repository = _ActivityRepository();
      final container = ProviderContainer(
        overrides: [activityRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      const filter = (
        category: ActivityCategory.orders,
        status: ActivityState.success,
        type: null,
        productOrAsset: null,
        cursor: null,
      );
      final page = await container.read(activityProvider(filter).future);

      expect(repository.lastFilter, filter);
      expect(page.items.single.status, ActivityState.success);
      expect(page.items.single.reference?.id, 'order-1');
    },
  );
}

final class _ActivityRepository implements ActivityRepository {
  ActivityFilter? lastFilter;

  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? type,
    String? productOrAsset,
    String? cursor,
  }) async {
    lastFilter = (
      category: category,
      status: status,
      type: type,
      productOrAsset: productOrAsset,
      cursor: cursor,
    );
    return DomainPage(
      items: [
        ActivityRecord(
          id: 'activity-1',
          category: ActivityCategory.orders,
          type: 'limit',
          status: ActivityState.success,
          title: 'Filled NVDA',
          reference: const ActivityReference(type: 'order', id: 'order-1'),
          createdAt: DateTime.utc(2026),
        ),
      ],
    );
  }
}
