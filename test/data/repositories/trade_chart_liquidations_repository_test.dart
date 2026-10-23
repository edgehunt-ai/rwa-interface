import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/repositories/trade_chart_liquidations_repository_impl.dart';
import 'package:nobell/data/services/trade_chart_liquidations_service.dart';
import 'package:nobell/domain/models/api_failure.dart';

void main() {
  test('liquidation events are paginated, deduplicated and matched by full product ID', () async {
    final service = _Service([
      _page([
        _event('one'),
        _event('other', productId: 'abc:NVDA'),
      ], next: 'page-2'),
      _page([_event('one'), _event('two')]),
    ]);
    final result = await TradeChartLiquidationsRepositoryImpl(service)
        .list(productId: 'xyz:NVDA', from: _from, to: _to);
    expect(result.markers.map((e) => e.id), [
      'liquidation:one',
      'liquidation:two',
    ]);
    expect(
      result.markers.every((e) => e.price == null),
      isTrue,
      reason: 'Account equity must never become a liquidation execution price',
    );
    expect(result.isPartial, isFalse);
    expect(service.requests, [
      (productId: 'xyz:NVDA', from: _from, to: _to, cursor: null),
      (productId: 'xyz:NVDA', from: _from, to: _to, cursor: 'page-2'),
    ]);
  });

  test('incomplete source coverage is preserved even after the final snapshot page', () async {
    final result = await TradeChartLiquidationsRepositoryImpl(
      _Service([
        _page([_event('one')], partial: true),
      ]),
    ).list(productId: 'xyz:NVDA', from: _from, to: _to);
    expect(result.isPartial, isTrue);
    expect(result.markers, hasLength(1));
  });

  test(
    'future chart boundaries are capped once for the entire snapshot',
    () async {
      final before = DateTime.now().toUtc();
      final service = _Service([_page([], next: 'page-2'), _page([])]);
      await TradeChartLiquidationsRepositoryImpl(service).list(
        productId: 'xyz:NVDA',
        from: before.subtract(const Duration(hours: 1)),
        to: before.add(const Duration(hours: 1)),
      );
      final end = service.requests.first.to;
      expect(end.isBefore(before), isFalse);
      expect(end.isAfter(DateTime.now().toUtc()), isFalse);
      expect(service.requests.last.to, end);
    },
  );

  test(
    'underlying liquidation API errors retain their business reason',
    () async {
      const failure = ServerFailure(
        statusCode: 503,
        code: 'ledger_unavailable',
        failureReason: 'Venue ledger is temporarily unavailable',
      );
      await expectLater(
        TradeChartLiquidationsRepositoryImpl(_Service([], failure: failure))
            .list(productId: 'xyz:NVDA', from: _from, to: _to),
        throwsA(same(failure)),
      );
    },
  );
}

final _from = DateTime.utc(2026, 10, 20, 10);
final _to = DateTime.utc(2026, 10, 20, 11);

api.Hip3Liquidation _event(String id, {String productId = 'xyz:NVDA'}) =>
    api.Hip3Liquidation(
      (b) => b
        ..id = id
        ..providerAccountValue = '1000'
        ..accountValueScope =
            api.Hip3LiquidationAccountValueScopeEnum.values.first
        ..marginMode = api.Hip3LiquidationMarginModeEnum.values.first
        ..positions.add(
          api.Hip3LiquidationPosition(
            (p) => p
              ..productId = productId
              ..signedPositionSize = '1',
          ),
        )
        ..excludedNativePositionCount = 0
        ..transactionHash = '0xhash'
        ..occurredAt = _from.add(const Duration(minutes: 20)),
    );

api.Hip3LiquidationPage _page(
  List<api.Hip3Liquidation> items, {
  String? next,
  bool partial = false,
}) => api.Hip3LiquidationPage(
  (b) => b
    ..querySource = api.Hip3LiquidationPageQuerySourceEnum.live
    ..snapshotId = 'snapshot'
    ..environment = api.Hip3Environment.testnet
    ..observedAt = _to
    ..items.addAll(items)
    ..hasMore = next != null
    ..nextCursor = next
    ..warnings.clear()
    ..coverage.replace(
      api.Hip3LiquidationHistoryCoverage(
        (c) => c
          ..source_ = api.Hip3LiquidationHistoryCoverageSource_Enum.values.first
          ..status = partial
              ? api.Hip3LiquidationHistoryCoverageStatusEnum.upstreamUnavailable
              : api.Hip3LiquidationHistoryCoverageStatusEnum.sourceExhausted
          ..from = _from
          ..to = _to
          ..retentionGuaranteed = false,
      ),
    ),
);

class _Service implements TradeChartLiquidationsService {
  _Service(this.pages, {this.failure});
  final List<api.Hip3LiquidationPage> pages;
  final ApiFailure? failure;
  final requests =
      <({String productId, DateTime from, DateTime to, String? cursor})>[];
  @override
  Future<api.Hip3LiquidationPage> list({
    required String productId,
    required DateTime from,
    required DateTime to,
    String? cursor,
  }) async {
    requests.add((productId: productId, from: from, to: to, cursor: cursor));
    if (failure != null) throw failure!;
    return pages[requests.length - 1];
  }
}
