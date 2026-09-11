import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/features/markets/providers/hip3_chart_provider.dart';
import 'package:rwa_interface/ui/features/markets/providers/hip3_chart_history_provider.dart';

const query = (
  product: MarketProductRef(symbol: 'TSLA', kind: MarketProductKind.perp),
  window: Hip3ChartWindow.hour,
);
final start = DateTime.utc(2026, 9, 10, 10);
Candle point(DateTime at, [String price = '1']) =>
    Candle(at: at, close: DecimalValue(price));
CandleChart chart(List<Candle> points, {DateTime? from}) => CandleChart(
  symbol: 'TSLA',
  range: '1h',
  points: points,
  from: from ?? start,
  to: start.add(const Duration(hours: 1)),
);

class Request {
  Request(this.product, this.interval, this.from, this.to);
  final MarketProductRef product;
  final String? interval;
  final DateTime from, to;
  final result = Completer<CandleChart>();
}

class Repository implements MarketsRepository {
  final requests = <Request>[];
  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    dynamic range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) {
    final request = Request(ref, interval, from!, to!);
    requests.add(request);
    return request.result.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('long-lived candle rollover retains at most 5000 newest bars', () {
    final old = List.generate(
      5000,
      (index) => point(start.add(Duration(minutes: index))),
    );
    final newest = point(start.add(const Duration(minutes: 5000)), '2');
    final merged = mergeHip3Candles(old, [newest]);
    expect(merged, hasLength(5000));
    expect(merged.first.at, start.add(const Duration(minutes: 1)));
    expect(merged.last, same(newest));
    expect(old.first.at, start);
  });
  test('REST fallback cannot regress a newer observed bar', () {
    Candle observedPoint(int seconds, String price) => Candle(
      at: start,
      close: DecimalValue(price),
      hip3Provenance: Hip3CandleProvenance(
        productId: 'xyz:TSLA',
        environment: 'testnet',
        source: 'hyperliquid_testnet',
        observedAt: start.add(Duration(seconds: seconds)),
        freshUntil: start.add(const Duration(minutes: 1)),
      ),
    );
    final livePoint = observedPoint(20, '12');
    expect(
      mergeHip3Candles([livePoint], [observedPoint(10, '11')]).single,
      same(livePoint),
    );
    expect(
      mergeHip3Candles([livePoint], [point(start, '10')]).single,
      same(livePoint),
    );
    expect(
      mergeHip3Candles(
        [livePoint],
        [observedPoint(30, '13')],
      ).single.close.value,
      '13',
    );
  });
  late Repository repo;
  late ProviderContainer container;
  late CandleChart live;
  setUp(() {
    repo = Repository();
    live = chart([point(start, '2')]);
    container = ProviderContainer(
      overrides: [
        marketsRepositoryProvider.overrideWithValue(repo),
        hip3ChartProvider.overrideWith((ref, query) async => live),
      ],
    );
  });
  tearDown(() => container.dispose());
  Future<void> watch([Hip3ChartQuery key = query]) async {
    container.listen(hip3ChartHistoryProvider(key), (_, _) {});
    await container.pump();
  }

  Hip3ChartHistoryState state([Hip3ChartQuery key = query]) =>
      container.read(hip3ChartHistoryProvider(key));
  Future<void> load([Hip3ChartQuery key = query]) =>
      container.read(hip3ChartHistoryProvider(key).notifier).loadOlder();

  test(
    'exclusive boundary, sorting, dedupe and no overwrite of current candle',
    () async {
      await watch();
      final pending = load();
      await load(); // Duplicate gesture sends no second request.
      final request = repo.requests.single;
      expect(request.product, query.product);
      expect(request.interval, '1m');
      expect(request.to, start);
      expect(request.from, start.subtract(const Duration(hours: 1)));
      final earlier = start.subtract(const Duration(minutes: 2));
      request.result.complete(
        chart([
          point(start, '999'),
          point(earlier, '3'),
          point(request.from, '4'),
          point(earlier, '5'),
          point(request.from.subtract(const Duration(minutes: 1)), '888'),
        ]),
      );
      await pending;
      expect(state().points.map((p) => p.close.value), ['4', '5', '2']);
      expect(state().before, request.from);
    },
  );

  test('unaligned initial window includes straddling candle instead of leaving a gap', () async {
    live = chart([
      point(start.add(const Duration(minutes: 1))),
    ], from: start.add(const Duration(seconds: 35)));
    await watch();
    final pending = load();
    expect(repo.requests.single.to, start.add(const Duration(minutes: 1)));
    repo.requests.single.result.complete(chart([point(start)]));
    await pending;
    expect(state().points.length, 2);
  });

  test('failed history retries exact window and retains live updates during flight', () async {
    await watch();
    var pending = load();
    repo.requests[0].result.completeError(StateError('offline'));
    await pending;
    expect(state().error, isNotNull);
    expect(state().before, start);
    pending = load();
    expect(repo.requests[1].from, repo.requests[0].from);
    expect(repo.requests[1].to, repo.requests[0].to);
    live = chart([
      point(start, '7'),
      point(start.add(const Duration(minutes: 1)), '8'),
    ]);
    container.invalidate(hip3ChartProvider(query));
    await container.pump();
    repo.requests[1].result.complete(
      chart([point(start.subtract(const Duration(minutes: 1)), '6')]),
    );
    await pending;
    expect(state().points.map((p) => p.close.value), ['6', '7', '8']);
    expect(state().error, isNull);
  });

  test(
    'empty page is a gap, not a fabricated end; next window advances',
    () async {
      live = chart([]);
      await watch();
      var pending = load();
      repo.requests[0].result.complete(chart([]));
      await pending;
      expect(state().emptyWindow, isTrue);
      expect(state().exhausted, isFalse);
      pending = load();
      expect(repo.requests[1].to, repo.requests[0].from);
      repo.requests[1].result.complete(chart([point(repo.requests[1].from)]));
      await pending;
      expect(state().points.length, 1);
      expect(state().emptyWindow, isFalse);
    },
  );

  test(
    'epoch terminal window clamps from, disables additional requests',
    () async {
      final nearEpoch = DateTime.fromMillisecondsSinceEpoch(60000, isUtc: true);
      live = chart([point(nearEpoch)], from: nearEpoch);
      await watch();
      final pending = load();
      expect(repo.requests.single.from.millisecondsSinceEpoch, 0);
      repo.requests.single.result.complete(chart([]));
      await pending;
      expect(state().exhausted, isTrue);
      await load();
      expect(repo.requests.length, 1);
    },
  );

  test(
    '5000 received candles stop pagination, not 5000 elapsed intervals',
    () async {
      live = chart(
        List.generate(5000, (i) => point(start.add(Duration(minutes: i)))),
      );
      await watch();
      await load();
      expect(state().exhausted, isTrue);
      expect(repo.requests, isEmpty);
    },
  );

  test(
    'product and interval families isolate late historical results',
    () async {
      await watch();
      final old = load();
      const other = (
        product: MarketProductRef(symbol: 'GOLD', kind: MarketProductKind.perp),
        window: Hip3ChartWindow.week,
      );
      live = chart([point(start, '22')]);
      await watch(other);
      final newer = load(other);
      expect(repo.requests[1].product.symbol, 'GOLD');
      expect(repo.requests[1].interval, '1h');
      repo.requests[1].result.complete(
        chart([point(start.subtract(const Duration(hours: 1)), '21')]),
      );
      await newer;
      repo.requests[0].result.complete(
        chart([point(start.subtract(const Duration(minutes: 1)), '999')]),
      );
      await old;
      expect(state(other).points.map((p) => p.close.value), ['21', '22']);
    },
  );

  test('disposed/recreated same key ignores old completion', () async {
    final subscription = container.listen(
      hip3ChartHistoryProvider(query),
      (_, _) {},
    );
    await container.pump();
    final old = load();
    subscription.close();
    await container.pump();
    await watch();
    repo.requests.single.result.complete(
      chart([point(start.subtract(const Duration(minutes: 1)), '999')]),
    );
    await old;
    expect(state().points.map((p) => p.close.value), ['2']);
  });

  test(
    'account change resets accumulated history and rejects late pages',
    () async {
      await watch();
      final old = load();
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await container.pump();
      repo.requests.single.result.complete(
        chart([point(start.subtract(const Duration(minutes: 1)), '999')]),
      );
      await old;
      expect(state().points.map((p) => p.close.value), ['2']);
      expect(state().loading, false);
    },
  );
}
