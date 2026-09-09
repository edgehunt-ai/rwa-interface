import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/application_state.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/unsupported_capability.dart';

void main() {
  group('QueryState', () {
    test('represents loading, empty, refresh, failure, and capability', () {
      const loading = QueryLoading<int>();
      const empty = QueryEmpty<int>();
      const data = QueryData(1, isRefreshing: true);
      const failure = QueryFailure<int>(NetworkFailure());
      const capability = QueryData(
        ResourceResult(
          resource: 'dep-1',
          capability: UnsupportedCapability.fundingTransfer(
            resourceId: 'dep-1',
          ),
        ),
      );
      expect(loading, isA<QueryLoading<int>>());
      expect(empty, isA<QueryEmpty<int>>());
      expect(data.isRefreshing, isTrue);
      expect(failure.failure.retryable, isTrue);
      expect(capability.value.capability?.userAction, 'wait_for_feature');
    });
  });

  group('CommandState', () {
    test('represents the complete command transition vocabulary', () {
      const idle = CommandIdle<String, String>();
      const submitting = CommandSubmitting<String, String>('intent', 'key-1');
      const accepted = CommandAccepted<String, String>(
        intent: 'intent',
        idempotencyKey: 'key-1',
        result: 'ord-1',
      );
      const failure = CommandFailure<String, String>(
        intent: 'intent',
        idempotencyKey: 'key-1',
        failure: NetworkFailure(),
      );
      expect(idle, isA<CommandIdle<String, String>>());
      expect(submitting.idempotencyKey, 'key-1');
      expect(accepted.result, 'ord-1');
      expect(failure.failure, isA<NetworkFailure>());
    });
  });
}
