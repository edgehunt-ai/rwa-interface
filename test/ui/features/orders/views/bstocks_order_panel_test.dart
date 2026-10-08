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
import 'package:rwa_interface/domain/models/funding_session.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/bstocks_order_execution_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/orders/views/bstocks_order_panel.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';
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
            transferOptionsProvider.overrideWith(
              (ref) async => _transferOptions('1000'),
            ),
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
      await tester.ensureVisible(
        find.byKey(const Key('order-funding-spot-option')),
      );
      await tester.tap(find.byKey(const Key('order-funding-spot-option')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
      await tester.pumpAndSettle();
      expect(funding.transfers, 1);
      expect(wallets.authorizations, 1);
      expect(funded, isNull);
      expect(
        find.byKey(const Key('order-funding-transfer-pending')),
        findsOneWidget,
      );
      expect(find.text('Preparing trading funds…'), findsOneWidget);
      expect(find.text('Close & View Later'), findsOneWidget);
      expect(find.text('Retry'), findsNothing);
      funding.completed = true;
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      expect(funded, isTrue);
      expect(funding.transfers, 1);
      expect(wallets.authorizations, 1);
    });
  }

  testWidgets(
    'order funding does not show pending before transfer submission',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            transferOptionsProvider.overrideWith(
              (ref) async => _transferOptions('1000'),
            ),
          ],
          child: buildTestApp(
            OrderFundingSheet(
              plan: _plannedFundingPlan,
              kind: MarketProductKind.bstock,
            ),
            locale: const Locale('zh'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('准备资金'), findsOneWidget);
      expect(
        find.byKey(const Key('order-funding-transfer-pending')),
        findsNothing,
      );

      await tester.tap(find.byKey(const Key('order-funding-spot-option')));
      await tester.pump();

      expect(find.text('转账'), findsOneWidget);
      expect(
        find.byKey(const Key('order-funding-transfer-pending')),
        findsNothing,
      );
      expect(find.text('滑点'), findsNothing);
      expect(
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, '确认'))
            .onPressed,
        isNotNull,
      );
    },
  );

  testWidgets('order funding hides Spot when its available balance is short', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transferOptionsProvider.overrideWith(
            (ref) async => _transferOptions('99.99'),
          ),
        ],
        child: buildTestApp(
          OrderFundingSheet(
            plan: _readyFundingPlan,
            kind: MarketProductKind.bstock,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byKey(const Key('order-funding-deposit-option')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('order-funding-spot-option')), findsNothing);
  });

  testWidgets('order funding shows Spot while its balance is loading', (
    tester,
  ) async {
    final options = Completer<TransferOptions>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transferOptionsProvider.overrideWith((ref) => options.future),
        ],
        child: buildTestApp(
          OrderFundingSheet(
            plan: _readyFundingPlan,
            kind: MarketProductKind.bstock,
          ),
          locale: const Locale('zh'),
        ),
      ),
    );

    expect(find.byKey(const Key('order-funding-spot-option')), findsOneWidget);
    expect(find.text('转入现有余额'), findsOneWidget);
    expect(find.text('选择其他资产进行转账'), findsOneWidget);
    expect(
      find.byKey(const Key('order-funding-spot-balance-loading')),
      findsOneWidget,
    );

    options.complete(_transferOptions('0'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('order-funding-spot-option')), findsNothing);
  });

  testWidgets('order funding prepare step follows the funding breakdown', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(393, 852);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transferOptionsProvider.overrideWith(
            (ref) async => _transferOptions(
              '100',
              positions: [
                FundingSourcePosition(
                  positionId: 'polygon-usdt',
                  token: 'USDT',
                  network: 'Polygon',
                  availableAmount: DecimalValue('51.22', asset: 'USDT'),
                  eligible: true,
                ),
                FundingSourcePosition(
                  positionId: 'bsc-usdc',
                  token: 'USDC',
                  network: 'BSC',
                  availableAmount: DecimalValue('48.78', asset: 'USDC'),
                  eligible: true,
                ),
              ],
            ),
          ),
        ],
        child: buildTestApp(
          OrderFundingSheet(
            plan: _prepareFundingPlan,
            kind: MarketProductKind.perp,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Add 90 USDC on Arbitrum to continue'), findsOneWidget);
    expect(
      find.text(
        'You have 10 USDC on Arbitrum ready. Transfer existing assets or '
        'deposit USDC on Arbitrum.',
      ),
      findsOneWidget,
    );
    expect(find.text('Order Value'), findsOneWidget);
    expect(find.text('100 USDC'), findsOneWidget);
    expect(find.text('Ready on Arbitrum'), findsOneWidget);
    expect(find.text('10 USDC'), findsOneWidget);
    expect(find.text('Other assets'), findsOneWidget);
    expect(find.text(r'$100'), findsOneWidget);
    expect(find.text('2 other networks'), findsOneWidget);
    expect(find.text('Still needed'), findsOneWidget);
    expect(find.text('90 USDC'), findsOneWidget);
    expect(find.text('Add 90 USDC from:'), findsOneWidget);
    expect(find.text('Transfer Existing Balances'), findsOneWidget);
    expect(find.text('Choose your other assets to transfer'), findsOneWidget);
    expect(find.text('Deposit'), findsOneWidget);
    expect(find.text('From another wallet or platform'), findsOneWidget);
    expect(
      tester.getSize(find.byKey(const Key('order-funding-other-assets-row'))),
      const Size(321, 32),
    );
    expect(
      tester.getSize(find.byKey(const Key('order-funding-breakdown'))),
      const Size(353, 185),
    );
    expect(
      tester.getSize(find.byKey(const Key('order-funding-spot-option'))),
      const Size(353, 72),
    );
  });

  testWidgets('order funding opens the shared Spot transfer review', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transferOptionsProvider.overrideWith(
            (ref) async => _transferOptions(
              '100',
              positions: [
                FundingSourcePosition(
                  positionId: 'position-1',
                  token: 'USDC',
                  network: 'Arbitrum',
                  availableAmount: DecimalValue('150', asset: 'USDC'),
                  eligible: true,
                ),
              ],
            ),
          ),
        ],
        child: buildTestApp(
          OrderFundingSheet(
            plan: _readyFundingPlan,
            kind: MarketProductKind.bstock,
            slippage: DecimalValue('0.12', unit: 'percent'),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('order-funding-spot-option')));
    await tester.pump();

    expect(find.text('Transfer from spot'), findsOneWidget);
    expect(find.text('Available: 150'), findsOneWidget);
    expect(find.text('150'), findsOneWidget);
    expect(find.text('USDC (Arbitrum)', findRichText: true), findsOneWidget);
    expect(find.text('USDT (BSC)'), findsOneWidget);
    expect(find.text('100'), findsOneWidget);
    expect(find.byIcon(Icons.check_box), findsNothing);
    expect(find.text('Add token'), findsNothing);
    expect(find.text('Slippage'), findsOneWidget);
    expect(find.text('0.12%'), findsOneWidget);
    expect(find.text('Amount needed'), findsNothing);
    expect(find.text('Transfer amount'), findsNothing);
  });

  testWidgets('order funding scrolls when more than four tokens are shown', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          transferOptionsProvider.overrideWith(
            (ref) async => _transferOptions('100'),
          ),
        ],
        child: buildTestApp(
          OrderFundingSheet(
            plan: _fundingPlanWithLegCount(5),
            kind: MarketProductKind.bstock,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('order-funding-spot-option')));
    await tester.pump();

    final tokenScroll = find.byKey(const Key('order-funding-token-scroll'));
    expect(tokenScroll, findsOneWidget);
    expect(tester.getSize(tokenScroll).height, 63 * 4);
    expect(
      find.descendant(of: tokenScroll, matching: find.byType(Scrollbar)),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.check_box), findsNothing);
    expect(find.text('Add token'), findsNothing);
  });

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
    expect(find.text('456.78 USDT'), findsOneWidget);

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
    expect(
      find.byKey(const Key('bstocks-funding-confirmation-step-3')),
      findsNothing,
    );
    expect(find.text('Order Type'), findsOneWidget);
    expect(find.text('Back'), findsOneWidget);
    expect(find.text('0.02 USDC'), findsWidgets);
  });

  testWidgets('completed funding opens bStocks confirmation as step 3', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final funding = _PanelCompletedFundingRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(
            _DelayedOrdersRepository(),
          ),
          fundingRepositoryProvider.overrideWithValue(funding),
          walletsRepositoryProvider.overrideWithValue(
            _FundingWalletsRepository(),
          ),
          transferOptionsProvider.overrideWith(
            (ref) async => _transferOptions('100'),
          ),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );

    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
    await _pumpUntilFound(
      tester,
      find.byKey(const Key('order-funding-spot-option')),
    );
    tester
        .widget<InkWell>(
          find.descendant(
            of: find.byKey(const Key('order-funding-spot-option')),
            matching: find.byType(InkWell),
          ),
        )
        .onTap!();
    await tester.pump();
    tester
        .widget<FilledButton>(find.widgetWithText(FilledButton, 'Confirm'))
        .onPressed!();
    await _pumpUntilFound(
      tester,
      find.byKey(const Key('bstocks-funding-confirmation-step-3')),
    );

    expect(funding.sessions, 2);
    expect(funding.planRequests, 1);
    expect(funding.transfers, 1);
    expect(
      find.byKey(const Key('bstocks-funding-confirmation-step-3')),
      findsOneWidget,
    );
    expect(find.widgetWithText(FilledButton, 'Confirm Buy'), findsOneWidget);
  });

  for (final refreshFails in [false, true]) {
    testWidgets(
      refreshFails
          ? 'exits funding pending when the refreshed limit preview fails'
          : 'shows funding pending while refreshing the limit preview after transfer',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final funding = _PanelCompletedFundingRepository();
        final orders = _DelayedFundingPreviewOrdersRepository();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              ordersRepositoryProvider.overrideWithValue(orders),
              fundingRepositoryProvider.overrideWithValue(funding),
              walletsRepositoryProvider.overrideWithValue(
                _FundingWalletsRepository(),
              ),
              transferOptionsProvider.overrideWith(
                (ref) async => _transferOptions('100'),
              ),
            ],
            child: buildTestApp(const BstocksOrderPanel()),
          ),
        );

        await tester.pumpAndSettle();
        await tester.tap(find.text('Limit'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('bstocks-limit-price-sheet-input')),
          '100',
        );
        await tester.pump();
        await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('bstocks-limit-quantity-input')),
          '1',
        );
        await tester.pump(const Duration(milliseconds: 301));
        await tester.pumpAndSettle();
        expect(orders.previewCalls, 1);
        await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
        await _pumpUntilFound(
          tester,
          find.byKey(const Key('order-funding-spot-option')),
        );
        await tester.ensureVisible(
          find.byKey(const Key('order-funding-spot-option')),
        );
        tester
            .widget<InkWell>(
              find.descendant(
                of: find.byKey(const Key('order-funding-spot-option')),
                matching: find.byType(InkWell),
              ),
            )
            .onTap!();
        await tester.pump();
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Confirm'))
            .onPressed!();
        await _pumpUntilFound(
          tester,
          find.byKey(const Key('order-funding-transfer-pending')),
        );
        await tester.pump(const Duration(milliseconds: 300));
        expect(find.byType(OrderFundingSheet), findsNothing);
        expect(orders.previewCalls, 2);
        expect(funding.sessions, 2);
        expect(funding.transfers, 1);
        expect(
          find.byKey(const Key('bstocks-primary-order-action')),
          findsNothing,
        );

        if (refreshFails) {
          orders.failRefreshedPreview();
          await _pumpUntilFound(tester, find.text('Preview refresh failed'));
          expect(
            find.byKey(const Key('order-funding-transfer-pending')),
            findsNothing,
          );
          expect(
            tester
                .widget<FilledButton>(
                  find.byKey(const Key('bstocks-primary-order-action')),
                )
                .onPressed,
            isNotNull,
          );
        } else {
          orders.completeRefreshedPreview();
          await _pumpUntilFound(
            tester,
            find.byKey(const Key('bstocks-funding-confirmation-step-3')),
          );
          expect(
            find.byKey(const Key('order-funding-transfer-pending')),
            findsNothing,
          );
        }
        expect(tester.takeException(), isNull);
      },
    );
  }

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

  testWidgets('zero amount disables review and skips order preview', (
    tester,
  ) async {
    final orders = _CountingOrdersRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          ordersRepositoryProvider.overrideWithValue(orders),
          bstocksOrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('10', asset: 'USD', unit: 'fiat'),
          ),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );
    await tester.pumpAndSettle();

    final input = find.byType(TextField).first;
    final slider = find.byKey(const Key('bstocks-percentage-slider'));
    final action = find.byKey(const Key('bstocks-primary-order-action'));

    await tester.enterText(input, '0');
    await tester.pump(const Duration(milliseconds: 400));
    expect(orders.previewCalls, 0);
    expect(tester.widget<FilledButton>(action).onPressed, isNull);

    await tester.enterText(input, '1');
    await tester.pump(const Duration(milliseconds: 400));
    expect(orders.previewCalls, 1);
    expect(tester.widget<FilledButton>(action).onPressed, isNotNull);

    tester.widget<Slider>(slider).onChanged!(0);
    await tester.pump(const Duration(milliseconds: 400));
    expect(tester.widget<TextField>(input).controller!.text, '0');
    expect(orders.previewCalls, 1);
    expect(tester.widget<FilledButton>(action).onPressed, isNull);
  });

  testWidgets('tiny settlement balance does not reset slider to zero', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          bstocksOrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('0', asset: 'USD', unit: 'fiat'),
          ),
          bstocksSettlementBalanceProvider('USDT').overrideWith(
            (ref) async =>
                DecimalValue('0.000000001', asset: 'USDT', unit: 'token'),
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

    expect(tester.widget<TextField>(input).controller!.text, '0.0000000005');
    expect(tester.widget<Slider>(slider).value, 50);
  });

  for (final isLimit in [false, true]) {
    testWidgets(
      '${isLimit ? 'limit' : 'market'} funding requires explicit approval before confirmation',
      (tester) async {
        tester.view.physicalSize = const Size(800, 1200);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final orders = _ApprovalOrdersRepository();
        final execution = _ApprovalExecutionRepository(orders);
        final funding = _PanelCompletedFundingRepository();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              fundingRepositoryProvider.overrideWithValue(funding),
              ordersRepositoryProvider.overrideWithValue(orders),
              bstocksOrderExecutionRepositoryProvider.overrideWithValue(
                execution,
              ),
              walletsRepositoryProvider.overrideWithValue(
                _FundingWalletsRepository(),
              ),
              transferOptionsProvider.overrideWith(
                (ref) async => _transferOptions('100'),
              ),
            ],
            child: buildTestApp(const BstocksOrderPanel()),
          ),
        );
        await tester.pumpAndSettle();

        final action = find.byKey(const Key('bstocks-primary-order-action'));
        if (isLimit) {
          await tester.tap(find.text('Limit'));
          await tester.pumpAndSettle();
          await tester.enterText(
            find.byKey(const Key('bstocks-limit-price-sheet-input')),
            '100',
          );
          await tester.pump();
          await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
          await tester.pumpAndSettle();
          await tester.enterText(
            find.byKey(const Key('bstocks-limit-quantity-input')),
            '0.1',
          );
        } else {
          await tester.enterText(find.byType(TextField).first, '10');
        }
        await tester.pump(const Duration(milliseconds: 400));

        expect(
          find.widgetWithText(FilledButton, r'Buy NVDAB · $10'),
          findsOneWidget,
        );
        await tester.tap(action);
        await _pumpUntilFound(
          tester,
          find.byKey(const Key('order-funding-spot-option')),
        );
        tester
            .widget<InkWell>(
              find.descendant(
                of: find.byKey(const Key('order-funding-spot-option')),
                matching: find.byType(InkWell),
              ),
            )
            .onTap!();
        await tester.pump();
        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Confirm'))
            .onPressed!();
        await _pumpUntilFound(
          tester,
          find.byKey(const Key('bstocks-funding-confirmation-step-3')),
        );

        expect(funding.sessions, 2);
        expect(funding.transfers, 1);
        expect(orders.createCalls, 0);
        expect(find.widgetWithText(FilledButton, 'Confirm Buy'), findsNothing);
        expect(find.widgetWithText(FilledButton, 'Approve'), findsOneWidget);

        tester
            .widget<FilledButton>(find.widgetWithText(FilledButton, 'Approve'))
            .onPressed!();
        await tester.pump();
        expect(orders.createCalls, 1);
        expect(execution.stopAfterApproval, isTrue);
        expect(
          find.byKey(const Key('bstocks-approval-loading')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('bstocks-funding-confirmation-step-3')),
          findsOneWidget,
        );
        expect(
          tester
              .widget<OutlinedButton>(
                find.widgetWithText(OutlinedButton, 'Back'),
              )
              .onPressed,
          isNull,
        );

        execution.completeApproval();
        await _pumpUntilFound(
          tester,
          find.widgetWithText(FilledButton, 'Confirm Buy'),
        );
        expect(orders.createCalls, 1);
        expect(find.text('Order submitted'), findsNothing);
        expect(find.widgetWithText(FilledButton, 'Approve'), findsNothing);
        expect(
          find.byKey(const Key('bstocks-funding-confirmation-step-3')),
          findsOneWidget,
        );
        orders.complete();
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Confirm Buy'),
            )
            .onPressed!();
        await _pumpUntilFound(tester, find.text('Order submitted'));
        expect(orders.createCalls, 2);
        expect(orders.createdPreviewIds, [
          'approval-preview',
          'post-approval-preview',
        ]);
      },
    );
  }

  testWidgets('failed approval stays at confirmation and can be retried', (
    tester,
  ) async {
    final orders = _ApprovalOrdersRepository();
    final execution = _ApprovalExecutionRepository(orders, failOnce: true);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
          ordersRepositoryProvider.overrideWithValue(orders),
          bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
        ],
        child: buildTestApp(const BstocksOrderPanel()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '10');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
    final approve = find.widgetWithText(FilledButton, 'Approve');
    await _pumpUntilFound(tester, approve);
    expect(orders.createCalls, 0);
    await tester.ensureVisible(approve);
    await tester.tap(approve);
    await _pumpUntilFound(tester, find.text('Approval rejected'));
    expect(tester.widget<FilledButton>(approve).onPressed, isNotNull);
    expect(find.widgetWithText(FilledButton, 'Confirm Buy'), findsNothing);
    expect(find.text('Order submitted'), findsNothing);
    expect(orders.createCalls, 1);

    await tester.tap(approve);
    await tester.pump();
    expect(execution.stopAfterApproval, isTrue);
    execution.completeApproval();
    await _pumpUntilFound(
      tester,
      find.widgetWithText(FilledButton, 'Confirm Buy'),
    );
    expect(orders.createCalls, 2);
    expect(find.text('Order submitted'), findsNothing);
    expect(find.text('Approval rejected'), findsNothing);
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

  testWidgets('manual bStocks quantities are limited to 18 decimals', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
        ],
        child: buildTestApp(
          const BstocksOrderPanel(initialSide: TradingSide.sell),
        ),
      ),
    );
    await tester.pumpAndSettle();

    const entered = '0.1234567890123456789';
    const expected = '0.123456789012345678';
    final marketQuantity = find.byKey(const Key('bstocks-market-amount-input'));
    await tester.enterText(marketQuantity, entered);
    expect(tester.widget<TextField>(marketQuantity).controller?.text, expected);

    await tester.tap(find.text('Limit'));
    await tester.pumpAndSettle();
    final priceInput = find.byKey(const Key('bstocks-limit-price-sheet-input'));
    await tester.enterText(priceInput, '100');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();
    final limitQuantity = find.byKey(const Key('bstocks-limit-quantity-input'));
    await tester.enterText(limitQuantity, entered);
    expect(tester.widget<TextField>(limitQuantity).controller?.text, expected);
  });

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
    expect(find.text('0 USDT'), findsOneWidget);
  });

  testWidgets(
    'does not dispose the account request during the initial order panel load',
    (tester) async {
      final accounts = Completer<List<TradingAccount>>();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            tradingAccountsProvider.overrideWith((_) => accounts.future),
          ],
          child: buildTestApp(const BstocksOrderPanel()),
        ),
      );

      // Allow initState's post-frame refresh callback to run while the
      // account request is still pending.
      await tester.pump();
      expect(tester.takeException(), isNull);

      accounts.complete(const <TradingAccount>[]);
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('bStocks sell form uses the short trade color', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(FundedRepository()),
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

    final indicator = tester.widget<Container>(
      find.byKey(const Key('bstocks-side-indicator')),
    );
    final decoration = indicator.decoration! as BoxDecoration;
    expect(decoration.color, kShortTradeColor);

    final submit = tester.widget<FilledButton>(
      find.byKey(const Key('bstocks-primary-order-action')),
    );
    expect(
      submit.style?.backgroundColor?.resolve(<WidgetState>{}),
      kShortTradeColor,
    );
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

  testWidgets('limit orders hide slippage and never send it', (tester) async {
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
    await tester.pumpAndSettle();

    await tester.tap(find.text('Limit'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('bstocks-limit-price-sheet-input')),
      '100',
    );
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();

    // A resting limit order is GTC: no slippage control, and none on the wire.
    expect(find.byKey(const Key('bstocks-edit-slippage')), findsNothing);
    expect(find.text('Slippage'), findsNothing);

    await tester.enterText(
      find.byKey(const Key('bstocks-limit-quantity-input')),
      '1',
    );
    await tester.pumpAndSettle();

    expect(repository.previewIntent?.type, TradingOrderType.limit);
    expect(repository.previewIntent?.slippage, isNull);
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

    final illustration = find.image(
      const AssetImage('assets/figma/trade/order_submitting.webp'),
    );
    expect(illustration, findsOneWidget);
    final image = tester.widget<Image>(illustration);
    expect(image.width, 120);
    expect(image.height, 120);
    expect(image.fit, BoxFit.contain);
    expect(tester.getSize(illustration).height, 120);
    expect(tester.takeException(), isNull);

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
              _DelayedOrdersRepository(executionReady: false),
            ),
            fundingRepositoryProvider.overrideWithValue(funding),
            transferOptionsProvider.overrideWith(
              (ref) async => _transferOptions('0'),
            ),
          ],
          child: buildTestApp(const BstocksOrderPanel()),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '100');
      await tester.tap(find.byKey(const Key('bstocks-primary-order-action')));
      await _pumpUntilFound(tester, find.text('Add 100 USDT from:'));

      expect(funding.intents, hasLength(1));
      expect(funding.intents.single.kind, MarketProductKind.bstock);
      expect(funding.intents.single.symbol, 'NVDAB');
      expect(find.text('Add 100 USDT from:'), findsOneWidget);
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
      expect(
        find.image(
          const AssetImage('assets/figma/trade/order_submitting.webp'),
        ),
        findsOneWidget,
      );
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
    final illustration = find.image(
      const AssetImage('assets/figma/trade/order_success.webp'),
    );
    expect(illustration, findsOneWidget);
    final image = tester.widget<Image>(illustration);
    expect(image.width, 120);
    expect(image.height, 120);
    expect(image.fit, BoxFit.contain);
    expect(tester.getSize(illustration).height, 120);
    expect(tester.takeException(), isNull);
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
  _DelayedOrdersRepository({this.executionReady = true});

  final bool executionReady;
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
    executionReady: executionReady,
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

