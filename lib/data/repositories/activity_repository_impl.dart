import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/activity_record.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/repositories/activity_repository.dart';
import '../services/activity_service.dart';
import '../mappers/chain_name_mapper.dart';

final class ActivityRepositoryImpl implements ActivityRepository {
  ActivityRepositoryImpl(this._service);
  final ActivityService _service;
  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? type,
    String? productOrAsset,
    String? cursor,
  }) async {
    final page = await _service.list(
      category: _category(category),
      status: _status(status),
      type: _type(type),
      productOrAsset: productOrAsset,
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
      api.ActivityCategory.cash => ActivityCategory.cash,
      api.ActivityCategory.funding => ActivityCategory.funding,
      _ => ActivityCategory.unknown,
    },
    type: _activityType(value.type),
    status: switch (value.status) {
      api.ActivityStatus.pending => ActivityState.pending,
      api.ActivityStatus.success => ActivityState.success,
      api.ActivityStatus.failed => ActivityState.failed,
      api.ActivityStatus.cancelled => ActivityState.cancelled,
      _ => ActivityState.unknown,
    },
    title: value.title,
    businessType: _businessType(value.businessType),
    rawStatus: _activityStatus(value.status),
    amount: value.amount == null
        ? null
        : DecimalValue(value.amount!, asset: value.asset, unit: 'activity'),
    context: value.context,
    failureReason: value.failureReason,
    reference: switch (value.reference) {
      final reference? => ActivityReference(
        type: _referenceType(reference.type),
        id: reference.id,
      ),
      null => null,
    },
    fields:
        value.fields
            ?.map(
              (field) => ActivityField(
                label: field.label,
                value: field.value,
                tone: field.tone?.name,
              ),
            )
            .toList() ??
        const [],
    relatedId: value.relatedId,
    selfCustodialWithdrawalId: value.selfCustodialWithdrawalId,
    continuation: value.continuation == null
        ? null
        : ActivityContinuation(
            action: _continuationAction(value.continuation!.action),
            actionId: value.continuation!.actionId,
            step: _continuationStep(value.continuation!.step),
            requiresNewBusinessObject:
                value.continuation!.requiresNewBusinessObject,
          ),
    chain: value.chain == null ? null : canonicalChainName(value.chain!.name),
    txHash: value.txHash,
    explorer: value.explorer == null
        ? null
        : ActivityExplorer(
            name: value.explorer!.name,
            url: value.explorer!.url,
          ),
    asset: value.asset,
    symbol: value.symbol,
    kind: value.kind?.name,
    createdAt: value.createdAt.toUtc(),
    updatedAt: value.updatedAt.toUtc(),
  );

  String _activityType(api.ActivityType value) => switch (value) {
    api.ActivityType.market => 'market',
    api.ActivityType.limit => 'limit',
    api.ActivityType.tpsl => 'tpsl',
    api.ActivityType.close => 'close',
    api.ActivityType.liquidation => 'liquidation',
    api.ActivityType.deposit => 'deposit',
    api.ActivityType.external_ => 'external',
    api.ActivityType.bridge => 'bridge',
    api.ActivityType.withdraw => 'withdraw',
    api.ActivityType.claim => 'claim',
    api.ActivityType.funding => 'funding',
    api.ActivityType.approval => 'approval',
    api.ActivityType.orderSign => 'orderSign',
    api.ActivityType.bridgeSign => 'bridgeSign',
    _ => value.name,
  };

  String _activityStatus(api.ActivityStatus value) => switch (value) {
    api.ActivityStatus.pending => 'pending',
    api.ActivityStatus.success => 'success',
    api.ActivityStatus.failed => 'failed',
    api.ActivityStatus.cancelled => 'cancelled',
    api.ActivityStatus.manualReview => 'manual_review',
    _ => value.name,
  };

  ActivityBusinessType? _businessType(
    api.ActivityRecordBusinessTypeEnum? value,
  ) => switch (value) {
    api.ActivityRecordBusinessTypeEnum.opening => ActivityBusinessType.opening,
    api.ActivityRecordBusinessTypeEnum.closing => ActivityBusinessType.closing,
    api.ActivityRecordBusinessTypeEnum.takeProfit =>
      ActivityBusinessType.takeProfit,
    api.ActivityRecordBusinessTypeEnum.stopLoss =>
      ActivityBusinessType.stopLoss,
    api.ActivityRecordBusinessTypeEnum.unknown => ActivityBusinessType.unknown,
    null => null,
    _ => ActivityBusinessType.unknown,
  };

  String _referenceType(api.ActivityRecordReferenceTypeEnum value) =>
      switch (value) {
        api.ActivityRecordReferenceTypeEnum.order => 'order',
        api.ActivityRecordReferenceTypeEnum.position => 'position',
        api.ActivityRecordReferenceTypeEnum.transfer => 'transfer',
        api.ActivityRecordReferenceTypeEnum.claim => 'claim',
        api.ActivityRecordReferenceTypeEnum.deposit => 'deposit',
        api.ActivityRecordReferenceTypeEnum.withdrawal => 'withdrawal',
        api.ActivityRecordReferenceTypeEnum.fundingPayment => 'funding_payment',
        _ => value.name,
      };

  String _continuationAction(api.BstocksActivityContinuationActionEnum value) =>
      switch (value) {
        api.BstocksActivityContinuationActionEnum.submitBstocksAction =>
          'submit_bstocks_action',
        _ => value.name,
      };

  String _continuationStep(api.BstocksActivityContinuationStepEnum value) =>
      switch (value) {
        api.BstocksActivityContinuationStepEnum.walletSignature =>
          'wallet_signature',
        _ => value.name,
      };

  api.ActivityCategory? _category(ActivityCategory? value) => switch (value) {
    ActivityCategory.orders => api.ActivityCategory.orders,
    ActivityCategory.cash => api.ActivityCategory.cash,
    ActivityCategory.funding => api.ActivityCategory.funding,
    _ => null,
  };
  api.ActivityStatus? _status(ActivityState? value) => switch (value) {
    ActivityState.pending => api.ActivityStatus.pending,
    ActivityState.success => api.ActivityStatus.success,
    ActivityState.failed => api.ActivityStatus.failed,
    ActivityState.cancelled => api.ActivityStatus.cancelled,
    _ => null,
  };

  api.ActivityType? _type(String? value) => switch (value) {
    null => null,
    'market' => api.ActivityType.market,
    'limit' => api.ActivityType.limit,
    'tpsl' => api.ActivityType.tpsl,
    'close' => api.ActivityType.close,
    'liquidation' => api.ActivityType.liquidation,
    'deposit' => api.ActivityType.deposit,
    'external' => api.ActivityType.external_,
    'bridge' => api.ActivityType.bridge,
    'withdraw' => api.ActivityType.withdraw,
    'claim' => api.ActivityType.claim,
    'funding' => api.ActivityType.funding,
    'approval' => api.ActivityType.approval,
    'orderSign' => api.ActivityType.orderSign,
    'bridgeSign' => api.ActivityType.bridgeSign,
    _ => throw ArgumentError.value(value, 'type'),
  };
}
