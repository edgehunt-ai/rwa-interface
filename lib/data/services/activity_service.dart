import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class ActivityService {
  Future<api.ActivityPage> list({
    api.ActivityCategory? category,
    api.ActivityStatus? status,
    String? cursor,
  });
}
