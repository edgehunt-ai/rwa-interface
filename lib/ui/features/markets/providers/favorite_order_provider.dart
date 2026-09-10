import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_list_query.dart';
import '../../../../domain/models/api_failure.dart';
import 'market_providers.dart';

final favoriteOrderProvider =
    AsyncNotifierProvider.autoDispose<FavoriteOrder, List<MarketProduct>>(
      FavoriteOrder.new,
      retry: (_, _) => null,
    );

/// An editing snapshot of the entire server favorites set, never a filtered
/// market page. No polling can silently overwrite a user's unsaved order.
class FavoriteOrder extends AsyncNotifier<List<MarketProduct>> {
  static const maximumFavorites = 1000;
  // Also bounds empty or sparse pages with endlessly advancing cursors.
  static const maximumPages = maximumFavorites;
  int _generation = 0;
  List<MarketProductRef> _baseline = const [];
  @override
  Future<List<MarketProduct>> build() async {
    final generation = ++_generation;
    ref.onDispose(() => _generation++);
    final session = ref.watch(sessionGenerationProvider);
    final repository = ref.watch(marketsRepositoryProvider);
    _baseline = const [];
    final products = <MarketProduct>[];
    final identities = <MarketProductRef>{};
    final cursors = <String>{};
    String? cursor;
    var pages = 0;
    do {
      if (++pages > maximumPages) throw const DecodingFailure();
      final page = await repository.listProducts(
        group: MarketListGroup.favorites,
        kind: null,
        query: null,
        cursor: cursor,
        limit: 100,
      );
      if (!ref.mounted ||
          generation != _generation ||
          ref.read(sessionGenerationProvider) != session) {
        throw const CancelledFailure();
      }
      for (final product in page.items) {
        if (!identities.add(product.ref)) throw const DecodingFailure();
        products.add(product);
        if (products.length > maximumFavorites) throw const DecodingFailure();
      }
      if (!page.hasMore) break;
      cursor = page.nextCursor;
      if (cursor == null || cursor.isEmpty || !cursors.add(cursor)) {
        throw const DecodingFailure();
      }
    } while (true);
    _baseline = List.unmodifiable(products.map((p) => p.ref));
    return List.unmodifiable(products);
  }

  void move(int index, int destination) {
    if (state.isLoading ||
        state.hasError ||
        ref.read(favoritesCommandProvider).isLoading) {
      return;
    }
    final products = state.requireValue.toList();
    if (index < 0 ||
        index >= products.length ||
        destination < 0 ||
        destination >= products.length) {
      return;
    }
    products.insert(destination, products.removeAt(index));
    state = AsyncData(List.unmodifiable(products));
  }

  Future<bool> save() async {
    if (state.isLoading || state.hasError) return false;
    final session = ref.read(sessionGenerationProvider);
    final generation = _generation;
    final saved = await ref
        .read(favoritesCommandProvider.notifier)
        .replace(
          state.requireValue.map((p) => p.ref).toList(),
          expectedFavorites: _baseline,
        );
    if (!ref.mounted ||
        generation != _generation ||
        ref.read(sessionGenerationProvider) != session) {
      return false;
    }
    // 409 or an uncertain transport result requires a fresh complete set before
    // another submission. Never retry an obsolete ordering automatically.
    if (!saved) ref.invalidateSelf();
    return saved;
  }
}
