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
