import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/provider_lifecycle.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../data/services/market_search_history_service.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_snapshot.dart';
import '../../../../domain/models/stock.dart';

typedef MarketQuery = ({
  String? query,
  String? cursor,
  String? group,
  MarketProductKind? productType,
});

typedef MarketProductFeedQuery = ({
  String? query,
  String? group,
  MarketProductKind? productType,
});

final class MarketProductFeed {
  const MarketProductFeed({
    required this.items,
    required this.nextCursor,
    required this.hasMore,
    this.isLoadingMore = false,
    this.loadMoreFailed = false,
  });

  final List<MarketProduct> items;
  final String? nextCursor;
  final bool hasMore;
  final bool isLoadingMore;
  final bool loadMoreFailed;
}

const _marketRankingTabKey = 'market_ranking_tab';

final marketRankingTabProvider =
    AsyncNotifierProvider<MarketRankingTabNotifier, String?>(
      MarketRankingTabNotifier.new,
    );

final class MarketRankingTabNotifier extends AsyncNotifier<String?> {
  @override
  Future<String?> build() async =>
      (await SharedPreferences.getInstance()).getString(_marketRankingTabKey);

  Future<void> select(String tab) async {
    state = AsyncData(tab);
    await (await SharedPreferences.getInstance()).setString(
      _marketRankingTabKey,
      tab,
    );
  }
}

const _marketProductTypeKey = 'market_product_type';

final marketProductTypeProvider =
    AsyncNotifierProvider<MarketProductTypeNotifier, MarketProductKind?>(
      MarketProductTypeNotifier.new,
    );

final class MarketProductTypeNotifier
    extends AsyncNotifier<MarketProductKind?> {
  @override
  Future<MarketProductKind?> build() async {
    final stored = (await SharedPreferences.getInstance()).getString(
      _marketProductTypeKey,
    );
    return MarketProductKind.values
        .where((kind) => kind.name == stored)
        .firstOrNull;
  }

  Future<void> select(MarketProductKind? kind) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_marketProductTypeKey, kind?.name ?? 'all');
    state = AsyncData(kind);
  }
}

String effectiveMarketRankingTab({
  required bool authenticated,
  required String? storedTab,
}) {
  if (authenticated) return storedTab ?? 'Favorites';
  return storedTab == null || storedTab == 'Favorites' ? 'Popular' : storedTab;
}

const marketListCacheDuration = Duration(minutes: 30);
const marketListRefreshInterval = Duration(seconds: 15);

void _cacheMarketList(Ref ref) {
  cacheAfterLastListener(ref, marketListCacheDuration);
}

final marketListRefreshProvider = Provider.autoDispose<void>((ref) {
  refreshWhileActive(
    ref,
    interval: marketListRefreshInterval,
    refresh: () {
      ref.invalidate(marketProductsProvider);
      ref.invalidate(marketStocksProvider);
    },
  );
});

final marketProductsProvider = FutureProvider.autoDispose
    .family<DomainPage<MarketProduct>, MarketQuery>((ref, query) {
      _cacheMarketList(ref);
      return _listMarketProducts(ref, query);
    });

final marketProductFeedProvider = AsyncNotifierProvider.autoDispose
    .family<
      MarketProductFeedNotifier,
      MarketProductFeed,
      MarketProductFeedQuery
    >((query) => MarketProductFeedNotifier(query));

final class MarketProductFeedNotifier extends AsyncNotifier<MarketProductFeed> {
  MarketProductFeedNotifier(this.query);

  final MarketProductFeedQuery query;
  final _pages = <String?, DomainPage<MarketProduct>>{};
  final _loadedCursors = <String>{};
  String? _loadingCursor;
  var _generation = 0;

  MarketQuery _pageQuery(String? cursor) => (
    query: query.query,
    cursor: cursor,
    group: query.group,
    productType: query.productType,
  );

