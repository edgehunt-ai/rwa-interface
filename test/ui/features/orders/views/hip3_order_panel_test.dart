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
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

import 'package:rwa_interface/app/observability/observability_reporter.dart';
import 'package:rwa_interface/app/providers/observability_providers.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

import '../../../../helpers/test_app.dart';
import '../../../../helpers/funded_repository.dart';

import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';

import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';

import 'package:rwa_interface/domain/models/hip3_opening_context.dart';
import 'package:rwa_interface/domain/repositories/hip3_opening_repository.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/domain/models/hip3_opening_size.dart';

void main() {
  testWidgets(
    'HIP-3 checks Hyperliquid funding despite a high display balance',
    (tester) async {
      final funding = _ShortfallFunding();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(_ExecutableHip3Orders()),
          ],
          child: _app(const Hip3OrderPanel(), funding: funding),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, '20');
      await tester.pump(const Duration(milliseconds: 301));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, r'Long NVDA · $20'));
      await tester.pumpAndSettle();
      expect(funding.previewIds, hasLength(1));
      expect(find.text('Hyperliquid Perps USDC'), findsOneWidget);
      expect(find.textContaining('5 USDC'), findsOneWidget);
      expect(find.text('Insufficient balance.'), findsNothing);
    },
  );

  testWidgets('order form uses a USDC amount input without a quantity tab', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const Hip3OrderPanel()));
    await tester.pumpAndSettle();
    expect(find.text('Quantity'), findsNothing);
    await tester.enterText(find.byType(TextField).first, '2');
    await tester.pump();
    expect(find.text(r'Long NVDA · $2'), findsOneWidget);
  });

  testWidgets(
    'an unreachable trading context explains itself on submit and is reported',
    (tester) async {
      final observability = _RecordingReporter();
      await tester.pumpWidget(
        _app(
          const Hip3OrderPanel(),
          opening: _Opening(failing: true),
          observability: observability,
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, r'Long NVDA · $0'));
      await tester.pump();
      expect(
        find.text('Trading service is unavailable. Try again in a moment.'),
        findsWidgets,
      );
      expect(
        observability.operations,
        contains('hip3.trading_context.load:failed'),
      );
    },
  );

  testWidgets('the product rules are visible before the order is composed', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const Hip3OrderPanel()));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('hip3-maximum-leverage')), findsOneWidget);
    expect(find.text('Max 20x'), findsOneWidget);
    expect(find.text('Min 12'), findsOneWidget);
    expect(find.byKey(const Key('hip3-order-value-range')), findsNothing);
  });

  testWidgets('amount over the interface maximum uses the shared error area', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hip3OpeningRepositoryProvider.overrideWithValue(
            _Opening(maximumNotional: '50'),
          ),
          hip3OpeningContextProvider.overrideWith(
            (ref, product) =>
                ref.watch(hip3OpeningRepositoryProvider).context(product),
          ),
          hip3OrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('1000', asset: 'USD', unit: 'fiat'),
          ),
        ],
        child: buildTestApp(const Hip3OrderPanel()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '51');
    await tester.pump();
    expect(find.byKey(const Key('hip3-form-error')), findsOneWidget);
    expect(find.byKey(const Key('hip3-order-amount-error')), findsNothing);
    expect(
      find.text('Order value is above the 50 USDC maximum.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField).first, '49');
    await tester.pump();
    expect(find.byKey(const Key('hip3-form-error')), findsNothing);
  });

  testWidgets('displayed balance does not block funding preparation', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hip3OrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('16', asset: 'USD', unit: 'fiat'),
          ),
          hip3OpeningRepositoryProvider.overrideWithValue(_Opening()),
          hip3OpeningContextProvider.overrideWith(
            (ref, product) =>
                ref.watch(hip3OpeningRepositoryProvider).context(product),
          ),
        ],
        child: buildTestApp(const Hip3OrderPanel()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '17');
    await tester.pump();
    expect(find.text('Insufficient balance.'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, r'Long NVDA · $17'),
          )
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('an order value under the minimum is refused with a toast', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const Hip3OrderPanel()));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '5');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, r'Long NVDA · $5'));
    await tester.pump();
    expect(
      find.text('Order value is below the 12 USDC minimum.'),
      findsWidgets,
    );
  });

  testWidgets('a leverage above the product maximum is refused with a toast', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(const Hip3OrderPanel(), opening: _Opening(maximum: 5)),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '50');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, r'Long NVDA · $50'));
    await tester.pump();
    expect(
      find.text('Leverage exceeds the 5x limit for this product.'),
      findsWidgets,
    );
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
      await tester.tap(find.byKey(const Key('hip3-tp-sl-confirm')));
      await tester.pumpAndSettle();
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
        find.textContaining('Submitted protection is not yet active.'),
        findsOneWidget,
      );
    },
  );
  testWidgets('opening protection label is scoped to this order', (
    tester,
  ) async {
    await tester.pumpWidget(_app(const Hip3OrderPanel()));
    await tester.pumpAndSettle();
    expect(find.text('Take profit/stop loss'), findsOneWidget);
    expect(find.text('Position TP/SL'), findsNothing);
  });

  testWidgets(
    'TP/SL add opens the localized price editor and slider updates price',
    (tester) async {
      await tester.pumpWidget(_app(const Hip3OrderPanel()));
      await tester.pumpAndSettle();

      expect(find.text('Take profit/stop loss'), findsOneWidget);
      await tester.tap(find.byKey(const Key('hip3-tp-sl-toggle')));
      await tester.pumpAndSettle();
      expect(find.text('Take Profit & stop loss'), findsOneWidget);

      final takeProfit = find.byKey(const Key('opening-protection-0'));
      await tester.enterText(takeProfit, '100');
      await tester.pump();
      await tester.drag(
        find.byKey(const Key('take-profit-ruler')),
        const Offset(80, 0),
      );
      await tester.pump();
      expect(
        tester.widget<TextField>(takeProfit).controller!.text,
        isNot('100'),
      );
    },
  );
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
  test('slider percentages spend balance and need no quote', () {
    final balance = DecimalValue('6', asset: 'USD', unit: 'fiat');
    // No quote at all: the slider must still produce an amount.
    expect(hip3OpeningNotional(balance, 1, 100), '6');
    expect(hip3OpeningNotional(balance, 1, 50), '3');
    expect(hip3OpeningNotional(balance, 1, 0), '0');
    // Leverage multiplies the spendable base.
    expect(hip3OpeningNotional(balance, 2, 100), '12');
    expect(hip3OpeningNotional(balance, 10, 25), '15');
    expect(() => hip3OpeningNotional(balance, 1, 101), throwsArgumentError);
    expect(() => hip3OpeningNotional(balance, 0, 50), throwsArgumentError);
  });

  test('a quote caps the slider at the venue maximum', () {
    final intent = OrderIntent(
      symbol: 'TSLA',
      kind: MarketProductKind.perp,
      side: TradingSide.long,
      type: TradingOrderType.market,
      amount: DecimalValue('6'),
    );
    // 0.148 at a price of 100 is 14.8 USDC of notional.
    final quote = _previewExecution(intent, maximum: '0.148');
    final balance = DecimalValue('6', asset: 'USD', unit: 'fiat');
    // 6 USDC at 5x would reach 30, but the venue maximum binds first.
    expect(hip3OpeningNotional(balance, 5, 100, quote: quote), '14.8');
    // At 2x the balance is still the binding limit, so the cap is inert.
    expect(hip3OpeningNotional(balance, 2, 100, quote: quote), '12');
    expect(hip3OpeningNotional(balance, 2, 50, quote: quote), '6');
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
        find.textContaining('This quote is unavailable or expired'),
        findsOneWidget,
      );
      await tester.pumpWidget(const SizedBox());
    }
  });
  testWidgets(
    'leverage options follow product maximum and stay local until order review',
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
      expect(opening.leverage, 3);
      expect(opening.settingsRequests, 0);
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
      expect(find.text('Margin mode'), findsOneWidget);
      await tester.tap(find.text('Isolated'));
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
      await tester.tap(find.byKey(const Key('hip3-tp-sl-confirm')));
      await tester.pumpAndSettle();
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
      expect(orders.intent?.openingProtection?.stopLoss?.limitPrice, isNull);
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

  testWidgets(
    'margin mode opens its selector and leverage opens its selector',
    (tester) async {
      final opening = _Opening();
      await tester.pumpWidget(_app(const Hip3OrderPanel(), opening: opening));
      await tester.pumpAndSettle();

      expect(find.text('Cross'), findsOneWidget);
      await tester.tap(find.byKey(const Key('hip3-margin-mode-toggle')));
      await tester.pumpAndSettle();
      expect(find.text('Margin mode'), findsOneWidget);
      await tester.tap(find.text('Isolated'));
      await tester.pumpAndSettle();
      expect(find.text('Margin mode'), findsNothing);
      expect(find.text('Isolated'), findsOneWidget);
      expect(opening.mode, TradingMarginMode.cross);

      await tester.tap(find.byKey(const Key('hip3-margin-mode-toggle')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cross'));
      await tester.pumpAndSettle();
      expect(find.text('Cross'), findsOneWidget);
      expect(opening.mode, TradingMarginMode.cross);

      await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
      await tester.pumpAndSettle();
      expect(find.text('Leverage'), findsOneWidget);
      expect(find.bySemanticsLabel('Drag to set leverage'), findsOneWidget);
    },
  );

  testWidgets('order settings remain usable when trading rules cannot load', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hip3OrderAvailableBalanceProvider.overrideWith(
            (ref) async => DecimalValue('0', asset: 'USD', unit: 'fiat'),
          ),
          hip3OpeningContextProvider.overrideWith(
            (ref, product) async => throw StateError('unavailable'),
          ),
        ],
        child: buildTestApp(const Hip3OrderPanel()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Reload trading rules'), findsNothing);
    expect(find.text('Loading trading rules...'), findsNothing);
    await tester.tap(find.byKey(const Key('hip3-margin-mode-toggle')));
    await tester.pumpAndSettle();
    expect(find.text('Margin mode'), findsOneWidget);
    await tester.tap(find.text('Isolated'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
    await tester.pumpAndSettle();
    expect(find.text('Leverage'), findsOneWidget);
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

Widget _app(
  Widget child, {
  Hip3OpeningRepository? opening,
  ObservabilityReporter? observability,
  FundingRepository? funding,
}) => ProviderScope(
  overrides: [
    fundingTransferCommandsProvider.overrideWith(
      (ref) => FundingTransferCommands(ref),
    ),
    fundingRepositoryProvider.overrideWithValue(funding ?? FundedRepository()),
    if (observability != null)
      observabilityReporterProvider.overrideWithValue(observability),
    hip3OpeningRepositoryProvider.overrideWithValue(opening ?? _Opening()),
    hip3OrderAvailableBalanceProvider.overrideWith(
      (ref) async => DecimalValue('1000', asset: 'USD', unit: 'fiat'),
    ),
    hip3OpeningContextProvider.overrideWith(
      (ref, product) =>
          ref.watch(hip3OpeningRepositoryProvider).context(product),
    ),
  ],
  child: buildTestApp(child),
);

final class _RecordingReporter implements ObservabilityReporter {
  final List<String> operations = [];

  @override
  Future<void> clearUser() async {}

  @override
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
  }) => recordOperation(operation, outcome: 'failed');

  @override
  void recordError({
    required String operation,
    required Object error,
    StackTrace? stackTrace,
  }) => recordOperation(operation, outcome: 'failed');

  @override
  void recordOperation(String operation, {required String outcome}) =>
      operations.add('$operation:$outcome');

  @override
  Future<void> setUserId(String userId) async {}
}

final class _Opening implements Hip3OpeningRepository {
  _Opening({
    this.maximum = 20,
    this.failing = false,
    this.maximumNotional = '1000',
  });
  final int maximum;
  final bool failing;
  final String maximumNotional;
  int settingsRequests = 0;
  int leverage = 10;
  TradingMarginMode mode = TradingMarginMode.cross;
  @override
  Future<Hip3OpeningContext> context(String productOrSymbol) async {
    if (failing) {
      throw const ServerFailure(statusCode: 503, code: 'unavailable');
    }
    return _context(productOrSymbol);
  }

  Hip3OpeningContext _context(String productOrSymbol) => Hip3OpeningContext(
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
    maximumNotional: DecimalValue(maximumNotional),
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

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Hip3PreviewExecution _previewExecution(
  OrderIntent intent, {
  String maximum = '1',
  String margin = '20',
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
  availableMargin: DecimalValue(margin),
  maximumQuantity: DecimalValue(maximum),
  estimatedFee: DecimalValue('0.05'),
  slippagePercent: DecimalValue('1'),
  liquidationPriceUnavailableReason:
      'cross_margin_requires_full_account_simulation',
);

class _ShortfallFunding extends FundedRepository {
  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async {
    previewIds.add(tradePreviewId);
    return FundingPlan(
      planId: 'hip3-plan',
      tradePreviewId: tradePreviewId,
      shortfall: DecimalValue('5'),
      status: FundingPlanState.blocked,
    );
  }
}
