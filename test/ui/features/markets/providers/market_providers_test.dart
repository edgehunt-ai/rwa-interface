import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/bstocks_support.dart';
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

  test('resolves a stock logo for its product symbols', () async {
    final container = ProviderContainer(
      overrides: [
        marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
      ],
    );
    addTearDown(container.dispose);

    await container.read(marketStocksProvider.future);
    expect(
      container.read(marketStockLogoUrlProvider('NVDAB')),
      'https://cdn.example.com/nvda.png',
    );
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
