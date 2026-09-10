import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/position_operation.dart';
import 'package:rwa_interface/domain/models/hip3_action_pending.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_close_position_sheet.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_open_orders_panel.dart';
import 'package:rwa_interface/ui/features/orders/views/trade_screen.dart';

import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('existing fixed protection keeps its quantity when reopened', (
    tester,
  ) async {
    final repo = _Positions();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(repo),
          ordersRepositoryProvider.overrideWithValue(_Orders()),
        ],
        child: buildTestApp(
          PositionTpSlSheet(position: _position(protectionIds: ['tp-1'])),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final input = tester.widget<TextField>(
      find.byKey(const Key('protection-quantity')),
    );
    expect(input.controller!.text, '1');
    expect(
      tester
          .widget<DropdownButton<bool>>(
            find.byKey(const Key('protection-size-mode')),
          )
          .value,
      isTrue,
    );
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();
    expect(repo.quantity, '1');
    expect(repo.takeProfit, '130');
    expect(repo.stopLoss, isNull);
  });

  testWidgets('pending close cannot be submitted again from the form', (
    tester,
  ) async {
    final repo = _Positions()..pending = true;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
      ),
    );
    await tester.ensureVisible(find.byKey(const Key('close-review')));
    await tester.tap(find.byKey(const Key('close-review')));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Resume it from pending actions'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('close-review')))
          .onPressed,
      isNull,
    );
    expect(repo.closeCalls, 1);
  });
  testWidgets(
    'market partial close passes selected short position, not default NVDA',
    (tester) async {
      final repo = _Positions();
      final position = _position(short: true);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: position)),
        ),
      );
      expect(find.textContaining('xyz:TSLA · Short → Buy'), findsOneWidget);
      await tester.tap(find.text('50%'));
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pumpAndSettle();
      expect(repo.closePosition, same(position));
      expect(repo.percent, '50');
      expect(repo.quantity, isNull);
      expect(repo.type, TradingOrderType.market);
    },
  );

  testWidgets('limit close validates then sends exact quantity and limit', (
    tester,
  ) async {
    final repo = _Positions();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
      ),
    );
    await tester.tap(find.text('Limit'));
    await tester.pump();
    await tester.enterText(
      find.byKey(const Key('close-limit-price')),
      '125.01',
    );
    await tester.enterText(find.byKey(const Key('close-quantity')), '2');
    await tester.ensureVisible(find.byKey(const Key('close-review')));
    await tester.tap(find.byKey(const Key('close-review')));
    await tester.pumpAndSettle();
    expect(repo.closeCalls, 0);
    expect(find.text('Quantity exceeds the current position'), findsOneWidget);
    await tester.enterText(find.byKey(const Key('close-quantity')), '0.125');
    await tester.ensureVisible(find.byKey(const Key('close-review')));
    await tester.tap(find.byKey(const Key('close-review')));
    await tester.pumpAndSettle();
    expect(repo.closeCalls, 1);
    expect(repo.quantity, '0.125');
    expect(repo.percent, isNull);
    expect(repo.limitPrice, '125.01');
    expect(repo.type, TradingOrderType.limit);
  });

  for (final both in [false, true]) {
    testWidgets('protection switches send explicit cancellation, both=$both', (
      tester,
    ) async {
      final repo = _Positions();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(PositionTpSlSheet(position: _position())),
        ),
      );
      await tester.tap(find.byType(Switch).first);
      if (both) await tester.tap(find.byType(Switch).last);
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(
        repo.clearScope,
        both ? ProtectionClearScope.both : ProtectionClearScope.takeProfit,
      );
      expect(repo.takeProfit, isNull);
      expect(repo.stopLoss, both ? null : '90');
    });
  }

  testWidgets(
    'fixed protection quantity is a real input with explicit semantics',
    (tester) async {
      final repo = _Positions();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(PositionTpSlSheet(position: _position())),
        ),
      );
      await tester.ensureVisible(find.byKey(const Key('protection-size-mode')));
      await tester.tap(find.byKey(const Key('protection-size-mode')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Fixed quantity').last);
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('protection-quantity')),
        '0.123',
      );
      expect(
        find.textContaining('will not adjust automatically'),
        findsOneWidget,
      );
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(repo.quantity, '0.123');
      expect(repo.clearScope, isNull);
    },
  );

  testWidgets(
    'open orders keep server filters on page two and show conditional progress',
    (tester) async {
      final repo = _Orders();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [ordersRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(
            const SingleChildScrollView(
              child: Hip3OpenOrdersPanel(symbol: 'TSLA', productId: 'xyz:TSLA'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(repo.queries.single, ('TSLA', 'xyz:TSLA', 'open', null));
      expect(find.text('TSLA/USDC · Long'), findsOneWidget);
      await tester.ensureVisible(
        find.byKey(const Key('hip3-orders-load-more')),
      );
      await tester.tap(find.byKey(const Key('hip3-orders-load-more')));
      await tester.pumpAndSettle();
      expect(repo.queries.last, ('TSLA', 'xyz:TSLA', 'open', 'page-2'));
      expect(find.text('TSLA/USDC · Long'), findsOneWidget);
      expect(find.text('TSLA/USDC · Short'), findsOneWidget);
      expect(find.text('Take profit'), findsOneWidget);
      expect(find.text('Trigger price: 130 USDC · mark'), findsOneWidget);
      expect(find.text('25.0% filled'), findsOneWidget);
      expect(find.byKey(const Key('hip3-orders-load-more')), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}

Position _position({
  bool short = false,
  List<String> protectionIds = const [],
}) => Position(
  positionId: 'p-tsla',
  productId: 'xyz:TSLA',
  positionVersion: 'v1',
  protectionOrderIds: protectionIds,
  symbol: 'TSLA',
  kind: MarketProductKind.perp,
  side: short ? PositionSide.short : PositionSide.long,
  quantity: DecimalValue(short ? '-1' : '1'),
  valueUsd: DecimalValue('100'),
  markPrice: DecimalValue('100'),
  takeProfitPrice: DecimalValue(short ? '90' : '110'),
  stopLossPrice: DecimalValue(short ? '110' : '90'),
);

TradingOrder _order(String id, {bool conditional = false}) => TradingOrder(
  orderId: id,
  productId: 'xyz:TSLA',
  positionId: 'p-tsla',
  symbol: 'TSLA',
  kind: MarketProductKind.perp,
  side: conditional ? TradingSide.short : TradingSide.long,
  type: TradingOrderType.limit,
  status: TradingOrderStatus.open,
  createdAt: DateTime.utc(2026),
  quantity: DecimalValue('1'),
  filledQuantity: DecimalValue(conditional ? '0.25' : '0'),
  conditional: conditional
      ? ConditionalOrder(
          role: 'takeProfit',
          triggerPrice: DecimalValue('130'),
          triggerReference: 'mark',
          triggerStatus: 'untriggered',
          executionType: 'market',
          sizeMode: 'quantity',
          quantity: '1',
        )
      : null,
);

class _Positions implements PositionsRepository {
  bool pending = false;
  int closeCalls = 0;
  Position? closePosition;
  TradingOrderType? type;
  String? quantity, percent, limitPrice, takeProfit, stopLoss;
  ProtectionClearScope? clearScope;
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
    closeCalls++;
    if (pending) throw const Hip3ActionPending('pending-close');
    closePosition = expectedPosition;
    this.quantity = quantity;
    this.percent = percent;
    this.type = type;
    this.limitPrice = limitPrice;
    return _order('close');
  }

  @override
  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
    ProtectionClearScope? clearScope,
    required String idempotencyKey,
  }) async {
    this.takeProfit = takeProfit;
    this.stopLoss = stopLoss;
    this.quantity = quantity;
    this.clearScope = clearScope;
    return position;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Orders implements OrdersRepository {
  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) async =>
      ResourceResult(resource: _order(orderId, conditional: true));
  final queries = <(String?, String?, String?, String?)>[];
  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async {
    expect(kind, MarketProductKind.perp);
    queries.add((symbol, productId, statusGroup, cursor));
    return DomainPage(
      items: [
        ResourceResult(
          resource: _order(cursor ?? 'first', conditional: cursor != null),
        ),
      ],
      hasMore: cursor == null,
      nextCursor: cursor == null ? 'page-2' : null,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
