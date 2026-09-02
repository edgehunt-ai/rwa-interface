import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for ActivityApi
void main() {
  final instance = RwaApiClient().getActivityApi();

  group(ActivityApi, () {
    // 交易与资金活动列表
    //
    //Future<ListActivity200Response> listActivity({ ActivityCategory category, ActivityStatus status, String cursor, int limit }) async
    test('test listActivity', () async {
      // TODO
    });

  });
}