  @override
  Future<MarketProductFeed> build() async {
    _generation++;
    _loadingCursor = null;
    final page = await ref.watch(
      marketProductsProvider(_pageQuery(null)).future,
    );
    final firstLoadedCursor = _pages.keys.whereType<String>().firstOrNull;
    final canPreserveLoadedPages =
        firstLoadedCursor != null &&
        page.hasMore &&
        page.nextCursor == firstLoadedCursor;
    if (!canPreserveLoadedPages) _pages.clear();
    _pages[null] = page;
    _loadedCursors
      ..clear()
      ..addAll(_pages.keys.whereType<String>());
    return _feedFromPages();
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    final cursor = current?.nextCursor;
    if (current == null ||
        current.isLoadingMore ||
        !current.hasMore ||
        cursor == null ||
        cursor.isEmpty ||
        _loadingCursor != null ||
        _loadedCursors.contains(cursor)) {
      return;
    }

    final generation = _generation;
    _loadingCursor = cursor;
    _loadedCursors.add(cursor);
    state = AsyncData(
      MarketProductFeed(
        items: current.items,
        nextCursor: current.nextCursor,
        hasMore: current.hasMore,
        isLoadingMore: true,
      ),
    );

    try {
      final pageProvider = marketProductsProvider(_pageQuery(cursor));
      if (current.loadMoreFailed) ref.invalidate(pageProvider);
      final page = await ref.read(pageProvider.future);
      if (!ref.mounted || generation != _generation) return;
      _pages[cursor] = page;
      state = AsyncData(_feedFromPages());
    } catch (_) {
      if (!ref.mounted || generation != _generation) return;
      _loadedCursors.remove(cursor);
      state = AsyncData(
        MarketProductFeed(
          items: current.items,
          nextCursor: current.nextCursor,
          hasMore: current.hasMore,
          loadMoreFailed: true,
        ),
      );
    } finally {
      if (generation == _generation) _loadingCursor = null;
    }
  }

  MarketProductFeed _feedFromPages() {
    final references = <MarketProductRef>{};
    final items = <MarketProduct>[];
    for (final page in _pages.values) {
      for (final product in page.items) {
        final reference = MarketProductRef(
          symbol: product.symbol,
          kind: product.kind,
        );
        if (references.add(reference)) items.add(product);
      }
    }
    final lastPage = _pages.values.last;
    return _feed(items, lastPage.nextCursor, lastPage.hasMore);
  }

  MarketProductFeed _feed(
    List<MarketProduct> items,
    String? nextCursor,
    bool hasMore,
  ) {
    final validCursor =
        nextCursor != null &&
        nextCursor.isNotEmpty &&
        !_loadedCursors.contains(nextCursor);
    return MarketProductFeed(
      items: List.unmodifiable(items),
      nextCursor: validCursor ? nextCursor : null,
      hasMore: hasMore && validCursor,
    );
  }
}

// Detail screens only need the matching products to resolve the active kind.
// They must not inherit the list-page polling cadence.
final marketProductLookupProvider = FutureProvider.autoDispose
    .family<DomainPage<MarketProduct>, MarketQuery>(
      (ref, query) => _listMarketProducts(ref, query),
    );

Future<DomainPage<MarketProduct>> _listMarketProducts(
  Ref ref,
  MarketQuery query,
) => ref
    .watch(marketsRepositoryProvider)
    .listProducts(
      query: query.query,
      cursor: query.cursor,
      group: query.group,
      productType: query.productType,
    );

final marketStocksProvider = FutureProvider.autoDispose<DomainPage<Stock>>((
  ref,
) {
  _cacheMarketList(ref);
  return ref.watch(marketsRepositoryProvider).listStocks();
});

final marketProductProvider = FutureProvider.autoDispose
    .family<MarketProduct, MarketProductRef>((ref, product) {
      return ref.watch(marketsRepositoryProvider).getProduct(product);
    });

final bstocksTokenDecimalsProvider = FutureProvider.autoDispose
    .family<int?, String>((ref, symbol) async {
      final normalized = symbol.toLowerCase();
      final tokens = await ref
          .watch(marketsRepositoryProvider)
          .listBstocksSupportedTokens();
      final decimals = tokens
          .where((token) => token.symbol.toLowerCase() == normalized)
          .map((token) => token.decimals)
          .toSet();
      return decimals.length == 1 ? decimals.single : null;
    });

/// Resolve identity reactively when a trade sheet opens before list loading.
final marketProductIdProvider = Provider.autoDispose
    .family<String?, MarketProductRef>((ref, product) {
      final products = ref
          .watch(
            marketProductLookupProvider((
              query: product.symbol,
              cursor: null,
              group: null,
              productType: product.kind,
            )),
          )
          .value
          ?.items;
      return products
          ?.where(
            (item) =>
                item.symbol == product.symbol && item.kind == product.kind,
          )
          .firstOrNull
          ?.productId;
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
    ref.invalidate(marketProductLookupProvider);
    ref.invalidate(marketProductsProvider);
  }
}
