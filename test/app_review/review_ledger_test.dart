import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/data/api/api_environment.dart';
import 'package:nobell/app_review/app_review.dart';
import 'package:nobell/domain/models/activity_record.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/deposit.dart';
import 'package:nobell/domain/models/hip3_opening_protection.dart';
import 'package:nobell/domain/models/hip3_protection.dart';
import 'package:nobell/domain/models/hip3_withdrawal_preview.dart';
import 'package:nobell/domain/repositories/hip3_withdrawal_repository.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/market_snapshot.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/domain/models/portfolio_history.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/models/self_custodial_withdrawal.dart';
import 'package:nobell/domain/models/trade_intent.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/domain/repositories/markets_repository.dart';
import 'package:nobell/domain/repositories/orders_repository.dart';
import 'package:nobell/domain/repositories/wallets_repository.dart';
import 'package:nobell/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/providers/withdrawal_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

DecimalValue money(String value) =>
    DecimalValue(value, asset: 'USD', unit: 'fiat');
double value(DecimalValue? amount) => double.parse(amount?.value ?? '0');

void main() {
  late AppReviewStore store;
  late AppReviewPortfolioRepository portfolio;
  late AppReviewPositionsRepository positions;
  late AppReviewOrdersRepository orders;
  late _Quotes quotes;
  late _Markets markets;
  setUp(() {
    store = AppReviewStore();
    portfolio = AppReviewPortfolioRepository(store);
    positions = AppReviewPositionsRepository(store);
    markets = _Markets();
    quotes = _Quotes();
    orders = AppReviewOrdersRepository(
      store,
      previewDelegate: quotes,
      marketsDelegate: markets,
    );
  });

  OrderIntent buy({TradingOrderType type = TradingOrderType.market}) =>
      OrderIntent(
        symbol: 'AAPL',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: type,
        amount: type == TradingOrderType.market ? money('100') : null,
        quantity: type == TradingOrderType.limit ? DecimalValue('1') : null,
        limitPrice: type == TradingOrderType.limit ? money('90') : null,
      );

  test('funding obtains a live quote when submit precedes preview', () async {
    final repo = AppReviewFundingRepository(store, quoteDelegate: orders);
    final intent = buy();
    final cash = store.cash;
    final session = await repo.createFundingSession(
      intent: intent,
      idempotencyKey: 'submit-before-quote',
    );
    expect(session.status, 'funded');
    expect(quotes.reads, 1);
    expect(quotes.writes, 0);
    expect(store.cash, cash);
    expect(store.orders.values.where((o) => o.symbol == 'AAPL'), isEmpty);
    await repo.getFundingSession(session.sessionId);
    expect(quotes.reads, 1);
    final quote = store.previews.values.single;
    final result = await orders.create(
      intent,
      previewId: quote.previewId,
      idempotencyKey: 'submit',
    );
    expect(result.resource.averageFillPrice?.value, '100');
    expect(store.cash, cash - 100.25);
  });

  test(
    'funding requotes changed slippage and preserves quote failures',
    () async {
      await orders.preview(buy(), idempotencyKey: 'old');
      final repo = AppReviewFundingRepository(store, quoteDelegate: orders);
      final intent = buy().withSlippage(DecimalValue('0.12'));
      final session = await repo.createFundingSession(
        intent: intent,
        idempotencyKey: 'changed-slippage',
      );
      expect(session.status, 'funded');
      expect(quotes.reads, 2);
      quotes.error = StateError('Provider quote unavailable');
      markets.error = StateError('Market unavailable');
      await expectLater(
        repo.createFundingSession(
          intent: buy().withSlippage(DecimalValue('0.2')),
          idempotencyKey: 'failed-quote',
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'reason',
            'Provider quote unavailable',
          ),
        ),
      );
    },
  );

  test(
    'perps allocation includes USDC pool and distinct margin balances',
    () async {
      final allocation = await portfolio.getRailAllocation();
      final breakdown = allocation.perps!.perpsBreakdown!;
      expect(value(breakdown.crossMarginPool!.valueUsd), 4900);
      expect(value(breakdown.crossMarginPoolQuantity), 4900);
      expect(breakdown.crossMarginPoolQuantity!.asset, 'USDC');
      expect(value(breakdown.crossMargin!.valueUsd), 2500);
      expect(value(breakdown.isolatedMargin!.valueUsd), 1100);
      expect(value(breakdown.openOrderMargin!.valueUsd), 0);
      expect(value(breakdown.estimatedWithdrawable!.valueUsd), 2400);
      expect(
        value(breakdown.crossMarginPool!.percent),
        closeTo(4900 / value(allocation.valuedTotalUsd) * 100, 0.000001),
      );
      // Token principal excludes the $450 of unrealized position gains.
      expect(
        value(allocation.perps!.valueUsd),
        value(breakdown.crossMarginPool!.valueUsd) +
            value(breakdown.isolatedMargin!.valueUsd) +
            450,
      );
      expect(breakdown.crossLiquidationRisk!.crossPositionCount, 1);
      expect(
        value(breakdown.crossLiquidationRisk!.closestDistancePercent),
        30.8,
      );
    },
  );

  test(
    'live quote drives simulated fill, cash, assets, holdings, and history',
    () async {
      final before = await portfolio.getSummary();
      final intent = buy();
      final preview = await orders.preview(intent, idempotencyKey: 'preview');
      final result = await orders.create(
        intent,
        previewId: preview.previewId,
        idempotencyKey: 'buy',
      );
      expect(quotes.reads, 1);
      expect(quotes.writes, 0);
      expect(result.resource.averageFillPrice?.value, '100');
      expect(result.resource.productId, 'bstock-aapl');
      final holding = (await portfolio.listHoldings()).items.singleWhere(
        (h) => h.symbol == 'AAPL',
      );
      expect(value(holding.positions.single.quantity), 1);
      final assets = await portfolio.listAssets(account: 'spot');
      expect(value(assets.singleWhere((a) => a.symbol == 'AAPL').balance), 1);
      expect(
        value(assets.singleWhere((a) => a.symbol == 'USDC').balance),
        4274.75,
      );
      expect(
        value((await portfolio.getSummary()).totalValueUsd),
        closeTo(value(before.totalValueUsd) - 0.25, 0.000001),
      );
      expect(
        (await AppReviewActivityRepository(
          store,
        ).list()).items.any((a) => a.reference?.id == result.resource.orderId),
        isTrue,
      );
      expect(
        value(
          (await portfolio.getHistory(PortfolioHistoryRange.oneDay))
              .points
              .last
              .totalValueUsd,
        ),
        value((await portfolio.getSummary()).totalValueUsd),
      );
      expect(
        value((await portfolio.getRailAllocation()).valuedTotalUsd),
        value((await portfolio.getSummary()).totalValueUsd),
      );
    },
  );

  test('same create key returns one order and deducts funds once', () async {
    final intent = buy();
    final preview = await orders.preview(intent, idempotencyKey: 'quote');
    final one = await orders.create(
      intent,
      previewId: preview.previewId,
      idempotencyKey: 'same',
    );
    final two = await orders.create(
      intent,
      previewId: preview.previewId,
      idempotencyKey: 'same',
    );
    expect(one.resource.orderId, two.resource.orderId);
    expect(store.cash, 4274.75);
    expect((await orders.list(symbol: 'AAPL')).items, hasLength(1));
  });

  test(
    'limit orders reserve funds and cancellation restores availability',
    () async {
      final available = store.availableCash;
      final intent = buy(type: TradingOrderType.limit);
      final preview = await orders.preview(intent, idempotencyKey: 'quote');
      final order = await orders.create(
        intent,
        previewId: preview.previewId,
        idempotencyKey: 'limit',
      );
      expect(order.resource.status, TradingOrderStatus.open);
      expect(store.availableCash, available - 90);
      expect((await positions.list(symbol: 'AAPL')).items, isEmpty);
      await AppReviewBstocksOrderExecutionRepository(store)
          .cancelOrder(order.resource.orderId);
      expect(store.availableCash, available);
      expect(
        (await orders.list(symbol: 'AAPL', statusGroup: 'open')).items,
        isEmpty,
      );
      expect(
        (await orders.list(
          symbol: 'AAPL',
          statusGroup: 'history',
        )).items.single.resource.status,
        TradingOrderStatus.cancelled,
      );
      expect(
        (await AppReviewActivityRepository(store)
                .list(status: ActivityState.cancelled))
            .items
            .any((a) => a.reference?.id == order.resource.orderId),
        isTrue,
      );
    },
  );

  test(
    'sell updates existing shares and cash without requiring a wallet',
    () async {
      final intent = OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.sell,
        type: TradingOrderType.market,
        quantity: DecimalValue('2'),
      );
      final quote = await orders.preview(intent, idempotencyKey: 'quote');
      await orders.create(
        intent,
        previewId: quote.previewId,
        idempotencyKey: 'sell',
      );
      expect(
        value((await positions.get('review-position-nvda')).quantity),
        10.5,
      );
      expect(store.cash, closeTo(4574.75, 0.000001));
    },
  );

  test(
    'partial and full close reconcile margin, PnL, orders and holdings',
    () async {
      const id = 'review-position-xyz-nvda';
      final total = store.total;
      final close = await positions.close(
        id,
        percent: '50',
        idempotencyKey: 'half',
      );
      expect(value(close.quantity), 3);
      expect(value((await positions.get(id)).quantity), 3);
      expect(value((await positions.get(id)).margin), 1250);
      expect(store.perpsCash, closeTo(3813.3125, 0.000001));
      expect(store.total, closeTo(total - 1.6875, 0.000001));
      final breakdown =
          (await portfolio.getRailAllocation()).perps!.perpsBreakdown!;
      expect(value(breakdown.crossMargin!.valueUsd), 1250);
      expect(
        value(breakdown.crossMarginPoolQuantity),
        closeTo(5063.3125, 0.000001),
      );
      expect(
        value(breakdown.estimatedWithdrawable!.valueUsd),
        store.availablePerps,
      );
      final replay = await positions.close(
        id,
        percent: '50',
        idempotencyKey: 'half',
      );
      expect(replay.orderId, close.orderId);
      expect(value((await positions.get(id)).quantity), 3);
      await positions.close(id, idempotencyKey: 'full');
      expect(
        (await positions.list(kind: MarketProductKind.perp)).items
            .any((p) => p.positionId == id),
        isFalse,
      );
      expect(
        (await portfolio.listHoldings()).items
            .expand((h) => h.positions)
            .any((p) => p.positionId == id),
        isFalse,
      );
      expect(
        (await orders.list(productId: 'xyz:NVDA', statusGroup: 'open')).items,
        isEmpty,
      );
    },
  );

  test('closing a short buys back the requested quantity', () async {
    final close = await positions.close(
      'review-position-xyz-tsla',
      quantity: '5',
      idempotencyKey: 'short',
    );
    expect(close.side, TradingSide.long);
    expect(value(close.quantity), 5);
    expect(
      value((await positions.get('review-position-xyz-tsla')).quantity),
      10,
    );
  });

  test(
    'limit close stays open and leaves holdings unchanged until execution',
    () async {
      final order = await positions.close(
        'review-position-xyz-nvda',
        quantity: '2',
        type: TradingOrderType.limit,
        limitPrice: '1300',
        idempotencyKey: 'limit-close',
      );
      expect(order.status, TradingOrderStatus.open);
      expect(
        value((await positions.get('review-position-xyz-nvda')).quantity),
        6,
      );
      await AppReviewHip3OrderExecutionRepository(store)
          .cancelOrder(order.orderId, idempotencyKey: 'cancel-close');
      expect(store.orders[order.orderId]?.status, TradingOrderStatus.cancelled);
    },
  );

  test(
    'leverage changes collateral and every portfolio surface consistently',
    () async {
      final total = store.total;
      final beforeCash = store.perpsCash;
      final position = await positions.get('review-position-xyz-nvda');
      final result = await positions.updateLeverage(
        position,
        leverage: '5',
        marginMode: PositionMarginMode.isolated,
        idempotencyKey: 'leverage',
      );
      expect(value(result.leverage), 5);
      expect(value(result.margin), 1500);
      expect(result.marginMode, PositionMarginMode.isolated);
      expect(store.perpsCash, beforeCash + 1000);
      expect(store.total, total);
      final breakdown =
          (await portfolio.getRailAllocation()).perps!.perpsBreakdown!;
      expect(value(breakdown.crossMargin!.valueUsd), 0);
      expect(value(breakdown.isolatedMargin!.valueUsd), 2600);
      expect(value(breakdown.crossMarginPoolQuantity), 3400);
      expect(breakdown.crossLiquidationRisk!.crossPositionCount, 0);
      expect(
        value(
          (await portfolio.listHoldings()).items
              .expand((g) => g.positions)
              .singleWhere((p) => p.positionId == position.positionId)
              .leverage,
        ),
        5,
      );
      expect(
        value((await positions.leverageContext(position.productId!)).current),
        5,
      );
    },
  );

  test(
    'protection create modify cancel update position and open orders',
    () async {
      const id = 'review-position-xyz-nvda';
      final p = await positions.get(id);
      final action = await positions.manageTpSl(
        p,
        changes: [
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: 'stopLoss',
              triggerPrice: money('1100'),
            ),
          ),
        ],
        idempotencyKey: 'create-protection',
      );
      final orderId = action.protectionOrders.single.orderId;
      expect(value((await positions.get(id)).stopLossPrice), 1100);
      expect(store.orders[orderId]?.conditional?.role, 'stopLoss');
      await positions.manageTpSl(
        await positions.get(id),
        changes: [
          Hip3ProtectionChange.modify(
            orderId: orderId,
            protection: Hip3ProtectionParameters(
              role: 'stopLoss',
              triggerPrice: money('1150'),
            ),
          ),
        ],
        idempotencyKey: 'modify-protection',
      );
      expect(store.orders[orderId]?.status, TradingOrderStatus.cancelled);
      expect(value((await positions.get(id)).stopLossPrice), 1150);
      final updated = await positions.get(id);
      final stop = updated.protectionOrders.singleWhere(
        (p) => p.protection.role == 'stopLoss',
      );
      await AppReviewHip3OrderExecutionRepository(store)
          .cancelOrder(stop.orderId, idempotencyKey: 'cancel-stop');
      expect((await positions.get(id)).stopLossPrice, isNull);
      expect((await positions.get(id)).takeProfitPrice, isNotNull);
    },
  );

  test(
    'opening protection creates corresponding orders and position triggers',
    () async {
      final intent = OrderIntent(
        symbol: 'AAPL',
        kind: MarketProductKind.perp,
        side: TradingSide.short,
        type: TradingOrderType.market,
        quantity: DecimalValue('2'),
        leverage: DecimalValue('5'),
        openingProtection: Hip3OpeningProtection(
          takeProfit: Hip3OpeningProtectionLeg(triggerPrice: money('90')),
          stopLoss: Hip3OpeningProtectionLeg(triggerPrice: money('110')),
        ),
      );
      final quote = await orders.preview(intent, idempotencyKey: 'quote');
      expect(quote.hip3Execution, isNotNull);
      expect(quote.openingProtectionMatchesIntent, isTrue);
      await orders.create(
        intent,
        previewId: quote.previewId,
        idempotencyKey: 'open',
      );
      final p = (await positions.list(symbol: 'AAPL')).items.single;
      expect(p.side, PositionSide.short);
      expect(value(p.margin), 40);
      expect(p.protectionOrders, hasLength(2));
      expect(
        (await orders.list(productId: 'venue:AAPL', statusGroup: 'open')).items,
        hasLength(2),
      );
    },
  );

  test(
    'trade intent references a real simulated order and applies its fill',
    () async {
      final quote = await orders.preview(buy(), idempotencyKey: 'quote');
      final repo = AppReviewTradeIntentRepository(store);
      final input = TradeIntentCreateInput(
        previewId: quote.previewId,
        authorizationId: 'simulated',
        executionPolicy: TradeIntentExecutionPolicy(
          limitPrice: money('100'),
          executeBefore: DateTime.now().add(const Duration(minutes: 5)),
        ),
      );
      final result = await repo.create(input, idempotencyKey: 'intent');
      expect(store.orders[result.orderId]?.symbol, 'AAPL');
      expect((await positions.list(symbol: 'AAPL')).items, hasLength(1));
      expect(
        (await repo.create(input, idempotencyKey: 'intent')).orderId,
        result.orderId,
      );
    },
  );

  for (final unavailableBook in [false, true]) {
    test(
      'new bStock fills and sells without upstream identity (book failure: $unavailableBook)',
      () async {
        markets.bookIdentity = true;
        markets.snapshotIdentity = false;
        if (unavailableBook) {
          markets.snapshotError = StateError('No order book');
        }
        final intent = OrderIntent(
          symbol: 'SPCXB',
          kind: MarketProductKind.bstock,
          side: TradingSide.buy,
          type: TradingOrderType.market,
          amount: money('2'),
        );
        final quote = await orders.preview(intent, idempotencyKey: 'quote');
        final repo = AppReviewTradeIntentRepository(store);
        final input = TradeIntentCreateInput(
          previewId: quote.previewId,
          authorizationId: 'simulated',
          executionPolicy: TradeIntentExecutionPolicy(
            limitPrice: money('100'),
            executeBefore: DateTime.now().add(const Duration(minutes: 5)),
          ),
        );
        final before = store.cash;
        final result = await repo.create(input, idempotencyKey: 'intent');
        expect(result.productId, 'review:bstock:SPCXB');
        expect(store.cash, before - 2.25);
        final holding = (await positions.list(symbol: 'SPCXB')).items.single;
        expect(holding.productId, result.productId);
        expect(value(holding.quantity), 0.02);
        expect(
          (await portfolio.listAssets(productId: result.productId))
              .single
              .symbol,
          'SPCXB',
        );
        expect(
          (await orders.list(productId: result.productId)).items,
          hasLength(1),
        );
        expect(
          (await repo.create(input, idempotencyKey: 'intent')).orderId,
          result.orderId,
        );
        expect(store.cash, before - 2.25);
        final sell = OrderIntent(
          symbol: 'SPCXB',
          kind: MarketProductKind.bstock,
          side: TradingSide.sell,
          type: TradingOrderType.market,
          quantity: holding.quantity,
        );
        final sellQuote = await orders.preview(
          sell,
          idempotencyKey: 'sell-quote',
        );
        final sold = await orders.create(
          sell,
          previewId: sellQuote.previewId,
          idempotencyKey: 'sell',
        );
        expect(sold.resource.productId, result.productId);
        expect((await positions.list(symbol: 'SPCXB')).items, isEmpty);
        expect(store.cash, before - 0.5);
        expect(quotes.writes, 0);
      },
    );
  }

  test(
    'transfer moves exact selected funds and conserves total assets on retries',
    () async {
      final repo = AppReviewFundingRepository(store);
      final before = store.total;
      final session = await repo.createTransferFundingSession(
        destination: 'hip3_margin',
        amount: '123.45',
        idempotencyKey: 'session',
      );
      final selected = await repo.updateFundingSessionSelection(
        fundingSessionId: session.sessionId,
        version: session.version,
        allocations: {'review-usdc': '123.45'},
        idempotencyKey: 'select',
      );
      final plan = await repo.createFundingSessionPlan(
        fundingSessionId: session.sessionId,
        selectionVersion: selected.version,
        idempotencyKey: 'plan',
      );
      final transfer = await repo.createFundingTransfer(
        planId: plan.planId,
        legId: plan.legs.single.legId,
        authorizationId: 'local',
        idempotencyKey: 'transfer',
      );
      await repo.createFundingTransfer(
        planId: plan.planId,
        legId: plan.legs.single.legId,
        authorizationId: 'local',
        idempotencyKey: 'retry-with-new-key',
      );
      expect(value(transfer.amount), 123.45);
      expect(store.cash, closeTo(4251.55, 0.000001));
      expect(store.perpsCash, closeTo(2523.45, 0.000001));
      expect(store.total, closeTo(before, 0.000001));
      final breakdown =
          (await portfolio.getRailAllocation()).perps!.perpsBreakdown!;
      expect(
        value(breakdown.crossMarginPoolQuantity),
        closeTo(5023.45, 0.000001),
      );
      expect(
        value(breakdown.estimatedWithdrawable!.valueUsd),
        closeTo(2523.45, 0.000001),
      );
      expect(
        (await repo.getFundingPlan(plan.planId)).legs.single.transferId,
        transfer.transferId,
      );
      expect(
        (await repo.getUnifiedFundingAccount())
            .positions
            .single
            .availableAmount
            .value,
        store.availableCash.toStringAsFixed(2),
      );
    },
  );

  test(
    'quantity orders fund the quoted margin and fee shortfall before opening',
    () async {
      store.perpsCash = 0;
      final intent = OrderIntent(
        symbol: 'AAPL',
        kind: MarketProductKind.perp,
        side: TradingSide.long,
        type: TradingOrderType.market,
        quantity: DecimalValue('50'),
        leverage: DecimalValue('5'),
      );
      final quote = await orders.preview(intent, idempotencyKey: 'quote');
      final repo = AppReviewFundingRepository(store);
      final session = await repo.createFundingSession(
        intent: intent,
        idempotencyKey: 'session',
      );
      expect(session.selectedTargetAmount, '1000.25');
      expect(session.canConfirmTransfer, isTrue);
      final plan = await repo.createFundingSessionPlan(
        fundingSessionId: session.sessionId,
        selectionVersion: session.version,
        idempotencyKey: 'plan',
      );
      await repo.createFundingTransfer(
        planId: plan.planId,
        legId: plan.legs.single.legId,
        authorizationId: 'local',
        idempotencyKey: 'transfer',
      );
      expect(
        (await repo.getFundingSession(session.sessionId)).status,
        'funded',
      );
      await orders.create(
        intent,
        previewId: quote.previewId,
        idempotencyKey: 'buy',
      );
      expect(
        value((await positions.list(symbol: 'AAPL')).items.single.margin),
        1000,
      );
      expect(store.perpsCash, closeTo(0, 0.000001));
    },
  );

  test('funding session rechecks balances after adding demo funds', () async {
    final intent = OrderIntent(
      symbol: 'AAPL',
      kind: MarketProductKind.bstock,
      side: TradingSide.buy,
      type: TradingOrderType.market,
      amount: money('2500'),
    );
    await orders.preview(intent, idempotencyKey: 'quote');
    final repo = AppReviewFundingRepository(store);
    final blocked = await repo.createFundingSession(
      intent: intent,
      idempotencyKey: 'session',
    );
    expect(blocked.status, 'readyToConfirm');
    store.simulateDeposit('1000', 'deposit');
    final funded = await repo.createFundingSession(
      intent: intent,
      idempotencyKey: 'session',
    );
    expect(funded.sessionId, blocked.sessionId);
    expect(funded.status, 'funded');
  });

  test(
    'self withdrawal confirms without signing and reduces assets exactly once',
    () async {
      final repo = AppReviewFundingRepository(store);
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(repo),
          walletsRepositoryProvider.overrideWithValue(
            AppReviewWalletsRepository(
              store,
              readDelegate: _UnexpectedWallets(),
            ),
          ),
          portfolioRepositoryProvider.overrideWithValue(portfolio),
        ],
      );
      addTearDown(container.dispose);
      final quote = WithdrawalQuote(
        quoteId: 'quote',
        intent: WithdrawalIntent(
          chain: 'arbitrum',
          amount: DecimalValue('25', asset: 'USDC', unit: 'token'),
          address: '0x0000000000000000000000000000000000000002',
        ),
        totalFee: DecimalValue('0'),
        estimatedReceive: DecimalValue('25', asset: 'USDC', unit: 'token'),
        sufficient: true,
      );
      container.read(appReviewModeProvider.notifier).setEnabled(true);
      final commands = container.read(selfCustodialWithdrawalCommandsProvider);
      final prepared = await commands.prepare(quote: quote);
      final result = await commands.execute(quote: quote, prepared: prepared);
      expect(result.status, SelfCustodialWithdrawalState.confirmed);
      await commands.executeUserPaid(quote: quote, prepared: prepared);
      expect(store.cash, 4350);
      expect(
        (await repo.listWithdrawals()).items.single.withdrawalId,
        result.withdrawalId,
      );
      expect(result.txHash, isNull);
    },
    skip: !AppReviewConfiguration.buildEnabled,
  );

  test(
    'bStocks withdrawals reconcile available shares, holdings and history',
    () async {
      final preview = await orders.preview(buy(), idempotencyKey: 'buy-quote');
      await orders.create(
        buy(),
        previewId: preview.previewId,
        idempotencyKey: 'buy-stock',
      );
      final repo = AppReviewFundingRepository(store);
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(repo),
          portfolioRepositoryProvider.overrideWithValue(portfolio),
          walletsRepositoryProvider.overrideWithValue(
            AppReviewWalletsRepository(
              store,
              readDelegate: _UnexpectedWallets(),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      container.read(appReviewModeProvider.notifier).setEnabled(true);
      final assets = await container.read(withdrawalAssetsProvider.future);
      final asset = assets.singleWhere((a) => a.symbol == 'AAPL');
      expect(value(asset.availableBalance), 1);
      // Outstanding TSLA sells reserve five shares from withdrawals as well.
      final tsla = store.stockAssets.singleWhere((a) => a.symbol == 'TSLA');
      expect(value(tsla.withdrawalAvailableBalance), value(tsla.balance) - 5);
      final startingCash = store.cash;
      final startingTotal = value((await portfolio.getSummary()).totalValueUsd);
      final commands = container.read(selfCustodialWithdrawalCommandsProvider);
      WithdrawalQuote quote(String quantity) => WithdrawalQuote(
        quoteId: 'stock-$quantity',
        intent: WithdrawalIntent(
          chain: 'bsc',
          amount: DecimalValue(quantity, asset: 'AAPL', unit: 'token'),
          address: '0x0000000000000000000000000000000000000002',
        ),
        totalFee: DecimalValue('0'),
        estimatedReceive: DecimalValue(quantity, asset: 'AAPL', unit: 'token'),
        sufficient: true,
      );
      await expectLater(commands.prepare(quote: quote('2')), throwsStateError);
      final partial = quote('0.4');
      final prepared = await commands.prepare(quote: partial);
      final result = await commands.execute(quote: partial, prepared: prepared);
      await commands.executeUserPaid(quote: partial, prepared: prepared);
      expect(result.status, SelfCustodialWithdrawalState.confirmed);
      final remaining = (await portfolio.listAssets(account: 'spot'))
          .singleWhere((a) => a.symbol == 'AAPL');
      expect(value(remaining.balance), 0.6);
      expect(value(remaining.withdrawalAvailableBalance), 0.6);
      expect(
        value(
          store.accounts
              .singleWhere((a) => a.label == 'bStocks')
              .balances
              .singleWhere((a) => a.symbol == 'AAPL')
              .balance,
        ),
        0.6,
      );
      expect(
        value((await portfolio.getSummary()).totalValueUsd),
        closeTo(startingTotal - 40, 0.000001),
      );
      expect(store.cash, startingCash);
      expect((await repo.listWithdrawals()).items.single.amount.value, '0.4');
      final rest = quote('0.6');
      final finalPrepared = await commands.prepare(quote: rest);
      await commands.execute(quote: rest, prepared: finalPrepared);
      expect(
        (await portfolio.listAssets()).where((a) => a.symbol == 'AAPL'),
        isEmpty,
      );
      expect(
        (await portfolio.listHoldings()).items.where((h) => h.symbol == 'AAPL'),
        isEmpty,
      );
      expect((await repo.listWithdrawals()).items.length, 2);
    },
    skip: !AppReviewConfiguration.buildEnabled,
  );

  test(
    'perps withdrawal returns funds to spot without changing total value',
    () async {
      final repo = AppReviewHip3WithdrawalRepository(store);
      final before = store.total;
      final quote = await repo.preview(amount: '200', payoutChainId: 42161);
      final prepared = await repo.create(
        amount: '200',
        rail: quote.rail,
        payoutChainId: 42161,
        idempotencyKey: 'prepare',
      );
      final result = await repo.signAndSubmit(
        prepared,
        idempotencyKey: 'submit',
      );
      await repo.signAndSubmit(prepared, idempotencyKey: 'retry');
      expect(result.status, 'completed');
      expect(store.perpsCash, 2200);
      expect(store.cash, 4575);
      expect(store.total, before);
    },
  );

  test('live withdrawal fees and routes are preserved while submission stays simulated', () async {
    final live = _WithdrawalReadDelegate();
    final repo = AppReviewHip3WithdrawalRepository(store, readDelegate: live);
    final before = store.total;
    final quote = await repo.preview(amount: '200', payoutChainId: 42161);
    expect(quote.fee, '1');
    expect(quote.rail, 'relay');
    expect(quote.canProceed, isTrue);
    final prepared = await repo.create(
      amount: '200',
      rail: quote.rail,
      payoutChainId: 42161,
      idempotencyKey: 'prepare',
    );
    final result = await repo.signAndSubmit(prepared, idempotencyKey: 'submit');
    expect(result.minimumReceived, '199');
    expect(result.destinationAddress, quote.destinationAddress);
    expect(live.reads, 1);
    expect(store.cash, 4574);
    expect(store.total, before - 1);
  });

  test(
    'simulated deposit updates balance, deposit list and activity',
    () async {
      final before = store.total;
      final deposit = store.simulateDeposit('1000', 'one');
      store.simulateDeposit('1000', 'one');
      expect(store.cash, 5375);
      expect(store.total, before + 1000);
      expect(
        (await AppReviewFundingRepository(
          store,
        ).listDeposits()).items.single.resource.depositId,
        deposit.depositId,
      );
      expect(
        (await AppReviewActivityRepository(store).list(type: 'deposit')).items
            .any((a) => a.id == deposit.depositId),
        isTrue,
      );
    },
  );

  test('selected deposit routes reconcile assets, totals, activity and withdrawals', () async {
    DepositInstruction route(String chain, String token) => DepositInstruction(
      chain: chain,
      token: token,
      tokenContract: '0x0000000000000000000000000000000000000003',
      tokenDecimals: chain == 'BSC' ? 18 : 6,
      address: '0x0000000000000000000000000000000000000001',
      qrPayload: 'review',
      minimumAmount: DecimalValue('1', asset: token),
      confirmationsRequired: 1,
      estimatedArrivalSeconds: 5,
      warning: '',
    );
    final before = store.total;
    final bsc = store.simulateDeposit(
      '1000',
      'bsc',
      instruction: route('BSC', 'USDT'),
    );
    store.simulateDeposit('1000', 'bsc', instruction: route('BSC', 'USDT'));
    store.simulateDeposit('1000', 'base', instruction: route('Base', 'USDT'));
    store.simulateDeposit(
      '1000',
      'arbitrum-usdt',
      instruction: route('Arbitrum', 'USDT'),
    );
    expect(store.cash, 4375);
    expect(store.total, before + 3000);
    final assets = await portfolio.listAssets(account: 'spot');
    final bscAsset = assets.singleWhere(
      (a) => a.network == 'bsc' && a.symbol == 'USDT',
    );
    expect(value(bscAsset.balance), 1000);
    expect(bscAsset.decimals, 18);
    expect(value(assets.singleWhere((a) => a.network == 'base').balance), 1000);
    final accounts = await portfolio.listAccounts();
    expect(
      accounts.fold(0.0, (sum, a) => sum + value(a.totalValueUsd)),
      store.total,
    );
    expect(
      accounts.where((a) => a.kind.name == 'app' && a.chain == 'arbitrum'),
      hasLength(1),
    );
    expect(
      value((await portfolio.getRailAllocation()).valuedTotalUsd),
      store.total,
    );
    expect(value((await portfolio.getSummary()).totalValueUsd), store.total);
    final activity = (await AppReviewActivityRepository(
      store,
    ).list(type: 'deposit')).items.singleWhere((a) => a.id == bsc.depositId);
    expect(activity.chain, 'bsc');
    expect(activity.asset, 'USDT');
    expect(activity.amount?.asset, 'USDT');
    final repo = AppReviewFundingRepository(store);
    expect(
      value((await repo.getUnifiedFundingAccount()).totalUsd),
      store.spotCash,
    );
    final prepared = await repo.createSelfCustodialWithdrawal(
      walletId: bscAsset.walletId!,
      assetId: bscAsset.canonicalEvmId!,
      chain: 'bsc',
      amount: '25',
      destinationAddress: '0x0000000000000000000000000000000000000002',
      idempotencyKey: 'prepare-bsc',
    );
    expect(prepared.assetSymbol, 'USDT');
    expect(prepared.transaction.chainId, 56);
    await repo.submitSelfCustodialWithdrawal(
      id: prepared.withdrawalId,
      txHash: 'review',
      idempotencyKey: 'submit',
    );
    await repo.submitSelfCustodialWithdrawal(
      id: prepared.withdrawalId,
      txHash: 'review',
      idempotencyKey: 'retry',
    );
    expect(store.cash, 4375);
    expect(
      value(
        store.cashAssets
            .singleWhere((a) => a.assetId == bscAsset.assetId)
            .balance,
      ),
      975,
    );
    expect(store.total, before + 2975);
  });

  test(
    'quote failures preserve the real reason when all price reads fail',
    () async {
      const failure = ServerFailure(
        code: 'market_closed',
        statusCode: 422,
        userAction: 'Market is closed for this instrument',
      );
      quotes.error = failure;
      markets.error = StateError('Market feed temporarily unavailable');
      await expectLater(
        orders.preview(buy(), idempotencyKey: 'quote'),
        throwsA(same(failure)),
      );
      expect(store.previews, isEmpty);
      expect(store.cash, 4375);
    },
  );

  test(
    'failed quote can recover with live market price, never a fixed price',
    () async {
      quotes.error = StateError('No funded real account');
      markets.price = '80';
      final preview = await orders.preview(buy(), idempotencyKey: 'quote');
      expect(value(preview.estimatedPrice), 80);
      expect(value(preview.estimatedQuantity), 1.25);
      await orders.create(
        buy(),
        previewId: preview.previewId,
        idempotencyKey: 'buy',
      );
      expect(
        value((await positions.list(symbol: 'AAPL')).items.single.quantity),
        1.25,
      );
    },
  );

  test(
    'oversized close and insufficient funds leave state untouched',
    () async {
      final before = store.total;
      await expectLater(
        positions.close(
          'review-position-xyz-nvda',
          quantity: '100',
          idempotencyKey: 'too-much',
        ),
        throwsArgumentError,
      );
      final intent = OrderIntent(
        symbol: 'AAPL',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.market,
        amount: money('999999'),
      );
      final preview = await orders.preview(intent, idempotencyKey: 'quote');
      await expectLater(
        orders.create(
          intent,
          previewId: preview.previewId,
          idempotencyKey: 'too-big',
        ),
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'reason',
            contains('Insufficient'),
          ),
        ),
      );
      expect(store.total, before);
      expect(
        value((await positions.get('review-position-xyz-nvda')).quantity),
        6,
      );
    },
  );

  test(
    'market refresh changes valuation without resurrecting a closed position',
    () async {
      final repo = AppReviewPortfolioRepository(store, markets);
      final summary = await repo.getSummary();
      expect(
        value((await positions.get('review-position-nvda')).markPrice),
        100,
      );
      expect(value(summary.totalValueUsd), closeTo(store.total, 0.000001));
      await positions.close('review-position-nvda', idempotencyKey: 'close');
      await repo.getSummary();
      expect(store.positions.containsKey('review-position-nvda'), isFalse);
    },
  );

  test('seeded perps align once with live prices and retain realistic protection levels', () async {
    markets.perpVenue = 'xyz';
    final repo = AppReviewPortfolioRepository(store, markets);
    await repo.getSummary();
    final p = await positions.get('review-position-xyz-nvda');
    expect(value(p.markPrice), 100);
    expect(value(p.entryPrice), closeTo(95.6, 0.000001));
    expect(value(p.takeProfitPrice), closeTo(111.2, 0.000001));
    expect(value(p.liquidationPrice), closeTo(69.2, 0.000001));
    expect(store.perpsEquity, greaterThan(0));
    final entry = p.entryPrice;
    markets.price = '110';
    store.marksUpdatedAt = null;
    await repo.getSummary();
    expect((await positions.get(p.positionId)).entryPrice, entry);
    expect(value((await positions.get(p.positionId)).markPrice), 110);
  });

  test(
    'account totals match portfolio and account asset filters stay separate',
    () async {
      final accounts = await portfolio.listAccounts();
      expect(
        accounts.fold(0.0, (sum, a) => sum + value(a.totalValueUsd)),
        store.total,
      );
      expect(
        (await portfolio.listAssets(account: 'perps'))
            .every((a) => a.network == 'hyperliquid'),
        isTrue,
      );
      expect(
        (await portfolio.listAssets(account: 'spot'))
            .every((a) => a.network != 'hyperliquid'),
        isTrue,
      );
    },
  );

  test('failed reversal rolls back its close, collateral and PnL', () async {
    final before = store.total;
    final beforeOrders = store.orders.length;
    final intent = OrderIntent(
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      side: TradingSide.short,
      type: TradingOrderType.market,
      quantity: DecimalValue('100000'),
      leverage: DecimalValue('1'),
    );
    final quote = OrderPreview(
      previewId: 'reverse',
      intent: intent,
      orderValue: money('125000000'),
      estimatedPrice: money('1250'),
      fee: money('0.25'),
    );
    store.previews[quote.previewId] = quote;
    await expectLater(
      orders.create(
        intent,
        previewId: quote.previewId,
        idempotencyKey: 'reverse',
      ),
      throwsStateError,
    );
    expect(store.total, before);
    expect(store.orders.length, beforeOrders);
    expect(store.realizedPnl, 0);
    expect(
      value((await positions.get('review-position-xyz-nvda')).quantity),
      6,
    );
  });

  test('perps limit order reserves requested leverage margin and releases on cancel', () async {
    final intent = OrderIntent(
      symbol: 'AAPL',
      kind: MarketProductKind.perp,
      side: TradingSide.long,
      type: TradingOrderType.limit,
      quantity: DecimalValue('10'),
      limitPrice: money('90'),
      leverage: DecimalValue('10'),
    );
    final preview = await orders.preview(intent, idempotencyKey: 'quote');
    final before = store.availablePerps;
    final order = await orders.create(
      intent,
      previewId: preview.previewId,
      idempotencyKey: 'limit',
    );
    expect(store.availablePerps, before - 90);
    final reserved =
        (await portfolio.getRailAllocation()).perps!.perpsBreakdown!;
    expect(value(reserved.openOrderMargin!.valueUsd), 90);
    expect(value(reserved.crossMarginPoolQuantity), 4810);
    expect(value(reserved.estimatedWithdrawable!.valueUsd), before - 90);
    await orders.cancel(order.resource.orderId, idempotencyKey: 'cancel');
    expect(store.availablePerps, before);
    final cancelled =
        (await portfolio.getRailAllocation()).perps!.perpsBreakdown!;
    expect(value(cancelled.openOrderMargin!.valueUsd), 0);
    expect(value(cancelled.crossMarginPoolQuantity), 4900);
  });

  test(
    'live book identity enables bStocks selling through application providers',
    () async {
      markets.bookIdentity = true;
      final repository = AppReviewPortfolioRepository(store, markets);
      expect(
        await repository.listAssets(productId: 'bstocks:nvda'),
        hasLength(1),
      );
      final container = ProviderContainer(
        overrides: [portfolioRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        bstocksSellAvailabilityProvider('bstocks:nvda'),
        (_, _) {},
      );
      addTearDown(subscription.close);
      final availability = await container.read(
        bstocksSellAvailabilityProvider('bstocks:nvda').future,
      );
      expect(availability, isNotNull);
      expect(value(availability!.quantity), 12.5);
    },
  );

  test(
    'review routing covers all financial execution paths without a signer',
    () {
      final container = ProviderContainer(
        overrides: [
          apiEnvironmentProvider.overrideWithValue(
            const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
          ),
        ],
      );
      addTearDown(container.dispose);
      container.read(appReviewModeProvider.notifier).setEnabled(true);
      expect(
        container.read(bstocksOrderExecutionRepositoryProvider),
        isA<AppReviewBstocksOrderExecutionRepository>(),
      );
      expect(
        container.read(hip3WithdrawalRepositoryProvider),
        isA<AppReviewHip3WithdrawalRepository>(),
      );
      expect(
        container.read(hip3OpeningRepositoryProvider),
        isA<AppReviewHip3OpeningRepository>(),
      );
      expect(
        container.read(hip3AccountAbstractionRepositoryProvider),
        isA<AppReviewHip3AccountAbstractionRepository>(),
      );
      expect(
        container.read(walletsRepositoryProvider),
        isA<AppReviewWalletsRepository>(),
      );
    },
    skip: !AppReviewConfiguration.buildEnabled,
  );

  test('provider consumers automatically refresh after mutations and isolate sessions', () async {
    final container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(markets)],
    );
    addTearDown(container.dispose);
    container.read(appReviewModeProvider.notifier).setEnabled(true);
    final subscription = container.listen(portfolioSummaryProvider, (_, _) {});
    final assetsSubscription = container.listen(
      withdrawalAssetsProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);
    addTearDown(assetsSubscription.close);
    final before = await container.read(portfolioSummaryProvider.future);
    await container.read(withdrawalAssetsProvider.future);
    final ledger = container.read(appReviewStoreProvider);
    ledger.simulateDeposit('100', 'one');
    final after = await container.read(portfolioSummaryProvider.future);
    expect(
      value(after.totalValueUsd) - value(before.totalValueUsd),
      closeTo(100, 0.000001),
    );
    final assets = await container.read(withdrawalAssetsProvider.future);
    expect(value(assets.singleWhere((a) => a.symbol == 'USDC').balance), 4475);
    container.read(appReviewModeProvider.notifier).clear();
    container.read(appReviewModeProvider.notifier).setEnabled(true);
    final fresh = container.read(appReviewStoreProvider);
    expect(fresh.cash, 4375);
    expect(fresh, isNot(same(ledger)));
    expect(() => ledger.simulateDeposit('100', 'old'), throwsStateError);
  }, skip: !AppReviewConfiguration.buildEnabled);
}

