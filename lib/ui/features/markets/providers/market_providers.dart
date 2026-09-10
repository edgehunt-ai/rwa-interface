import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_snapshot.dart';

typedef MarketQuery = ({String? query, String? cursor});

final marketProductsProvider = FutureProvider.autoDispose
    .family<DomainPage<MarketProduct>, MarketQuery>((ref, query) {
      return ref
          .watch(marketsRepositoryProvider)
          .listProducts(query: query.query, cursor: query.cursor);
    });

final marketProductProvider = FutureProvider.autoDispose
    .family<MarketProduct, MarketProductRef>((ref, product) {
      return ref.watch(marketsRepositoryProvider).getProduct(product);
    });

final marketSnapshotProvider = FutureProvider.autoDispose
    .family<MarketSnapshot, MarketProductRef>((ref, product) async {
      Timer? timer;
      ref.onDispose(() => timer?.cancel());
      try {
        return await ref.watch(marketsRepositoryProvider).getSnapshot(product);
      } finally {
        if (product.kind == MarketProductKind.perp && ref.mounted) {
          timer = Timer(const Duration(seconds: 10), ref.invalidateSelf);
        }
      }
    });

final marketCandlesProvider = FutureProvider.autoDispose
    .family<CandleChart, ({MarketProductRef product, String? interval})>(
      (ref, query) => ref
          .watch(marketsRepositoryProvider)
          .getCandles(query.product, interval: query.interval),
    );

final favoritesCommandProvider =
    AsyncNotifierProvider.autoDispose<FavoritesCommand, void>(
      FavoritesCommand.new,
    );

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
