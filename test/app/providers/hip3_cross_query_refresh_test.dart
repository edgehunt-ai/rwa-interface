import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/app/providers/hip3_live_provider.dart';
import 'package:rwa_interface/app/providers/hip3_live_scope.dart';
import 'package:rwa_interface/domain/models/hip3_live.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

void main() {
  testWidgets(
    'push refreshes real order position holdings and summary providers before polling',
    (tester) async {
      final venue = _Venue();
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(_Orders(venue)),
          positionsRepositoryProvider.overrideWithValue(_Positions(venue)),
          portfolioRepositoryProvider.overrideWithValue(_Portfolio(venue)),
          hip3AccountLiveProvider.overrideWith((ref) {
            final revision = ref.watch(_pushRevision);
            if (revision == 0) {
              return const Hip3LiveConnection(Hip3LivePhase.disabled);
            }
            return Hip3LiveConnection(
              Hip3LivePhase.live,
              snapshot: Hip3LiveSnapshot(
                query: Hip3LiveQuery(
                  signer: '0x1111111111111111111111111111111111111111',
                  environment: 'testnet',
                  channels: {'hip3:orders', 'hip3:positions', 'hip3:balance'},
                ),
                cursor: 'h3.11111111111111111111111111111111.$revision',
                completedAt: DateTime.utc(2026),
                emittedAt: DateTime.utc(2026),
                orders: {},
                positions: {},
                prices: {},
                candles: {},
              ),
            );
          }),
        ],
      );
      const filter = (
        symbol: 'xyz:TSLA',
        kind: MarketProductKind.perp,
        cursor: null,
      );
      const openQuery = (
        symbol: 'TSLA',
        productId: 'xyz:TSLA',
        cursor: 'page-2',
      );
      final subscriptions = [
        container.listen(hip3OrdersProvider(null), (_, _) {}),
        container.listen(hip3OpenOrdersProvider(openQuery), (_, _) {}),
        container.listen(positionsProvider(filter), (_, _) {}),
        container.listen(portfolioSummaryProvider, (_, _) {}),
        container.listen(holdingsOverviewProvider, (_, _) {}),
      ];
      await tester.pump();
      expect(
        container.read(positionsProvider(filter)).requireValue.items,
        isEmpty,
      );
      venue.phase = 1;
      container.read(_pushRevision.notifier).push();
      await tester.pump();
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();
      expect(
        container
            .read(hip3OrdersProvider(null))
            .requireValue
            .items
            .single
            .resource
            .status,
        TradingOrderStatus.filled,
      );
      expect(
        container
            .read(positionsProvider(filter))
            .requireValue
            .items
            .single
            .quantity
            .value,
        '1',
      );
      expect(
        container
            .read(holdingsOverviewProvider)
            .requireValue
            .items
            .single
            .positions
            .single
            .quantity
            .value,
        '1',
      );
      expect(
        container
            .read(portfolioSummaryProvider)
            .requireValue
            .totalValueUsd
            .value,
        '101',
      );
      expect(venue.commands, 0);
      final openPage = container
          .read(hip3OpenOrdersProvider(openQuery))
          .requireValue;
      expect(openPage.nextCursor, 'server-next');
      expect(openPage.hasMore, isTrue);
      expect(openPage.items, isEmpty);
      expect(venue.orderQueries.where((q) => q['cursor'] != null), [
        {
          'cursor': 'page-2',
          'kind': MarketProductKind.perp,
          'symbol': 'TSLA',
          'productId': 'xyz:TSLA',
          'statusGroup': 'open',
        },
        {
          'cursor': 'page-2',
          'kind': MarketProductKind.perp,
          'symbol': 'TSLA',
          'productId': 'xyz:TSLA',
          'statusGroup': 'open',
        },
      ]);
      for (final sub in subscriptions) {
        sub.close();
      }
      container.dispose();
    },
  );
  testWidgets(
    'later fill and close command refresh real order position and asset providers',
    (tester) async {
      final venue = _Venue();
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(_Orders(venue)),
          positionsRepositoryProvider.overrideWithValue(_Positions(venue)),
          portfolioRepositoryProvider.overrideWithValue(_Portfolio(venue)),
        ],
      );
      const filter = (
        symbol: 'TSLA',
        kind: MarketProductKind.perp,
        cursor: null,
      );
      final subscriptions = [
        container.listen(hip3OrdersProvider(null), (_, _) {}),
        container.listen(positionsProvider(filter), (_, _) {}),
        container.listen(portfolioSummaryProvider, (_, _) {}),
        container.listen(holdingsOverviewProvider, (_, _) {}),
        container.listen(positionCommandProvider, (_, _) {}),
      ];
      await tester.pump();
      expect(
        container
            .read(hip3OrdersProvider(null))
            .requireValue
            .items
            .single
            .resource
            .status,
        TradingOrderStatus.open,
      );
      expect(
        container.read(positionsProvider(filter)).requireValue.items,
        isEmpty,
      );
      venue.phase =
          1; // A venue fill arrives later, without a front-end command.
      await tester.pump(const Duration(seconds: 10));
      await tester.pump();
      expect(
        container
            .read(hip3OrdersProvider(null))
            .requireValue
            .items
            .single
            .resource
            .status,
        TradingOrderStatus.filled,
      );
      expect(
        container
            .read(positionsProvider(filter))
            .requireValue
            .items
            .single
            .quantity
            .value,
        '1',
      );
      expect(
        container
            .read(holdingsOverviewProvider)
            .requireValue
            .items
            .single
            .positions
            .single
            .quantity
            .value,
        '1',
      );
      expect(
        container
            .read(portfolioSummaryProvider)
            .requireValue
            .totalValueUsd
            .value,
        '101',
      );
      expect(venue.commands, 0);

      await container.read(positionCommandProvider).close('p', quantity: '1');
      await tester.pump(const Duration(milliseconds: 1));
      expect(venue.commands, 1);
      expect(
        container.read(positionsProvider(filter)).requireValue.items,
        isEmpty,
      );
      expect(
        container.read(holdingsOverviewProvider).requireValue.items,
        isEmpty,
      );
      expect(
        container
            .read(portfolioSummaryProvider)
            .requireValue
            .totalValueUsd
            .value,
        '102',
      );

      final reads = venue.reads;
      container.read(hip3ForegroundProvider.notifier).setForeground(false);
      await tester.pump(const Duration(seconds: 30));
      expect(venue.reads, reads);
      expect(
        venue.commands,
        1,
        reason: 'polling must never sign or broadcast again',
      );
      for (final subscription in subscriptions) {
        subscription.close();
      }
      container.dispose();
    },
  );
}

