import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/observability/observability_reporter.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/observability_providers.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/bstocks_support.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/deployment_environment.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/market_snapshot.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/models/stock.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/repositories/bstocks_order_execution_repository.dart';
import 'package:nobell/domain/repositories/markets_repository.dart';
import 'package:nobell/domain/repositories/orders_repository.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/ui/features/home/views/home_screen.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_screen.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/positions/providers/position_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/funded_repository.dart';
import '../helpers/test_app.dart';

/// All network/wallet boundaries are controlled. Unexpected transport access
/// fails immediately, rather than contacting a live trading environment.
final class PerformanceFixture {
  PerformanceFixture({String initialLocation = AppRoutes.homePath}) {
    SharedPreferences.setMockInitialValues({'market_ranking_tab': 'Popular'});
    router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: AppRoutes.homePath,
          name: AppRoutes.homeName,
          builder: (_, _) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.marketsPath,
          name: AppRoutes.marketsName,
          builder: (_, _) => const MarketScreen(),
        ),
        GoRoute(
          path: AppRoutes.tradePath,
          name: AppRoutes.tradeName,
          builder: (_, state) => TradeScreen(
            symbol: state.uri.queryParameters['symbol'] ?? 'NVDAB',
          ),
        ),
      ],
    );
    container = ProviderContainer(
      overrides: [
        authenticatedStateOverride,
        bstocksSettlementTokenProvider.overrideWith(
          (_) async => _performanceSettlementToken,
        ),
        apiDataSourceProvider.overrideWith(
          (_) => throw StateError('Live API access in performance suite'),
        ),
        observabilityReporterProvider.overrideWithValue(
          const NoopObservabilityReporter(),
        ),
        marketsRepositoryProvider.overrideWithValue(markets),
        portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
        fundingRepositoryProvider.overrideWithValue(FundedRepository()),
        ordersRepositoryProvider.overrideWithValue(orders),
        bstocksOrderExecutionRepositoryProvider.overrideWithValue(
          _Execution(orders),
        ),
        positionsProvider.overrideWith(
          (_, _) async => const DomainPage(items: []),
        ),
        marketHoursProvider.overrideWith(
          (_) async => const MarketHours(
            timezone: 'America/New_York',
            current: MarketSessionKind.regular,
            currentLabel: 'Open',
          ),
        ),
      ],
    );
  }

  final markets = _Markets();
  final orders = PerformanceOrders();
  late final GoRouter router;
  late final ProviderContainer container;

  Widget get app => UncontrolledProviderScope(
    container: container,
    child: buildRouterTestApp(
      router,
      platform: defaultTargetPlatform,
      locale: const Locale('en'),
    ),
  );

  void dispose() {
    router.dispose();
    container.dispose();
  }
}

const _performanceSettlementToken = BstocksSettlementToken(
  environment: 'mainnet',
  chainId: 56,
  symbol: 'USDT',
  contract: '0x55d398326f99059ff775485246999027b3197955',
  decimals: 18,
);

final class _Markets implements MarketsRepository {
  int snapshots = 0;
  int charts = 0;

  static final products = List.generate(
    60,
    (i) => MarketProduct(
      symbol: i == 0 ? 'NVDAB' : 'STOCK${i}B',
      name: i == 0 ? 'NVIDIA' : 'Stock $i',
      kind: MarketProductKind.bstock,
      productId: i == 0 ? 'bstocks:nvdab' : 'bstocks:stock$i',
      price: DecimalValue('100', asset: 'USD', unit: 'price'),
      settlementAsset: 'USDT',
      network: 'BSC',
      tradable: true,
      logoText: i == 0 ? 'NV' : 'S$i',
      change24hPercent: DecimalValue('1.2', unit: 'percent'),
    ),
  );

