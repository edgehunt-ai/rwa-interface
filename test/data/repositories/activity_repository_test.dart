import 'package:flutter_test/flutter_test.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/repositories/activity_repository_impl.dart';
import 'package:nobell/data/services/activity_service.dart';
import 'package:nobell/domain/models/activity_record.dart';

void main() {
  for (final (economic, expected) in [
    ('reserved', ActivityState.reserved),
    ('source_debited', ActivityState.sourceDebited),
    ('in_transit', ActivityState.inTransit),
    ('refund_pending', ActivityState.refundPending),
    ('partially_settled', ActivityState.partiallySettled),
    ('partially_refunded', ActivityState.partiallyRefunded),
    ('credited', ActivityState.credited),
    ('refunded', ActivityState.refunded),
    ('compensated', ActivityState.compensated),
    ('released', ActivityState.released),
    ('settled', ActivityState.settled),
    ('unknown', ActivityState.unknown),
  ]) {
    test('$economic overrides technical success without losing evidence', () async {
      const amount = '1000000000000000000.000000000000000001';
      const fee = '0.000000000000000001';
      final value = api.standardSerializers.deserializeWith(
        api.ActivityRecord.serializer,
        {
          'id': 'activity-original',
          'category': 'cash',
          'type': 'bridge',
          'status': 'success',
          'economic_status': economic,
          'financial_obligation_ids': ['obligation-1', 'obligation-2'],
          'title': 'Transfer',
          'amount': amount,
          'asset': 'USDT',
          'failure_reason': 'Destination credit unresolved',
          'related_id': 'refund-original',
          'reference': {'type': 'transfer', 'id': 'transfer-original'},
          'tx_hash': '0xoriginal',
          'created_at': '2026-01-01T00:00:00.123456Z',
          'updated_at': '2026-01-02T00:00:00.123456Z',
          'fields': [
            {'label': 'Refund amount', 'value': amount},
            {'label': 'Refund fee', 'value': fee},
            {'label': 'Refund ID', 'value': 'refund-original'},
          ],
        },
      )!;
      final record = (await ActivityRepositoryImpl(
        _ActivityService([value]),
      ).list()).items.single;
      expect(record.status, expected);
      expect(record.status, isNot(ActivityState.success));
      expect(record.economicStatus, economic);
      expect(record.rawStatus, 'success');
      expect(record.financialObligationIds, ['obligation-1', 'obligation-2']);
      expect(() => record.financialObligationIds.add('changed'),
          throwsUnsupportedError);
      expect(record.amount!.value, amount);
      expect(record.amount!.asset, 'USDT');
      expect(record.fields.map((field) => field.value),
          [amount, fee, 'refund-original']);
      expect(record.id, 'activity-original');
      expect(record.reference!.id, 'transfer-original');
      expect(record.relatedId, 'refund-original');
      expect(record.txHash, '0xoriginal');
      expect(record.failureReason, 'Destination credit unresolved');
      expect(record.createdAt.toIso8601String(), '2026-01-01T00:00:00.123456Z');
      expect(record.updatedAt!.toIso8601String(), '2026-01-02T00:00:00.123456Z');
    });
  }

  test('economic states cannot silently become unfiltered technical queries', () async {
    await expectLater(
      ActivityRepositoryImpl(_Activity()).list(status: ActivityState.refunded),
      throwsArgumentError,
    );
  });

  test('manual review remains visible when economic status is absent', () async {
    final page = await _Activity().list();
    final value = page.items.single.rebuild(
      (b) => b.status = api.ActivityStatus.manualReview,
    );
    final record = (await ActivityRepositoryImpl(
      _ActivityService([value]),
    ).list()).items.single;
    expect(record.status, ActivityState.manualReview);
    expect(record.rawStatus, 'manual_review');
  });

  test('maps activity amount with asset and resource reference', () async {
    final record = (await ActivityRepositoryImpl(
      _Activity(),
    ).list()).items.single;
    expect(record.status, ActivityState.success);
    expect(record.economicStatus, isNull);
    expect(record.financialObligationIds, isEmpty);
    expect(record.amount?.value, '0.000000000000000001');
    expect(record.amount?.asset, 'USDC');
    expect(record.reference?.id, 'order-1');
    expect(record.chain, 'BSC');
    expect(record.txHash, '0xtx');
    expect(record.fields.single.label, 'Network Fee');
    expect(record.fields.single.value, 'Free');
  });

  for (final (source, sourceId, destination, destinationId) in [
    ('BSC', '56', 'Hyperliquid', null),
    ('Arbitrum', '42161', 'Hyperliquid', null),
    ('Hyperliquid', null, 'Arbitrum', '42161'),
    ('Hyperliquid', null, 'BSC', '97'),
  ]) {
    test('maps cash flow $source to $destination from wire JSON', () async {
      final wire = <String, Object?>{
        'id': 'cash-1',
        'category': 'cash',
        'type': 'bridge',
        'status': 'success',
        'title': 'USDT → USDC',
        'created_at': '2026-10-17T00:00:00Z',
        'updated_at': '2026-10-17T00:00:00Z',
        'cash_flow': {
          'source': {'asset': 'USDT', 'chain': source, 'chain_id': sourceId},
          'destination': {
            'asset': 'USDC',
            'chain': destination,
            'chain_id': destinationId,
          },
        },
      };
      final value = api.standardSerializers.deserializeWith(
        api.ActivityRecord.serializer,
        wire,
      )!;
      final record = (await ActivityRepositoryImpl(
        _ActivityService([value]),
      ).list()).items.single;
      expect(record.cashFlow!.source.asset, 'USDT');
      expect(record.cashFlow!.source.chain, source);
      expect(record.cashFlow!.source.chainId, sourceId);
      expect(record.cashFlow!.destination.asset, 'USDC');
      expect(record.cashFlow!.destination.chain, destination);
      expect(record.cashFlow!.destination.chainId, destinationId);
    });
  }

  test('legacy activity without cash flow stays absent', () async {
    final record = (await ActivityRepositoryImpl(
      _Activity(),
    ).list()).items.single;
    expect(record.cashFlow, isNull);
  });

  test('maps preview and wallet-signature activity continuations', () async {
    final preview = api.BstocksPreviewContinuation(
      (builder) => builder
        ..action = api.BstocksPreviewContinuationActionEnum.previewBstocksOrder
        ..orderId = 'order-1'
        ..step = api.BstocksPreviewContinuationStepEnum.orderPreview
        ..requiresNewBusinessObject = false,
    );
    final signature = api.BstocksSignatureContinuation(
      (builder) => builder
        ..action =
            api.BstocksSignatureContinuationActionEnum.submitBstocksAction
        ..orderId = 'order-2'
        ..actionId = 'action-2'
        ..step = api.BstocksSignatureContinuationStepEnum.walletSignature
        ..requiresNewBusinessObject = false,
    );

    final page = await ActivityRepositoryImpl(
      _ActivityService([
        _record('preview', preview, typeIndex: 0),
        _record('signature', signature, typeIndex: 1),
      ]),
    ).list();

    expect(page.items.first.continuation?.orderId, 'order-1');
    expect(page.items.first.continuation?.actionId, isNull);
    expect(page.items.first.continuation?.step, 'order_preview');
    expect(page.items.last.continuation?.orderId, 'order-2');
    expect(page.items.last.continuation?.actionId, 'action-2');
    expect(page.items.last.continuation?.step, 'wallet_signature');
  });
}

