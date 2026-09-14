import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../data/services/market_search_history_service.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_snapshot.dart';
import '../../../../domain/models/stock.dart';

typedef MarketQuery = ({String? query, String? cursor});

final marketProductsProvider = FutureProvider.autoDispose
    .family<DomainPage<MarketProduct>, MarketQuery>((ref, query) {
      return ref
          .watch(marketsRepositoryProvider)
          .listProducts(query: query.query, cursor: query.cursor);
    });

final marketStocksProvider = FutureProvider.autoDispose<DomainPage<Stock>>((
  ref,
) {
  return ref.watch(marketsRepositoryProvider).listStocks();
});

final marketProductProvider = FutureProvider.autoDispose
    .family<MarketProduct, MarketProductRef>((ref, product) {
      return ref.watch(marketsRepositoryProvider).getProduct(product);
    });

final marketSnapshotProvider = FutureProvider.autoDispose
    .family<MarketSnapshot, MarketProductRef>((ref, product) {
      return ref.watch(marketsRepositoryProvider).getSnapshot(product);
    });

final marketHoursProvider = FutureProvider.autoDispose<MarketHours>((ref) {
  return ref.watch(marketHoursRepositoryProvider).getMarketHours();
});

final marketCandlesProvider = FutureProvider.autoDispose
    .family<CandleChart, ({MarketProductRef product, CandleChartRange range})>(
      (ref, query) => ref
          .watch(marketsRepositoryProvider)
          .getCandles(query.product, range: query.range),
    );

final favoritesCommandProvider =
    AsyncNotifierProvider.autoDispose<FavoritesCommand, void>(
      FavoritesCommand.new,
    );

final marketSearchHistoryServiceProvider = Provider<MarketSearchHistoryService>(
  (_) => SharedPreferencesMarketSearchHistoryService(),
);

final recentMarketSearchesProvider =
    AsyncNotifierProvider.autoDispose<
      RecentMarketSearches,
      List<MarketProductRef>
    >(RecentMarketSearches.new);

final class RecentMarketSearches extends AsyncNotifier<List<MarketProductRef>> {
  @override
  Future<List<MarketProductRef>> build() =>
      ref.read(marketSearchHistoryServiceProvider).read();

  Future<void> record(MarketProductRef product) async {
    final previous = state.asData?.value ?? const <MarketProductRef>[];
    try {
      final updated = await ref
          .read(marketSearchHistoryServiceProvider)
          .record(product);
      state = AsyncData(updated);
    } catch (_) {
      state = AsyncData(previous);
    }
  }
}

final class FavoritesCommand extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    ref.watch(sessionGenerationProvider);
  }

  Future<void> add(MarketProductRef product) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(marketsRepositoryProvider).addFavorite(product),
    );
    if (!state.hasError) _invalidate(product);
  }

  Future<void> remove(MarketProductRef product) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(marketsRepositoryProvider).removeFavorite(product),
    );
    if (!state.hasError) _invalidate(product);
  }

  void _invalidate(MarketProductRef product) {
    ref.invalidate(marketProductProvider(product));
    ref.invalidate(marketProductsProvider);
  }
}