final class _UnexpectedWallets implements WalletsRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Simulated withdrawals must not call the wallet API');
}

final class _Markets extends Fake implements MarketsRepository {
  String price = '100';
  bool bookIdentity = false;
  String perpVenue = 'venue';
  bool snapshotIdentity = true;
  Object? snapshotError;
  Object? error;
  @override
  Future<MarketProduct> getProduct(MarketProductRef ref) async {
    if (error != null) throw error!;
    return MarketProduct(
      symbol: ref.symbol,
      name: ref.symbol,
      kind: ref.kind,
      productId: ref.kind == MarketProductKind.perp
          ? '$perpVenue:${ref.symbol}'
          : bookIdentity
          ? null
          : 'bstock-${ref.symbol.toLowerCase()}',
      price: money(price),
      settlementAsset: 'USDC',
      network: 'arbitrum',
      tradable: true,
    );
  }

  @override
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref) async {
    if (snapshotError != null) throw snapshotError!;
    return MarketSnapshot(
      price: money(price),
      productId: snapshotIdentity
          ? 'bstocks:${ref.symbol.toLowerCase()}'
          : null,
    );
  }
}

final class _Quotes extends Fake implements OrdersRepository {
  int reads = 0;
  int writes = 0;
  Object? error;
  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    reads++;
    if (error != null) throw error!;
    return OrderPreview(
      previewId: 'live-quote-$reads',
      intent: intent,
      orderValue: intent.amount ?? money('${value(intent.quantity) * 100}'),
      estimatedPrice: money('100'),
      marketPrice: money('100'),
      fee: money('0.25'),
      expiresAt: DateTime.now().add(const Duration(minutes: 1)),
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    writes++;
    throw StateError('Must never call real financial commands');
  }
}

final class _WithdrawalReadDelegate extends Fake
    implements Hip3WithdrawalRepository {
  int reads = 0;
  @override
  Future<Hip3WithdrawalPreview> preview({
    required String amount,
    required int payoutChainId,
  }) async {
    reads++;
    return Hip3WithdrawalPreview(
      amount: amount,
      fee: '1',
      minimumReceived: '199',
      rail: 'relay',
      destinationAddress: '0x0000000000000000000000000000000000000002',
      chainId: '$payoutChainId',
      maximumTransferable: '0',
      blockers: const ['insufficient_withdrawable_balance'],
      estimatedArrivalSeconds: 30,
      feeDetails: const [],
      crossLiquidationImpacts: const [],
      riskStatus: 'available',
      payoutAsset: 'USDC',
    );
  }
}