final class _Activity implements ActivityService {
  @override
  Future<api.ActivityPage> list({
    api.ActivityCategory? category,
    api.ActivityStatus? status,
    api.ActivityType? type,
    String? productOrAsset,
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

api.ActivityRecord _record(
  String id,
  Object continuation, {
  required int typeIndex,
}) => api.ActivityRecord(
  (builder) => builder
    ..id = id
    ..category = api.ActivityCategory.orders
    ..type = api.ActivityType.orderSign
    ..status = api.ActivityStatus.pending
    ..title = 'Pending order action'
    ..createdAt = DateTime.utc(2026)
    ..updatedAt = DateTime.utc(2026)
    ..continuation.replace(
      api.BstocksActivityContinuation(
        (wrapper) => wrapper.oneOf = OneOfDynamic(
          typeIndex: typeIndex,
          types: const [
            api.BstocksPreviewContinuation,
            api.BstocksSignatureContinuation,
          ],
          value: continuation,
        ),
      ),
    ),
);

final class _ActivityService implements ActivityService {
  const _ActivityService(this.items);

  final List<api.ActivityRecord> items;

  @override
  Future<api.ActivityPage> list({
    api.ActivityCategory? category,
    api.ActivityStatus? status,
    api.ActivityType? type,
    String? productOrAsset,
    String? cursor,
  }) async => api.ActivityPage(
    (builder) => builder
      ..hasMore = false
      ..items.addAll(items),
  );
}
