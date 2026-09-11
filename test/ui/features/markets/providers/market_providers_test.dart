import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/data/services/market_search_history_service.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';

void main() {
  test('isolates complete query parameters', () async {
    final repository = _MarketsRepository();
    final container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    const first = (query: 'nv', cursor: 'a');
    const second = (query: 'nv', cursor: 'b');
    expect(
      (await container.read(marketProductsProvider(first).future)).nextCursor,
      'a',
    );
    expect(
      (await container.read(marketProductsProvider(second).future)).nextCursor,
      'b',
    );
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

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  }) async => DomainPage(items: const [], nextCursor: cursor);

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
