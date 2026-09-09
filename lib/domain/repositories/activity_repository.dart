import '../models/activity_record.dart';
import '../models/domain_page.dart';

abstract interface class ActivityRepository {
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? cursor,
  });
}
