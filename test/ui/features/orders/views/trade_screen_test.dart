import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/data/repositories/bstocks_order_execution_repository_impl.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/market_snapshot.dart';
import 'package:nobell/domain/models/hip3_account_abstraction.dart';
import 'package:nobell/domain/models/hip3_opening_context.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/position_close_preview.dart';
import 'package:nobell/domain/models/position_operation.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/repositories/markets_repository.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/domain/repositories/orders_repository.dart';
import 'package:nobell/domain/repositories/bstocks_order_action_repository.dart';
import 'package:nobell/domain/repositories/positions_repository.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/domain/repositories/hip3_account_abstraction_repository.dart';
import 'package:nobell/domain/repositories/hip3_order_execution_repository.dart';
import 'package:nobell/ui/features/orders/providers/order_providers.dart';
import 'package:nobell/ui/features/orders/providers/hip3_account_abstraction_providers.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_screen.dart';
import 'package:nobell/ui/features/positions/providers/position_providers.dart';

import '../../../../helpers/test_app.dart';
import '../../../../helpers/funded_repository.dart';

/// Makes a failed journey assertion identify the Figma child node, its parent
/// route/state, and the expected dismissal target.
void expectNodeVisible({
  required String nodeId,
  required String parentContext,
  required String returnContext,
  required Finder finder,
}) {
  expect(
    finder,
    findsOneWidget,
    reason:
        'Node $nodeId from $parentContext was not visible; dismissal must return to $returnContext.',
  );
}

