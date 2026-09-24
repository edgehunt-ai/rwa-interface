import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/features/orders/views/bstocks_order_panel.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

import '../../../../helpers/test_app.dart';
import '../../../../helpers/funded_repository.dart';

import 'package:rwa_interface/ui/features/orders/views/order_funding_sheet.dart';

void main() {
  for (final kind in [MarketProductKind.bstock, MarketProductKind.perp]) {
    testWidgets('$kind funding waits for arrival before allowing review', (
      tester,
    ) async {
      final funding = _PendingFundingRepository();
      final wallets = _FundingWalletsRepository();
      bool? funded;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            fundingRepositoryProvider.overrideWithValue(funding),
            walletsRepositoryProvider.overrideWithValue(wallets),
          ],
          child: buildTestApp(
            Builder(
              builder: (context) => TextButton(
                onPressed: () async {
                  funded = await showModalBottomSheet<bool>(
                    context: context,
                    builder: (_) =>
                        OrderFundingSheet(plan: _readyFundingPlan, kind: kind),
                  );
                },
                child: const Text('Open funding'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open funding'));
      await tester.pumpAndSettle();
      expect(wallets.authorizations, 0);
      await tester.tap(find.widgetWithText(FilledButton, 'In-App Transfer'));
      await tester.pumpAndSettle();
      expect(funding.transfers, 1);
      expect(wallets.authorizations, 1);
      expect(funded, isNull);
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'In-App Transfer'),
            )
            .onPressed,
        isNull,
      );
      funding.completed = true;
      await tester.tap(find.widgetWithText(OutlinedButton, 'Retry'));
      await tester.pumpAndSettle();
      expect(funded, isTrue);
      expect(funding.transfers, 1);
      expect(wallets.authorizations, 1);
    });
  }

  testWidgets('bStocks order form follows tab sizing and continuous slider', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const BstocksOrderPanel())),
    );

    expect(
      tester.getSize(find.byKey(const Key('bstocks-side-tabs'))),
      const Size(123, 44),
    );
    final sliderFinder = find.byKey(const Key('bstocks-percentage-slider'));
    expect(tester.widget<Slider>(sliderFinder).divisions, isNull);
    await tester.drag(sliderFinder, const Offset(37, 0));
    await tester.pump();
    expect(tester.widget<Slider>(sliderFinder).value % 20, isNot(0));
  });

  testWidgets(
    'slider selection is applied after the balance finishes loading',
    (tester) async {
      final balance = Completer<DecimalValue>();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            bstocksOrderAvailableBalanceProvider.overrideWith(
              (_) => balance.future,
            ),
          ],
          child: buildTestApp(const BstocksOrderPanel()),
        ),
      );

      final input = find.byType(TextField).first;
      final slider = find.byKey(const Key('bstocks-percentage-slider'));
      tester.widget<Slider>(slider).onChanged!(50);
      await tester.pump();
      expect(tester.widget<TextField>(input).controller!.text, isEmpty);

      balance.complete(DecimalValue('456.78', asset: 'USD', unit: 'fiat'));
      await tester.pumpAndSettle();
      expect(tester.widget<TextField>(input).controller!.text, '228');
      expect(tester.widget<Slider>(slider).value, closeTo(50, 0.2));
    },
  );

  testWidgets('bStocks order form renders account balance and live quote', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          bstocksOrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('456.78', asset: 'USD', unit: 'fiat'),
          ),
          ordersRepositoryProvider.overrideWithValue(_QuotedOrdersRepository()),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Spot balance: '), findsOneWidget);
    expect(find.text('456.78 TUSDT'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.pump(const Duration(milliseconds: 301));
    await tester.pumpAndSettle();

    expect(find.text('0.54 NVDAB'), findsOneWidget);
    expect(find.text('0.02 NVDAB'), findsOneWidget);
    expect(find.text('USDC'), findsOneWidget);
  });

  testWidgets('review summary formats fee with its settlement asset', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          ordersRepositoryProvider.overrideWithValue(
            _SettlementFeeOrdersRepository(),
          ),
        ],
        child: buildTestApp(const BstocksOrderPanel(symbol: 'TSLA')),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.pump(const Duration(milliseconds: 301));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
    await _pumpUntilFound(tester, find.text('Order Type'));

    expect(tester.takeException(), isNull);
    expect(find.text('Order Type'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('0.02 USDC'), findsWidgets);
  });

  testWidgets('balance slider and order value stay synchronized', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          bstocksOrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('456.78', asset: 'USD', unit: 'fiat'),
          ),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );
    await tester.pumpAndSettle();

    final input = find.byType(TextField).first;
    final slider = find.byKey(const Key('bstocks-percentage-slider'));
    tester.widget<Slider>(slider).onChanged!(50);
    await tester.pump();
    expect(tester.widget<TextField>(input).controller!.text, '228');
    expect(tester.widget<Slider>(slider).value, closeTo(50, 0.2));

    tester.widget<Slider>(slider).onChanged!(100);
    await tester.pump();
    expect(tester.widget<TextField>(input).controller!.text, '456.78');

    await tester.enterText(input, '114.195');
    await tester.pump();
    expect(tester.widget<Slider>(slider).value, closeTo(25, 0.0001));

    await tester.enterText(input, '999');
    await tester.pump();
    expect(tester.widget<Slider>(slider).value, 100);

    await tester.enterText(input, '-1');
    await tester.pump();
    expect(tester.widget<Slider>(slider).value, 0);

    await tester.enterText(input, 'invalid');
    await tester.pump();
    expect(tester.widget<Slider>(slider).value, 0);
  });

  testWidgets('small balances keep slider decimals', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          bstocksOrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('1.5', asset: 'USD', unit: 'fiat'),
          ),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );
    await tester.pumpAndSettle();

    final input = find.byType(TextField).first;
    final slider = find.byKey(const Key('bstocks-percentage-slider'));
    tester.widget<Slider>(slider).onChanged!(50);
    await tester.pump();

    expect(tester.widget<TextField>(input).controller!.text, '0.75');
  });

  testWidgets(
    'sell uses the matching position quantity without a dollar sign',
    (tester) async {
      final position = Position(
        positionId: 'nvda-position',
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        quantity: DecimalValue('12.5', asset: 'NVDA', unit: 'token'),
        valueUsd: DecimalValue('1000', asset: 'USD', unit: 'fiat'),
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            fundingRepositoryProvider.overrideWithValue(FundedRepository()),
            bstocksOrderAvailableBalanceProvider.overrideWith(
              (ref) async => DecimalValue('456.78', asset: 'USD', unit: 'fiat'),
            ),
            holdingsProvider(null).overrideWith(
              (ref) async => DomainPage(
                items: [
                  HoldingGroup(
                    symbol: 'NVDA',
                    totalValueUsd: position.valueUsd,
                    positions: [position],
                  ),
                ],
              ),
            ),
          ],
          child: buildTestApp(
            const BstocksOrderPanel(
              symbol: 'NVDAB',
              initialSide: TradingSide.sell,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('12.5 NVDAB'), findsOneWidget);
      expect(find.text(r'$456.78'), findsNothing);

      final slider = find.byKey(const Key('bstocks-percentage-slider'));
      tester.widget<Slider>(slider).onChanged!(40);
      await tester.pump();

      expect(
        tester.widget<TextField>(find.byType(TextField).first).controller!.text,
        '5',
      );
      expect(find.text('Sell NVDAB · 5'), findsOneWidget);
      expect(find.text(r'Sell NVDAB · $5'), findsNothing);
    },
  );

  testWidgets('bStocks order form shows a skeleton while the balance loads', (
    tester,
  ) async {
    final balance = Completer<DecimalValue>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          bstocksOrderAvailableBalanceProvider.overrideWith(
            (_) => balance.future,
          ),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );

    expect(find.byKey(const Key('bstocks-balance-loading')), findsOneWidget);
    expect(find.text('—'), findsNothing);

    balance.complete(DecimalValue('0', asset: 'USD', unit: 'fiat'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('bstocks-balance-loading')), findsNothing);
    expect(find.text('0 TUSDT'), findsOneWidget);
  });

  testWidgets('bStocks order panel validates an empty order value', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const BstocksOrderPanel())),
    );

    expect(find.text('Buy NVDAB'), findsWidgets);
    await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
    await tester.pump();
    expect(find.text('Enter a valid order value.'), findsOneWidget);

    expect(find.text('Market'), findsOneWidget);
    expect(find.text('Limit'), findsOneWidget);
  });

  testWidgets(
    'bStocks sell panel preserves its initial side and token amount',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: buildTestApp(
            const BstocksOrderPanel(initialSide: TradingSide.sell),
          ),
        ),
      );

      expect(find.text('Sell NVDAB'), findsWidgets);
      expect(find.text('Amount'), findsOneWidget);
      expect(find.text('NVDAB'), findsWidgets);
    },
  );

  testWidgets('slippage can be edited before requesting an order preview', (
    tester,
  ) async {
    final repository = _CapturingOrdersRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          ordersRepositoryProvider.overrideWithValue(repository),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );

    await tester.tap(find.byKey(const Key('bstocks-edit-slippage')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('bstocks-slippage-input')),
      '0.5',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();

    expect(find.text('0.5%'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
    await tester.pumpAndSettle();

    expect(repository.previewIntent?.slippage?.value, '0.5');
  });

  testWidgets('slippage editor restricts malformed and out-of-range values', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const BstocksOrderPanel())),
    );

    await tester.tap(find.byKey(const Key('bstocks-edit-slippage')));
    await tester.pumpAndSettle();
    final input = find.byKey(const Key('bstocks-slippage-input'));
    await tester.enterText(input, '0.123');
    expect(tester.widget<TextField>(input).controller!.text, '0.12');

    await tester.enterText(input, '100.01');
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pump();
    expect(
      find.text('Enter a slippage percentage from 0% to 100%.'),
      findsOneWidget,
    );
  });

  testWidgets('confirmation first shows the submitting-order state', (
    tester,
  ) async {
    final repository = _DelayedOrdersRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          ordersRepositoryProvider.overrideWithValue(repository),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
    await _pumpUntilFound(
      tester,
      find.widgetWithText(FilledButton, 'Confirm Buy'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm Buy'));
    await tester.pump();

    expect(find.text('Submitting Order…'), findsOneWidget);
    expect(find.text('Close & View Later'), findsOneWidget);

    repository.complete();
    await tester.pump();
  });

  testWidgets('insufficient funds sheet presents recoverable funding routes', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          BstocksFundingRequiredSheet(
            amountNeeded: DecimalValue('100', asset: 'USDT', unit: 'token'),
            onInAppTransfer: () {},
            onExternalDeposit: () {},
          ),
        ),
      ),
    );

    expect(find.text('Amount needed'), findsOneWidget);
    expect(find.text('100 USDT'), findsOneWidget);
    expect(find.text('In-App Transfer'), findsOneWidget);
    expect(find.text('External Deposit'), findsOneWidget);
  });

  testWidgets(
    'high displayed balance still checks BSC USDT through the funding plan',
    (tester) async {
      final funding = _FundingPlanRepository(_readyFundingPlan);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            bstocksOrderAvailableBalanceProvider.overrideWith(
              (ref) async => DecimalValue('100000', asset: 'USD', unit: 'fiat'),
            ),
            ordersRepositoryProvider.overrideWithValue(
              _DelayedOrdersRepository(),
            ),
            fundingRepositoryProvider.overrideWithValue(funding),
          ],
          child: buildTestApp(const BstocksOrderPanel()),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '100');
      await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
      await _pumpUntilFound(tester, find.text('Add funds from:'));

      expect(funding.previewIds, ['preview-1']);
      expect(find.text('Add funds from:'), findsOneWidget);
    },
  );

  testWidgets(
    'transfer flow renders the server-selected source through review',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: buildTestApp(
            BstocksTransferFlowSheet(
              amountNeeded: DecimalValue('100', asset: 'USDT', unit: 'token'),
              plan: _readyFundingPlan,
              orderPreview: _fundedPreview,
              symbol: 'NVDAB',
            ),
          ),
        ),
      );

      expect(find.text('In-app transfer'), findsOneWidget);
      expect(find.text('USDC (server selected)'), findsOneWidget);
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pump();
      expect(find.text('Buy NVDAB · Market'), findsOneWidget);
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Confirm Buy'),
      );
    },
  );

  testWidgets('funding pending state is independently reachable', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          BstocksTransferFlowSheet(
            amountNeeded: DecimalValue('100', asset: 'USDT', unit: 'token'),
            initialStage: BstocksTransferFlowStage.fundingPending,
            plan: _readyFundingPlan,
            orderPreview: _fundedPreview,
            symbol: 'NVDAB',
          ),
        ),
      ),
    );

    expect(find.text('Preparing trading funds…'), findsOneWidget);
    expect(find.text('Close & View Later'), findsOneWidget);
  });

  testWidgets(
    'completed funding submits the original preview ID once and can close pending',
    (tester) async {
      final orders = _PreviewCapturingOrdersRepository();
      final funding = _CompletedFundingRepository();
      final wallets = _FundingWalletsRepository();
      var closed = false;
      final preview = OrderPreview(
        previewId: 'funded-preview',
        intent: OrderIntent(
          symbol: 'NVDAB',
          kind: MarketProductKind.bstock,
          side: TradingSide.buy,
          type: TradingOrderType.market,
          amount: DecimalValue('100', asset: 'USDT', unit: 'token'),
        ),
        orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(orders),
            fundingRepositoryProvider.overrideWithValue(funding),
            walletsRepositoryProvider.overrideWithValue(wallets),
          ],
          child: buildTestApp(
            BstocksTransferFlowSheet(
              amountNeeded: DecimalValue('100', asset: 'USDT', unit: 'token'),
              plan: _readyFundingPlan,
              orderPreview: preview,
              symbol: 'NVDAB',
              onClose: () => closed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(find.text('Buy NVDAB · Market'), findsOneWidget);
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Confirm Buy'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm Buy'));
      await tester.pump();
      await tester.runAsync(
        () async => await Future<void>.delayed(Duration.zero),
      );
      await tester.pump(const Duration(seconds: 1));

      expect(wallets.authorizations, 1);
      expect(funding.transfers, 1);
      expect(
        find.text('Unable to authorize or start this transfer. Try again.'),
        findsNothing,
      );
      expect(orders.receivedPreviewIds, [preview.previewId]);
      expect(find.text('Submitting Order…'), findsOneWidget);
      await tester.tap(
        find.widgetWithText(OutlinedButton, 'Close & View Later'),
      );
      expect(closed, isTrue);
    },
  );

  testWidgets('filled bStocks order opens Activity from View History', (
    tester,
  ) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: BstocksOrderPanel()),
        ),
        GoRoute(
          name: AppRoutes.activityName,
          path: AppRoutes.activityPath,
          builder: (_, _) => const Scaffold(body: Text('Activity destination')),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          ordersRepositoryProvider.overrideWithValue(_FilledOrdersRepository()),
        ],
        child: buildRouterTestApp(router),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
    await _pumpUntilFound(
      tester,
      find.widgetWithText(FilledButton, 'Confirm Buy'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm Buy'));
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Trade Successful'), findsOneWidget);
    expect(
      find.text('You can check the order status on the activities page.'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'View History'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Activity destination'), findsOneWidget);
  });

  testWidgets(
    'a rejected bStocks order remains reviewable with failure feedback',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            fundingRepositoryProvider.overrideWithValue(FundedRepository()),
            ordersRepositoryProvider.overrideWithValue(
              _RejectedOrdersRepository(),
            ),
          ],
          child: buildTestApp(const BstocksOrderPanel()),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '100');
      await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
      await _pumpUntilFound(
        tester,
        find.widgetWithText(FilledButton, 'Confirm Buy'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm Buy'));
      await tester.pump(const Duration(milliseconds: 100));
      await _pumpUntilFound(tester, find.textContaining('network:'));

      expect(find.textContaining('network:'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Confirm Buy'), findsOneWidget);
      expect(find.text('Trade Successful'), findsNothing);
    },
  );
}

Future<void> _pumpUntilFound(
  WidgetTester tester,
  Finder finder, {
  int attempts = 100,
}) async {
  for (var i = 0; i < attempts && finder.evaluate().isEmpty; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
  expect(finder, findsWidgets);
}

final class _DelayedOrdersRepository implements OrdersRepository {
  final _submission = Completer<ResourceResult<TradingOrder>>();

  void complete() => _submission.complete(
    ResourceResult(
      resource: TradingOrder(
        orderId: 'order-1',
        symbol: 'NVDAB',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.market,
        status: TradingOrderStatus.submitted,
        createdAt: DateTime.utc(2026),
      ),
    ),
  );

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: 'preview-1',
    intent: intent,
    orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
  );

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) => _submission.future;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

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

final class _FilledOrdersRepository extends _DelayedOrdersRepository {
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async => ResourceResult(
    resource: TradingOrder(
      orderId: 'filled-order-1',
      symbol: intent.symbol,
      kind: intent.kind,
      side: intent.side,
      type: intent.type,
      status: TradingOrderStatus.filled,
      createdAt: DateTime.utc(2026),
    ),
  );
}

final class _QuotedOrdersRepository extends _DelayedOrdersRepository {
  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: 'live-quote',
    intent: intent,
    orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
    estimatedQuantity: DecimalValue('0.54', asset: 'NVDAB', unit: 'token'),
    fee: DecimalValue('0.02', asset: 'NVDAB', unit: 'token'),
    settlementAsset: 'USDC',
  );
}

final class _SettlementFeeOrdersRepository extends _DelayedOrdersRepository {
  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: 'settlement-fee-quote',
    intent: intent,
    orderValue: DecimalValue('100', asset: 'USDC', unit: 'token'),
    estimatedQuantity: DecimalValue('0.54', asset: 'TSLA', unit: 'token'),
    fee: DecimalValue('0.02', asset: 'USDC', unit: 'token'),
    settlementAsset: 'USDC',
  );
}

