import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/hip3_opening_protection.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/hip3_order_execution_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_order_panel.dart';

import '../../../../helpers/test_app.dart';

import 'package:rwa_interface/domain/models/hip3_opening_context.dart';
import 'package:rwa_interface/domain/repositories/hip3_opening_repository.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/domain/models/hip3_opening_size.dart';

void main() {
  testWidgets('quantity input is labelled in product units, not dollars', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const Hip3OrderPanel()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Quantity').first);
    await tester.enterText(find.byType(TextField).first, '2');
    await tester.pump();
    expect(find.text('Long NVDA · 2 NVDA'), findsOneWidget);
    expect(find.text(r'Long NVDA · $2'), findsNothing);
  });

  testWidgets(
    'leverage modal from an old session cannot change the new account',
    (tester) async {
      final opening = _Opening();
      await tester.pumpWidget(_app(const Hip3OrderPanel(), opening: opening));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('20x'));
      final container = ProviderScope.containerOf(
        tester.element(find.byType(Hip3OrderPanel)),
      );
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(opening.settingsRequests, 0);
      expect(opening.leverage, 10);
    },
  );
  testWidgets(
    'opening protection is reviewed and submitted with the parent, not labelled active',
    (tester) async {
      final execution = _Hip3Execution();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(_ExecutableHip3Orders()),
            hip3OrderExecutionRepositoryProvider.overrideWithValue(execution),
          ],
          child: _app(const Hip3OrderPanel()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '100');
      await tester.tap(find.byKey(const Key('hip3-tp-sl-toggle')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('opening-protection-0')),
        '120',
      );
      await tester.ensureVisible(find.byType(FilledButton).first);
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      expect(find.text('Fixed quantity: 1 (this order only)'), findsOneWidget);
      expect(
        find.textContaining(
          'Mark trigger 120 USDC · Market price bound 108 USDC',
        ),
        findsOneWidget,
      );
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(execution.calls, 1);
      expect(
        find.textContaining('Attached protection is not confirmed active'),
        findsOneWidget,
      );
    },
  );
  testWidgets('opening protection label is scoped to this order', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const Hip3OrderPanel()));
    await tester.pumpAndSettle();
    expect(find.text('Order TP/SL'), findsOneWidget);
    expect(find.text('Position TP/SL'), findsNothing);
  });
  testWidgets(
    'late execution outcomes cannot restore a previous account order',
    (tester) async {
      for (final pending in [false, true]) {
        final release = Completer<void>();
        final execution = _Hip3Execution(
          pending: pending,
          waitFor: release.future,
        );
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              ordersRepositoryProvider.overrideWithValue(
                _ExecutableHip3Orders(),
              ),
              hip3OrderExecutionRepositoryProvider.overrideWithValue(execution),
            ],
            child: _app(const Hip3OrderPanel()),
          ),
        );
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextField).first, '100');
        await tester.tap(find.byType(FilledButton).first);
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
        await tester.pump();
        expect(execution.orderId, 'order-1');
        final container = ProviderScope.containerOf(
          tester.element(find.byType(Hip3OrderPanel)),
        );
        container.read(sessionGenerationProvider.notifier).clearUserScope();
        await tester.pumpAndSettle();
        release.complete();
        await tester.pumpAndSettle();
        expect(find.text('Order submitted'), findsNothing);
        expect(find.textContaining('Confirming this order'), findsNothing);
        expect(find.byType(TextField), findsWidgets);
        await tester.pumpWidget(const SizedBox());
      }
    },
  );
  testWidgets('late review cannot restore a previous account quote', (
    tester,
  ) async {
    final release = Completer<void>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          orderPreviewProvider.overrideWith((ref, intent) async {
            await release.future;
            return _ExecutableHip3Orders().preview(
              intent,
              idempotencyKey: 'old-account',
            );
          }),
        ],
        child: _app(const Hip3OrderPanel()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byType(FilledButton).first);
    await tester.pump();
    final container = ProviderScope.containerOf(
      tester.element(find.byType(Hip3OrderPanel)),
    );
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await tester.pumpAndSettle();
    release.complete();
    await tester.pumpAndSettle();
    expect(find.widgetWithText(FilledButton, 'Confirm'), findsNothing);
    expect(find.byType(TextField), findsWidgets);
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller!.text,
      isEmpty,
    );
  });

  testWidgets('optional opening phone visual capture', (tester) async {
    const output = String.fromEnvironment('HIP3_OPEN_CAPTURE');
    const font = String.fromEnvironment('HIP3_OPEN_FONT');
    if (output.isEmpty || font.isEmpty) return;
    await tester.runAsync(() async {
      final bytes = ByteData.sublistView(await File(font).readAsBytes());
      for (final name in ['Roboto', 'Ahem']) {
        final loader = FontLoader(name)..addFont(Future.value(bytes));
        for (final weight in ['Medium', 'Bold']) {
          loader.addFont(
            Future.value(
              ByteData.sublistView(
                await File('${File(font).parent.path}/Roboto-$weight.ttf')
                    .readAsBytes(),
              ),
            ),
          );
        }
        await loader.load();
      }
      await (FontLoader('MaterialIcons')..addFont(
            Future.value(
              ByteData.sublistView(
                await File(
                  '${File(font).parent.path}/MaterialIcons-Regular.otf',
                ).readAsBytes(),
              ),
            ),
          ))
          .load();
    });
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    const key = Key('opening-capture');
    await tester.pumpWidget(
      RepaintBoundary(
        key: key,
        child: ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(_ExecutableHip3Orders()),
          ],
          child: _app(const Hip3OrderPanel()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    Future<void> capture(String suffix) async {
      final boundary = tester.renderObject<RenderRepaintBoundary>(
        find.byKey(key),
      );
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File('$output-$suffix.png')
            .writeAsBytes(bytes!.buffer.asUint8List());
        image.dispose();
      });
    }

    await capture('form');
    await tester.enterText(find.byType(TextField).first, '100');
    if (const bool.fromEnvironment('HIP3_OPEN_PROTECTION')) {
      await tester.tap(find.byKey(const Key('hip3-tp-sl-toggle')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('opening-protection-0')),
        '120',
      );
      await tester.enterText(
        find.byKey(const Key('opening-protection-2')),
        '90',
      );
      await tester.enterText(
        find.byKey(const Key('opening-protection-3')),
        '89',
      );
      await tester.ensureVisible(find.byKey(const Key('opening-protection-2')));
      await tester.pumpAndSettle();
      await capture('protection');
    }
    await tester.ensureVisible(find.byType(FilledButton).first);
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();
    if (const bool.fromEnvironment('HIP3_OPEN_PROTECTION')) {
      await tester.ensureVisible(
        find.text('Fixed quantity: 1 (this order only)'),
      );
      await tester.pumpAndSettle();
    }
    await capture('review');
    expect(tester.takeException(), isNull);
  });
  test('opening percentages floor whole lots and preserve exact notional', () {
    final intent = OrderIntent(
      symbol: 'TSLA',
      kind: MarketProductKind.perp,
      side: TradingSide.long,
      type: TradingOrderType.market,
      amount: DecimalValue('15'),
    );
    final quote = _previewExecution(intent, maximum: '0.148');
    expect(hip3OpeningPercentage(quote, 50, 3, notional: false), '0.074');
    expect(hip3OpeningPercentage(quote, 25, 3, notional: true), '3.7');
    expect(hip3OpeningPercentage(quote, 1, 3, notional: false), '0.001');
    expect(hip3OpeningPercentage(quote, 0, 3, notional: true), '0');
    expect(
      () => hip3OpeningPercentage(quote, 101, 3, notional: false),
      throwsArgumentError,
    );
  });
  testWidgets('missing or expired quotes cannot create a new order', (
    tester,
  ) async {
    for (final missing in [false, true]) {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(
              _ExecutableHip3Orders(expired: true, missingExecution: missing),
            ),
          ],
          child: _app(const Hip3OrderPanel()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '100');
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      final confirm = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Confirm'),
      );
      expect(confirm.onPressed, isNull);
      expect(
        find.textContaining('Quote unavailable or expired'),
        findsOneWidget,
      );
      await tester.pumpWidget(const SizedBox());
    }
  });
  testWidgets(
    'leverage options follow product maximum and sign before selection changes',
    (tester) async {
      final opening = _Opening(maximum: 7)..leverage = 3;
      await tester.pumpWidget(_app(const Hip3OrderPanel(), opening: opening));
      await tester.pumpAndSettle();
      expect(find.text('3×'), findsWidgets);
      await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
      await tester.pumpAndSettle();
      expect(find.text('20x'), findsNothing);
      await tester.tap(find.text('7x'));
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(opening.leverage, 7);
      expect(opening.settingsRequests, 1);
      expect(find.text('7×'), findsWidgets);
    },
  );
  testWidgets(
    'an unresolved broadcast shows confirmation pending, not success',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(_ExecutableHip3Orders()),
            hip3OrderExecutionRepositoryProvider.overrideWithValue(
              _Hip3Execution(pending: true),
            ),
          ],
          child: _app(const Hip3OrderPanel()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '100');
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(find.textContaining('Confirming this order.'), findsOneWidget);
      final container = ProviderScope.containerOf(
        tester.element(find.byType(Hip3OrderPanel)),
      );
      expect(
        container.read(hip3QueryRevisionProvider),
        greaterThan(0),
        reason: 'ambiguous broadcasts must refresh recoverable actions and balances too',
      );
      expect(find.text('Order submitted'), findsNothing);
      expect(find.text('Trade Successful'), findsNothing);
    },
  );
  testWidgets('HIP-3 panel exposes perpetual-only order controls', (
    tester,
  ) async {
    await tester.pumpWidget(ProviderScope(child: _app(const Hip3OrderPanel())));

    await tester.pumpAndSettle();
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
      ProviderScope(child: _app(const Hip3OrderPanel(initialReduceOnly: true))),
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
        child: _app(const Hip3OrderPanel()),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '100');
    await tester.pump(const Duration(milliseconds: 301));
    await tester.pumpAndSettle();

    expect(find.text('USDT'), findsOneWidget);
  });

  testWidgets('HIP-3 leverage sheet retains a confirmed selection', (
    tester,
  ) async {
    await tester.pumpWidget(ProviderScope(child: _app(const Hip3OrderPanel())));

    await tester.pumpAndSettle();
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
        child: _app(
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

  testWidgets(
    'HIP-3 review preserves settings and real opening protection intent',
    (tester) async {
      final orders = _CapturingHip3Orders();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
          child: _app(const Hip3OrderPanel()),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('hip3-margin-mode-toggle')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('20x'));
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('hip3-tp-sl-toggle')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('opening-protection-0')),
        '120',
      );
      await tester.enterText(
        find.byKey(const Key('opening-protection-2')),
        '90',
      );
      await tester.enterText(
        find.byKey(const Key('opening-protection-3')),
        '89',
      );
      await tester.enterText(find.byType(TextField).first, '100');
      await tester.ensureVisible(find.byType(FilledButton).first);
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();

      expect(orders.intent?.side, TradingSide.long);
      expect(orders.intent?.marginMode, TradingMarginMode.isolated);
      expect(orders.intent?.leverage?.value, '20');
      expect(
        orders.intent?.openingProtection?.takeProfit?.triggerPrice.value,
        '120',
      );
      expect(orders.intent?.openingProtection?.takeProfit?.limitPrice, isNull);
      expect(
        orders.intent?.openingProtection?.stopLoss?.limitPrice?.value,
        '89',
      );
      expect(orders.intent?.tpSl, isNull);
      expect(find.text('Review Long NVDA'), findsOneWidget);
      expect(find.text('Isolated'), findsOneWidget);
      expect(find.text('20x'), findsOneWidget);

      await tester.tap(find.widgetWithText(OutlinedButton, 'Back'));
      await tester.pumpAndSettle();
      expect(find.text('20×'), findsWidgets);
      expect(find.text('Remove'), findsOneWidget);
    },
  );

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
        child: _app(const Hip3OrderPanel()),
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
      hip3Execution: _previewExecution(value),
      expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _app(Widget child, {Hip3OpeningRepository? opening}) => ProviderScope(
  overrides: [
    hip3OpeningRepositoryProvider.overrideWithValue(opening ?? _Opening()),
    hip3OpeningContextProvider.overrideWith(
      (ref, product) =>
          ref.watch(hip3OpeningRepositoryProvider).context(product),
    ),
  ],
  child: buildTestApp(child),
);

