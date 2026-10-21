import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/bstocks_support.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/market_snapshot.dart';
import 'package:nobell/domain/models/stock.dart';
import 'package:nobell/domain/repositories/markets_repository.dart';
import 'package:nobell/data/services/market_search_history_service.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';

void main() {
  test('ranking tab defaults and persisted selection respect auth state', () {
    expect(
      effectiveMarketRankingTab(authenticated: false, storedTab: 'Favorites'),
      'Popular',
    );
    expect(
      effectiveMarketRankingTab(authenticated: false, storedTab: 'Gainers'),
      'Gainers',
    );
    expect(
      effectiveMarketRankingTab(authenticated: false, storedTab: 'Losers'),
      'Losers',
    );
    expect(
      effectiveMarketRankingTab(authenticated: false, storedTab: 'Volume'),
      'Volume',
    );
    expect(
      effectiveMarketRankingTab(authenticated: true, storedTab: null),
      'Favorites',
    );
    expect(
      effectiveMarketRankingTab(authenticated: true, storedTab: 'Volume'),
      'Volume',
    );
  });

  test('ranking tab selection persists locally', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    await container.read(marketRankingTabProvider.future);
    await container.read(marketRankingTabProvider.notifier).select('Gainers');

    expect(
      (await SharedPreferences.getInstance()).getString('market_ranking_tab'),
      'Gainers',
    );
  });

  for (final kind in <MarketProductKind?>[null, ...MarketProductKind.values]) {
    test('product filter persists and restores $kind', () async {
      SharedPreferences.setMockInitialValues({'market_product_type': 'perp'});
      final container = ProviderContainer();
      addTearDown(container.dispose);
      await container.read(marketProductTypeProvider.future);
      await container.read(marketProductTypeProvider.notifier).select(kind);
      expect(container.read(marketProductTypeProvider).value, kind);
      final restored = ProviderContainer();
      addTearDown(restored.dispose);
      expect(await restored.read(marketProductTypeProvider.future), kind);
    });
  }

  test('missing or invalid product filter defaults to all', () async {
    for (final values in <Map<String, Object>>[
      {},
      {'market_product_type': 'invalid'},
    ]) {
      SharedPreferences.setMockInitialValues(values);
      final container = ProviderContainer();
      expect(await container.read(marketProductTypeProvider.future), isNull);
      container.dispose();
    }
  });

  test('isolates complete query parameters', () async {
    final repository = _MarketsRepository();
    final container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    const first = (
      query: 'nv',
      cursor: 'a',
      group: 'hot',
      productType: MarketProductKind.bstock,
    );
    const second = (
      query: 'nv',
      cursor: 'b',
      group: 'gainers',
      productType: MarketProductKind.perp,
    );
    expect(
      (await container.read(marketProductsProvider(first).future)).nextCursor,
      'a',
    );
    expect(
      (await container.read(marketProductsProvider(second).future)).nextCursor,
      'b',
    );
    expect(repository.requests, [
      (
        query: 'nv',
        cursor: 'a',
        group: 'hot',
        productType: MarketProductKind.bstock,
      ),
      (
        query: 'nv',
        cursor: 'b',
        group: 'gainers',
        productType: MarketProductKind.perp,
      ),
    ]);
  });

  test(
    'product feed appends cursor pages in API order without duplicates',
    () async {
      final repository = _PagedMarketsRepository();
      final container = ProviderContainer(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      const query = (query: 'tech', group: 'hot', productType: null);
      final subscription = container.listen(
        marketProductFeedProvider(query),
        (_, _) {},
      );
      addTearDown(subscription.close);

      final first = await container.read(
        marketProductFeedProvider(query).future,
      );
      expect(first.items.map((item) => item.symbol), ['NVDA', 'TSLA']);
      expect(first.hasMore, isTrue);

      await container
          .read(marketProductFeedProvider(query).notifier)
          .loadMore();

      final complete = container
          .read(marketProductFeedProvider(query))
          .requireValue;
      expect(complete.items.map((item) => item.symbol), [
        'NVDA',
        'TSLA',
        'AAPL',
      ]);
      expect(complete.hasMore, isFalse);
      expect(repository.cursors, [null, 'page-2']);

      container.invalidate(
        marketProductsProvider((
          query: 'tech',
          cursor: null,
          group: 'hot',
          productType: null,
        )),
      );
      final refreshed = await container.read(
        marketProductFeedProvider(query).future,
      );
      expect(refreshed.items.map((item) => item.symbol), [
        'NVDA',
        'TSLA',
        'AAPL',
      ]);
      expect(repository.cursors, [null, 'page-2', null]);
    },
  );

  test(
    'product feed keeps loaded items and retries a failed next page',
    () async {
      final repository = _PagedMarketsRepository(failPage2Once: true);
      final container = ProviderContainer(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      const query = (query: null, group: 'hot', productType: null);
      final subscription = container.listen(
        marketProductFeedProvider(query),
        (_, _) {},
      );
      addTearDown(subscription.close);

      await container.read(marketProductFeedProvider(query).future);
      final notifier = container.read(
        marketProductFeedProvider(query).notifier,
      );
      await notifier.loadMore();
      final failed = container
          .read(marketProductFeedProvider(query))
          .requireValue;
      expect(failed.items.map((item) => item.symbol), ['NVDA', 'TSLA']);
      expect(failed.loadMoreFailed, isTrue);

      await notifier.loadMore();
      final retried = container
          .read(marketProductFeedProvider(query))
          .requireValue;
      expect(retried.items.map((item) => item.symbol), [
        'NVDA',
        'TSLA',
        'AAPL',
      ]);
      expect(retried.loadMoreFailed, isFalse);
      expect(repository.cursors, [null, 'page-2', 'page-2']);
    },
  );

  test('updates recent searches after a market is opened', () async {
    final history = _MarketSearchHistoryService();
    final container = ProviderContainer(
      overrides: [
        marketSearchHistoryServiceProvider.overrideWithValue(history),
      ],
    );
    addTearDown(container.dispose);
    const product = MarketProductRef(
      symbol: 'NVDA',
      kind: MarketProductKind.bstock,
    );

    await container.read(recentMarketSearchesProvider.future);
    await container.read(recentMarketSearchesProvider.notifier).record(product);

    expect(container.read(recentMarketSearchesProvider).asData?.value, [
      product,
    ]);
  });

  test('resolves bStock decimals from the supported token catalog', () async {
    final container = ProviderContainer(
      overrides: [
        marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
      ],
    );
    addTearDown(container.dispose);

    expect(
      await container.read(bstocksTokenDecimalsProvider('nvdab').future),
      8,
    );
  });

  test('keeps chart requests isolated by selected range', () async {
    final repository = _MarketsRepository();
    final container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    const product = MarketProductRef(
      symbol: 'NVDA',
      kind: MarketProductKind.bstock,
    );

    await container.read(
      marketCandlesProvider((product: product, range: CandleChartRange.oneHour))
          .future,
    );
    await container.read(
      marketCandlesProvider((
        product: product,
        range: CandleChartRange.fourHours,
      )).future,
    );

    expect(repository.requestedRanges, [
      CandleChartRange.oneHour,
      CandleChartRange.fourHours,
    ]);
  });
}

final class _MarketSearchHistoryService implements MarketSearchHistoryService {
  final entries = <MarketProductRef>[];

  @override
  Future<List<MarketProductRef>> read() async => entries;

  @override
  Future<List<MarketProductRef>> record(MarketProductRef product) async {
    entries
      ..remove(product)
      ..insert(0, product);
    return List.unmodifiable(entries);
  }
}

final class _MarketsRepository implements MarketsRepository {
  final requestedRanges = <CandleChartRange>[];
  final requests = <MarketQuery>[];

  @override
  Future<List<BstocksSupportedToken>> listBstocksSupportedTokens() async =>
      const [
        BstocksSupportedToken(
          symbol: 'NVDAB',
          contractAddress: '0x0000000000000000000000000000000000000001',
          decimals: 8,
          executionStatus: BstocksExecutionStatus.admitted,
          executionEnabled: true,
        ),
      ];

  @override
  Future<DomainPage<Stock>> listStocks() async => const DomainPage(
    items: [
      Stock(
        symbol: 'NVDA',
        name: 'NVIDIA',
        referencePrice: '120',
        logoUrl: 'https://cdn.example.com/nvda.png',
        products: [
          MarketProductRef(symbol: 'NVDAB', kind: MarketProductKind.bstock),
        ],
      ),
    ],
  );

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  }) async {
    requests.add((
      query: query,
      cursor: cursor,
      group: group,
      productType: productType,
    ));
    return DomainPage(items: const [], nextCursor: cursor);
  }

  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    CandleChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) async {
    requestedRanges.add(range!);
    return CandleChart(
      symbol: ref.symbol,
      range: range.label,
      points: const [],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _PagedMarketsRepository implements MarketsRepository {
  _PagedMarketsRepository({this.failPage2Once = false});

  bool failPage2Once;
  final cursors = <String?>[];

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  }) async {
    cursors.add(cursor);
    if (cursor == null) {
      return DomainPage(
        items: [_product('NVDA'), _product('TSLA')],
        nextCursor: 'page-2',
        hasMore: true,
      );
    }
    if (failPage2Once) {
      failPage2Once = false;
      throw StateError('page failed');
    }
    return DomainPage(
      items: [_product('TSLA'), _product('AAPL')],
      hasMore: false,
    );
  }

  MarketProduct _product(String symbol) => MarketProduct(
    symbol: symbol,
    name: symbol,
    kind: MarketProductKind.bstock,
    price: DecimalValue('100', asset: 'USD', unit: 'price'),
    settlementAsset: 'USDC',
    network: 'BSC',
    tradable: true,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
