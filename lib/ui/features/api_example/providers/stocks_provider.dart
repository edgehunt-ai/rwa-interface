import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../domain/models/stock.dart';

final stocksProvider =
    AsyncNotifierProvider.autoDispose<StocksNotifier, List<Stock>>(
      StocksNotifier.new,
    );

final stocksSearchProvider = AsyncNotifierProvider.autoDispose
    .family<StocksSearchNotifier, List<Stock>, String>(
      StocksSearchNotifier.new,
    );

final class StocksNotifier extends AsyncNotifier<List<Stock>> {
  var _generation = 0;
  @override
  Future<List<Stock>> build() async =>
      (await ref.watch(marketsRepositoryProvider).listStocks()).items;

  Future<void> refresh() async {
    final generation = ++_generation;
    final previous = state.value;
    // Riverpod 暂未提供 public constructor 表达“loading + previous data”。
    // ignore: invalid_use_of_internal_member
    state = const AsyncLoading<List<Stock>>().copyWithPrevious(state);
    final next = await AsyncValue.guard(
      () async =>
          (await ref.read(marketsRepositoryProvider).listStocks()).items,
    );
    if (generation == _generation && ref.mounted) state = next;
    if (next.hasError && previous != null && ref.mounted) {
      final failure = AsyncError<List<Stock>>(
        next.error!,
        next.stackTrace ?? StackTrace.current,
      );
      // ignore: invalid_use_of_internal_member
      state = failure.copyWithPrevious(AsyncData(previous));
    }
  }
}

final class StocksSearchNotifier extends AsyncNotifier<List<Stock>> {
  StocksSearchNotifier(this.query);
  final String query;

  @override
  Future<List<Stock>> build() async {
    final stocks =
        (await ref.watch(marketsRepositoryProvider).listStocks()).items;
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) return stocks;
    return stocks
        .where(
          (stock) =>
              stock.symbol.toLowerCase().contains(normalized) ||
              stock.name.toLowerCase().contains(normalized),
        )
        .toList(growable: false);
  }
}