  @override
  Future<DomainPage<Stock>> listStocks() async => const DomainPage(
    items: [
      Stock(
        symbol: 'NVDA',
        name: 'NVIDIA',
        referencePrice: '100',
        logoText: 'NV',
        products: [
          MarketProductRef(symbol: 'NVDAB', kind: MarketProductKind.bstock),
        ],
      ),
    ],
  );

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  }) async => DomainPage(items: query == null ? products : [products.first]);

  @override
  Future<MarketProduct> getProduct(MarketProductRef ref) async =>
      products.first;

  @override
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref) async {
    snapshots++;
    return MarketSnapshot(
      price: DecimalValue('100', asset: 'USD', unit: 'price'),
      productId: 'bstocks:nvdab',
      bids: [
        OrderBookEntry(price: DecimalValue('99'), size: DecimalValue('100')),
      ],
      asks: [
        OrderBookEntry(price: DecimalValue('101'), size: DecimalValue('100')),
      ],
    );
  }

  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    CandleChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) async {
    charts++;
    return CandleChart(
      symbol: ref.symbol,
      range: (range ?? CandleChartRange.oneHour).label,
      points: List.generate(
        240,
        (i) => Candle(
          at: DateTime.utc(2026, 1, 1).add(Duration(minutes: i)),
          open: DecimalValue('${98 + i % 5}'),
          close: DecimalValue('${100 + i % 5}'),
          high: DecimalValue('${103 + i % 5}'),
          low: DecimalValue('${97 + i % 5}'),
        ),
      ),
    );
  }

  @override
  Future<List<BstocksSupportedToken>> listBstocksSupportedTokens() async =>
      const [
        BstocksSupportedToken(
          symbol: 'NVDAB',
          contractAddress: '0x0000000000000000000000000000000000000001',
          decimals: 18,
          executionStatus: BstocksExecutionStatus.admitted,
          executionEnabled: true,
        ),
      ];

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected market call: ${invocation.memberName}');
}

final class _Portfolio
    implements PortfolioRepository, PortfolioAssetsRepository {
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('12580.40', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('10000', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.bstocks,
      walletId: 'performance-wallet',
      availableUsd: DecimalValue('10000', asset: 'USD', unit: 'fiat'),
      balances: [
        TokenBalance(
          symbol: 'USDT',
          balance: DecimalValue('10000', asset: 'USDT', unit: 'token'),
          decimals: 18,
        ),
      ],
    ),
  ];

  @override
  Future<List<PortfolioAsset>> listAssets({
    String? cursor,
    String? productId,
    String? account,
  }) async => [
    PortfolioAsset(
      assetId: 'performance-holding',
      walletId: 'performance-wallet',
      productId: 'bstocks:nvdab',
      network: 'BSC',
      symbol: 'NVDAB',
      decimals: 18,
      balance: DecimalValue('100', asset: 'NVDAB', unit: 'token'),
      bstocksAvailableQuantity: DecimalValue(
        '100',
        asset: 'NVDAB',
        unit: 'token',
      ),
      bstocksUnavailableQuantity: DecimalValue(
        '0',
        asset: 'NVDAB',
        unit: 'token',
      ),
      bstocksAvailabilityStatus: 'complete',
      freshness: 'fresh',
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class PerformanceOrders implements OrdersRepository {
  final createdIntents = <OrderIntent>[];
  final previewedIntents = <OrderIntent>[];
  final cancelledIds = <String>[];
  final openOrders = <String, ResourceResult<TradingOrder>>{};

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    previewedIntents.add(intent);
    return OrderPreview(
      previewId: 'performance-preview-${previewedIntents.length}',
      intent: intent,
      orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
      marketPrice: DecimalValue('100', asset: 'USD', unit: 'price'),
      estimatedQuantity: DecimalValue('1', asset: 'NVDAB', unit: 'token'),
      fee: DecimalValue('0.1', asset: 'USDT', unit: 'token'),
      settlementAsset: 'USDT',
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    if (previewId == null || !previewId.startsWith('performance-preview-')) {
      throw StateError('Order must use its controlled preview');
    }
    createdIntents.add(intent);
    final result = ResourceResult(
      resource: TradingOrder(
        orderId: 'performance-order-${createdIntents.length}',
        symbol: intent.symbol,
        productId: 'bstocks:nvdab',
        kind: intent.kind,
        side: intent.side,
        type: intent.type,
        status: intent.type == TradingOrderType.limit
            ? TradingOrderStatus.open
            : TradingOrderStatus.filled,
        quantity: intent.quantity ?? DecimalValue('1', asset: 'NVDAB'),
        limitPrice: intent.limitPrice,
        createdAt: DateTime.utc(2026),
      ),
    );
    if (result.resource.isOpen) openOrders[result.resource.orderId] = result;
    return result;
  }

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async => DomainPage(items: openOrders.values.toList());

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) async {
    final old = openOrders.remove(orderId)!.resource;
    cancelledIds.add(orderId);
    return ResourceResult(
      resource: TradingOrder(
        orderId: orderId,
        symbol: old.symbol,
        kind: old.kind,
        side: old.side,
        type: old.type,
        status: TradingOrderStatus.cancelled,
        createdAt: old.createdAt,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected order call: ${invocation.memberName}');
}

final class _Execution implements BstocksOrderExecutionRepository {
  _Execution(this.orders);
  final PerformanceOrders orders;

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    bool Function()? isCancelled,
  }) => orders.cancel(orderId, idempotencyKey: 'controlled-cancel');

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected wallet call: ${invocation.memberName}');
}
