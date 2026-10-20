import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/repositories/funding_repository_impl.dart';
import 'package:nobell/data/services/funding_service.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

void main() {
  for (final environment in ['mainnet', 'testnet']) {
    test(
      'venue asset retains exact $environment identity despite common signing chain',
      () async {
        final body = _obligation();
        (body['amounts']! as List<Map<String, Object?>>).single['asset'] = {
          'status': 'known',
          'namespace': 'hyperliquid',
          'network': 'Hyperliquid',
          'chain_id': 1337,
          'token': 'USDC-PERPS',
          'environment': environment,
          'asset_id': 'hyperliquid:$environment/perps:USDC-PERPS',
        };
        final value = (await FundingRepositoryImpl(
          _ObligationsService(_page(body)),
        ).listFinancialObligations()).items.single.amounts.single.asset;
        expect(value.environment, environment);
        expect(value.assetId, 'hyperliquid:$environment/perps:USDC-PERPS');
      },
    );
  }

  test('venue signing chain cannot fabricate a known environment', () async {
    final body = _obligation();
    (body['amounts']! as List<Map<String, Object?>>).single['asset'] = {
      'status': 'known',
      'namespace': 'hyperliquid',
      'network': 'Hyperliquid',
      'chain_id': 1337,
      'token': 'USDC-PERPS',
      'asset_id': 'hyperliquid:1337/perps:USDC-PERPS',
    };
    await expectLater(
      FundingRepositoryImpl(_ObligationsService(_page(body)))
          .listFinancialObligations(),
      throwsFormatException,
    );
  });
  test(
    'repository preserves exact hashless holds and unknown quantities',
    () async {
      final service = _ObligationsService(_page(_obligation()));
      final page = await FundingRepositoryImpl(service)
          .listFinancialObligations(cursor: 'cursor-1', includeResolved: true);
      expect(service.cursor, 'cursor-1');
      expect(service.includeResolved, isTrue);
      expect(page.nextCursor, 'cursor-2');
      expect(page.hasMore, isTrue);
      final value = page.items.single;
      expect(value.id, 'hold-1');
      expect(value.businessReference.type, 'bstocks_order');
      expect(value.evidence, isEmpty);
      expect(
        value.amounts.single.buckets['reserved']!.raw,
        '2500970232991173395',
      );
      expect(value.amounts.single.buckets['actual_fee']!.raw, isNull);
      expect(
        value.amounts.single.buckets['actual_fee']!.unknownReason,
        'fee_not_observed',
      );
      expect(value.responsibility.caseId, 'case-1');
      expect(value.responsibility.owner, 'Funding support');
      expect(value.nextObservationAt, DateTime.utc(2026, 10, 19, 12));
    },
  );

  test(
    'unknown identity never acquires token, decimals or authoritative asset ID',
    () async {
      final body = _obligation();
      final rows = body['amounts']! as List<Map<String, Object?>>;
      rows.single['asset'] = {
        'status': 'unknown',
        'reason': 'historical_identity_missing',
        'observed_asset_ref': 'legacy-orphan',
      };
      final value = (await FundingRepositoryImpl(
        _ObligationsService(_page(body)),
      ).listFinancialObligations()).items.single.amounts.single.asset;
      expect(value.status, 'unknown');
      expect(value.assetId, isNull);
      expect(value.token, isNull);
      expect(value.tokenDecimals, isNull);
      expect(value.observedAssetRef, 'legacy-orphan');
    },
  );

  test('partial refund retains actual fee, evidence coordinates and economic status', () async {
    final body = _obligation();
    body['economic_status'] = 'partially_refunded';
    final rows = body['amounts']! as List<Map<String, Object?>>;
    rows.single['refunded'] = _known('1200000000000000001');
    rows.single['refund_due'] = _known('1300970232991173394');
    rows.single['actual_fee'] = _known('250');
    body['evidence'] = [
      {
        'evidence_id': 'refund-event-1',
        'kind': 'refund',
        'status': 'finalized',
        'reference': {'type': 'cross_chain_transfer', 'id': 'transfer-1'},
        'observed_at': '2026-10-19T11:00:00Z',
        'chain_id': 56,
        'tx_hash': '0x${List.filled(64, 'a').join()}',
        'log_index': 7,
      },
    ];
    final value = (await FundingRepositoryImpl(
      _ObligationsService(_page(body)),
    ).listFinancialObligations()).items.single;
    expect(value.economicStatus, 'partiallyRefunded');
    expect(value.technicalStatus, 'manual_review');
    expect(value.unresolved, isTrue);
    expect(
      value.amounts.single.buckets['refunded']!.raw,
      '1200000000000000001',
    );
    expect(
      value.amounts.single.buckets['refund_due']!.raw,
      '1300970232991173394',
    );
    expect(value.amounts.single.buckets['actual_fee']!.raw, '250');
    expect(value.evidence.single.logIndex, 7);
    expect(value.evidence.single.observedAt, DateTime.utc(2026, 10, 19, 11));
  });

  test(
    'same-receipt return preserves net debit 2 refund 98 outstanding 2',
    () async {
      final body = _obligation();
      body['economic_status'] = 'partially_refunded';
      final rows = body['amounts']! as List<Map<String, Object?>>;
      rows.single['reserved'] = _known('0');
      rows.single['source_debited'] = _known('2000000000000000000');
      rows.single['refunded'] = _known('98000000000000000000');
      rows.single['outstanding'] = _known('2000000000000000000');
      final value = (await FundingRepositoryImpl(
        _ObligationsService(_page(body)),
      ).listFinancialObligations()).items.single;
      final amounts = value.amounts.single.buckets;
      expect(amounts['source_debited']!.decimal(18), '2.000000000000000000');
      expect(amounts['refunded']!.decimal(18), '98.000000000000000000');
      expect(amounts['outstanding']!.decimal(18), '2.000000000000000000');
      expect(value.unresolved, isTrue);
      expect(value.economicStatus, 'partiallyRefunded');
    },
  );
}

