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

final activityProvider = FutureProvider.autoDispose
    .family<DomainPage<ActivityRecord>, ActivityFilter>((ref, filter) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(activityRepositoryProvider)
          .list(
            category: filter.category,
            status: filter.status,
            cursor: filter.cursor,
          );
    });
