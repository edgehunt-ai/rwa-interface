import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/hip3_query_refresh.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/market_list_query.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/repositories/markets_repository.dart';

final marketListProvider = NotifierProvider.autoDispose
    .family<MarketListNotifier, MarketListState, MarketListQuery>(
      MarketListNotifier.new,
    );

final class MarketListState {
  const MarketListState({
    this.items = const [],
    this.nextCursor,
    this.hasMore = false,
    this.loading = false,
    this.loadingMore = false,
    this.error,
  });
  final List<MarketProduct> items;
  final String? nextCursor;
  final bool hasMore;
  final bool loading;
  final bool loadingMore;
  final Object? error;
}

/// One instance per complete filter. Refresh/rebuild generations additionally
/// isolate late pages for the *same* filter, including account changes.
final class MarketListNotifier extends Notifier<MarketListState> {
  MarketListNotifier(this.query);
  final MarketListQuery query;
  int _generation = 0;
  Future<void>? _more;
  final _usedCursors = <String>{};
  Timer? _timer;
  bool _subscribed = true;
  bool _reading = false;
  int _pages = 1;

  @override
  MarketListState build() {
    ref.watch(sessionGenerationProvider);
    final repository = ref.watch(marketsRepositoryProvider);
    final generation = ++_generation;
    _usedCursors.clear();
    _more = null;
    _pages = 1;
    _subscribed = true;
    _reading = true;
    ref.onDispose(() {
      _generation++;
      _timer?.cancel();
    });
    ref.onCancel(() {
      _subscribed = false;
      _timer?.cancel();
    });
    ref.onResume(() {
      _subscribed = true;
      _schedule();
    });
    ref.listen(hip3ForegroundProvider, (_, foreground) {
      _timer?.cancel();
      if (foreground && _subscribed && !_reading && _more == null) {
        unawaited(_refreshVisible());
      }
    });
    unawaited(_first(repository, generation));
    return const MarketListState(loading: true);
  }

  Future<DomainPage<MarketProduct>> _page(
    MarketsRepository repository,
    String? cursor,
  ) => repository.listProducts(
    query: query.query.trim().isEmpty ? null : query.query.trim(),
    cursor: cursor,
    kind: query.kind,
    group: query.group,
    limit: query.limit,
  );

  bool _current(int generation) => ref.mounted && _generation == generation;

  void _schedule() {
    _timer?.cancel();
    if (!ref.mounted ||
        !_subscribed ||
        _reading ||
        _more != null ||
        !ref.read(hip3ForegroundProvider)) {
      return;
    }
    _timer = Timer(const Duration(seconds: 10), () {
      if (ref.mounted && _subscribed && ref.read(hip3ForegroundProvider)) {
        unawaited(_refreshVisible());
      }
    });
  }

  /// Re-read the visible window from page one, never append a fresh first page
  /// to old cursor pages. Publish atomically so polling preserves scroll data.
  Future<void> _refreshVisible() async {
    if (_reading || _more != null) return;
    _reading = true;
    final generation = _generation;
    final repository = ref.read(marketsRepositoryProvider);
    final previous = state;
    final used = <String>{};
    var updated = const MarketListState();
    try {
      String? cursor;
      for (var index = 0; index < _pages; index++) {
        if (!_subscribed || !ref.read(hip3ForegroundProvider)) return;
        final page = await _page(repository, cursor);
        if (!_current(generation)) return;
        if (page.hasMore &&
            (page.nextCursor == null ||
                page.nextCursor!.isEmpty ||
                page.nextCursor == cursor ||
                used.contains(page.nextCursor))) {
          throw const FormatException('Market pagination did not advance');
        }
        if (cursor != null) used.add(cursor);
        updated = _loaded(page, updated.items);
        if (!page.hasMore) break;
        cursor = page.nextCursor;
      }
      _usedCursors
        ..clear()
        ..addAll(used);
      state = updated;
    } catch (error) {
      if (_current(generation)) {
        state = MarketListState(
          items: previous.items,
          nextCursor: previous.nextCursor,
          hasMore: previous.hasMore,
          error: error,
        );
      }
    } finally {
      if (_current(generation)) {
        _reading = false;
        _schedule();
      }
    }
  }

  Future<void> refresh() {
    final generation = ++_generation;
    _usedCursors.clear();
    _more = null;
    _timer?.cancel();
    _pages = 1;
    _reading = true;
    state = const MarketListState(loading: true);
    return _first(ref.read(marketsRepositoryProvider), generation);
  }

  Future<void> _first(MarketsRepository repository, int generation) async {
    try {
      final page = await Future.sync(() => _page(repository, null));
      if (!_current(generation)) return;
      _validateCursor(page, null);
      state = _loaded(page, const []);
    } catch (error) {
      if (_current(generation)) state = MarketListState(error: error);
    } finally {
      if (_current(generation)) {
        _reading = false;
        _schedule();
      }
    }
  }

  Future<void> loadMore() {
    if (_more != null) return _more!;
    if (_reading ||
        state.loading ||
        !state.hasMore ||
        state.nextCursor == null) {
      return Future.value();
    }
    final generation = _generation;
    _timer?.cancel();
    final previous = state;
    final request = _next(
      ref.read(marketsRepositoryProvider),
      previous,
      generation,
    );
    _more = request;
    return request.whenComplete(() {
      if (_current(generation)) {
        _more = null;
        _schedule();
      }
    });
  }

  Future<void> _next(
    MarketsRepository repository,
    MarketListState previous,
    int generation,
  ) async {
    state = MarketListState(
      items: previous.items,
      nextCursor: previous.nextCursor,
      hasMore: true,
      loadingMore: true,
    );
    try {
      final page = await _page(repository, previous.nextCursor);
      if (!_current(generation)) return;
      _validateCursor(page, previous.nextCursor);
      _usedCursors.add(previous.nextCursor!);
      _pages++;
      state = _loaded(page, previous.items);
    } catch (error) {
      if (_current(generation)) {
        state = MarketListState(
          items: previous.items,
          nextCursor: previous.nextCursor,
          hasMore: true,
          error: error,
        );
      }
    }
  }

  void _validateCursor(DomainPage<MarketProduct> page, String? requested) {
    if (page.hasMore &&
        (page.nextCursor == null ||
            page.nextCursor!.isEmpty ||
            page.nextCursor == requested ||
            _usedCursors.contains(page.nextCursor))) {
      throw const FormatException('Market pagination did not advance');
    }
  }

  MarketListState _loaded(
    DomainPage<MarketProduct> page,
    List<MarketProduct> previous,
  ) {
    // Preserve server order. Same ticker across venues/product kinds is not a duplicate.
    final unique = <MarketProductRef, MarketProduct>{
      for (final product in previous)
        MarketProductRef(symbol: product.symbol, kind: product.kind): product,
    };
    for (final product in page.items) {
      // Defensive only: the server must filter before pagination. Do not use
      // bStocks grouping, which would drop HIP3-only symbols.
      if (query.kind != null && product.kind != query.kind) continue;
      unique[MarketProductRef(symbol: product.symbol, kind: product.kind)] =
          product;
    }
    return MarketListState(
      items: List.unmodifiable(unique.values),
      hasMore: page.hasMore,
      nextCursor: page.hasMore ? page.nextCursor : null,
    );
  }
}