final class _Opening implements Hip3OpeningRepository {
  _Opening({this.maximum = 20});
  final int maximum;
  int settingsRequests = 0;
  int leverage = 10;
  TradingMarginMode mode = TradingMarginMode.cross;
  @override
  Future<Hip3OpeningContext> context(String productOrSymbol) async =>
      Hip3OpeningContext(
        contextId: 'context',
        productId: productOrSymbol.contains(':')
            ? productOrSymbol
            : 'xyz:$productOrSymbol',
        environment: 'testnet',
        currentLeverage: leverage,
        maximumLeverage: maximum,
        currentMarginMode: mode,
        marginModes: {TradingMarginMode.cross, TradingMarginMode.isolated},
        orderTypes: {TradingOrderType.market, TradingOrderType.limit},
        timeInForce: {'gtc', 'ioc'},
        availableMargin: DecimalValue('100'),
        minimumNotional: DecimalValue('12'),
        maximumNotional: DecimalValue('1000'),
        sizeDecimals: 3,
        validUntil: DateTime.now().toUtc().add(const Duration(minutes: 1)),
        operations: {'placeOrder', 'setLeverage'},
      );
  @override
  Future<Hip3OpeningContext> setLeverage(
    String productId,
    int leverage,
    TradingMarginMode mode, {
    required String idempotencyKey,
  }) async {
    settingsRequests++;
    this.leverage = leverage;
    this.mode = mode;
    return context(productId);
  }
}

