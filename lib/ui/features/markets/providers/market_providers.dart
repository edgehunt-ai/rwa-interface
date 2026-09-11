import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/hip3_query_refresh.dart';
import '../../../../app/providers/hip3_market_live_provider.dart';
import '../../../../app/providers/hip3_live_provider.dart';
import '../../../../domain/services/hip3_market_overlay.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../data/services/market_search_history_service.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_snapshot.dart';
import 'market_list_provider.dart';

typedef MarketQuery = ({String? query, String? cursor});

final marketProductsProvider = FutureProvider.autoDispose
    .family<DomainPage<MarketProduct>, MarketQuery>((ref, query) {
      final repository = ref.watch(marketsRepositoryProvider);
      return hip3RefreshingQuery(
        ref,
        () => repository.listProducts(query: query.query, cursor: query.cursor),
      );
    });

final marketProductProvider = FutureProvider.autoDispose
    .family<MarketProduct, MarketProductRef>((ref, product) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(marketsRepositoryProvider).getProduct(product);
    });

final marketSnapshotRestProvider = FutureProvider.autoDispose
    .family<MarketSnapshot, MarketProductRef>((ref, product) async {
      final repository = ref.watch(marketsRepositoryProvider);
      if (product.kind != MarketProductKind.perp) {
        return repository.getSnapshot(product);
      }
      return hip3RefreshingQuery(ref, () => repository.getSnapshot(product));
    });

/// Keep the HTTP query independent of push updates so a tick does not refetch
/// the book or restart its polling timer/subscription.
final marketSnapshotProvider = FutureProvider.autoDispose
    .family<MarketSnapshot, MarketProductRef>((ref, product) async {
      final baseline = ref.watch(marketSnapshotRestProvider(product).future);
      final stream = hip3MarketLiveProvider((product: product, interval: null));
      ref.listen(stream, (previous, next) {
        if (previous?.phase == Hip3LivePhase.live &&
            next.phase != Hip3LivePhase.live &&
            ref.read(hip3ForegroundProvider)) {
          ref.invalidate(marketSnapshotRestProvider(product));
        }
      });
      final connection = ref.watch(stream);
      final base = await baseline;
      final live =
          connection.snapshot?.prices[(
            productId: product.productId ?? '',
            environment: product.environment ?? '',
          )];
      return overlayHip3Price(base, live, DateTime.now().toUtc());
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
  bool _pending = false;
  int _generation = 0;
  @override
  void build() {
    ref.watch(sessionGenerationProvider);
    _generation++;
    _pending = false;
  }

  Future<bool> add(MarketProductRef product) => _mutate(product, true);

  Future<bool> remove(MarketProductRef product) => _mutate(product, false);

  Future<bool> _mutate(MarketProductRef product, bool add) =>
      _execute(product, () {
        final repository = ref.read(marketsRepositoryProvider);
        return add
            ? repository.addFavorite(product)
            : repository.removeFavorite(product);
      });

  Future<bool> replace(
    List<MarketProductRef> ordered, {
    required List<MarketProductRef> expectedFavorites,
  }) async {
    if (ordered.length != expectedFavorites.length ||
        ordered.toSet().length != ordered.length ||
        !ordered.toSet().containsAll(expectedFavorites)) {
      return false;
    }
    final frozen = List<MarketProductRef>.unmodifiable(ordered);
    return _execute(
      null,
      () => ref.read(marketsRepositoryProvider).replaceFavorites(frozen),
    );
  }

  Future<bool> _execute(
    MarketProductRef? product,
    Future<void> Function() send,
  ) async {
    if (_pending) return false;
    final generation = _generation;
    final session = ref.read(sessionGenerationProvider);
    _pending = true;
    state = const AsyncLoading();
    final result = await AsyncValue.guard(send);
    if (!ref.mounted ||
        generation != _generation ||
        session != ref.read(sessionGenerationProvider)) {
      return false;
    }
    _pending = false;
    state = result;
    // A lost response may still have committed. Reconcile on failure too,
    // without treating an unconfirmed mutation as a successful star toggle.
    _invalidate(product);
    return !result.hasError;
  }

  void _invalidate(MarketProductRef? product) {
    if (product == null) {
      ref.invalidate(marketProductProvider);
    } else {
      ref.invalidate(marketProductProvider(product));
    }
    ref.invalidate(marketProductsProvider);
    ref.invalidate(marketListProvider);
  }
}
