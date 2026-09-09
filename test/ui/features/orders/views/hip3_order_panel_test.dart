import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
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
    expect(find.text('Leverage: 10x'), findsOneWidget);
    expect(find.text('Cross'), findsOneWidget);
    expect(find.text('Isolated'), findsOneWidget);
    expect(find.text('Reduce only'), findsOneWidget);
    expect(find.text('Take profit / stop loss'), findsOneWidget);
    expect(find.text('Liquidation Price'), findsOneWidget);
    expect(find.text('Margin Required'), findsOneWidget);

    await tester.tap(find.text('Short'));
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
    expect(find.widgetWithText(FilledButton, 'Close NVDA'), findsOneWidget);
  });

  testWidgets('HIP-3 limit orders block a missing limit price', (tester) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const Hip3OrderPanel())),
    );

    await tester.tap(find.text('Limit'));
    await tester.pump();
    final submit = find.widgetWithText(FilledButton, 'Long NVDA');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();

    expect(find.text('Enter a valid limit price.'), findsOneWidget);
  });

  testWidgets('HIP-3 leverage sheet retains a confirmed selection', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const Hip3OrderPanel())),
    );

    await tester.tap(find.text('Leverage: 10x'));
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('Drag to set leverage'), findsOneWidget);
    expect(find.text('20x'), findsOneWidget);
    await tester.tap(find.text('20x'));
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();

    expect(find.text('Leverage: 20x'), findsOneWidget);
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
    expect(find.widgetWithText(FilledButton, 'Close NVDA'), findsOneWidget);
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

    await tester.tap(find.text('Isolated'));
    await tester.tap(find.text('Leverage: 10x'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('20x'));
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(SwitchListTile, 'Take profit / stop loss'),
    );
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Long NVDA'));
    await tester.tap(find.widgetWithText(FilledButton, 'Long NVDA'));
    await tester.pumpAndSettle();

    expect(orders.intent?.side, TradingSide.long);
    expect(orders.intent?.marginMode, TradingMarginMode.isolated);
    expect(orders.intent?.leverage?.value, '20');
    expect(find.text('Long NVDA · market'), findsOneWidget);
    expect(find.text('Leverage: 20x · isolated'), findsOneWidget);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Back'));
    await tester.pumpAndSettle();
    expect(find.text('Leverage: 20x'), findsOneWidget);
    expect(find.text('TP/SL will be set during order review.'), findsOneWidget);
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
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