final class _CapturingOrdersRepository extends _DelayedOrdersRepository {
  OrderIntent? previewIntent;

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    previewIntent = intent;
    return OrderPreview(
      previewId: 'limit-preview',
      intent: intent,
      orderValue: DecimalValue('10', asset: 'USDT', unit: 'token'),
    );
  }
}

final class _RejectedOrdersRepository extends _DelayedOrdersRepository {
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) => Future<ResourceResult<TradingOrder>>.error(const NetworkFailure());
}

final _readyFundingPlan = FundingPlan(
  planId: 'completed-plan',
  tradePreviewId: 'funded-preview',
  shortfall: DecimalValue('100', asset: 'USDT', unit: 'token'),
  status: FundingPlanState.ready,
  sourceWalletId: 'wallet-1',
  sourceAsset: 'USDC',
  sourceMaximum: DecimalValue('150', asset: 'USDC', unit: 'token'),
  legs: [
    FundingLeg(
      legId: 'leg-1',
      walletId: 'wallet-1',
      asset: 'USDC',
      maximumAmount: DecimalValue('150', asset: 'USDC', unit: 'token'),
      outputAmount: DecimalValue('100', asset: 'USDT', unit: 'token'),
      status: FundingLegState.actionReleased,
    ),
  ],
);

final _fundedPreview = OrderPreview(
  previewId: 'funded-preview',
  intent: OrderIntent(
    symbol: 'NVDAB',
    kind: MarketProductKind.bstock,
    side: TradingSide.buy,
    type: TradingOrderType.market,
    amount: DecimalValue('100', asset: 'USDT', unit: 'token'),
  ),
  orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
);

