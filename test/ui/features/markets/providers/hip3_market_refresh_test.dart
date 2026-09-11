import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/app/providers/hip3_live_provider.dart';
import 'package:rwa_interface/app/providers/hip3_market_live_provider.dart';
import 'package:rwa_interface/domain/models/hip3_live.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_list_query.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/features/markets/providers/hip3_chart_provider.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_list_provider.dart';

const product = MarketProductRef(symbol: 'TSLA', kind: MarketProductKind.perp);
const query = (product: product, window: Hip3ChartWindow.hour);

class Repository implements MarketsRepository {
  final snapshots = <Completer<MarketSnapshot>>[];
  final charts = <Completer<CandleChart>>[];
  final mutations = <Completer<void>>[];
  var favorite = false;
  MarketProduct get value => MarketProduct(
    symbol: 'TSLA',
    name: 'Tesla',
    kind: MarketProductKind.perp,
    price: DecimalValue('1'),
    settlementAsset: 'USDC',
    network: 'Hyperliquid',
    tradable: true,
    isFavorite: favorite,
  );
  @override
  Future<MarketProduct> getProduct(MarketProductRef product) async => value;
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    MarketProductKind? kind,
    MarketListGroup? group,
    int? limit,
  }) async => DomainPage(
    items: group == MarketListGroup.favorites && !favorite ? [] : [value],
  );
  @override
  Future<MarketSnapshot> getSnapshot(MarketProductRef product) {
    final request = Completer<MarketSnapshot>();
    snapshots.add(request);
    return request.future;
  }

  @override
  Future<CandleChart> getCandles(
    MarketProductRef product, {
    CandleChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) {
    final request = Completer<CandleChart>();
    charts.add(request);
    return request.future;
  }

  @override
  Future<void> addFavorite(MarketProductRef product) {
    final request = Completer<void>();
    mutations.add(request);
    return request.future;
  }

  @override
  Future<void> removeFavorite(MarketProductRef product) => addFavorite(product);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('chart consumes continuous candle pushes without refetching and falls back to REST', () async {
    final repo = Repository();
    final c = ProviderContainer(
      overrides: [
        marketsRepositoryProvider.overrideWithValue(repo),
        hip3MarketLiveProvider.overrideWith(
          (ref, request) => ref.watch(_priceFeed),
        ),
      ],
    );
    addTearDown(c.dispose);
    const identity = Hip3PublicMarket(
      productId: 'xyz:TSLA',
      venue: 'xyz',
      environment: 'testnet',
      settlementAsset: 'USDC',
      tradable: true,
    );
    const ref = MarketProductRef(
      symbol: 'TSLA',
      kind: MarketProductKind.perp,
      productId: 'xyz:TSLA',
      environment: 'testnet',
    );
    const q = (product: ref, window: Hip3ChartWindow.hour);
    final now = DateTime.now().toUtc();
    final at = DateTime.fromMillisecondsSinceEpoch(
      now.millisecondsSinceEpoch ~/ 60000 * 60000,
      isUtc: true,
    );
    Candle point(String price) => Candle(
      at: at,
      close: DecimalValue(price, asset: 'USDC', unit: 'price'),
    );
    CandleChart chart(String price, int age) => CandleChart(
      symbol: 'TSLA',
      range: '1h',
      interval: '1m',
      from: now.subtract(const Duration(hours: 1)),
      to: now,
      fetchedAt: now,
      hip3Market: identity,
      hip3Provenance: Hip3CandleProvenance(
        productId: identity.productId,
        environment: identity.environment,
        source: 'hyperliquid_testnet',
        observedAt: now.subtract(Duration(seconds: age)),
        freshUntil: now.add(const Duration(minutes: 1)),
      ),
      points: [point(price)],
    );
    void tick(String price, int age) => c
        .read(_priceFeed.notifier)
        .publishCandle(
          Hip3LiveCandle(
            market: identity,
            interval: '1m',
            point: point(price),
            closed: false,
            source: 'hyperliquid_testnet',
            observedAt: now.subtract(Duration(seconds: age)),
            freshUntil: now.add(const Duration(minutes: 1)),
          ),
        );
    final p = hip3ChartProvider(q);
    final sub = c.listen(p, (_, _) {});
    addTearDown(sub.close);
    await pumpEventQueue();
    repo.charts.single.complete(chart('10', 30));
    expect((await c.read(p.future)).points.single.close.value, '10');
    tick('11', 20);
    await pumpEventQueue();
    expect((await c.read(p.future)).points.single.close.value, '11');
    tick('12', 10);
    await pumpEventQueue();
    expect((await c.read(p.future)).points.single.close.value, '12');
    expect(repo.charts, hasLength(1));
    c.invalidate(hip3ChartRestProvider(q));
    await pumpEventQueue();
    repo.charts[1].complete(chart('13', 5));
    expect((await c.read(p.future)).points.single.close.value, '13');
    c.read(_priceFeed.notifier).lose();
    await pumpEventQueue();
    expect(repo.charts, hasLength(3));
    repo.charts[2].complete(chart('14', 1));
    expect((await c.read(p.future)).points.single.close.value, '14');
  });
  test('market page applies ticks without refetching REST and retries REST on live loss', () async {
    final repo = Repository();
    final c = ProviderContainer(
      overrides: [
        marketsRepositoryProvider.overrideWithValue(repo),
        hip3MarketLiveProvider.overrideWith(
          (ref, request) => ref.watch(_priceFeed),
        ),
      ],
    );
    addTearDown(c.dispose);
    const ref = MarketProductRef(
      symbol: 'TSLA',
      kind: MarketProductKind.perp,
      productId: 'xyz:TSLA',
      environment: 'testnet',
    );
    const identity = Hip3PublicMarket(
      productId: 'xyz:TSLA',
      venue: 'xyz',
      environment: 'testnet',
      settlementAsset: 'USDC',
      tradable: true,
    );
    final now = DateTime.now().toUtc();
    MarketSnapshot quote(String price, int age) => MarketSnapshot(
      price: DecimalValue(price, asset: 'USDC', unit: 'price'),
      hip3Market: identity,
      priceKind: 'mark',
      asOf: now.subtract(Duration(seconds: age)),
      validUntil: now.add(const Duration(minutes: 1)),
    );
    final p = marketSnapshotProvider(ref);
    final sub = c.listen(p, (_, _) {});
    addTearDown(sub.close);
    await pumpEventQueue();
    repo.snapshots.single.complete(quote('10', 30));
    expect((await c.read(p.future)).price.value, '10');
    c.read(_priceFeed.notifier).publish(quote('12', 20));
    await pumpEventQueue();
    expect((await c.read(p.future)).price.value, '12');
    c.read(_priceFeed.notifier).publish(quote('13', 10));
    await pumpEventQueue();
    expect((await c.read(p.future)).price.value, '13');
    expect(repo.snapshots, hasLength(1));
    c.invalidate(marketSnapshotRestProvider(ref));
    await pumpEventQueue();
    expect(repo.snapshots, hasLength(2));
    repo.snapshots[1].complete(quote('14', 5));
    expect((await c.read(p.future)).price.value, '14');
    c.read(_priceFeed.notifier).lose();
    await pumpEventQueue();
    expect(repo.snapshots, hasLength(3));
    repo.snapshots[2].complete(quote('15', 1));
    expect((await c.read(p.future)).price.value, '15');
  });
  test(
    'confirmed favorite mutation reconciles detail, search and favorites pages',
    () async {
      final repo = Repository();
      final container = ProviderContainer(
        overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      const all = (query: null, cursor: null);
      const favorites = MarketListQuery(group: MarketListGroup.favorites);
      container.listen(marketProductProvider(product), (_, _) {});
      container.listen(marketProductsProvider(all), (_, _) {});
      container.listen(marketListProvider(favorites), (_, _) {});
      container.listen(favoritesCommandProvider, (_, _) {});
      await container.pump();
      expect(container.read(marketListProvider(favorites)).items, isEmpty);
      final refreshed = Completer<void>();
      container.listen(marketListProvider(favorites), (_, next) {
        if (next.items.isNotEmpty &&
            next.items.single.isFavorite &&
            !refreshed.isCompleted) {
          refreshed.complete();
        }
      });
      final mutation = container
          .read(favoritesCommandProvider.notifier)
          .add(product);
      repo.favorite = true;
      repo.mutations.single.complete();
      expect(await mutation, true);
      await container.read(marketProductProvider(product).future);
      await container.read(marketProductsProvider(all).future);
      await container.pump();
      await refreshed.future.timeout(const Duration(seconds: 2));
      expect(
        container.read(marketProductProvider(product)).requireValue.isFavorite,
        true,
      );
      expect(
        container
            .read(marketProductsProvider(all))
            .requireValue
            .items
            .single
            .isFavorite,
        true,
      );
      expect(
        container.read(marketListProvider(favorites)).items.single.isFavorite,
        true,
      );
    },
  );
  testWidgets(
    'snapshot and candles wait for completion, pause and resume safely',
    (tester) async {
      final repo = Repository();
      final container = ProviderContainer(
        overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
      );
      final snapshot = container.listen(
        marketSnapshotProvider(product),
        (_, _) {},
      );
      final candles = container.listen(hip3ChartProvider(query), (_, _) {});
      await tester.pump(const Duration(seconds: 60));
      expect(repo.snapshots.length, 1);
      expect(repo.charts.length, 1);
      repo.snapshots.single.complete(MarketSnapshot(price: DecimalValue('10')));
      repo.charts.single.complete(
        const CandleChart(symbol: 'TSLA', range: '1h', points: []),
      );
      await tester.pump();
      container.read(hip3ForegroundProvider.notifier).setForeground(false);
      await tester.pump(const Duration(seconds: 60));
      expect(repo.snapshots.length, 1);
      expect(repo.charts.length, 1);
      container.read(hip3ForegroundProvider.notifier).setForeground(true);
      await tester.pump(const Duration(milliseconds: 1));
      expect(repo.snapshots.length, 2);
      expect(repo.charts.length, 2);
      snapshot.close();
      candles.close();
      repo.snapshots.last.complete(MarketSnapshot(price: DecimalValue('11')));
      repo.charts.last.complete(
        const CandleChart(symbol: 'TSLA', range: '1h', points: []),
      );
      await tester.pump(const Duration(seconds: 60));
      expect(repo.snapshots.length, 2);
      expect(repo.charts.length, 2);
      container.dispose();
    },
  );

  test(
    'favorite mutations serialize, report failure and allow retry',
    () async {
      final repo = Repository();
      final container = ProviderContainer(
        overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      container.listen(favoritesCommandProvider, (_, _) {});
      await container.read(favoritesCommandProvider.future);
      final command = container.read(favoritesCommandProvider.notifier);
      final failed = command.add(product);
      expect(await command.add(product), false);
      expect(repo.mutations.length, 1);
      repo.mutations.single.completeError(StateError('offline'));
      expect(await failed, false);
      expect(container.read(favoritesCommandProvider).hasError, true);
      final retry = command.add(product);
      repo.mutations.last.complete();
      expect(await retry, true);
      expect(container.read(favoritesCommandProvider).hasError, false);
    },
  );

  test('old account mutation cannot report success or overwrite new account command', () async {
    final repo = Repository();
    final container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    container.listen(favoritesCommandProvider, (_, _) {});
    await container.read(favoritesCommandProvider.future);
    final old = container.read(favoritesCommandProvider.notifier).add(product);
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await container.pump();
    final current = container
        .read(favoritesCommandProvider.notifier)
        .remove(product);
    repo.mutations.first.complete();
    expect(await old, false);
    expect(container.read(favoritesCommandProvider).isLoading, true);
    repo.mutations.last.complete();
    expect(await current, true);
  });
}

final _priceFeed = NotifierProvider<_PriceFeed, Hip3LiveConnection>(
  _PriceFeed.new,
);

class _PriceFeed extends Notifier<Hip3LiveConnection> {
  void publishCandle(Hip3LiveCandle candle) {
    state = Hip3LiveConnection(
      Hip3LivePhase.live,
      snapshot: Hip3LiveSnapshot(
        query: Hip3LiveQuery(
          signer: '0x1111111111111111111111111111111111111111',
          environment: 'testnet',
          channels: {'hip3:candle:testnet:1m:xyz:TSLA'},
        ),
        cursor: 'cursor',
        completedAt: DateTime.now().toUtc(),
        emittedAt: DateTime.now().toUtc(),
        orders: {},
        positions: {},
        prices: {},
        candles: {
          (
            productId: candle.market.productId,
            environment: candle.market.environment,
            interval: candle.interval,
            at: candle.point.at,
          ): candle,
        },
      ),
    );
  }

  @override
  Hip3LiveConnection build() =>
      const Hip3LiveConnection(Hip3LivePhase.disabled);
  void publish(MarketSnapshot quote) {
    final market = quote.hip3Market!;
    state = Hip3LiveConnection(
      Hip3LivePhase.live,
      snapshot: Hip3LiveSnapshot(
        query: Hip3LiveQuery(
          signer: '0x1111111111111111111111111111111111111111',
          environment: 'testnet',
          channels: {'hip3:price:testnet:xyz:TSLA'},
        ),
        cursor: 'cursor',
        completedAt: DateTime.now().toUtc(),
        emittedAt: DateTime.now().toUtc(),
        orders: {},
        positions: {},
        candles: {},
        prices: {
          (productId: market.productId, environment: market.environment):
              Hip3LivePrice(quote: quote, source: 'hyperliquid_testnet'),
        },
      ),
    );
  }

  void lose() => state = const Hip3LiveConnection(Hip3LivePhase.fallback);
}