final class _DelayedFundingPreviewOrdersRepository implements OrdersRepository {
  var previewCalls = 0;
  final _refreshedPreview = Completer<OrderPreview>();
  late OrderIntent _intent;

  void completeRefreshedPreview() {
    _refreshedPreview.complete(
      OrderPreview(
        previewId: 'refreshed-preview',
        intent: _intent,
        orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
      ),
    );
  }

  void failRefreshedPreview() => _refreshedPreview.completeError(
    const UnknownFailure(userAction: 'Preview refresh failed'),
  );

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    previewCalls++;
    _intent = intent;
    if (previewCalls == 1) {
      return OrderPreview(
        previewId: 'initial-preview',
        intent: intent,
        orderValue: DecimalValue('100', asset: 'USDT', unit: 'token'),
      );
    }
    return _refreshedPreview.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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

final class _CountingOrdersRepository extends _DelayedOrdersRepository {
  var previewCalls = 0;

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) {
    previewCalls++;
    return super.preview(intent, idempotencyKey: idempotencyKey);
  }
}

final class _ApprovalOrdersRepository extends _DelayedOrdersRepository {
  var approved = false;
  var createCalls = 0;
  final createdPreviewIds = <String?>[];

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async => OrderPreview(
    previewId: approved ? 'post-approval-preview' : 'approval-preview',
    intent: intent,
    orderValue: DecimalValue('10', asset: 'TUSDT', unit: 'token'),
    estimatedQuantity: DecimalValue('0.1', asset: 'NVDAB', unit: 'token'),
    settlementAsset: 'TUSDT',
    approvalRequired: !approved,
  );

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    createCalls++;
    createdPreviewIds.add(previewId);
    if (approved) {
      return super.create(
        intent,
        idempotencyKey: idempotencyKey,
        previewId: previewId,
      );
    }
    return ResourceResult(
      resource: TradingOrder(
        orderId: 'approval-order',
        symbol: intent.symbol,
        kind: intent.kind,
        side: intent.side,
        type: intent.type,
        status: TradingOrderStatus.pendingSignature,
        createdAt: DateTime.utc(2026, 9, 30),
        nextAction: BstocksOrderAction(
          orderId: 'approval-order',
          stepId: 'approval-step',
          ordinal: 1,
          kind: BstocksOrderActionKind.erc20Approval,
          chainId: 56,
          from: '0x1111111111111111111111111111111111111111',
          to: '0x2222222222222222222222222222222222222222',
          data: '0xaa',
          value: '0x0',
          payloadHash: 'approval-hash',
          validUntil: DateTime.utc(2030),
        ),
      ),
    );
  }
}