final class _ExecutableHip3Orders implements OrdersRepository {
  _ExecutableHip3Orders({this.expired = false, this.missingExecution = false});
  final bool expired;
  final bool missingExecution;
  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: 'hip3-preview',
    intent: intent,
    orderValue: DecimalValue('100', asset: 'USDC', unit: 'token'),
    hip3Execution: missingExecution ? null : _previewExecution(intent),
    expiresAt: DateTime.now().toUtc().add(Duration(minutes: expired ? -1 : 1)),
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
  _Hip3Execution({this.pending = false, this.waitFor});
  final bool pending;
  final Future<void>? waitFor;
  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  }) => throw UnimplementedError();
  String? orderId;
  int calls = 0;

  @override
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(
    String orderId,
  ) async {
    calls++;
    this.orderId = orderId;
    if (waitFor != null) await waitFor;
    if (pending) throw Hip3ExecutionPending(orderId, 'action-1');
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

Hip3PreviewExecution _previewExecution(
  OrderIntent intent, {
  String maximum = '1',
}) => Hip3PreviewExecution(
  openingProtection: intent.openingProtection == null
      ? null
      : Hip3OpeningProtectionConfirmation(
          quantity: DecimalValue('1'),
          legs: [
            for (final (take, leg) in [
              (true, intent.openingProtection!.takeProfit),
              (false, intent.openingProtection!.stopLoss),
            ])
              if (leg != null)
                Hip3ConfirmedProtectionLeg(
                  takeProfit: take,
                  market: leg.limitPrice == null,
                  triggerPrice: leg.triggerPrice,
                  executionPrice:
                      leg.limitPrice ?? DecimalValue(take ? '108' : '81'),
                ),
          ],
        ),
  contextId: 'context',
  productId: 'xyz:${intent.symbol}',
  environment: 'testnet',
  quantity: DecimalValue('1'),
  type: intent.type,
  timeInForce: 'ioc',
  limitPrice: DecimalValue('100'),
  leverage: intent.leverage ?? DecimalValue('1'),
  marginMode: intent.marginMode ?? TradingMarginMode.cross,
  reduceOnly: false,
  notional: DecimalValue('100'),
  marginRequired: DecimalValue('10'),
  availableMargin: DecimalValue('20'),
  maximumQuantity: DecimalValue(maximum),
  estimatedFee: DecimalValue('0.05'),
  slippagePercent: DecimalValue('1'),
  liquidationPriceUnavailableReason:
      'cross_margin_requires_full_account_simulation',
);