void main() {
  testWidgets('Trade pull-to-refresh reloads the current position list', (
    tester,
  ) async {
    var positionLoads = 0;
    const filter = (
      symbol: 'NVDAB',
      kind: MarketProductKind.bstock,
      cursor: null,
    );
    const lookup = (
      query: 'NVDA',
      cursor: null,
      group: 'hot',
      productType: null,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketProductLookupProvider(lookup).overrideWith(
            (_) async => DomainPage(
              items: [_marketProduct('NVDAB', MarketProductKind.bstock)],
            ),
          ),
          marketProductProvider(_bstockProduct).overrideWith(
            (_) async => _marketProduct('NVDAB', MarketProductKind.bstock),
          ),
          marketSnapshotProvider(_bstockProduct)
              .overrideWith((_) async => _bstockDisclosureSnapshot()),
          marketCandlesProvider((
            product: _bstockProduct,
            range: CandleChartRange.oneHour,
          )).overrideWith(
            (_) async => _chart('NVDAB', CandleChartRange.oneHour),
          ),
          marketHoursProvider.overrideWith(
            (_) async => MarketHours(
              timezone: 'America/New_York',
              current: MarketSessionKind.weekend,
              currentLabel: 'Closed',
              segments: const [],
            ),
          ),
          positionsProvider(filter).overrideWith((_) async {
            positionLoads++;
            return const DomainPage<Position>(items: []);
          }),
          bstocksOpenOrdersProvider((symbol: 'NVDAB', productId: null))
              .overrideWith((_) async => const DomainPage(items: [])),
        ],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(positionLoads, 1);

    await tester.drag(
      find.byKey(const Key('trade-screen-scroll-view')),
      const Offset(0, 500),
    );
    await tester.pumpAndSettle();

    expect(positionLoads, 2);
  });

  testWidgets('successful order reloads the detail position list', (
    tester,
  ) async {
    var positionLoads = 0;
    const filter = (
      symbol: 'NVDAB',
      kind: MarketProductKind.bstock,
      cursor: null,
    );
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(
          _OrderOutcomeRepository(shouldFail: false),
        ),
        positionsProvider(filter).overrideWith((_) async {
          positionLoads++;
          return const DomainPage<Position>(items: []);
        }),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(positionLoads, 1);

    await container.read(orderCommandProvider.notifier).submit(_bstockIntent);
    await tester.pumpAndSettle();

    expect(positionLoads, 2);
  });

  testWidgets('Trade switches chart states and exposes market hours', (
    tester,
  ) async {
    // The sheet only lists sessions that fall on the current local day.
    final today = DateTime.now();
    final sessionStart = DateTime(today.year, today.month, today.day, 9, 30);
    final sessionEnd = DateTime(today.year, today.month, today.day, 16);
    await tester.pumpWidget(
      _tradeWithMarkets(
        marketHours: MarketHours(
          timezone: 'America/New_York',
          current: MarketSessionKind.regular,
          currentLabel: 'Regular Market',
          nextTransitionAt: DateTime.now().add(
            const Duration(hours: 2, seconds: 30),
          ),
          segments: [
            MarketSessionSegment(
              kind: MarketSessionKind.regular,
              start: sessionStart,
              end: sessionEnd,
            ),
          ],
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NVDAB'), findsOneWidget);
    expect(find.text('Details'), findsOneWidget);
    await tester.tap(find.byTooltip('Candlestick chart'));
    await tester.pump();
    await tester.tap(find.byTooltip('US stock reference price'));
    await tester.pump();

    expect(find.text('24/7'), findsNothing);
    expect(find.byKey(const Key('trade-market-status-header')), findsNothing);
    await tester.tap(
      find.descendant(
        of: find.byKey(const Key('trade-market-status-navigation')),
        matching: find.text('Regular Market 09:30'),
      ),
    );
    await tester.pumpAndSettle();
    expectNodeVisible(
      nodeId: '513:17402',
      parentContext: '/trade bStocks Details',
      returnContext: '/trade bStocks Details',
      finder: find.text('US Market Trading Hours'),
    );
    // The sheet's lead paragraph is the fixed trading-hours disclaimer, so
    // 'Regular Market' appears once, as the row for that session.
    expect(find.text('Regular Market'), findsOneWidget);
    expect(
      find.textContaining('Market closed indicates no-trading periods'),
      findsOneWidget,
    );
    // The navigation badge pairs the session with its local start time.
    expect(find.text('Regular Market 09:30'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('market-status-icon-regular')),
      findsOneWidget,
    );
    expect(find.text('24/7'), findsNothing);
    expect(find.text(_localSchedule(sessionStart, sessionEnd)), findsOneWidget);

    await tester.tap(find.byTooltip('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('US Market Trading Hours'), findsNothing);
    expect(find.text('Details'), findsOneWidget);
  });

  testWidgets('Trade details render bStocks snapshot disclosures', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketSnapshotProvider(_bstockProduct)
              .overrideWith((_) async => _bstockDisclosureSnapshot()),
        ],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('US Stock Reference'), findsOneWidget);
    expect(find.text('—'), findsWidgets);
    expect(find.text('Asset & Rights'), findsOneWidget);
    expect(find.text('BTECH Holdings Limited'), findsOneWidget);
    expect(find.text('No Shareholder Voting Rights'), findsOneWidget);
  });

  testWidgets('Trade shows field skeletons while market data loads', (
    tester,
  ) async {
    const product = MarketProductRef(
      symbol: 'NVDAB',
      kind: MarketProductKind.bstock,
    );
    final snapshot = Completer<MarketSnapshot>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketSnapshotProvider(product).overrideWith((_) => snapshot.future),
        ],
        child: buildTestApp(const TradeScreen()),
      ),
    );

    expect(find.byKey(const Key('trade-price-skeleton')), findsOneWidget);
    expect(
      find.byKey(const Key('trade-details-price-skeleton')),
      findsOneWidget,
    );

    snapshot.complete(MarketSnapshot(price: DecimalValue('191.25')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('trade-price-skeleton')), findsNothing);
  });

  testWidgets('Trade shows a chart skeleton while switching chart ranges', (
    tester,
  ) async {
    const product = MarketProductRef(
      symbol: 'NVDAB',
      kind: MarketProductKind.bstock,
    );
    final oneHour = Completer<CandleChart>();
    final fourHours = Completer<CandleChart>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketCandlesProvider((
            product: product,
            range: CandleChartRange.oneHour,
          )).overrideWith((_) => oneHour.future),
          marketCandlesProvider((
            product: product,
            range: CandleChartRange.fourHours,
          )).overrideWith((_) => fourHours.future),
        ],
        child: buildTestApp(const TradeScreen()),
      ),
    );

    expect(find.byKey(const Key('trade-chart-skeleton')), findsOneWidget);
    oneHour.complete(_chart(product.symbol, CandleChartRange.oneHour));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('trade-chart-skeleton')), findsNothing);

    await tester.tap(find.text('4h'));
    await tester.pump();
    expect(find.byKey(const Key('trade-chart-skeleton')), findsOneWidget);

    fourHours.complete(_chart(product.symbol, CandleChartRange.fourHours));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('trade-chart-skeleton')), findsNothing);
  });

  testWidgets('Trade drag tooltip updates the price and change colors', (
    tester,
  ) async {
    const product = MarketProductRef(
      symbol: 'NVDAB',
      kind: MarketProductKind.bstock,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketSnapshotProvider(product).overrideWith(
            (_) async => MarketSnapshot(
              price: DecimalValue('100', asset: 'USDC', unit: 'price'),
              change24hPercent: DecimalValue('-1', unit: 'percent'),
            ),
          ),
          marketCandlesProvider((
            product: product,
            range: CandleChartRange.oneHour,
          )).overrideWith((_) async => _interactiveChart(product.symbol)),
        ],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final chart = find.byKey(const Key('trade-chart-plot'));
    final bounds = tester.getRect(chart);
    final gesture = await tester.startGesture(bounds.centerLeft);
    await gesture.moveTo(Offset(bounds.right - 1, bounds.center.dy));
    await tester.pump();

    expect(find.text(r'$110'), findsWidgets);
    expect(find.text('+10%'), findsWidgets);
    expect(
      tester.widget<Text>(_headerPrice(r'$110')).style?.color,
      const Color(0xFF04A08B),
    );

    await gesture.up();
    await tester.pump();
    // Releasing hands the header back to the live price, which rolls into
    // place; let that land before reading the settled Text.
    await tester.pump(const Duration(milliseconds: 900));
    expect(_headerPrice(r'$100'), findsOneWidget);
    expect(
      tester.widget<Text>(_headerPrice(r'$100')).style?.color,
      const Color(0xFFB3261E),
    );
  });

  testWidgets('Reference chart shows US prices and market sessions', (
    tester,
  ) async {
    const product = MarketProductRef(
      symbol: 'NVDAB',
      kind: MarketProductKind.bstock,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketCandlesProvider((
            product: product,
            range: CandleChartRange.oneHour,
          )).overrideWith((_) async => _interactiveChart(product.symbol)),
        ],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('US stock reference price'));
    await tester.pump();
    expect(find.text('US Stock \$175'), findsOneWidget);
    expect(find.text('Regular Market'), findsOneWidget);

    final chart = find.byKey(const Key('trade-chart-plot'));
    final bounds = tester.getRect(chart);
    final gesture = await tester.startGesture(bounds.centerLeft);
    await gesture.moveTo(Offset(bounds.right - 1, bounds.center.dy));
    await tester.pump();
    expect(find.text('US \$175'), findsOneWidget);
    await gesture.up();
  });

  testWidgets(
    'Trade header renders the authoritative snapshot when available',
    (tester) async {
      const product = MarketProductRef(
        symbol: 'NVDAB',
        kind: MarketProductKind.bstock,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            marketSnapshotProvider(product).overrideWith(
              (_) async => MarketSnapshot(
                price: DecimalValue('191.25'),
                change24hPercent: DecimalValue('3.50'),
              ),
            ),
          ],
          child: buildTestApp(const TradeScreen()),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(r'$191.25'), findsOneWidget);
      expect(find.text('+3.5%'), findsOneWidget);
    },
  );

  testWidgets('Trade updates the favorite icon after a successful request', (
    tester,
  ) async {
    final repository = _FavoriteMarketsRepository(isFavorite: false);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Add favorite'));
    await tester.pumpAndSettle();

    expect(repository.added, [
      const MarketProductRef(symbol: 'NVDAB', kind: MarketProductKind.bstock),
    ]);
    expect(repository.removed, isEmpty);
    expect(find.byTooltip('Remove favorite'), findsOneWidget);
  });

  testWidgets('Trade removes an active favorite', (tester) async {
    final repository = _FavoriteMarketsRepository(isFavorite: true);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Remove favorite'));
    await tester.pumpAndSettle();

    expect(repository.removed, [
      const MarketProductRef(symbol: 'NVDAB', kind: MarketProductKind.bstock),
    ]);
    expect(repository.added, isEmpty);
    expect(find.byTooltip('Add favorite'), findsOneWidget);
  });

  testWidgets('Trade shows progress while updating favorites', (tester) async {
    final gate = Completer<void>();
    final repository = _FavoriteMarketsRepository(addGate: gate);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Add favorite'));
    await tester.pump();

    expect(find.byKey(const Key('trade-favorite-loading')), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('trade-favorite-loading')), findsNothing);
  });

  testWidgets('Trade preserves the favorite icon when the request fails', (
    tester,
  ) async {
    final repository = _FavoriteMarketsRepository(shouldFail: true);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Add favorite'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Add favorite'), findsOneWidget);
    expect(find.byTooltip('Remove favorite'), findsNothing);
  });

  testWidgets('bStocks order acceptance shows only the success toast', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(
          _OrderOutcomeRepository(shouldFail: false),
        ),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const TradeScreen()),
      ),
    );

    await container.read(orderCommandProvider.notifier).submit(_bstockIntent);
    await tester.pump();

    expect(find.text('NVDAB Buy Successful!'), findsOneWidget);
    expect(find.text('NVDAB Buy Failed!'), findsNothing);
  });

  testWidgets('bStocks order failure shows only the failure toast', (
    tester,
  ) async {
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(
          _OrderOutcomeRepository(shouldFail: true),
        ),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: buildTestApp(const TradeScreen()),
      ),
    );

    await container.read(orderCommandProvider.notifier).submit(_bstockIntent);
    await tester.pump();

    expect(find.text('NVDAB Buy Failed!'), findsOneWidget);
    expect(find.text('NVDAB Buy Successful!'), findsNothing);
  });

  testWidgets('Trade routes HIP-3 actions to the perpetual order panel', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(perpSnapshot: _perpDisclosureSnapshot()),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Long'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Long NVDA'), findsWidgets);
    expect(find.byKey(const Key('hip3-tp-sl-toggle')), findsOneWidget);
  });

  testWidgets('Trade opens a loading sheet before HIP-3 account status loads', (
    tester,
  ) async {
    final status = Completer<Hip3AccountAbstractionStatus>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          hip3AccountAbstractionProvider.overrideWith((_) => status.future),
        ],
        child: buildTestApp(
          const TradeScreen(
            symbol: 'NVDA',
            initialKind: MarketProductKind.perp,
          ),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Long'));
    await tester.pump();

    expect(find.byKey(const Key('order-panel-entry-loading')), findsOneWidget);
    expect(find.byKey(const Key('order-panel-entry-skeleton')), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    status.complete(
      const Hip3AccountAbstractionStatus(
        ownerAddress: '0xowner',
        currentMode: Hip3AccountAbstractionMode.unifiedAccount,
        switchAvailable: false,
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('order-panel-entry-loading')), findsNothing);
    expect(find.text('Long NVDA'), findsWidgets);
  });

  testWidgets('Trade preserves the HIP-3 short side when opening its panel', (
    tester,
  ) async {
    await tester.pumpWidget(_tradeWithMarkets());
    await tester.pumpAndSettle();

    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Short'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Short NVDA'), findsWidgets);
  });

  testWidgets('Trade routes bStocks actions to the bStocks order panel', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [authenticatedStateOverride],
        child: buildTestApp(const TradeScreen()),
      ),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Buy NVDAB'), findsWidgets);
    expect(
      find.byKey(const Key('bstocks-market-amount-input')),
      findsOneWidget,
    );
  });

  testWidgets('Trade preserves the bStocks sell side when opening its panel', (
    tester,
  ) async {
    await tester.pumpWidget(_tradeWithMarkets());
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Sell'));
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Sell NVDAB'), findsWidgets);
  });

  for (final orderType in TradingOrderType.values) {
    testWidgets(
      'View Position reveals the ${orderType.name} bStocks result card',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(800, 900);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        final positions = _ResultNavigationPositionsRepository();
        final orders = _ResultNavigationOrdersRepository(orderType, positions);
        await tester.pumpWidget(
          _tradeWithMarkets(
            fundingRepository: FundedRepository(),
            ordersRepository: orders,
            positionsRepository: positions,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
        await tester.pump();
        await tester.pumpAndSettle();
        if (orderType == TradingOrderType.limit) {
          final limitTab = find.text('Limit').last;
          await tester.ensureVisible(limitTab);
          await tester.tap(limitTab);
          await tester.pumpAndSettle();
          await tester.enterText(
            find.byKey(const Key('bstocks-limit-price-sheet-input')),
            '100',
          );
          await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
          await tester.pumpAndSettle();
          await tester.enterText(
            find.byKey(const Key('bstocks-limit-quantity-input')),
            '1',
          );
        } else {
          await tester.enterText(
            find.byKey(const Key('bstocks-market-amount-input')),
            '100',
          );
        }
        await tester.pump();
        final primaryAction = find.byKey(
          const Key('bstocks-primary-order-action'),
        );
        await tester.ensureVisible(primaryAction);
        await tester.tap(primaryAction);
        final confirmBuy = find.widgetWithText(FilledButton, 'Confirm Buy');
        await _pumpUntilVisible(tester, confirmBuy);
        await tester.ensureVisible(confirmBuy);
        await tester.tap(confirmBuy);
        final viewPosition = find.widgetWithText(FilledButton, 'View Position');
        await _pumpUntilVisible(tester, viewPosition);
        await tester.ensureVisible(viewPosition);

        await tester.tap(find.byKey(const Key('bstocks-order-result-action')));
        await tester.pumpAndSettle();

        expect(find.byType(TradeScreen), findsOneWidget);
        final target = orderType == TradingOrderType.limit
            ? find.byKey(const ValueKey('trade-open-order-card-result-order'))
            : find.byKey(const ValueKey('trade-position-card-position-1'));
        expect(target, findsOneWidget);
        final viewport = tester.getRect(
          find.byKey(const Key('trade-screen-scroll-view')),
        );
        final card = tester.getRect(target);
        expect(card.top, greaterThanOrEqualTo(viewport.top));
        expect(card.bottom, lessThanOrEqualTo(viewport.bottom));
        if (orderType == TradingOrderType.market) {
          expect(positions.listCalls, greaterThanOrEqualTo(2));
        }
      },
    );
  }

  for (final orderType in TradingOrderType.values) {
    testWidgets(
      'View Position reveals the ${orderType.name} HIP-3 result card',
      (tester) async {
        tester.view.devicePixelRatio = 1;
        tester.view.physicalSize = const Size(800, 900);
        addTearDown(tester.view.resetDevicePixelRatio);
        addTearDown(tester.view.resetPhysicalSize);
        final positions = _ResultNavigationPositionsRepository();
        final orders = _Hip3ResultNavigationOrdersRepository(orderType);
        final execution = _Hip3ResultNavigationExecution(orders, positions);
        await tester.pumpWidget(
          _tradeWithMarkets(
            initialKind: MarketProductKind.perp,
            fundingRepository: FundedRepository(),
            ordersRepository: orders,
            positionsRepository: positions,
            hip3OpeningContext: _hip3OpeningContext(),
            hip3ExecutionRepository: execution,
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(find.widgetWithText(FilledButton, 'Long'));
        await tester.pumpAndSettle();
        if (orderType == TradingOrderType.limit) {
          await tester.tap(find.text('Limit').last);
          await tester.pumpAndSettle();
          final priceInput = find.byKey(
            const Key('hip3-limit-price-sheet-input'),
          );
          await tester.enterText(priceInput, '100');
          Navigator.of(tester.element(priceInput)).pop('100');
          await tester.pumpAndSettle();
          await tester.enterText(
            find.byKey(const Key('hip3-limit-quantity-input')),
            '1',
          );
        } else {
          await tester.enterText(find.byType(TextField).first, '100');
        }
        await tester.pump(const Duration(milliseconds: 301));
        await tester.pumpAndSettle();
        final submit = find.byKey(const Key('hip3-submit-button'));
        await tester.ensureVisible(submit);
        await tester.tap(submit);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('hip3-confirm-button')));
        await tester.pumpAndSettle();

        expect(
          find.widgetWithText(FilledButton, 'View Position'),
          findsOneWidget,
        );
        await tester.tap(find.byKey(const Key('hip3-order-result-action')));
        await tester.pumpAndSettle();

        final target = orderType == TradingOrderType.limit
            ? find.byKey(const ValueKey('trade-open-order-card-result-order'))
            : find.byKey(const ValueKey('trade-position-card-position-1'));
        expect(target, findsOneWidget);
        final viewport = tester.getRect(
          find.byKey(const Key('trade-screen-scroll-view')),
        );
        final card = tester.getRect(target);
        expect(card.top, greaterThanOrEqualTo(viewport.top));
        expect(card.bottom, lessThanOrEqualTo(viewport.bottom));
      },
    );
  }

  testWidgets('Trade renders HIP-3-specific price and rights disclosures', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(perpSnapshot: _perpDisclosureSnapshot()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pumpAndSettle();

    expect(find.text('24/7'), findsNothing);
    expect(find.text('Perpetual'), findsNothing);
    expect(find.text('HIP-3 Perpetual Contract'), findsOneWidget);
    expect(find.text('Price Exposure Only'), findsOneWidget);
  });

  testWidgets('Trade HIP-3 position card matches the Figma summary layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(
        locale: const Locale('en'),
        positionsRepository: _PositionsRepository(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pumpAndSettle();
    await _scrollToTradeTab(tester, 'Position');
    await tester.tap(_tradeTab('Position'));
    await tester.pumpAndSettle();

    for (final text in [
      'NVDA/USDC',
      'Long · 10x',
      'XYZ',
      'HIP-3 · ARB',
      'Unrealized PnL',
      r'+$16',
      '+3%',
      r'$550.01',
      r'$182.4',
      r'$177.09',
      'Funding',
      r'+$1.05',
      r'~$120.33',
      '2.0154・Cross',
      'Close',
      'TP/SL',
    ]) {
      expect(
        find.text(text),
        text == r'$550.01' ? findsWidgets : findsOneWidget,
      );
    }
    expect(
      tester.getSize(find.widgetWithText(OutlinedButton, 'Close')).height,
      36,
    );
  });

  for (final (side, pnl, label) in [
    (PositionSide.long, '-16', 'Long · 10x'),
    (PositionSide.short, '16', 'Short · 10x'),
  ]) {
    testWidgets('Trade HIP-3 ${side.name} label color ignores PnL sign', (
      tester,
    ) async {
      await tester.pumpWidget(
        _tradeWithMarkets(
          locale: const Locale('en'),
          positionsRepository: _PositionsRepository(
            perpSide: side,
            perpPnl: pnl,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('HIP-3 Perp'));
      await tester.pumpAndSettle();
      await _scrollToTradeTab(tester, 'Position');
      await tester.tap(_tradeTab('Position'));
      await tester.pumpAndSettle();

      final labelFinder = find.text(label);
      final semantic = Theme.of(tester.element(labelFinder))
          .extension<AppSemanticColors>()!;
      expect(
        tester.widget<Text>(labelFinder).style?.color,
        side == PositionSide.long ? semantic.success : kShortTradeColor,
      );
    });
  }

  testWidgets('Trade bStocks position card uses the summary-card layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(
        locale: const Locale('en'),
        positionsRepository: _PositionsRepository(),
        portfolioRepository: _BstocksPositionPortfolioRepository(),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollToTradeTab(tester, 'Position');
    await tester.tap(_tradeTab('Position'));
    await tester.pumpAndSettle();

    for (final text in [
      'NVDAB',
      'Spot · BSC',
      'Unrealized PnL',
      r'+$16.00',
      '+3.00%',
      'Value',
      r'$550.00',
      'Token amount',
      '3.0154',
      'Market Price',
      r'$228.71',
      'Available',
      '2.0154',
      'Unavailable',
      '1',
      'Withdraw',
    ]) {
      expect(find.text(text), findsOneWidget);
    }
    expect(
      tester.getSize(find.widgetWithText(OutlinedButton, 'Withdraw')).height,
      36,
    );
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SvgPicture &&
            widget.bytesLoader.toString().contains('common/network_bsc.svg'),
      ),
      findsWidgets,
    );
    expect(find.text('Token position'), findsNothing);
    expect(find.text('Close'), findsNothing);
    expect(find.text('Edit TP/SL'), findsNothing);
  });

  testWidgets('Trade keeps both product tabs and empties the unsupported one', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(
        products: [_marketProduct('NVDA', MarketProductKind.perp)],
        perpSnapshot: _perpDisclosureSnapshot(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('bStocks'), findsOneWidget);
    expect(find.text('HIP-3 Perp'), findsOneWidget);
    expect(find.text('HIP-3 Perpetual Contract'), findsOneWidget);
    expect(find.byKey(const Key('trade-product-unavailable')), findsNothing);

    await tester.tap(find.text('bStocks'));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('trade-product-unavailable')), findsOneWidget);
    expect(find.text('No bStocks market'), findsOneWidget);
    expect(
      find.textContaining('NVDA is not listed on this product yet'),
      findsOneWidget,
    );
    // The tabs stay usable so the trader can go back.
    expect(find.text('HIP-3 Perp'), findsOneWidget);
  });

  testWidgets('Trade bStocks Withdraw selects its token and chain', (
    tester,
  ) async {
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, _) => const TradeScreen()),
        GoRoute(
          path: AppRoutes.withdrawalPath,
          builder: (_, state) => WithdrawalScreen(
            token: state.uri.queryParameters['token'] ?? 'USDC',
            chain: state.uri.queryParameters['chain'] ?? 'Arbitrum',
          ),
        ),
        GoRoute(
          path: AppRoutes.withdrawalSelectPath,
          builder: (_, _) => const WithdrawalScreen(showSelector: true),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      _tradeWithMarkets(
        router: router,
        locale: const Locale('en'),
        positionsRepository: _PositionsRepository(),
        portfolioRepository: _BstocksPositionPortfolioRepository(),
      ),
    );

    await tester.pumpAndSettle();
    await _scrollToTradeTab(tester, 'Position');
    await tester.tap(_tradeTab('Position'));
    await tester.pumpAndSettle();
    expect(find.text('Spot · BSC'), findsOneWidget);

    final withdraw = find.widgetWithText(OutlinedButton, 'Withdraw');
    await tester.ensureVisible(withdraw);
    expect(withdraw, findsOneWidget);
    await tester.tap(withdraw);
    await tester.pumpAndSettle();

    expect(find.byType(WithdrawalScreen), findsOneWidget);
    expect(find.text('Withdraw NVDAB'), findsOneWidget);
    expect(find.text('NVDAB'), findsWidgets);
    expect(find.text('BSC'), findsOneWidget);
    expect(find.text('Available 3.0154 NVDAB'), findsOneWidget);
  });

  testWidgets('Trade tab counts stay on their matching tabs without overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(_PositionsRepository()),
        ],
        child: buildTestApp(const TradeScreen()),
      ),
    );
    await tester.pumpAndSettle();
    await _scrollToTradeTab(tester, 'Position');

    expect(_tradeTab('Position'), findsOneWidget);
    await tester.tap(_tradeTab('Position'));
    await tester.pumpAndSettle();

    expect(find.text('Position (1)'), findsOneWidget);
    expect(find.text('Details'), findsOneWidget);
    expect(find.text('Details (1)'), findsNothing);
    expect(tester.takeException(), isNull);

    // Tabs size to their own label, so the one carrying a count is wider.
    Rect tab(String label) =>
        tester.getRect(find.widgetWithText(TextButton, label));
    expect(tab('Position (1)').width, greaterThan(tab('Details').width));
    // ...and they stay packed against the left gutter, in order.
    expect(tab('Open').left, closeTo(20, 0.01));
    expect(tab('Position (1)').left, greaterThan(tab('Open').right));
    expect(tab('Details').left, greaterThan(tab('Position (1)').right));
  });

  testWidgets(
    'Trade open tab cancels a live bStocks order through its provider',
    (tester) async {
      final repository = _OpenOrderRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(repository),
            bstocksOrderExecutionRepositoryProvider.overrideWithValue(
              BstocksOrderExecutionRepositoryImpl(
                repository,
                _UnusedOrderActions(),
                null,
              ),
            ),
          ],
          child: buildTestApp(const TradeScreen()),
        ),
      );

      final openTab = _tradeTab('Open');
      await tester.pumpAndSettle();
      await _scrollToTradeTab(tester, 'Open');
      await tester.tap(openTab);
      await tester.pumpAndSettle();
      expect(find.text('Open (1)'), findsOneWidget);
      expect(find.text('Filled / Total'), findsOneWidget);
      expect(find.text('NVDAB/TUSDT'), findsOneWidget);
      expect(find.text('Buy / Limit'), findsOneWidget);
      expect(find.text('40 / 200'), findsOneWidget);
      expect(find.text('123.45'), findsOneWidget);
      expect(find.text('1/5'), findsOneWidget);
      expect(find.text('123.45 TUSDT'), findsNothing);

      final semantic = AppTheme.light.extension<AppSemanticColors>()!;
      final colors = AppTheme.light.extension<AppRwaColors>()!;
      final typeChip = tester.widget<Container>(
        find.byKey(const ValueKey('trade-open-order-type-chip-open-order')),
      );
      expect(
        (typeChip.decoration! as BoxDecoration).color,
        semantic.successSoft,
      );
      expect(
        tester.widget<Text>(find.text('Buy / Limit')).style?.color,
        semantic.success,
      );
      final indicator = tester.widget<LinearProgressIndicator>(
        find.descendant(
          of: find.byKey(
            const ValueKey('trade-open-order-progress-open-order'),
          ),
          matching: find.byType(LinearProgressIndicator),
        ),
      );
      expect(indicator.value, 0.2);
      expect(indicator.backgroundColor, colors.subtleSurface);
      expect(indicator.valueColor?.value, colors.selected);
      expect(
        tester.getSize(
          find.byKey(const ValueKey('trade-open-order-progress-open-order')),
        ),
        const Size(40, 8),
      );
      expect(repository.lastStatusGroup, 'open');
      expect(repository.lastSymbol, 'NVDAB');

      await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
      await tester.pump();
      expect(repository.cancelledOrderId, 'open-order');
      expect(tester.takeException(), isNull);
    },
  );

  for (final asset in ['USDT', null]) {
    testWidgets('Trade uses settlement $asset and disables IOC cancellation', (
      tester,
    ) async {
      final repository = _OpenOrderRepository(
        type: TradingOrderType.market,
        settlementAsset: asset,
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
          child: buildTestApp(const TradeScreen()),
        ),
      );
      await tester.pumpAndSettle();
      await _scrollToTradeTab(tester, 'Open');
      await tester.tap(_tradeTab('Open'));
      await tester.pumpAndSettle();
      expect(
        find.text(asset == null ? 'NVDAB' : 'NVDAB/$asset'),
        findsOneWidget,
      );
      expect(find.text('NVDAB/USDC'), findsNothing);
      expect(find.text('NVDAB/—'), findsNothing);
      final cancel = find.widgetWithText(OutlinedButton, 'Cancel');
      expect(tester.widget<OutlinedButton>(cancel).onPressed, isNull);
      expect(repository.cancelledOrderId, isNull);
      expect(tester.takeException(), isNull);
    });
  }
}