final class _ApprovalExecutionRepository
    implements BstocksOrderExecutionRepository {
  _ApprovalExecutionRepository(this.orders, {this.failOnce = false});

  final _ApprovalOrdersRepository orders;
  final _completion = Completer<void>();
  bool? stopAfterApproval;
  bool failOnce;

  void completeApproval() => _completion.complete();

  @override
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) async {
    this.stopAfterApproval = stopAfterApproval;
    if (failOnce) {
      failOnce = false;
      throw const UnknownFailure(userAction: 'Approval rejected');
    }
    await _completion.future;
    orders.approved = true;
    return ResourceResult(
      resource: TradingOrder(
        orderId: created.resource.orderId,
        symbol: intent.symbol,
        kind: intent.kind,
        side: intent.side,
        type: intent.type,
        status: TradingOrderStatus.open,
        actionStatus: BstocksOrderActionStatus.confirmed,
        createdAt: created.resource.createdAt,
      ),
    );
  }
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
  targetAsset: 'USDT',
  targetNetwork: 'BSC',
  legs: [
    FundingLeg(
      legId: 'leg-1',
      walletId: 'wallet-1',
      asset: 'USDC',
      sourcePositionId: 'position-1',
      network: 'Arbitrum',
      maximumAmount: DecimalValue('150', asset: 'USDC', unit: 'token'),
      outputAmount: DecimalValue('100', asset: 'USDT', unit: 'token'),
      status: FundingLegState.actionReleased,
    ),
  ],
);

