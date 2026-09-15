import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/activity_record.dart';
import '../../../../domain/models/domain_page.dart';

typedef ActivityFilter = ({
  ActivityCategory? category,
  ActivityState? status,
  String? cursor,
});

const activityListCacheDuration = Duration(minutes: 30);
const activityListRefreshInterval = Duration(minutes: 1);

void _cacheActivityList(Ref ref) {
  final link = ref.keepAlive();
  Timer? expiryTimer;
  Timer? refreshTimer;

  void stopTimers() {
    refreshTimer?.cancel();
    expiryTimer?.cancel();
  }

  void startRefresh() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(
      activityListRefreshInterval,
      (_) => ref.invalidateSelf(),
    );
  }

  void startExpiry() {
    expiryTimer?.cancel();
    expiryTimer = Timer(activityListCacheDuration, link.close);
  }

  startExpiry();
  startRefresh();
  ref.onCancel(stopTimers);
  ref.onResume(() {
    startExpiry();
    startRefresh();
  });
  ref.onDispose(() {
    expiryTimer?.cancel();
    refreshTimer?.cancel();
  });
}

final activityProvider = FutureProvider.autoDispose
    .family<DomainPage<ActivityRecord>, ActivityFilter>((ref, filter) {
      _cacheActivityList(ref);
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(activityRepositoryProvider)
          .list(
            category: filter.category,
            status: filter.status,
            cursor: filter.cursor,
          );
    });
