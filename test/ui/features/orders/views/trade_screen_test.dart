import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
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
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const TradeScreen())),
    );

    expect(find.text('NVDAB'), findsOneWidget);
    expect(find.text('Details'), findsOneWidget);
    await tester.tap(find.byTooltip('Candlestick chart'));
    await tester.pump();
    await tester.tap(find.byTooltip('US stock reference price'));
    await tester.pump();
    expect(find.text(r'US Stock $175.22'), findsOneWidget);
    expect(find.text(r'US $175.22'), findsOneWidget);

    await tester.tap(find.text('24/7'));
    await tester.pumpAndSettle();
    expectNodeVisible(
      nodeId: '513:17402',
      parentContext: '/trade bStocks Details',
      returnContext: '/trade bStocks Details',
      finder: find.text('US Market Trading Hours'),
    );
    expect(find.text('Regular Market'), findsOneWidget);

    await tester.tap(find.byTooltip('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('US Market Trading Hours'), findsNothing);
    expect(find.text('Details'), findsOneWidget);
  });

  testWidgets(
    'Trade details show unavailable market data without fabrication',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: buildTestApp(const TradeScreen())),
      );

      expect(find.text('US Stock Reference'), findsOneWidget);
      expect(find.text('—'), findsWidgets);
      expect(find.text('Asset & Rights'), findsOneWidget);
      expect(find.text('BTECH Holdings Limited'), findsOneWidget);
      expect(find.text('No Shareholder Voting Rights'), findsOneWidget);
    },
  );

  testWidgets('Trade remains usable at enlarged text with safe references', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
            child: const TradeScreen(hasFundingInProgress: true),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('1 funding in progress'), findsOneWidget);
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

      expect(find.text(r'$191.25'), findsNWidgets(2));
      expect(find.text('+3.5%'), findsOneWidget);
    },
  );

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
      ProviderScope(child: buildTestApp(const TradeScreen())),
    );

    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Long'));
    await tester.pumpAndSettle();

    expect(find.text('Leverage: 10x'), findsOneWidget);
    expect(find.text('Reduce only'), findsOneWidget);
  });

  testWidgets('Trade preserves the HIP-3 short side when opening its panel', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const TradeScreen())),
    );

    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Short'));
    await tester.pumpAndSettle();

    expect(find.text('Short NVDA'), findsWidgets);
  });

  testWidgets('Trade routes bStocks actions to the bStocks order panel', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const TradeScreen())),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
    await tester.pumpAndSettle();

    expect(find.text('Buy NVDAB'), findsWidgets);
    expect(find.text('Market'), findsOneWidget);
    expect(find.text('Limit'), findsOneWidget);
  });

  testWidgets('Trade preserves the bStocks sell side when opening its panel', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const TradeScreen())),
    );

    await tester.tap(find.widgetWithText(FilledButton, 'Sell'));
    await tester.pumpAndSettle();

    expect(find.text('Sell NVDAB'), findsWidgets);
  });

  testWidgets(
    'Trade bStocks funding recovery starts from the buy entry point',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: buildTestApp(const TradeScreen())),
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Buy'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '1001');
      await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
      await tester.pumpAndSettle();

      expect(find.text('Amount Needed'), findsOneWidget);
      expect(find.text('In-App Transfer'), findsOneWidget);
      expect(find.text('External Deposit'), findsOneWidget);
    },
  );

  testWidgets('Trade renders HIP-3-specific price and rights disclosures', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const TradeScreen())),
    );
    await tester.tap(find.text('HIP-3 Perp'));
    await tester.pump();

    expect(find.text('HIP-3 Perpetual Contract'), findsOneWidget);
    expect(find.text('Price Exposure Only'), findsOneWidget);
  });

  testWidgets('TP/SL editor submits position updates through the provider', (
    tester,
  ) async {
    final repository = _PositionsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(
          PositionTpSlSheet(position: _position(MarketProductKind.bstock)),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), '200');
    await tester.enterText(find.byType(TextField).at(1), '150');
    expect(find.text('Drag to set'), findsNWidgets(2));
    expect(find.text('Quantity'), findsOneWidget);
    expect(find.text('NVDA'), findsWidgets);
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pump();

    expect(repository.tpSlUpdates, [('position-1', '200', '150')]);
  });

  testWidgets('Trade position tab opens the TP/SL editor from its live card', (
    tester,
  ) async {
    final repository = _PositionsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const TradeScreen()),
      ),
    );

    final positionTab = find.widgetWithText(TextButton, 'Position');
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();
    await tester.tap(positionTab);
    await tester.pumpAndSettle();
    expect(find.text('Token amount'), findsOneWidget);

    final editTpSl = find.widgetWithText(OutlinedButton, 'Edit TP/SL');
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();
    await tester.ensureVisible(editTpSl);
    await tester.tap(editTpSl);
    await tester.pumpAndSettle();
    expect(find.text('Drag to set'), findsNWidgets(2));
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
      expect(find.text('Filled / Total'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
      await tester.pump();
      expect(repository.cancelledOrderId, 'open-order');
    },
  );

  testWidgets('funding-in-progress banner opens its recoverable status sheet', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(const TradeScreen(hasFundingInProgress: true)),
      ),
    );

    expect(find.text('1 funding in progress'), findsOneWidget);
    await tester.tap(
      find.descendant(
        of: find
            .ancestor(
              of: find.text('1 funding in progress'),
              matching: find.byType(Container),
            )
            .first,
        matching: find.widgetWithText(TextButton, 'Details'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Preparing Trading Funds...'), findsOneWidget);
  });
}

Position _position(MarketProductKind kind) => Position(
  positionId: 'position-1',
  symbol: 'NVDA',
  kind: kind,
  side: PositionSide.long,
  quantity: DecimalValue('1', unit: 'quantity'),
  valueUsd: DecimalValue('100', asset: 'USDC', unit: 'token'),
  entryPrice: DecimalValue('175', asset: 'USDC', unit: 'price'),
);

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
  Future<DomainPage<ResourceResult<TradingOrder>>> list({String? cursor}) =>
      throw UnimplementedError();

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
  final List<(String, String?, String?)> tpSlUpdates = [];

  @override
  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? stopLoss,
    String? stopLimit,
    required String idempotencyKey,
  }) async {
    tpSlUpdates.add((position.positionId, takeProfit, stopLoss));
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
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
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
  Future<DomainPage<ResourceResult<TradingOrder>>> list({String? cursor}) =>
      Future.value(DomainPage(items: [ResourceResult(resource: _order)]));

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