final _pushRevision = NotifierProvider<_PushRevision, int>(_PushRevision.new);

class _PushRevision extends Notifier<int> {
  @override
  int build() => 0;
  void push() => state++;
}

final class _Venue {
  final orderQueries = <Map<String, Object?>>[];
  var phase = 0;
  var reads = 0;
  var commands = 0;
  TradingOrder get order => TradingOrder(
    orderId: 'o',
    symbol: 'TSLA',
    kind: MarketProductKind.perp,
    side: TradingSide.long,
    type: TradingOrderType.limit,
    status: phase == 0 ? TradingOrderStatus.open : TradingOrderStatus.filled,
    createdAt: DateTime.utc(2026, 9, 10),
  );
  Position get position => Position(
    positionId: 'p',
    symbol: 'TSLA',
    productId: 'xyz:TSLA',
    kind: MarketProductKind.perp,
    quantity: DecimalValue('1', unit: 'quantity'),
    valueUsd: DecimalValue('100', asset: 'USD', unit: 'fiat'),
  );
}

final class _Orders implements OrdersRepository {
  _Orders(this.venue);
  final _Venue venue;
  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async {
    venue.reads++;
    venue.orderQueries.add({
      'cursor': cursor,
      'kind': kind,
      'symbol': symbol,
      'productId': productId,
      'statusGroup': statusGroup,
    });
    if (statusGroup == 'open') {
      return const DomainPage(
        items: [],
        nextCursor: 'server-next',
        hasMore: true,
      );
    }
    return DomainPage(items: [ResourceResult(resource: venue.order)]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Positions implements PositionsRepository {
  _Positions(this.venue);
  final _Venue venue;
  @override
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  }) async {
    venue.reads++;
    return DomainPage(items: venue.phase == 1 ? [venue.position] : []);
  }

  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    required String idempotencyKey,
  }) async {
    venue.commands++;
    venue.phase = 2;
    return venue.order;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Portfolio implements PortfolioRepository {
  _Portfolio(this.venue);
  final _Venue venue;
  @override
  Future<Portfolio> getSummary() async {
    venue.reads++;
    return Portfolio(
      totalValueUsd: DecimalValue(
        '${100 + venue.phase}',
        asset: 'USD',
        unit: 'fiat',
      ),
      availableToTradeUsd: DecimalValue('60', asset: 'USD', unit: 'fiat'),
    );
  }

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async {
    venue.reads++;
    return DomainPage(
      items: venue.phase == 1
          ? [
              HoldingGroup(
                symbol: 'TSLA',
                totalValueUsd: venue.position.valueUsd,
                positions: [venue.position],
              ),
            ]
          : [],
    );
  }

  @override
  Future<List<TradingAccount>> listAccounts() async => [];
}
