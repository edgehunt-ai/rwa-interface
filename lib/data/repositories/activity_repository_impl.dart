import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/activity_record.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/repositories/activity_repository.dart';
import '../services/activity_service.dart';

final class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl(this._service);
  final ActivityService _service;
  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? cursor,
  }) async {
    final page = await _service.list(
      category: _category(category),
      status: _status(status),
      cursor: cursor,
    );
    return DomainPage(
      items: page.items.map(_map).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  ActivityRecord _map(api.ActivityRecord value) => ActivityRecord(
    id: value.id,
    category: switch (value.category) {
      api.ActivityCategory.orders => ActivityCategory.orders,
      api.ActivityCategory.funds => ActivityCategory.funds,
      api.ActivityCategory.signatures => ActivityCategory.signatures,
      _ => ActivityCategory.unknown,
    },
    type: value.type.name,
    businessType: switch (value.businessType) {
      api.ActivityRecordBusinessTypeEnum.opening =>
        ActivityBusinessType.opening,
      api.ActivityRecordBusinessTypeEnum.closing =>
        ActivityBusinessType.closing,
      api.ActivityRecordBusinessTypeEnum.takeProfit =>
        ActivityBusinessType.takeProfit,
      api.ActivityRecordBusinessTypeEnum.stopLoss =>
        ActivityBusinessType.stopLoss,
      null => null,
      _ => ActivityBusinessType.unknown,
    },
    status: switch (value.status) {
      api.ActivityStatus.pending => ActivityState.pending,
      api.ActivityStatus.success => ActivityState.success,
      api.ActivityStatus.failed => ActivityState.failed,
      api.ActivityStatus.cancelled => ActivityState.cancelled,
      _ => ActivityState.unknown,
    },
    title: value.title,
    amount: value.amount == null
        ? null
        : DecimalValue(value.amount!, asset: value.asset, unit: 'activity'),
    context: value.context,
    reference: switch (value.reference) {
      final reference? => ActivityReference(
        type: reference.type.name,
        id: reference.id,
      ),
      null => null,
    },
    createdAt: value.createdAt.toUtc(),
    updatedAt: value.updatedAt.toUtc(),
  );
  api.ActivityCategory? _category(ActivityCategory? value) => switch (value) {
    ActivityCategory.orders => api.ActivityCategory.orders,
    ActivityCategory.funds => api.ActivityCategory.funds,
    ActivityCategory.signatures => api.ActivityCategory.signatures,
    _ => null,
  };
  api.ActivityStatus? _status(ActivityState? value) => switch (value) {
    ActivityState.pending => api.ActivityStatus.pending,
    ActivityState.success => api.ActivityStatus.success,
    ActivityState.failed => api.ActivityStatus.failed,
    ActivityState.cancelled => api.ActivityStatus.cancelled,
    _ => null,
  };
}
