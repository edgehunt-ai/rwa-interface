import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app_review/app_review.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/repositories/funding_repository_impl.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/stock.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';

void main() {
  group('AppReviewConfiguration', () {
    const configuration = AppReviewConfiguration(
      users: {'did:privy:review', 'review@example.com', 'account-review'},
    );

    test('matches normalized principal identifiers', () {
      expect(
        configuration.matchesPrincipal(
          const IdentityPrincipal(
            'DID:PRIVY:REVIEW',
            displayName: ' REVIEW@EXAMPLE.COM ',
          ),
        ),
        isTrue,
      );
    });

    test('matches backend account identifiers as a fallback', () {
      expect(configuration.matchesSession(_session('account-review')), isTrue);
    });

    test('disabled configuration never matches', () {
      const disabled = AppReviewConfiguration(
        users: {'review@example.com'},
        enabled: false,
      );
      expect(
        disabled.matchesPrincipal(
          const IdentityPrincipal('id', displayName: 'review@example.com'),
        ),
        isFalse,
      );
    });
  });

  test(
    'review mode replaces supported repositories while funding uses the API',
    () async {
      final container = ProviderContainer(
        overrides: [
          apiEnvironmentProvider.overrideWithValue(
            const ApiEnvironment(baseUrl: 'https://api.example.test'),
          ),
        ],
      );
      addTearDown(container.dispose);
      container.read(appReviewModeProvider.notifier).setEnabled(true);

      expect(
        container.read(accountRepositoryProvider),
        isA<AppReviewAccountRepository>(),
      );
      expect(
        container.read(portfolioRepositoryProvider),
        isA<AppReviewPortfolioRepository>(),
      );
      expect(
        container.read(fundingRepositoryProvider),
        isA<FundingRepositoryImpl>(),
      );
      expect(
        container.read(realtimeRepositoryProvider),
        isA<AppReviewRealtimeRepository>(),
      );
      final orders = container.read(ordersRepositoryProvider);
      expect(orders, isA<AppReviewOrdersRepository>());

      final result = await orders.create(
        OrderIntent(
          symbol: 'NVDA',
          kind: MarketProductKind.bstock,
          side: TradingSide.buy,
          type: TradingOrderType.market,
          amount: DecimalValue('100.00', asset: 'USD', unit: 'fiat'),
        ),
        idempotencyKey: 'test-review-order',
      );
      expect(result.resource.orderId, startsWith('review-order-'));
      expect(result.resource.status.name, 'filled');
    },
    skip: !AppReviewConfiguration.buildEnabled,
  );

  test('review portfolio uses the application USD unit', () async {
    final portfolio = await AppReviewPortfolioRepository().getSummary();

    expect(
      portfolio.totalValueUsd.compareTo(
        DecimalValue('0', asset: 'USD', unit: 'fiat'),
      ),
      greaterThan(0),
    );
    expect(
      portfolio.accounts
          .firstWhere((account) => account.totalValueUsd != null)
          .totalValueUsd
          ?.unit,
      'fiat',
    );
  });

  test('review portfolio includes representative perps positions', () async {
    final repository = AppReviewPortfolioRepository();
    final holdings = await repository.listHoldings();
    final perps = holdings.items
        .expand((group) => group.positions)
        .where((position) => position.kind == MarketProductKind.perp)
        .toList(growable: false);

    expect(perps, hasLength(2));
    expect(
      perps.map((position) => position.side),
      unorderedEquals([PositionSide.long, PositionSide.short]),
    );
    expect(perps.every((position) => position.leverage != null), isTrue);
    expect(perps.every((position) => position.margin != null), isTrue);
    expect(
      perps.every((position) => position.liquidationPrice != null),
      isTrue,
    );
    expect(
      (await repository.listAccounts()).any(
        (account) => account.kind.name == 'hip3',
      ),
      isTrue,
    );
  });

  test('review account seeds open bStocks and HIP-3 orders', () async {
    final repository = AppReviewOrdersRepository(
      AppReviewStore(),
      previewDelegate: _PreviewDelegate(),
      marketsDelegate: _MarketsDelegate(),
    );

    final bstocks = await repository.list(
      kind: MarketProductKind.bstock,
      statusGroup: 'open',
    );
    final hip3 = await repository.list(
      kind: MarketProductKind.perp,
      symbol: 'NVDA',
      productId: 'xyz:NVDA',
      statusGroup: 'open',
    );

    expect(
      bstocks.items.map((item) => item.resource.symbol),
      unorderedEquals(['NVDA', 'TSLA']),
    );
    expect(bstocks.items.every((item) => !item.resource.isTerminal), isTrue);
    expect(hip3.items, hasLength(1));
    expect(hip3.items.single.resource.conditional?.role, 'takeProfit');
    expect(hip3.items.single.resource.status, TradingOrderStatus.open);
  });

  test('review orders use real preview but keep create local', () async {
    final delegate = _PreviewDelegate();
    final repository = AppReviewOrdersRepository(
      AppReviewStore(),
      previewDelegate: delegate,
      marketsDelegate: _MarketsDelegate(),
    );
    final intent = OrderIntent(
      symbol: 'NVDA',
      kind: MarketProductKind.bstock,
      side: TradingSide.buy,
      type: TradingOrderType.market,
      amount: DecimalValue('100.00', asset: 'USD', unit: 'fiat'),
    );

    final preview = await repository.preview(
      intent,
      idempotencyKey: 'preview-key',
    );
    final order = await repository.create(
      intent,
      idempotencyKey: 'create-key',
      previewId: preview.previewId,
    );

    expect(delegate.previewCalls, 1);
    expect(delegate.createCalls, 0);
    expect(preview.previewId, 'real-preview');
    expect(preview.estimatedPrice?.value, '123.45');
    expect(preview.estimatedQuantity?.value, '0.81004455');
    expect(preview.estimatedReceive?.value, '0.81004455');
    expect(order.resource.orderId, startsWith('review-order-'));
  });
}