final _plannedFundingPlan = FundingPlan(
  planId: 'planned-plan',
  tradePreviewId: 'funded-preview',
  shortfall: DecimalValue('100', asset: 'USDT', unit: 'token'),
  status: FundingPlanState.ready,
  sourceWalletId: 'wallet-1',
  sourceAsset: 'USDC',
  sourceMaximum: DecimalValue('150', asset: 'USDC', unit: 'token'),
  legs: [
    FundingLeg(
      legId: 'planned-leg',
      walletId: 'wallet-1',
      asset: 'USDC',
      maximumAmount: DecimalValue('150', asset: 'USDC', unit: 'token'),
      outputAmount: DecimalValue('100', asset: 'USDT', unit: 'token'),
      status: FundingLegState.planned,
    ),
  ],
);

final _prepareFundingPlan = FundingPlan(
  planId: 'prepare-plan',
  tradePreviewId: 'prepare-preview',
  shortfall: DecimalValue('90', asset: 'USDC', unit: 'token'),
  requiredTargetAmount: DecimalValue('100', asset: 'USDC', unit: 'token'),
  targetAvailableAmount: DecimalValue('10', asset: 'USDC', unit: 'token'),
  targetAsset: 'USDC-PERPS',
  targetNetwork: 'Hyperliquid',
  status: FundingPlanState.ready,
  legs: [
    FundingLeg(
      legId: 'prepare-leg',
      walletId: 'wallet-1',
      asset: 'USDT',
      maximumAmount: DecimalValue('90', asset: 'USDT', unit: 'token'),
      outputAmount: DecimalValue('90', asset: 'USDC', unit: 'token'),
      status: FundingLegState.actionReleased,
    ),
  ],
);

