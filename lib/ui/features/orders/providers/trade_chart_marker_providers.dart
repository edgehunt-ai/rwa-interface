import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app_review/app_review.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/provider_lifecycle.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../app/providers/realtime_providers.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/application_state.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/market_snapshot.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/trade_chart_marker.dart';
import '../../positions/providers/position_providers.dart';
import '../../markets/providers/market_providers.dart';
import 'order_providers.dart';

typedef TradeChartProduct = ({MarketProductRef product, String? productId});
typedef TradeChartLiquidationQuery = ({
  String productId,
  DateTime from,
  DateTime to,
});

final tradeChartOrdersProvider = FutureProvider.autoDispose
    .family<List<TradingOrder>, TradeChartProduct>((ref, query) async {
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(ordersRepositoryProvider);
      final orders = <String, TradingOrder>{};
      final cursors = <String>{};
      String? cursor;
      do {
        final page = await repository.list(
          kind: query.product.kind,
          symbol: query.product.symbol,
          productId: query.productId,
          cursor: cursor,
        );
        if (!ref.mounted) throw const CancelledFailure();
        for (final item in page.items) {
          final order = item.resource;
          if (order.kind == query.product.kind &&
              order.symbol == query.product.symbol &&
              (query.productId == null || order.productId == query.productId)) {
            orders[order.orderId] = order;
          }
        }
        if (!page.hasMore) break;
        cursor = page.nextCursor;
        if (cursor == null || cursor.isEmpty || !cursors.add(cursor)) {
          throw const CompatibilityFailure(
            userAction: 'Trade history pagination is incomplete',
          );
        }
      } while (true);
      return orders.values.toList();
    }, retry: (_, _) => null);

final tradeChartPositionsProvider = FutureProvider.autoDispose
    .family<List<Position>, TradeChartProduct>((ref, query) async {
      ref.watch(sessionGenerationProvider);
      final positions = <String, Position>{};
      final cursors = <String>{};
      String? cursor;
      do {
        final page = await ref.watch(
          positionsProvider((
            symbol: query.product.symbol,
            kind: query.product.kind,
            cursor: cursor,
          )).future,
        );
        if (!ref.mounted) throw const CancelledFailure();
        for (final position in page.items) {
          if (position.kind == query.product.kind &&
              position.symbol == query.product.symbol &&
              (query.productId == null ||
                  position.productId == query.productId)) {
            positions[position.positionId] = position;
          }
        }
        if (!page.hasMore) break;
        cursor = page.nextCursor;
        if (cursor == null || cursor.isEmpty || !cursors.add(cursor)) {
          throw const CompatibilityFailure(
            userAction: 'Position pagination is incomplete',
          );
        }
      } while (true);
      return positions.values.toList();
    }, retry: (_, _) => null);

final tradeChartLiquidationsProvider = FutureProvider.autoDispose
    .family<TradeChartLiquidations, TradeChartLiquidationQuery>((ref, query) {
      ref.watch(sessionGenerationProvider);
      if (AppReviewConfiguration.buildEnabled &&
          ref.watch(appReviewModeProvider)) {
        return const TradeChartLiquidations();
      }
      return ref
          .watch(tradeChartLiquidationsRepositoryProvider)
          .list(productId: query.productId, from: query.from, to: query.to);
    }, retry: (_, _) => null);

typedef TradeChartRefreshQuery = ({
  TradeChartProduct product,
  CandleChartRange range,
  TradeChartLiquidationQuery? liquidation,
});

final tradeChartMarkerRefreshProvider = Provider.autoDispose
    .family<void, TradeChartRefreshQuery>((ref, request) {
      final query = request.product;
      final chartQuery = (product: query.product, range: request.range);
      ref.watch(sessionGenerationProvider);
      void refreshMarkers() {
        ref.invalidate(marketCandlesProvider(chartQuery));
        ref.invalidate(tradeChartOrdersProvider(query));
        if (query.product.kind == MarketProductKind.perp) {
          ref.invalidate(positionsProvider);
          if (request.liquidation case final liquidation?) {
            ref.invalidate(tradeChartLiquidationsProvider(liquidation));
          }
        }
      }

      ref.listen(
        typedRealtimeEventsProvider((
          channelsKey: query.product.kind == MarketProductKind.perp
              ? 'hip3:orders,hip3:positions'
              : 'orders,positions',
          generation: ref.read(sessionGenerationProvider).value,
        )),
        (_, next) {
          if (next.hasValue && !next.isLoading) refreshMarkers();
        },
      );
      refreshWhileActive(
        ref,
        interval: const Duration(seconds: 5),
        refresh: () {
          if (!ref.read(marketCandlesProvider(chartQuery)).isLoading) {
            ref.invalidate(marketCandlesProvider(chartQuery));
          }
          if (!ref.read(tradeChartOrdersProvider(query)).isLoading) {
            ref.invalidate(tradeChartOrdersProvider(query));
          }
          if (query.product.kind == MarketProductKind.perp &&
              !ref.read(tradeChartPositionsProvider(query)).isLoading) {
            ref.invalidate(positionsProvider);
          }
          if (request.liquidation case final liquidation?) {
            if (!ref
                .read(tradeChartLiquidationsProvider(liquidation))
                .isLoading) {
              ref.invalidate(tradeChartLiquidationsProvider(liquidation));
            }
          }
        },
      );
      // A completed app action updates the chart immediately, without waiting
      // for the foreground refresh that also catches external fills/closures.
      ref.listen(orderCommandProvider, (_, next) {
        if (next is CommandAccepted) refreshMarkers();
      });
      ref.listen(orderCancellationsProvider, (previous, next) {
        if (previous != null && previous.any((id) => !next.contains(id))) {
          refreshMarkers();
        }
      });
    });