final class _PreviewCapturingOrdersRepository extends _DelayedOrdersRepository {
  final receivedPreviewIds = <String?>[];

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) {
    receivedPreviewIds.add(previewId);
    return super.create(
      intent,
      idempotencyKey: idempotencyKey,
      previewId: previewId,
    );
  }
}

final class _CompletedFundingRepository implements FundingRepository {
  var transfers = 0;
  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    transfers++;
    return FundingTransfer(
      transferId: 'completed-transfer',
      planId: planId,
      amount: DecimalValue('100', asset: 'USDT', unit: 'token'),
      status: FundingTransferState.completed,
    );
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async => FundingPlan(
    planId: id,
    tradePreviewId: 'funded-preview',
    shortfall: DecimalValue('0', asset: 'USDT', unit: 'token'),
    status: FundingPlanState.alreadyFunded,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FundingPlanRepository implements FundingRepository {
  _FundingPlanRepository(this.plan);

  final FundingPlan plan;
  final previewIds = <String>[];

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async {
    previewIds.add(tradePreviewId);
    return plan;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FundingWalletsRepository implements WalletsRepository {
  var authorizations = 0;
  @override
  Future<WalletAuthorization> authorizeFundingTransfer({
    required String walletId,
    required String planId,
    required String asset,
    required String maximumAmount,
    required String idempotencyKey,
  }) async {
    authorizations++;
    return WalletAuthorization(
      authorizationId: 'funding-authorization',
      walletId: walletId,
      status: WalletAuthorizationState.authorized,
      expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _PendingFundingRepository implements FundingRepository {
  int transfers = 0;
  bool completed = false;
  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    transfers++;
    return FundingTransfer(
      transferId: 'pending-transfer',
      planId: planId,
      amount: DecimalValue('100'),
      status: FundingTransferState.filling,
    );
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async => FundingPlan(
    planId: id,
    tradePreviewId: 'preview-1',
    shortfall: DecimalValue(completed ? '0' : '100'),
    status: completed ? FundingPlanState.alreadyFunded : FundingPlanState.ready,
  );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
