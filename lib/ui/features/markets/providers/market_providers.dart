import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../app/providers/api_providers.dart';
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
  final link = ref.keepAlive();
  Timer? expiryTimer;
  Timer? refreshTimer;

  void stopTimers() {
    refreshTimer?.cancel();
    expiryTimer?.cancel();
  }

  void startRefresh() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(
      marketListRefreshInterval,
      (_) => ref.invalidateSelf(),
    );
  }

  void startExpiry() {
    expiryTimer?.cancel();
    expiryTimer = Timer(marketListCacheDuration, link.close);
  }

  startExpiry();
  startRefresh();
  ref.onCancel(stopTimers);
  ref.onResume(() {
    startExpiry();
    startRefresh();
  });
  ref.onDispose(() {
    expiryTimer?.cancel();
    refreshTimer?.cancel();
  });
}

final marketProductsProvider = FutureProvider.autoDispose
    .family<DomainPage<MarketProduct>, MarketQuery>((ref, query) {
      _cacheMarketList(ref);
      return ref
          .watch(marketsRepositoryProvider)
          .listProducts(
            query: query.query,
            cursor: query.cursor,
            group: query.group,
            productType: query.productType,
          );
    });

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
