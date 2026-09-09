import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/hip3_order_execution_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_order_panel.dart';

import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('HIP-3 panel exposes perpetual-only order controls', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const Hip3OrderPanel())),
    );

    expect(find.text('Long NVDA'), findsWidgets);
    expect(find.text('10×'), findsWidgets);
    expect(find.text('Cross'), findsOneWidget);
    expect(find.byKey(const Key('hip3-margin-mode-toggle')), findsOneWidget);
    expect(find.byKey(const Key('hip3-tp-sl-toggle')), findsOneWidget);
    expect(find.text('Liquidation Price'), findsOneWidget);
    expect(find.text('Margin Required'), findsOneWidget);

    await tester.tap(find.text('Short').first);
    await tester.pump();
    expect(find.text('Short NVDA'), findsWidgets);
  });

  testWidgets('HIP-3 reduce-only flow identifies the close-position state', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(const Hip3OrderPanel(initialReduceOnly: true)),
      ),
    );

    expect(find.text('Close Position'), findsOneWidget);
    expect(find.textContaining('Close NVDA'), findsOneWidget);
  });

  testWidgets('HIP-3 order value uses the preview settlement asset', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(_CapturingHip3Orders()),
        ],
        child: buildTestApp(const Hip3OrderPanel()),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.pump(const Duration(milliseconds: 301));
    await tester.pumpAndSettle();

    expect(find.text('USDT'), findsOneWidget);
  });

  testWidgets('HIP-3 leverage sheet retains a confirmed selection', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const Hip3OrderPanel())),
    );

    await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Drag to set leverage'), findsOneWidget);
    expect(find.text('20x'), findsOneWidget);
    await tester.tap(find.text('20x'));
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();

    expect(find.text('20×'), findsWidgets);
  });

  testWidgets('HIP-3 order surface remains usable at enlarged text', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
            child: const Hip3OrderPanel(initialReduceOnly: true),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.textContaining('Close NVDA'), findsOneWidget);
  });

  testWidgets('HIP-3 review preserves side, margin, leverage, and TP/SL', (
    tester,
  ) async {
    final orders = _CapturingHip3Orders();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
        child: buildTestApp(const Hip3OrderPanel()),
      ),
    );

    await tester.tap(find.byKey(const Key('hip3-margin-mode-toggle')));
    await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('20x'));
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('hip3-tp-sl-toggle')));
    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();

    expect(orders.intent?.side, TradingSide.long);
    expect(orders.intent?.marginMode, TradingMarginMode.isolated);
    expect(orders.intent?.leverage?.value, '20');
    expect(find.text('Review Long NVDA'), findsOneWidget);
    expect(find.text('Isolated'), findsOneWidget);
    expect(find.text('20x'), findsOneWidget);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Back'));
    await tester.pumpAndSettle();
    expect(find.text('20×'), findsWidgets);
    expect(find.text('Added'), findsOneWidget);
  });

  testWidgets('pending HIP-3 order is signed and submitted before success', (
    tester,
  ) async {
    final orders = _ExecutableHip3Orders();
    final execution = _Hip3Execution();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(orders),
          hip3OrderExecutionRepositoryProvider.overrideWithValue(execution),
        ],
        child: buildTestApp(const Hip3OrderPanel()),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();

    expect(execution.orderId, 'order-1');
    expect(find.text('Order submitted'), findsOneWidget);
  });
}

final class _CapturingHip3Orders implements OrdersRepository {
  OrderIntent? intent;

  @override
  Future<OrderPreview> preview(
    OrderIntent value, {
    required String idempotencyKey,
  }) async {
    intent = value;
    return OrderPreview(
      previewId: 'hip3-preview',
      intent: value,
      orderValue: DecimalValue('100', asset: 'USDC', unit: 'token'),
      settlementAsset: 'USDT',
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _ExecutableHip3Orders implements OrdersRepository {
  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: 'hip3-preview',
    intent: intent,
    orderValue: DecimalValue('100', asset: 'USDC', unit: 'token'),
  );

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async => ResourceResult(
    resource: TradingOrder(
      orderId: 'order-1',
      symbol: intent.symbol,
      kind: MarketProductKind.perp,
      side: intent.side,
      type: intent.type,
      status: TradingOrderStatus.pendingSignature,
      createdAt: DateTime.utc(2026),
    ),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Hip3Execution implements Hip3OrderExecutionRepository {
  String? orderId;

  @override
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(
    String orderId,
  ) async {
    this.orderId = orderId;
    return ResourceResult(
      resource: TradingOrder(
        orderId: orderId,
        symbol: 'NVDA',
        kind: MarketProductKind.perp,
        side: TradingSide.long,
        type: TradingOrderType.market,
        status: TradingOrderStatus.open,
        createdAt: DateTime.utc(2026),
      ),
    );
  }
}
