import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/activity_repository_impl.dart';
import 'package:rwa_interface/data/services/activity_service.dart';
import 'package:rwa_interface/domain/models/activity_record.dart';

void main() {
  for (final entry in <String?, ActivityBusinessType?>{
    'opening': ActivityBusinessType.opening,
    'closing': ActivityBusinessType.closing,
    'take_profit': ActivityBusinessType.takeProfit,
    'stop_loss': ActivityBusinessType.stopLoss,
    'unknown': ActivityBusinessType.unknown,
    null: null,
  }.entries) {
    test(
      'preserves explicit HIP3 business type ${entry.key}, separate from limit type',
      () async {
        final source = api.standardSerializers.deserializeWith(
          api.ActivityRecord.serializer,
          {
            'id': 'hip3-activity',
            'category': 'orders',
            'type': 'limit',
            'status': 'success',
            'title': 'Order filled',
            'context': 'Long TSLA',
            'created_at': '2026-09-10T00:00:00Z',
            'updated_at': '2026-09-10T00:00:00Z',
            if (entry.key != null) 'business_type': entry.key,
          },
        )!;
        final record = (await ActivityRepositoryImpl(
          _ActivityRecordService(source),
        ).list()).items.single;
        expect(record.businessType, entry.value);
        expect(record.type, 'limit');
        expect(record.context, 'Long TSLA');
        expect(record.status, ActivityState.success);
      },
    );
  }
  test('maps activity amount with asset and resource reference', () async {
    final record = (await ActivityRepositoryImpl(
      _Activity(),
    ).list()).items.single;
    expect(record.amount?.value, '0.000000000000000001');
    expect(record.amount?.asset, 'USDC');
    expect(record.reference?.id, 'order-1');
  });
}

class _ActivityRecordService implements ActivityService {
  _ActivityRecordService(this.record);
  final api.ActivityRecord record;
  @override
  Future<api.ActivityPage> list({
    api.ActivityCategory? category,
    api.ActivityStatus? status,
    String? cursor,
  }) async => api.ActivityPage(
    (page) => page
      ..hasMore = false
      ..items.add(record),
  );
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
