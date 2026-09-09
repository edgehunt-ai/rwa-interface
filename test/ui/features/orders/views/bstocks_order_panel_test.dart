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
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/features/orders/views/bstocks_order_panel.dart';

import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('bStocks order panel validates an empty order value', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(child: buildTestApp(const BstocksOrderPanel())),
    );

    expect(find.text('Buy NVDAB'), findsWidgets);
    await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
    await tester.pump();
    expect(find.text('Enter a valid order value.'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Limit'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Drag to set'), findsOneWidget);
    await tester.tap(find.widgetWithText(OutlinedButton, 'Back'));
    await tester.pumpAndSettle();
    expect(find.text('Limit Price'), findsOneWidget);
    await tester.tap(find.text('Take profit/stop loss · Add'));
    await tester.pump();
    expect(
      find.text('TP/SL is not available for bStocks orders.'),
      findsOneWidget,
    );
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
      expect(find.text('Balance: 400'), findsOneWidget);
      expect(find.text('NVDAB'), findsWidgets);
    },
  );

  testWidgets('limit order preserves its price and quantity for preview', (
    tester,
  ) async {
    final repository = _CapturingOrdersRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );

    await tester.tap(find.widgetWithText(ChoiceChip, 'Limit'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), '0.88');
    await tester.enterText(find.byType(TextField).at(1), '180');
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Buy NVDAB'));
    await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
    await tester.pumpAndSettle();

    expect(repository.previewIntent?.type, TradingOrderType.limit);
    expect(repository.previewIntent?.quantity?.value, '0.88');
    expect(repository.previewIntent?.limitPrice?.value, '180');
    expect(find.widgetWithText(FilledButton, 'Confirm Buy'), findsOneWidget);
  });

  testWidgets('confirmation first shows the submitting-order state', (
    tester,
  ) async {
    final repository = _DelayedOrdersRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
    await tester.pump();
    await tester.pump();
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

    expect(find.text('Amount Needed'), findsOneWidget);
    expect(find.text('100 USDT'), findsOneWidget);
    expect(find.text('In-App Transfer'), findsOneWidget);
    expect(find.text('External Deposit'), findsOneWidget);
  });

  testWidgets(
    'market orders over the displayed balance open funding recovery',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(child: buildTestApp(const BstocksOrderPanel())),
      );

      await tester.enterText(find.byType(TextField).first, '1001');
      await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
      await tester.pumpAndSettle();

      expect(find.text('Amount Needed'), findsOneWidget);
      expect(find.text('In-App Transfer'), findsOneWidget);
      expect(find.text('External Deposit'), findsOneWidget);
    },
  );

  testWidgets(
    'insufficient funds external deposit returns to its trade sheet',
    (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: BstocksOrderPanel()),
          ),
          GoRoute(
            name: AppRoutes.depositName,
            path: AppRoutes.depositPath,
            builder: (_, _) =>
                const Scaffold(body: Text('Deposit destination')),
          ),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));

      await tester.enterText(find.byType(TextField).first, '1001');
      await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('External Deposit'));
      await tester.pumpAndSettle();
      expect(find.text('Deposit destination'), findsOneWidget);

      router.pop();
      await tester.pumpAndSettle();
      expect(find.text('Buy NVDAB'), findsWidgets);
    },
  );

  testWidgets('transfer flow preserves selected sources through review', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          BstocksTransferFlowSheet(
            amountNeeded: DecimalValue('100', asset: 'USDT', unit: 'token'),
          ),
        ),
      ),
    );

    expect(find.text('In-App transfer'), findsOneWidget);
    expect(find.text('USDC (Arbitrum)'), findsOneWidget);
    await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pump();
    expect(find.text('Buy NVDAB · Market'), findsOneWidget);
    await tester.ensureVisible(
      find.widgetWithText(FilledButton, 'Confirm Buy'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm Buy'));
    await tester.pump();
    expect(find.text('Submitting Order...'), findsOneWidget);
  });

  testWidgets('funding pending state is independently reachable', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          BstocksTransferFlowSheet(
            amountNeeded: DecimalValue('100', asset: 'USDT', unit: 'token'),
            initialStage: BstocksTransferFlowStage.fundingPending,
          ),
        ),
      ),
    );

    expect(find.text('Preparing Trading Funds...'), findsOneWidget);
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
      expect(find.text('Submitting Order...'), findsOneWidget);
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
          ordersRepositoryProvider.overrideWithValue(_FilledOrdersRepository()),
        ],
        child: buildRouterTestApp(router),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm Buy'));
    await tester.pumpAndSettle();

    expect(find.text('Trade Successful'), findsOneWidget);
    expect(
      find.text('You can check the order status on the activities page.'),
      findsOneWidget,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'View History'));
    await tester.pumpAndSettle();
    expect(find.text('Activity destination'), findsOneWidget);
  });

  testWidgets(
    'a rejected bStocks order remains reviewable with failure feedback',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(
              _RejectedOrdersRepository(),
            ),
          ],
          child: buildTestApp(const BstocksOrderPanel()),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '100');
      await tester.tap(find.widgetWithText(FilledButton, 'Buy NVDAB'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm Buy'));
      await tester.pump();
      await tester.pumpAndSettle();

      expect(find.text('Order was not submitted. Try again.'), findsOneWidget);
      expect(find.widgetWithText(FilledButton, 'Confirm Buy'), findsOneWidget);
      expect(find.text('Trade Successful'), findsNothing);
    },
  );
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