final class _MarketsDelegate implements MarketsRepository {
  @override
  Future<MarketProduct> getProduct(MarketProductRef ref) async => MarketProduct(
    symbol: ref.symbol,
    name: ref.symbol,
    kind: ref.kind,
    price: DecimalValue('123.45', asset: 'USDC', unit: 'price'),
    settlementAsset: 'USDC',
    network: 'Arbitrum',
    tradable: true,
  );

  @override
  Future<void> addFavorite(MarketProductRef ref) async {}

  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    CandleChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) => throw UnimplementedError();

  @override
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref) =>
      throw UnimplementedError();

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    dynamic kind,
    dynamic group,
    dynamic productType,
    int? limit,
  }) => throw UnimplementedError();

  @override
  Future<DomainPage<Stock>> listStocks() => throw UnimplementedError();

  @override
  Future<void> removeFavorite(MarketProductRef ref) async {}

  @override
  Future<void> replaceFavorites(List<MarketProductRef> refs) async {}
}

final class _PreviewDelegate implements OrdersRepository {
  int previewCalls = 0;
  int createCalls = 0;

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    previewCalls++;
    return OrderPreview(
      previewId: 'real-preview',
      intent: intent,
      orderValue: DecimalValue('100.00', asset: 'USD', unit: 'fiat'),
      marketPrice: DecimalValue('123.45', asset: 'USD', unit: 'fiat'),
      estimatedReceive: DecimalValue('1', asset: 'NVDA', unit: 'token'),
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    createCalls++;
    throw StateError('Real create must not be called in review mode');
  }

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) =>
      throw UnimplementedError();

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) => throw UnimplementedError();
}

ProductSession _session(String userId) => ProductSession(
  sessionId: 'session',
  createdAt: DateTime.utc(2026, 9, 10),
  expiresAt: DateTime.utc(2027, 9, 10),
  generation: 0,
  accountCreated: false,
  account: UserAccount(
    userId: userId,
    settings: const UserPreferences(
      language: 'en',
      pushEnabled: false,
      notifyOrderFilled: false,
      notifyOrderFailed: false,
      notifyLiquidationWarning: false,
    ),
  ),
);
