import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/provider_lifecycle.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/activity_record.dart';
import '../../../../domain/models/domain_page.dart';

typedef ActivityFilter = ({
  ActivityCategory? category,
  ActivityState? status,
  String? type,
  String? productOrAsset,
  String? cursor,
});

const activityListCacheDuration = Duration(minutes: 30);
const activityListRefreshInterval = Duration(minutes: 1);

void _cacheActivityList(Ref ref) {
  cacheAfterLastListener(ref, activityListCacheDuration);
}

final activityListRefreshProvider = Provider.autoDispose<void>((ref) {
  refreshWhileActive(
    ref,
    interval: activityListRefreshInterval,
    refresh: () => ref.invalidate(activityProvider),
  );
});

final activityProvider = FutureProvider.autoDispose
    .family<DomainPage<ActivityRecord>, ActivityFilter>((ref, filter) {
      _cacheActivityList(ref);
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(activityRepositoryProvider)
          .list(
            category: filter.category,
            status: filter.status,
            type: filter.type,
            productOrAsset: filter.productOrAsset,
            cursor: filter.cursor,
          );
    });

/// The contract exposes activity pages only; resolve a stable record ID across
/// all pages independently of the list screen's active filters.
final activityDetailProvider = FutureProvider.autoDispose
    .family<ActivityRecord?, String>((ref, id) async {
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(activityRepositoryProvider);
      String? cursor;
      final visited = <String>{};
      do {
        final page = await repository.list(cursor: cursor);
        if (!ref.mounted) return null;
        for (final record in page.items) {
          if (record.id == id) return record;
        }
        cursor = page.nextCursor;
        if (!page.hasMore || cursor == null || !visited.add(cursor)) {
          return null;
        }
      } while (true);
    });