FundingPlan _fundingPlanWithLegCount(int count) => FundingPlan(
  planId: 'multi-leg-plan',
  tradePreviewId: 'funded-preview',
  shortfall: DecimalValue('100', asset: 'USDT', unit: 'token'),
  status: FundingPlanState.ready,
  sourceWalletId: 'wallet-1',
  sourceAsset: 'USDC',
  sourceMaximum: DecimalValue('150', asset: 'USDC', unit: 'token'),
  legs: List.generate(
    count,
    (index) => FundingLeg(
      legId: 'leg-$index',
      walletId: 'wallet-$index',
      asset: index.isEven ? 'USDC' : 'USDT',
      maximumAmount: DecimalValue(
        '${150 + index}',
        asset: index.isEven ? 'USDC' : 'USDT',
        unit: 'token',
      ),
      outputAmount: DecimalValue('${20 + index}', asset: 'USDT', unit: 'token'),
      status: FundingLegState.actionReleased,
    ),
  ),
);

TransferOptions _transferOptions(
  String available, {
  List<FundingSourcePosition> positions = const [],
}) => TransferOptions(
  account: UnifiedFundingAccountSummary(
    totalUsd: DecimalValue(available, asset: 'USD'),
    availableToFundUsd: DecimalValue(available, asset: 'USD'),
    reservedUsd: DecimalValue('0', asset: 'USD'),
    inTransitUsd: DecimalValue('0', asset: 'USD'),
    dataStatus: 'complete',
    calculatedAt: DateTime.utc(2026, 9, 28),
    positions: positions,
  ),
  catalog: null,
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

final class _PanelCompletedFundingRepository implements FundingRepository {
  var sessions = 0;
  var planRequests = 0;
  var transfers = 0;

  @override
  Future<FundingSessionSummary> createFundingSession({
    required OrderIntent intent,
    required String idempotencyKey,
  }) async {
    sessions++;
    return FundingSessionSummary(
      sessionId: 'session-$sessions',
      status: sessions > 1 ? 'funded' : 'ready_to_confirm',
      version: 1,
      canConfirmTransfer: sessions == 1,
      expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    );
  }

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async {
    planRequests++;
    return _readyFundingPlan;
  }

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
      amount: DecimalValue('100'),
      status: FundingTransferState.completed,
    );
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async => FundingPlan(
    planId: id,
    tradePreviewId: 'preview-1',
    shortfall: DecimalValue('0'),
    status: FundingPlanState.alreadyFunded,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FundingPlanRepository implements FundingRepository {
  _FundingPlanRepository(this.plan);

  final FundingPlan plan;
  final intents = <OrderIntent>[];

  @override
  Future<FundingSessionSummary> createFundingSession({
    required OrderIntent intent,
    required String idempotencyKey,
  }) async {
    intents.add(intent);
    return FundingSessionSummary(
      sessionId: 'bstocks-session',
      status: 'ready_to_confirm',
      version: 1,
      canConfirmTransfer: true,
      expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
    );
  }

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async {
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
    status: completed
        ? FundingPlanState.alreadyFunded
        : FundingPlanState.executing,
    legs: completed
        ? const []
        : [
            FundingLeg(
              legId: 'leg-1',
              walletId: 'wallet-1',
              asset: 'USDC',
              maximumAmount: DecimalValue('100'),
              outputAmount: DecimalValue('100'),
              status: FundingLegState.actionReleased,
              transferId: 'pending-transfer',
            ),
          ],
  );

  @override
  Future<FundingTransfer> getFundingTransfer(String id) async =>
      FundingTransfer(
        transferId: id,
        planId: 'completed-plan',
        amount: DecimalValue('100'),
        status: FundingTransferState.filling,
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
