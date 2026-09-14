import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/activity_repository_impl.dart';
import 'package:rwa_interface/data/services/activity_service.dart';

void main() {
  test('maps activity amount with asset and resource reference', () async {
    final record = (await ActivityRepositoryImpl(
      _Activity(),
    ).list()).items.single;
    expect(record.amount?.value, '0.000000000000000001');
    expect(record.amount?.asset, 'USDC');
    expect(record.reference?.id, 'order-1');
    expect(record.chain, 'BSC');
    expect(record.txHash, '0xtx');
    expect(record.fields.single.label, 'Network Fee');
    expect(record.fields.single.value, 'Free');
  });
}

final class _Activity implements ActivityService {
  @override
  Future<api.ActivityPage> list({
    api.ActivityCategory? category,
    api.ActivityStatus? status,
    String? cursor,
  }) async => api.ActivityPage(
    (page) => page
      ..hasMore = false
      ..items.add(
        api.ActivityRecord(
          (record) => record
            ..id = 'activity-1'
            ..category = api.ActivityCategory.orders
            ..type = api.ActivityType.market
            ..status = api.ActivityStatus.success
            ..title = 'Filled'
            ..amount = '0.000000000000000001'
            ..asset = 'USDC'
            ..chain = api.ActivityRecordChainEnum.BSC
            ..txHash = '0xtx'
            ..fields.add(
              api.KeyValue(
                (field) => field
                  ..label = 'Network Fee'
                  ..value = 'Free',
              ),
            )
            ..createdAt = DateTime.utc(2026)
            ..updatedAt = DateTime.utc(2026)
            ..reference.update(
              (reference) => reference
                ..type = api.ActivityRecordReferenceTypeEnum.order
                ..id = 'order-1',
            ),
        ),
      ),
  );
}
