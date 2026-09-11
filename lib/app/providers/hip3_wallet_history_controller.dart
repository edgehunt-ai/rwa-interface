import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/hip3_wallet_history.dart';
import 'api_providers.dart';
import 'session_scope.dart';

typedef Hip3WalletHistoryRequest = ({
  Hip3HistoryKind kind,
  Hip3HistoryQuery query,
});
final hip3WalletHistoryControllerProvider = AsyncNotifierProvider.autoDispose
    .family<
      Hip3WalletHistoryController,
      Hip3WalletHistoryState,
      Hip3WalletHistoryRequest
    >(Hip3WalletHistoryController.new);

final class Hip3WalletHistoryState {
  Hip3WalletHistoryState({
    required this.page,
    required List<Object> items,
    this.loadingMore = false,
    this.pageError,
    Set<String> consumedCursors = const {},
  }) : items = List.unmodifiable(items),
       consumedCursors = Set.unmodifiable(consumedCursors);
  final Hip3HistoryPage<Object> page;
  final List<Object> items;
  final bool loadingMore;
  final Object? pageError;
  final Set<String> consumedCursors;
}

class Hip3WalletHistoryController
    extends AsyncNotifier<Hip3WalletHistoryState> {
  Hip3WalletHistoryController(this.request);
  final Hip3WalletHistoryRequest request;
  int _generation = 0;
  @override
  Future<Hip3WalletHistoryState> build() async {
    ref.watch(sessionGenerationProvider);
    ref.watch(hip3WalletHistoryRepositoryProvider);
    _generation++;
    ref.onDispose(() => _generation++);
    final page = await _read(null);
    return Hip3WalletHistoryState(page: page, items: page.items);
  }

  Future<Hip3HistoryPage<Object>> _read(String? cursor) {
    final repository = ref.read(hip3WalletHistoryRepositoryProvider);
    return switch (request.kind) {
      Hip3HistoryKind.funding => repository.funding(
        request.query,
        cursor: cursor,
      ),
      Hip3HistoryKind.liquidations => repository.liquidations(
        request.query,
        cursor: cursor,
      ),
    };
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null ||
        state.isLoading ||
        current.loadingMore ||
        !current.page.hasMore) {
      return;
    }
    final generation = _generation;
    state = AsyncData(
      Hip3WalletHistoryState(
        page: current.page,
        items: current.items,
        loadingMore: true,
        consumedCursors: current.consumedCursors,
      ),
    );
    try {
      final cursor = current.page.nextCursor;
      if (cursor == null ||
          cursor.isEmpty ||
          current.consumedCursors.contains(cursor)) {
        throw const DecodingFailure();
      }
      final page = await _read(cursor);
      if (!ref.mounted || generation != _generation) return;
      if (page.snapshotId != current.page.snapshotId ||
          page.environment != current.page.environment ||
          page.source != current.page.source ||
          page.observedAt != current.page.observedAt ||
          (page.hasMore &&
              (page.nextCursor == cursor ||
                  current.consumedCursors.contains(page.nextCursor)))) {
        throw const DecodingFailure();
      }
      final merged = {for (final item in current.items) _id(item): item};
      for (final item in page.items) {
        final old = merged[_id(item)];
        if (old != null && _fingerprint(old) != _fingerprint(item)) {
          throw const DecodingFailure();
        }
        merged[_id(item)] = item;
      }
      if (merged.length > 10000) throw const DecodingFailure();
      state = AsyncData(
        Hip3WalletHistoryState(
          page: page,
          items: merged.values.toList(),
          consumedCursors: {...current.consumedCursors, cursor},
        ),
      );
    } catch (error) {
      if (!ref.mounted || generation != _generation) return;
      state = AsyncData(
        Hip3WalletHistoryState(
          page: current.page,
          items: current.items,
          pageError: error,
          consumedCursors: current.consumedCursors,
        ),
      );
    }
  }

  String _id(Object item) => switch (item) {
    Hip3FundingPayment(:final id) => id,
    Hip3LiquidationEvent(:final id) => id,
    _ => throw const DecodingFailure(),
  };
  String _fingerprint(Object item) => jsonEncode(switch (item) {
    Hip3FundingPayment p => [
      p.productId,
      p.amount.value,
      p.settlementAsset,
      p.collateralToken,
      p.signedPositionSize.value,
      p.fundingRate.value,
      p.transactionHash,
      p.occurredAt.toIso8601String(),
    ],
    Hip3LiquidationEvent e => [
      e.providerAccountValue.value,
      e.accountValueScope,
      e.marginMode,
      e.excludedNativePositionCount,
      e.transactionHash,
      e.occurredAt.toIso8601String(),
      [
        for (final p in e.positions) [p.productId, p.signedPositionSize.value],
      ],
    ],
    _ => throw const DecodingFailure(),
  });
}
