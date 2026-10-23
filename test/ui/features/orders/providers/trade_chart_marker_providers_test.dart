import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/realtime_providers.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/market_snapshot.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/repositories/orders_repository.dart';
import 'package:nobell/domain/repositories/realtime_repository.dart';
import 'package:nobell/ui/features/orders/providers/trade_chart_marker_providers.dart';
import 'package:nobell/ui/features/positions/providers/position_providers.dart';

const _query = (
  product: MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.perp),
  productId: 'xyz:NVDA',
);

void main() {
  test(
    'order history reads every page and filters the complete product identity',
    () async {
      final orders = _Orders();
      final container = ProviderContainer(
        overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
      );
      addTearDown(container.dispose);
      final result = await container.read(
        tradeChartOrdersProvider(_query).future,
      );
      expect(result.map((e) => e.orderId), ['first', 'second']);
      expect(orders.cursors, [null, 'page-2']);
      expect(orders.productIds, everyElement('xyz:NVDA'));
      expect(orders.statusGroups, everyElement(isNull));
    },
  );

  test(
    'bad history pagination fails explicitly instead of truncating history',
    () async {
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(_Orders(broken: true)),
        ],
      );
      addTearDown(container.dispose);
      await expectLater(
        container.read(tradeChartOrdersProvider(_query).future),
        throwsA(isA<CompatibilityFailure>()),
      );
    },
  );

  test('position levels follow all pages and exclude same-symbol positions from other venues', () async {
    var closed = false;
    final container = ProviderContainer(
      overrides: [
        positionsProvider.overrideWith(
          (_, query) async => DomainPage(
            items: closed
                ? []
                : [
                    _position(query.cursor ?? 'first'),
                    _position('other', productId: 'abc:NVDA'),
                  ],
            hasMore: !closed && query.cursor == null,
            nextCursor: !closed && query.cursor == null ? 'page-2' : null,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      tradeChartPositionsProvider(_query),
      (_, _) {},
    );
    addTearDown(subscription.close);
    expect(
      (await container.read(tradeChartPositionsProvider(_query).future))
          .map((e) => e.positionId),
      ['first', 'page-2'],
    );
    closed = true;
    container.invalidate(positionsProvider);
    expect(
      await container.read(tradeChartPositionsProvider(_query).future),
      isEmpty,
    );
  });

  testWidgets('realtime updates and foreground polling refresh chart data', (
    tester,
  ) async {
    final orders = _Orders();
    final events = StreamController<TypedRealtimeEvent>();
    var chartCalls = 0;
    final chartQuery = (
      product: _query.product,
      range: CandleChartRange.oneHour,
    );
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(orders),
        marketCandlesProvider.overrideWith((_, _) async {
          chartCalls++;
          return const CandleChart(symbol: 'NVDA', range: '1h', points: []);
        }),
        positionsProvider.overrideWith(
          (_, _) async => const DomainPage(items: <Position>[]),
        ),
        typedRealtimeEventsProvider.overrideWith((_, key) {
          expect(key.channelsKey, 'hip3:orders,hip3:positions');
          return events.stream;
        }),
      ],
    );
    try {
      final chartSubscription = container.listen(
        marketCandlesProvider(chartQuery),
        (_, _) {},
      );
      final markerSubscription = container.listen(
        tradeChartOrdersProvider(_query),
        (_, _) {},
      );
      final positionSubscription = container.listen(
        tradeChartPositionsProvider(_query),
        (_, _) {},
      );
      final refreshSubscription = container.listen(
        tradeChartMarkerRefreshProvider((
          product: _query,
          range: CandleChartRange.oneHour,
          liquidation: null,
        )),
        (_, _) {},
      );
      await tester.pump();
      await container.read(tradeChartOrdersProvider(_query).future);
      await container.read(marketCandlesProvider(chartQuery).future);
      final initialCalls = orders.cursors.length;
      final initialChartCalls = chartCalls;
      events.add(
        const TypedRealtimeEvent(
          id: 'event',
          kind: 'order.updated',
          entityId: 'first',
          sequence: 1,
          payload: {},
        ),
      );
      await tester.pump();
      await tester.pump();
      await container.read(tradeChartOrdersProvider(_query).future);
      await container.read(marketCandlesProvider(chartQuery).future);
      expect(orders.cursors.length, greaterThan(initialCalls));
      expect(chartCalls, greaterThan(initialChartCalls));
      final realtimeChartCalls = chartCalls;
      final realtimeCalls = orders.cursors.length;
      await tester.pump(const Duration(seconds: 5));
      await tester.pump();
      await container.read(tradeChartOrdersProvider(_query).future);
      await container.read(marketCandlesProvider(chartQuery).future);
      expect(orders.cursors.length, greaterThan(realtimeCalls));
      expect(chartCalls, greaterThan(realtimeChartCalls));
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      final pausedCalls = orders.cursors.length;
      final pausedChartCalls = chartCalls;
      await tester.pump(const Duration(seconds: 10));
      expect(orders.cursors.length, pausedCalls);
      expect(chartCalls, pausedChartCalls);
      chartSubscription.close();
      refreshSubscription.close();
      positionSubscription.close();
      markerSubscription.close();
    } finally {
      container.dispose();
      unawaited(events.close());
      await tester.pump();
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    }
  });
}

class _Orders implements OrdersRepository {
  _Orders({this.broken = false});
  final bool broken;
  final cursors = <String?>[];
  final productIds = <String?>[];
  final statusGroups = <String?>[];
  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async {
    cursors.add(cursor);
    productIds.add(productId);
    statusGroups.add(statusGroup);
    return DomainPage(
      items: [
        ResourceResult(resource: _order(cursor == null ? 'first' : 'second')),
        ResourceResult(resource: _order('other', productId: 'abc:NVDA')),
      ],
      hasMore: cursor == null,
      nextCursor: cursor == null && !broken ? 'page-2' : null,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

TradingOrder _order(String id, {String productId = 'xyz:NVDA'}) => TradingOrder(
  orderId: id,
  productId: productId,
  symbol: 'NVDA',
  kind: MarketProductKind.perp,
  side: TradingSide.long,
  type: TradingOrderType.market,
  status: TradingOrderStatus.filled,
  createdAt: DateTime.utc(2026),
);

Position _position(String id, {String productId = 'xyz:NVDA'}) => Position(
  positionId: id,
  productId: productId,
  symbol: 'NVDA',
  kind: MarketProductKind.perp,
  side: PositionSide.long,
  quantity: DecimalValue('1'),
  valueUsd: DecimalValue('100'),
);
