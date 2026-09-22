import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/models/hip3_account_abstraction.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/position_operation.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/domain/repositories/hip3_account_abstraction_repository.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/orders/views/trade_screen.dart';

import '../../../../helpers/test_app.dart';

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

    await tester.tap(find.byKey(const Key('trade-market-status-header')));
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
    expect(find.text('24/7'), findsOneWidget);
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
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Long NVDA'), findsWidgets);
    expect(find.byKey(const Key('hip3-tp-sl-toggle')), findsOneWidget);
  });

  testWidgets('Trade preserves the HIP-3 short side when opening its panel', (
    tester,
  ) async {
    await tester.pumpWidget(_tradeWithMarkets());
    await tester.pumpAndSettle();

    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Short'));
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
    expect(find.text('Limit'), findsNothing);
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

  testWidgets('Trade renders HIP-3-specific price and rights disclosures', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(perpSnapshot: _perpDisclosureSnapshot()),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pumpAndSettle();

    expect(find.text('24/7'), findsOneWidget);
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
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Position'));
    await tester.pumpAndSettle();

    for (final text in [
      'NVDA/USDC',
      'Long · 10x',
      'XYZ',
      'HIP-3 · ARB',
      'Unrealized PnL',
      r'+$16',
      '+3%',
      r'$550',
      r'$182.4',
      r'$177.09',
      r'+$1.05',
      r'~$120.33',
      '2.0154・Cross',
      'Close',
      'Edit TP/SL',
    ]) {
      expect(find.text(text), text == r'$550' ? findsWidgets : findsOneWidget);
    }
    expect(
      tester.getSize(find.widgetWithText(OutlinedButton, 'Close')).height,
      36,
    );
  });

  testWidgets('Trade bStocks position card uses the summary-card layout', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(
        locale: const Locale('en'),
        positionsRepository: _PositionsRepository(),
      ),
    );
    await tester.pumpAndSettle();
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Position'));
    await tester.pumpAndSettle();

    for (final text in [
      'NVDA/USDT',
      'Token position',
      'bStocks · BSC',
      'Unrealized PnL',
      r'+$16',
      '+3%',
      r'$550',
      r'$182.4',
      r'$177.09',
      'Close',
    ]) {
      expect(find.text(text), text == r'$550' ? findsWidgets : findsOneWidget);
    }
    expect(
      tester.getSize(find.widgetWithText(OutlinedButton, 'Close')).height,
      36,
    );
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

  testWidgets('Trade bStocks position card opens the sell panel from Close', (
    tester,
  ) async {
    await tester.pumpWidget(
      _tradeWithMarkets(
        locale: const Locale('en'),
        positionsRepository: _PositionsRepository(),
      ),
    );

    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Position'));
    await tester.pumpAndSettle();
    expect(find.text('bStocks · BSC'), findsOneWidget);

    final close = find.widgetWithText(OutlinedButton, 'Close');
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();
    await tester.ensureVisible(close);
    await tester.tap(close);
    await tester.pumpAndSettle();
    expect(find.text('Sell NVDA'), findsWidgets);
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
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();

    expect(find.text('Position'), findsOneWidget);
    expect(find.text('Position (1)'), findsNothing);
    await tester.tap(find.widgetWithText(TextButton, 'Position'));
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
          overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
          child: buildTestApp(const TradeScreen()),
        ),
      );

      final openTab = find.widgetWithText(TextButton, 'Open');
      await tester.drag(find.byType(ListView), const Offset(0, -160));
      await tester.pumpAndSettle();
      await tester.tap(openTab);
      await tester.pumpAndSettle();
      expect(find.text('Open (1)'), findsOneWidget);
      expect(find.text('Filled / Total'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
      await tester.pump();
      expect(repository.cancelledOrderId, 'open-order');
    },
  );
}

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

Position _position(MarketProductKind kind) => switch (kind) {
  MarketProductKind.perp => Position(
    positionId: 'position-1',
    productId: 'xyz:NVDA',
    symbol: 'NVDA',
    kind: kind,
    side: PositionSide.long,
    quantity: DecimalValue('3.0154', unit: 'quantity'),
    valueUsd: DecimalValue('550', asset: 'USDC', unit: 'token'),
    leverage: DecimalValue('10'),
    entryPrice: DecimalValue('177.09', asset: 'USDC', unit: 'price'),
    markPrice: DecimalValue('182.4', asset: 'USDC', unit: 'price'),
    unrealizedPnl: DecimalValue('16', asset: 'USDC', unit: 'token'),
    unrealizedPnlPercent: DecimalValue('3', unit: 'percent'),
    fundingPaid: DecimalValue('1.05', asset: 'USDC', unit: 'token'),
    liquidationPrice: DecimalValue('120.33', asset: 'USDC', unit: 'price'),
    margin: DecimalValue('2.0154'),
    marginMode: PositionMarginMode.cross,
  ),
  _ => Position(
    positionId: 'position-1',
    symbol: 'NVDA',
    kind: kind,
    side: PositionSide.long,
    quantity: DecimalValue('3.0154', unit: 'quantity'),
    valueUsd: DecimalValue('550', asset: 'USDC', unit: 'token'),
    entryPrice: DecimalValue('177.09', asset: 'USDC', unit: 'price'),
    markPrice: DecimalValue('182.4', asset: 'USDC', unit: 'price'),
    unrealizedPnl: DecimalValue('16', asset: 'USDC', unit: 'token'),
    unrealizedPnlPercent: DecimalValue('3', unit: 'percent'),
  ),
};

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
  List<MarketProduct>? products,
  PositionsRepository? positionsRepository,
  Locale? locale,
  MarketHours? marketHours,
  MarketSnapshot? bstockSnapshot,
  MarketSnapshot? perpSnapshot,
}) => ProviderScope(
  overrides: [
    authenticatedStateOverride,
    hip3AccountAbstractionRepositoryProvider.overrideWithValue(
      _UnifiedAccountRepository(),
    ),
    if (positionsRepository != null)
      positionsRepositoryProvider.overrideWithValue(positionsRepository),
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
    if (bstockSnapshot != null)
      marketSnapshotProvider(_bstockProduct)
          .overrideWith((_) async => bstockSnapshot),
    if (perpSnapshot != null)
      marketSnapshotProvider(_perpProduct)
          .overrideWith((_) async => perpSnapshot),
    if (marketHours != null)
      marketHoursProvider.overrideWith((_) async => marketHours),
  ],
  child: buildTestApp(const TradeScreen(), locale: locale),
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
  }) => Future.value(
    DomainPage(items: [_position(kind ?? MarketProductKind.bstock)]),
  );

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
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

final class _OpenOrderRepository implements OrdersRepository {
  String? cancelledOrderId;

  final _order = TradingOrder(
    orderId: 'open-order',
    symbol: 'NVDAB',
    kind: MarketProductKind.bstock,
    side: TradingSide.buy,
    type: TradingOrderType.market,
    status: TradingOrderStatus.open,
    createdAt: DateTime.utc(2026),
  );

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) => Future.value(DomainPage(items: [ResourceResult(resource: _order)]));

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) async {
    cancelledOrderId = orderId;
    return ResourceResult(resource: _order);
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
      throw UnimplementedError();
}
