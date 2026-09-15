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

void _cacheActivityList(Ref ref) {
  final link = ref.keepAlive();
  final timer = Timer(activityListCacheDuration, link.close);
  ref.onDispose(timer.cancel);
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