Future<void> _scrollToTradeTab(WidgetTester tester, String label) async {
  final tab = _tradeTab(label);
  final page = find.byKey(const Key('trade-screen-scroll-view'));
  expect(page, findsOneWidget);
  final controller = tester.widget<ListView>(page).controller!;
  for (var attempt = 0; attempt < 30 && tab.evaluate().isEmpty; attempt++) {
    controller.jumpTo(controller.position.maxScrollExtent);
    await tester.pumpAndSettle();
  }
  expect(tab, findsOneWidget);
  await tester.ensureVisible(tab);
  await tester.pumpAndSettle();
}

Future<void> _pumpUntilVisible(WidgetTester tester, Finder finder) async {
  for (var attempt = 0; attempt < 30 && finder.evaluate().isEmpty; attempt++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  expect(finder, findsOneWidget);
}

Finder _tradeTab(String label) =>
    find.byKey(Key('trade-details-tab-${label.toLowerCase()}'));

String _localSchedule(DateTime start, DateTime end) {
  final localStart = start.toLocal();
  final localEnd = end.toLocal();
  final offset = localStart.timeZoneOffset;
  final sign = offset.isNegative ? '-' : '+';
  final absoluteOffset = offset.abs();
  String time(DateTime value) =>
      '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  return '${time(localStart)} - ${time(localEnd)} '
      'UTC$sign${absoluteOffset.inHours.toString().padLeft(2, '0')}:'
      '${(absoluteOffset.inMinutes % 60).toString().padLeft(2, '0')}';
}

Position _position(
  MarketProductKind kind, {
  PositionSide side = PositionSide.long,
  String unrealizedPnl = '16',
}) => switch (kind) {
  MarketProductKind.perp => Position(
    positionId: 'position-1',
    productId: 'xyz:NVDA',
    symbol: 'NVDA',
    kind: kind,
    side: side,
    quantity: DecimalValue(
      side == PositionSide.short ? '-3.0154' : '3.0154',
      unit: 'quantity',
    ),
    valueUsd: DecimalValue('700', asset: 'USDC', unit: 'token'),
    leverage: DecimalValue('10'),
    entryPrice: DecimalValue('177.09', asset: 'USDC', unit: 'price'),
    markPrice: DecimalValue('182.4', asset: 'USDC', unit: 'price'),
    unrealizedPnl: DecimalValue(unrealizedPnl, asset: 'USDC', unit: 'token'),
    unrealizedPnlPercent: DecimalValue('3', unit: 'percent'),
    fundingPaid: DecimalValue('1.05', asset: 'USDC', unit: 'token'),
    liquidationPrice: DecimalValue('120.33', asset: 'USDC', unit: 'price'),
    margin: DecimalValue('2.0154'),
    marginMode: PositionMarginMode.cross,
  ),
  _ => Position(
    positionId: 'position-1',
    productId: 'bstocks:nvdab',
    symbol: 'NVDA',
    kind: kind,
    side: PositionSide.long,
    quantity: DecimalValue('3.0154', unit: 'quantity'),
    valueUsd: DecimalValue('550', asset: 'USDC', unit: 'token'),
    entryPrice: DecimalValue('177.09', asset: 'USDC', unit: 'price'),
    markPrice: DecimalValue('228.71', asset: 'USDC', unit: 'price'),
    unrealizedPnl: DecimalValue('16', asset: 'USDC', unit: 'token'),
    unrealizedPnlPercent: DecimalValue('3', unit: 'percent'),
  ),
};

final class _BstocksPositionPortfolioRepository
    implements PortfolioRepository, PortfolioAssetsRepository {
  @override
  Future<List<PortfolioAsset>> listAssets({
    String? cursor,
    String? productId,
  }) async => [
    PortfolioAsset(
      assetId: 'portfolio-nvdab',
      network: 'bsc',
      symbol: 'NVDAB',
      decimals: 18,
      balance: DecimalValue('3.0154', asset: 'NVDAB', unit: 'token'),
      walletId: 'wallet-1',
      productId: 'bstocks:nvdab',
      bstocksAvailableQuantity: DecimalValue(
        '2.0154',
        asset: 'NVDAB',
        unit: 'token',
      ),
      bstocksUnavailableQuantity: DecimalValue(
        '1',
        asset: 'NVDAB',
        unit: 'token',
      ),
      withdrawable: true,
      bstocksAvailabilityStatus: 'complete',
      freshness: 'fresh',
    ),
  ];

  @override
  Future<List<TradingAccount>> listAccounts() async => const [
    TradingAccount(
      kind: TradingAccountKind.bstocks,
      walletId: 'wallet-1',
      balances: [],
    ),
  ];

  @override
  Future<Portfolio> getSummary() => throw UnimplementedError();

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      throw UnimplementedError();
}

CandleChart _chart(String symbol, CandleChartRange range) => CandleChart(
  symbol: symbol,
  range: range.label,
  points: [
    Candle(
      at: DateTime.utc(2026),
      close: DecimalValue('100', asset: 'USDC', unit: 'price'),
    ),
  ],
);

CandleChart _interactiveChart(String symbol) => CandleChart(
  symbol: symbol,
  range: '1h',
  points: [
    Candle(
      at: DateTime.utc(2026),
      close: DecimalValue('100', asset: 'USDC', unit: 'price'),
    ),
    Candle(
      at: DateTime.utc(2026, 1, 1, 0, 1),
      close: DecimalValue('110', asset: 'USDC', unit: 'price'),
    ),
  ],
  referencePoints: [
    Candle(
      at: DateTime.utc(2026),
      close: DecimalValue('160', asset: 'USD', unit: 'price'),
    ),
    Candle(
      at: DateTime.utc(2026, 1, 1, 0, 1),
      close: DecimalValue('175', asset: 'USD', unit: 'price'),
    ),
  ],
  sessions: [
    MarketSessionSegment(
      kind: MarketSessionKind.regular,
      start: DateTime.utc(2026),
      end: DateTime.utc(2026, 1, 1, 0, 1),
    ),
  ],
);

Finder _headerPrice(String value) => find.byWidgetPredicate(
  (widget) =>
      widget is Text && widget.data == value && widget.style?.fontSize == 24,
);

Widget _tradeWithMarkets({
  GoRouter? router,
  List<MarketProduct>? products,
  PositionsRepository? positionsRepository,
  OrdersRepository? ordersRepository,
  FundingRepository? fundingRepository,
  PortfolioRepository? portfolioRepository,
  Locale? locale,
  MarketHours? marketHours,
  MarketSnapshot? bstockSnapshot,
  MarketSnapshot? perpSnapshot,
  MarketProductKind initialKind = MarketProductKind.bstock,
  Hip3OpeningContext? hip3OpeningContext,
  Hip3OrderExecutionRepository? hip3ExecutionRepository,
}) => ProviderScope(
  overrides: [
    authenticatedStateOverride,
    hip3AccountAbstractionProvider.overrideWith(
      (_) async => const Hip3AccountAbstractionStatus(
        ownerAddress: '0xowner',
        currentMode: Hip3AccountAbstractionMode.unifiedAccount,
        switchAvailable: false,
      ),
    ),
    hip3AccountAbstractionRepositoryProvider.overrideWithValue(
      _UnifiedAccountRepository(),
    ),
    if (positionsRepository != null)
      positionsRepositoryProvider.overrideWithValue(positionsRepository),
    if (ordersRepository != null)
      ordersRepositoryProvider.overrideWithValue(ordersRepository),
    if (fundingRepository != null)
      fundingRepositoryProvider.overrideWithValue(fundingRepository),
    if (portfolioRepository != null)
      portfolioRepositoryProvider.overrideWithValue(portfolioRepository),
    if (hip3OpeningContext != null)
      hip3OpeningContextProvider.overrideWith(
        (_, _) async => hip3OpeningContext,
      ),
    if (hip3ExecutionRepository != null)
      hip3OrderExecutionRepositoryProvider.overrideWithValue(
        hip3ExecutionRepository,
      ),
    marketProductLookupProvider((
      query: 'NVDA',
      cursor: null,
      group: 'hot',
      productType: null,
    )).overrideWith(
      (_) async => DomainPage(
        items:
            products ??
            [
              _marketProduct('NVDAB', MarketProductKind.bstock),
              _marketProduct('NVDA', MarketProductKind.perp),
            ],
        hasMore: false,
      ),
    ),
    marketProductProvider(_bstockProduct).overrideWith(
      (_) async => _marketProduct('NVDAB', MarketProductKind.bstock),
    ),
    marketProductProvider(
      _perpProduct,
    ).overrideWith((_) async => _marketProduct('NVDA', MarketProductKind.perp)),
    if (bstockSnapshot != null)
      marketSnapshotProvider(_bstockProduct)
          .overrideWith((_) async => bstockSnapshot),
    if (perpSnapshot != null)
      marketSnapshotProvider(_perpProduct)
          .overrideWith((_) async => perpSnapshot),
    if (marketHours != null)
      marketHoursProvider.overrideWith((_) async => marketHours),
  ],
  child: router == null
      ? buildTestApp(TradeScreen(initialKind: initialKind), locale: locale)
      : buildRouterTestApp(router),
);

final class _UnifiedAccountRepository
    implements Hip3AccountAbstractionRepository {
  @override
  Future<Hip3AccountAbstractionStatus> getStatus() async =>
      const Hip3AccountAbstractionStatus(
        ownerAddress: '0xowner',
        currentMode: Hip3AccountAbstractionMode.unifiedAccount,
        switchAvailable: false,
      );

  @override
  Future<Hip3AccountAbstractionStatus> switchToUnifiedAccount({
    required String prepareIdempotencyKey,
    required String executeIdempotencyKey,
  }) async => getStatus();
}

const _bstockProduct = MarketProductRef(
  symbol: 'NVDAB',
  kind: MarketProductKind.bstock,
);

const _perpProduct = MarketProductRef(
  symbol: 'NVDA',
  kind: MarketProductKind.perp,
);

MarketSnapshot _bstockDisclosureSnapshot() => MarketSnapshot(
  price: DecimalValue('100', asset: 'USDT', unit: 'price'),
  referenceLabel: 'US Stock Reference',
  assetTitle: 'Asset & Rights',
  assetDescription: 'BTECH Holdings Limited',
  assetRights: const [
    AssetRight(label: 'Voting Rights', value: 'No Shareholder Voting Rights'),
  ],
);

MarketSnapshot _perpDisclosureSnapshot() => MarketSnapshot(
  price: DecimalValue('100', asset: 'USDC', unit: 'price'),
  assetTitle: 'HIP-3 Perpetual Contract',
  assetDescription: 'Price Exposure Only',
);

MarketProduct _marketProduct(String symbol, MarketProductKind kind) =>
    MarketProduct(
      symbol: symbol,
      name: symbol,
      kind: kind,
      price: DecimalValue('100', asset: 'USD', unit: 'price'),
      settlementAsset: kind == MarketProductKind.bstock ? 'USDT' : 'USDC',
      network: kind == MarketProductKind.bstock ? 'BSC' : 'Hyperliquid',
      tradable: true,
    );

final class _FavoriteMarketsRepository implements MarketsRepository {
  _FavoriteMarketsRepository({
    this.isFavorite = false,
    this.shouldFail = false,
    this.addGate,
  });

  final bool isFavorite;
  final bool shouldFail;
  final Completer<void>? addGate;
  final List<MarketProductRef> added = [];
  final List<MarketProductRef> removed = [];

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  }) async => DomainPage(
    items: [
      MarketProduct(
        symbol: 'NVDAB',
        name: 'NVDAB',
        kind: MarketProductKind.bstock,
        price: DecimalValue('100', asset: 'USD', unit: 'price'),
        settlementAsset: 'USDT',
        network: 'BSC',
        tradable: true,
        isFavorite: isFavorite,
      ),
    ],
  );

  @override
  Future<void> addFavorite(MarketProductRef ref) async {
    await addGate?.future;
    if (shouldFail) throw const NetworkFailure();
    added.add(ref);
  }

  @override
  Future<void> removeFavorite(MarketProductRef ref) async {
    if (shouldFail) throw const NetworkFailure();
    removed.add(ref);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final _bstockIntent = OrderIntent(
  symbol: 'NVDAB',
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.market,
  amount: DecimalValue('100', asset: 'USDT', unit: 'token'),
);

final class _OrderOutcomeRepository implements OrdersRepository {
  _OrderOutcomeRepository({required this.shouldFail});

  final bool shouldFail;

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    if (shouldFail) throw const NetworkFailure();
    return ResourceResult(
      resource: TradingOrder(
        orderId: 'outcome-order',
        symbol: intent.symbol,
        kind: intent.kind,
        side: intent.side,
        type: intent.type,
        status: TradingOrderStatus.filled,
        createdAt: DateTime.utc(2026),
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) => throw UnimplementedError();

  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) =>
      throw UnimplementedError();

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

final class _PositionsRepository implements PositionsRepository {
  _PositionsRepository({
    this.perpSide = PositionSide.long,
    this.perpPnl = '16',
  });

  final PositionSide perpSide;
  final String perpPnl;
  var listCalls = 0;

  @override
  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
    ProtectionClearScope? clearScope,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    return position;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  }) {
    listCalls++;
    final resolvedKind = kind ?? MarketProductKind.bstock;
    return Future.value(
      DomainPage(
        items: [
          _position(
            resolvedKind,
            side: resolvedKind == MarketProductKind.perp
                ? perpSide
                : PositionSide.long,
            unrealizedPnl: resolvedKind == MarketProductKind.perp
                ? perpPnl
                : '16',
          ),
        ],
      ),
    );
  }

  @override
  Future<Position> get(String positionId) => throw UnimplementedError();

  @override
  Future<Position> clearTpSl(
    String positionId, {
    ProtectionClearScope scope = ProtectionClearScope.both,
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    PositionMarginMode? marginMode,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<TradingOrder> close(
    String positionId, {
    bool confirmBeforeSigning = true,
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    PositionClosePreview? preview,
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

final class _OpenOrderRepository implements OrdersRepository {
  _OpenOrderRepository({
    this.type = TradingOrderType.limit,
    this.settlementAsset = 'TUSDT',
  });
  final TradingOrderType type;
  final String? settlementAsset;
  String? cancelledOrderId;
  String? lastStatusGroup;
  String? lastSymbol;

  TradingOrder get _order => TradingOrder(
    orderId: 'open-order',
    symbol: 'NVDAB',
    kind: MarketProductKind.bstock,
    side: TradingSide.buy,
    type: type,
    status: TradingOrderStatus.open,
    settlementAsset: settlementAsset,
    limitPrice: type == TradingOrderType.limit
        ? DecimalValue('123.45', asset: settlementAsset, unit: 'price')
        : null,
    quantity: DecimalValue('200', asset: 'NVDAB', unit: 'token'),
    filledQuantity: DecimalValue('40', asset: 'NVDAB', unit: 'token'),
    createdAt: DateTime.utc(2026),
  );

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) {
    lastStatusGroup = statusGroup;
    lastSymbol = symbol;
    return Future.value(DomainPage(items: [ResourceResult(resource: _order)]));
  }

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) async {
    cancelledOrderId = orderId;
    return ResourceResult(
      resource: TradingOrder(
        orderId: _order.orderId,
        symbol: _order.symbol,
        kind: _order.kind,
        side: _order.side,
        type: _order.type,
        status: TradingOrderStatus.cancelled,
        createdAt: _order.createdAt,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) => throw UnimplementedError();

  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) =>
      Future.value(ResourceResult(resource: _order));
}

final class _UnusedOrderActions implements BstocksOrderActionRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw StateError(
    'An immediate cancellation must not access wallet actions',
  );
}

final class _ResultNavigationOrdersRepository implements OrdersRepository {
  _ResultNavigationOrdersRepository(this.type, this.positions);

  final TradingOrderType type;
  final _ResultNavigationPositionsRepository positions;

  TradingOrder get _result => TradingOrder(
    orderId: 'result-order',
    positionId: type == TradingOrderType.market ? 'position-1' : null,
    symbol: 'NVDAB',
    kind: MarketProductKind.bstock,
    side: TradingSide.buy,
    type: type,
    status: type == TradingOrderType.limit
        ? TradingOrderStatus.open
        : TradingOrderStatus.filled,
    quantity: DecimalValue('1', asset: 'NVDAB', unit: 'token'),
    filledQuantity: DecimalValue(
      type == TradingOrderType.limit ? '0' : '1',
      asset: 'NVDAB',
      unit: 'token',
    ),
    limitPrice: type == TradingOrderType.limit
        ? DecimalValue('100', asset: 'USDT', unit: 'price')
        : null,
    createdAt: DateTime.utc(2026),
  );

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: 'result-preview',
    intent: intent,
    orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
    estimatedQuantity: DecimalValue('1', asset: 'NVDAB', unit: 'token'),
    marketPrice: DecimalValue('100', asset: 'USDT', unit: 'price'),
    settlementAsset: 'USDT',
  );

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    if (type == TradingOrderType.market) positions.revealPosition();
    return ResourceResult(resource: _result);
  }

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async => DomainPage(
    items: type == TradingOrderType.limit
        ? [ResourceResult(resource: _result)]
        : const [],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Hip3OpeningContext _hip3OpeningContext() => Hip3OpeningContext(
  contextId: 'context',
  productId: 'xyz:NVDA',
  environment: 'testnet',
  currentLeverage: 10,
  maximumLeverage: 20,
  currentMarginMode: TradingMarginMode.cross,
  marginModes: const {TradingMarginMode.cross, TradingMarginMode.isolated},
  orderTypes: const {TradingOrderType.market, TradingOrderType.limit},
  timeInForce: const {'gtc', 'ioc'},
  availableMargin: DecimalValue('1000'),
  minimumNotional: DecimalValue('10'),
  maximumNotional: DecimalValue('10000'),
  sizeDecimals: 3,
  validUntil: DateTime.now().toUtc().add(const Duration(minutes: 5)),
  operations: const {'placeOrder', 'setLeverage'},
);

final class _Hip3ResultNavigationOrdersRepository implements OrdersRepository {
  _Hip3ResultNavigationOrdersRepository(this.type);

  final TradingOrderType type;

  TradingOrder get result => TradingOrder(
    orderId: 'result-order',
    positionId: type == TradingOrderType.market ? 'position-1' : null,
    symbol: 'NVDA',
    productId: 'xyz:NVDA',
    kind: MarketProductKind.perp,
    side: TradingSide.long,
    type: type,
    status: type == TradingOrderType.limit
        ? TradingOrderStatus.open
        : TradingOrderStatus.filled,
    quantity: DecimalValue('1', asset: 'NVDA', unit: 'token'),
    filledQuantity: DecimalValue(
      type == TradingOrderType.limit ? '0' : '1',
      asset: 'NVDA',
      unit: 'token',
    ),
    limitPrice: type == TradingOrderType.limit
        ? DecimalValue('100', asset: 'USDC', unit: 'price')
        : null,
    createdAt: DateTime.utc(2026),
  );

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: 'hip3-result-preview',
    intent: intent,
    orderValue: DecimalValue('100', asset: 'USDC', unit: 'token'),
    expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    hip3Execution: Hip3PreviewExecution(
      contextId: 'context',
      productId: 'xyz:NVDA',
      environment: 'testnet',
      quantity: DecimalValue('1'),
      type: intent.type,
      timeInForce: intent.type == TradingOrderType.limit ? 'gtc' : 'ioc',
      limitPrice: DecimalValue('100'),
      leverage: intent.leverage ?? DecimalValue('10'),
      marginMode: intent.marginMode ?? TradingMarginMode.cross,
      reduceOnly: false,
      notional: DecimalValue('100'),
      marginRequired: DecimalValue('10'),
      availableMargin: DecimalValue('1000'),
      estimatedFee: DecimalValue('0.05'),
      slippagePercent: DecimalValue('1'),
      liquidationPrice: DecimalValue('90'),
    ),
  );

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async => ResourceResult(
    resource: TradingOrder(
      orderId: result.orderId,
      symbol: result.symbol,
      productId: result.productId,
      kind: result.kind,
      side: result.side,
      type: result.type,
      status: TradingOrderStatus.pendingSignature,
      createdAt: result.createdAt,
    ),
  );

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async => DomainPage(
    items: type == TradingOrderType.limit
        ? [ResourceResult(resource: result)]
        : const [],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Hip3ResultNavigationExecution
    implements Hip3OrderExecutionRepository {
  _Hip3ResultNavigationExecution(this.orders, this.positions);

  final _Hip3ResultNavigationOrdersRepository orders;
  final _ResultNavigationPositionsRepository positions;

  @override
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(
    String orderId,
  ) async {
    if (orders.type == TradingOrderType.market) positions.revealPosition();
    return ResourceResult(resource: orders.result);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _ResultNavigationPositionsRepository
    implements PositionsRepository {
  var _positionVisible = false;
  var listCalls = 0;

  void revealPosition() => _positionVisible = true;

  @override
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  }) async {
    listCalls++;
    return DomainPage(
      items: _positionVisible
          ? [_position(kind ?? MarketProductKind.bstock)]
          : const [],
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