Map<String, Object?> _known(String raw) => {
  'status': 'known',
  'amount_raw': raw,
};
Map<String, Object?> _page(Map<String, Object?> item) => {
  'items': [item],
  'next_cursor': 'cursor-2',
  'has_more': true,
};
Map<String, Object?> _obligation() => {
  'obligation_id': 'hold-1',
  'business_reference': {'type': 'bstocks_order', 'id': 'order-1'},
  'related_references': [
    {'type': 'funding_plan', 'id': 'plan-1'},
  ],
  'economic_status': 'reserved',
  'technical_status': 'manual_review',
  'unresolved': true,
  'reason': 'receipt_missing',
  'created_at': '2026-10-01T00:00:00Z',
  'updated_at': '2026-10-19T10:00:00Z',
  'last_observed_at': '2026-10-19T09:00:00Z',
  'next_observation_at': '2026-10-19T12:00:00Z',
  'amounts': <Map<String, Object?>>[
    {
      'asset': {
        'status': 'known',
        'asset_id': 'bsc-usdt',
        'namespace': 'eip155',
        'network': 'BSC',
        'chain_id': 56,
        'token': 'USDT',
        'token_decimals': 18,
      },
      'reserved': _known('2500970232991173395'),
      for (final bucket in [
        'source_debited',
        'in_transit',
        'credited',
        'refund_due',
        'refunded',
        'released',
        'compensated',
        'outstanding',
      ])
        bucket: _known('0'),
      'actual_fee': {'status': 'unknown', 'reason': 'fee_not_observed'},
    },
  ],
  'evidence': <Object>[],
  'responsibility': {
    'queue': 'funds-recovery',
    'escalation_status': 'escalated',
    'allowed_actions': ['observe', 'contact_support', 'view_details'],
    'case_id': 'case-1',
    'owner': 'Funding support',
  },
};

final class _ObligationsService implements FundingService {
  _ObligationsService(this.body);
  final Map<String, Object?> body;
  String? cursor;
  bool? includeResolved;

  @override
  Future<api.FinancialObligationPage> listFinancialObligations({
    String? cursor,
    bool includeResolved = false,
  }) async {
    this.cursor = cursor;
    this.includeResolved = includeResolved;
    return api.standardSerializers.deserializeWith(
      api.FinancialObligationPage.serializer,
      body,
    )!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
