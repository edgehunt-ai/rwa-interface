import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/hip3_wallet_history_repository_impl.dart';
import 'package:rwa_interface/data/services/hip3_wallet_history_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/hip3_wallet_history.dart';

const from = '2026-09-01T00:00:00Z', to = '2026-09-02T00:00:00Z';
Map<String, Object?> fixture({bool liquidation = false}) => {
  'snapshot_id': '00000000-0000-0000-0000-000000000001',
  'environment': 'testnet',
  'observed_at': to,
  'query_source': 'live',
  'archive_coverage': null,
  'has_more': false,
  'next_cursor': null,
  'warnings': ['provider_history_retention_not_guaranteed'],
  'coverage': {
    'source': liquidation
        ? 'hyperliquid_userNonFundingLedgerUpdates'
        : 'hyperliquid_userFunding',
    'status': 'source_exhausted',
    'from': from,
    'to': to,
    'resume_from': null,
    'retention_guaranteed': false,
  },
  'items': liquidation
      ? [
          {
            'id': 'event',
            'provider_account_value': '-1234567890.123456789012345678',
            'account_value_scope': 'cross_account',
            'margin_mode': 'cross',
            'positions': [
              {'product_id': 'xyz:TSLA', 'signed_position_size': '-0.1'},
              {'product_id': 'xyz:NVDA', 'signed_position_size': '2'},
            ],
            'excluded_native_position_count': 1,
            'transaction_hash': '0x${'11' * 32}',
            'occurred_at': from,
          },
        ]
      : [
          {
            'id': '11' * 32,
            'product_id': 'xyz:TSLA',
            'amount': '-0.000000000000000001',
            'settlement_asset': null,
            'collateral_token': null,
            'signed_position_size': '-2.000000000000000001',
            'funding_rate': '0.0001',
            'transaction_hash': '0x${'11' * 32}',
            'occurred_at': from,
          },
        ],
};
void main() {
  test('query normalizes sub-millisecond clocks to backend precision', () {
    final precise = DateTime.parse('2026-09-01T00:00:00.123456Z');
    final query = Hip3HistoryQuery(from: precise, to: precise);
    expect(query.from.toIso8601String(), '2026-09-01T00:00:00.123Z');
    expect(query.to, query.from);
  });
  late Map<String, Object?> response;
  late List<RequestOptions> requests;
  late Hip3WalletHistoryRepositoryImpl repository;
  late Dio dio;
  Hip3HistoryQuery query({Hip3HistorySource source = Hip3HistorySource.live}) =>
      Hip3HistoryQuery(
        from: DateTime.parse(from),
        to: DateTime.parse(to),
        productId: 'xyz:TSLA',
        source: source,
      );
  setUp(() {
    response = fixture();
    requests = [];
    dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          requests.add(request);
          handler.resolve(
            Response(requestOptions: request, statusCode: 200, data: response),
          );
        },
      ),
    );
    repository = Hip3WalletHistoryRepositoryImpl(
      GeneratedHip3WalletHistoryService(
        api.RwaApiClient(dio: dio).getOrdersApi(),
      ),
    );
  });
  tearDown(() => dio.close(force: true));
  test('generated funding API preserves exact signed decimal and unknown settlement asset', () async {
    final page = await repository.funding(query(), cursor: 'frozen');
    expect(page.items.single.amount.value, '-0.000000000000000001');
    expect(page.items.single.amount.asset, isNull);
    expect(page.items.single.signedPositionSize.value, '-2.000000000000000001');
    expect(page.coverage.isPartial, isFalse);
    expect(page.coverage.retentionGuaranteed, isFalse);
    expect(requests.single.path, '/v1/hip3/funding-payments');
    expect(requests.single.queryParameters, containsPair('source', 'live'));
    expect(
      requests.single.queryParameters,
      containsPair('product_id', 'xyz:TSLA'),
    );
    expect(requests.single.queryParameters, containsPair('cursor', 'frozen'));
    expect(requests.single.queryParameters.keys, isNot(contains('user')));
  });
  test(
    'empty archived page retains explicit gaps independent from pagination',
    () async {
      response['items'] = [];
      response['query_source'] = 'archive';
      (response['coverage'] as Map<String, Object?>).addAll({
        'status': 'archive_partial',
        'resume_from': from,
      });
      response['archive_coverage'] = {
        'covered_ranges': <Map<String, Object?>>[],
        'missing_ranges': [
          {'from': from, 'to': to},
        ],
      };
      final page = await repository.funding(
        query(source: Hip3HistorySource.archive),
      );
      expect(page.items, isEmpty);
      expect(page.hasMore, isFalse);
      expect(page.coverage.isPartial, isTrue);
      expect(page.coverage.missingRanges.single.from, DateTime.parse(from));
      expect(
        requests.single.queryParameters,
        containsPair('source', 'archive'),
      );
    },
  );
  test(
    'liquidation product selection retains full event and native scope',
    () async {
      response = fixture(liquidation: true);
      final event = (await repository.liquidations(query())).items.single;
      expect(event.positions.map((p) => p.productId), ['xyz:TSLA', 'xyz:NVDA']);
      expect(event.excludedNativePositionCount, 1);
      expect(event.accountValueScope, 'crossAccount');
      expect(
        event.providerAccountValue.value,
        '-1234567890.123456789012345678',
      );
      expect(event.providerAccountValue.asset, isNull);
      expect(requests.single.path, '/v1/hip3/liquidations');
    },
  );
  test(
    'rejects switched source, broken cursor and invented coverage',
    () async {
      for (final mutate in <void Function(Map<String, Object?>)>[
        (p) => p['query_source'] = 'archive',
        (p) => p['has_more'] = true,
        (p) => (p['coverage'] as Map<String, Object?>)['retention_guaranteed'] =
            true,
        (p) => (p['coverage'] as Map<String, Object?>)['from'] = to,
      ]) {
        response = fixture();
        mutate(response);
        await expectLater(
          repository.funding(query()),
          throwsA(isA<DecodingFailure>()),
        );
      }
    },
  );
  test('query retains UTC identity and rejects invalid windows', () {
    expect(query(), query());
    expect(query(), isNot(query(source: Hip3HistorySource.archive)));
    expect(
      () =>
          Hip3HistoryQuery(from: DateTime.parse(to), to: DateTime.parse(from)),
      throwsArgumentError,
    );
    expect(
      () => Hip3HistoryQuery(
        from: DateTime.parse(from),
        to: DateTime.parse(from).add(const Duration(days: 32)),
      ),
      throwsArgumentError,
    );
  });
}
