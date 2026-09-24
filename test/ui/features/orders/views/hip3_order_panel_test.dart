import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/hip3_opening_protection.dart';
import 'package:rwa_interface/domain/models/hip3_step_confirmation.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/hip3_order_execution_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_confirm_sheet.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_order_panel.dart';

import 'package:rwa_interface/app/observability/observability_reporter.dart';
import 'package:rwa_interface/app/providers/observability_providers.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

import '../../../../helpers/test_app.dart';
import '../../../../helpers/funded_repository.dart';

import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';

import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/models/funding_session.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';

import 'package:rwa_interface/domain/models/hip3_opening_context.dart';
import 'package:rwa_interface/domain/models/hip3_account_abstraction.dart';
import 'package:rwa_interface/domain/repositories/hip3_account_abstraction_repository.dart';
import 'package:rwa_interface/domain/repositories/hip3_opening_repository.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/domain/models/hip3_opening_size.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

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
      // The parent submit button keeps its indeterminate loading animation
      // while the funding sheet is open, so there is intentionally no stable
      // frame for pumpAndSettle to wait for here.
      await tester.pump(const Duration(seconds: 1));
      expect(funding.previewIds, hasLength(1));
      expect(find.text('Hyperliquid Perps USDC'), findsOneWidget);
      expect(find.textContaining('5 USDC'), findsOneWidget);
      expect(find.text('Insufficient balance.'), findsNothing);
    },
  );

  testWidgets(
    'a completed transfer re-reads the balance without resetting the leverage',
    (tester) async {
      final opening = _Opening(availableMargin: '16');
      final orders = _CapturingHip3Orders();
      final funding = _TransferThenFunded(
        onTransfer: () => opening.availableMargin = '40',
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(orders),
            walletsRepositoryProvider.overrideWithValue(_FundingWallets()),
          ],
          child: _app(
            const Hip3OrderPanel(),
            opening: opening,
            funding: funding,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Perps balance: 16 USDC'), findsOneWidget);
      expect(opening.contextCalls, 1);

      // Pick a leverage the server context does not report, so a full context
      // reload would visibly overwrite the selection.
      await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('20x'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).first, '20');
      await tester.pump(const Duration(milliseconds: 301));
      await tester.pumpAndSettle();
      final submit = find.byKey(const Key('hip3-submit-button'));
      await tester.ensureVisible(submit);
      await tester.pumpAndSettle();
      await tester.tap(submit);
      // The parent submit button animates while the funding sheet is open, so
      // there is no stable frame for pumpAndSettle until the sheet closes.
      await tester.pump(const Duration(seconds: 1));

      // Completing the transfer closes the sheet and resumes the order.
      final transfer = find.widgetWithText(FilledButton, 'In-App Transfer');
      await tester.ensureVisible(transfer);
      // Let the scroll settle without pumpAndSettle, which the parent's
      // indeterminate animation would never allow to return.
      for (var i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      await tester.tap(transfer);
      await tester.pumpAndSettle();

      expect(funding.transfers, 1);
      // The second session is the loop re-checking funding after the transfer.
      expect(funding.sessions, 2);
      // The settings action refreshes the authoritative context, and the
      // completed transfer refreshes it once more.
      expect(opening.contextCalls, 3);
      // The setting action and transfer refresh both preserve the selection.
      expect(orders.intent?.leverage?.value, '20');
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

  testWidgets('slider selection is preserved while the trading context loads', (
    tester,
  ) async {
    final opening = _Opening();
    final rules = Completer<Hip3OpeningContext>();
    await tester.pumpWidget(
      _app(
        const Hip3OrderPanel(),
        opening: _DelayedOpening(opening, rules.future),
      ),
    );
    await tester.pump(const Duration(milliseconds: 100));

    final sliderFinder = find.byType(Slider);
    expect(sliderFinder, findsOneWidget);
    await tester.drag(sliderFinder, const Offset(80, 0));
    await tester.pump();
    final selectedBeforeBalance = tester.widget<Slider>(sliderFinder).value;
    expect(selectedBeforeBalance, greaterThan(0));
    expect(
      tester.widget<TextField>(find.byType(TextField).first).controller?.text,
      isEmpty,
    );

    rules.complete(opening._context('NVDA'));
    await tester.pumpAndSettle();

    final selectedAfterBalance = tester.widget<Slider>(sliderFinder).value;
    expect(selectedAfterBalance, closeTo(selectedBeforeBalance, 0.01));
    expect(find.text('0.0'), findsNothing);
    expect(find.byType(TextField).first, findsOneWidget);
    expect(
      (tester.widget<TextField>(find.byType(TextField).first).controller?.text),
      isNotEmpty,
    );
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
      final notice = find.byKey(const Key('hip3-form-error'));
      expect(notice, findsOneWidget);
      final message = (tester.widget<Text>(
        find.descendant(of: notice, matching: find.byType(Text)),
      )).data!;
      expect(
        message,
        isNot('Trading service is unavailable. Try again in a moment.'),
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
          hip3OpeningRepositoryProvider.overrideWithValue(
            _Opening(availableMargin: '16'),
          ),
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
      await tester.ensureVisible(find.byKey(const Key('tpsl-risk-checkbox')));
      await tester.tap(find.byKey(const Key('tpsl-risk-checkbox')));
      await tester.ensureVisible(find.byKey(const Key('hip3-tp-sl-confirm')));
      await tester.tap(find.byKey(const Key('hip3-tp-sl-confirm')));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byType(FilledButton).first);
      await tester.tap(find.byType(FilledButton).first);
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(Hip3ConfirmSheet),
          matching: find.text('\$120/—'),
        ),
        findsOneWidget,
      );
      await tester.ensureVisible(find.byKey(const Key('hip3-confirm-button')));
      await tester.tap(find.byKey(const Key('hip3-confirm-button')));
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
        await tester.tap(find.byKey(const Key('hip3-confirm-button')));
        await tester.pump();
        expect(execution.orderId, 'order-1');
        final container = ProviderScope.containerOf(
          tester.element(find.byType(Hip3OrderPanel)),
        );
        container.read(sessionGenerationProvider.notifier).clearUserScope();
        // The confirm action spins while the execution is in flight, so there
        // is no settled frame to wait for until it resolves.
        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
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
    expect(find.widgetWithText(FilledButton, 'Confirm and sign'), findsNothing);
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

  testWidgets('a quote that lapses on the confirmation is re-requested', (
    tester,
  ) async {
    final requote = Completer<void>();
    final orders = _ExecutableHip3Orders(
      // Long enough to survive the sheet's open animation, short enough to
      // lapse inside the test.
      firstQuoteLifetime: const Duration(seconds: 2),
      holdRequote: requote,
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
        child: _app(const Hip3OrderPanel()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();
    expect(find.byType(Hip3ConfirmSheet), findsOneWidget);
    expect(orders.previews, 1);

    // Letting the window lapse must not report anything to the trader: the
    // sheet asks for new terms and the action shows it is busy.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    expect(find.byKey(const Key('hip3-confirm-busy')), findsOneWidget);
    expect(find.textContaining('quote is unavailable'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('hip3-confirm-button')))
          .onPressed,
      isNull,
    );

    requote.complete();
    await tester.pumpAndSettle();
    // The expiry timer and the explicit refresh completion can each schedule
    // a request; the contract is that a fresh quote is eventually available.
    expect(orders.previews, greaterThanOrEqualTo(2));
    expect(find.byKey(const Key('hip3-confirm-busy')), findsNothing);
    expect(find.byType(Hip3ConfirmSheet), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('hip3-confirm-button')))
          .onPressed,
      isNotNull,
    );
  });

  testWidgets('slippage is edited on the confirmation and re-quoted', (
    tester,
  ) async {
    final orders = _ExecutableHip3Orders();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
        child: _app(const Hip3OrderPanel()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '100');
    await tester.tap(find.byType(FilledButton).first);
    await tester.pumpAndSettle();
    // The first quote carries no client tolerance: the server's value is shown.
    expect(orders.intents.first.slippage, isNull);
    expect(find.text('1%'), findsOneWidget);

    await tester.tap(find.byKey(const Key('hip3-slippage-row')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('hip3-slippage-input')), '0.5');
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm'));
    await tester.pumpAndSettle();

    // The override only takes effect through a fresh quote.
    expect(orders.intents.length, greaterThanOrEqualTo(2));
    expect(orders.intents.last.slippage?.value, '0.5');
    expect(find.text('0.5%'), findsOneWidget);
    expect(find.byType(Hip3ConfirmSheet), findsOneWidget);
  });

  testWidgets('missing or expired quotes never open the confirmation view', (
    tester,
  ) async {
    // An unsubmittable quote used to open a confirmation sheet with no terms
    // and a dead Confirm button. It now stays on the form and reports the
    // reason in the failure notice above the order button.
    const expectations = {
      false: 'This quote is unavailable or expired',
      true: 'Execution details are unavailable',
    };
    for (final missing in expectations.keys) {
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
      expect(find.byType(Hip3ConfirmSheet), findsNothing);
      expect(find.byKey(const Key('hip3-form-error')), findsOneWidget);
      expect(find.textContaining(expectations[missing]!), findsOneWidget);
      // The order button stays live so a fresh quote can be requested.
      final submit = tester.widget<FilledButton>(
        find.byKey(const Key('hip3-submit-button')),
      );
      expect(submit.onPressed, isNotNull);
      await tester.pumpWidget(const SizedBox());
    }
  });
  testWidgets(
    'leverage options follow product maximum and update the trading context',
    (tester) async {
      final opening = _Opening(maximum: 7)..leverage = 3;
      await tester.pumpWidget(_app(const Hip3OrderPanel(), opening: opening));
      await tester.pumpAndSettle();
      expect(find.text('3×'), findsWidgets);
      await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
      await tester.pumpAndSettle();
      expect(find.text('20x'), findsNothing);
      await tester.tap(find.text('7x'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
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
      await tester.tap(find.byKey(const Key('hip3-confirm-button')));
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

  testWidgets('HIP-3 amount input refreshes preview risk details', (
    tester,
  ) async {
    final orders = _ExecutableHip3Orders(missingLiquidationPrice: true);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
        child: _app(const Hip3OrderPanel()),
      ),
    );

    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '100');
    await tester.pump(const Duration(milliseconds: 301));
    await tester.pumpAndSettle();

    expect(orders.previews, 1);
    expect(find.text('-'), findsOneWidget);
    expect(find.text('10 USDC'), findsOneWidget);
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
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
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
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('hip3-leverage-toggle')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('20x'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
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
      await tester.ensureVisible(find.byKey(const Key('tpsl-risk-checkbox')));
      await tester.tap(find.byKey(const Key('tpsl-risk-checkbox')));
      await tester.ensureVisible(find.byKey(const Key('hip3-tp-sl-confirm')));
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
      expect(find.byType(Hip3ConfirmSheet), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(Hip3ConfirmSheet),
          matching: find.text('20x・Isolated'),
        ),
        findsOneWidget,
      );

      // Dismissing the modal is the way back to the form.
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      expect(find.byType(Hip3ConfirmSheet), findsNothing);
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
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
      await tester.pumpAndSettle();
      expect(find.text('Margin mode'), findsNothing);
      expect(find.text('Isolated'), findsOneWidget);
      expect(opening.mode, TradingMarginMode.isolated);
      expect(opening.settingsRequests, 1);

      await tester.tap(find.byKey(const Key('hip3-margin-mode-toggle')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cross'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
      await tester.pumpAndSettle();
      expect(find.text('Cross'), findsOneWidget);
      expect(opening.mode, TradingMarginMode.cross);
      expect(opening.settingsRequests, 2);

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
    await tester.tap(find.text('Isolated').last);
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Confirm and sign'));
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
    await tester.tap(find.byKey(const Key('hip3-confirm-button')));
    await tester.pump(const Duration(seconds: 1));

    expect(execution.orderId, 'order-1');
    expect(find.text('Order submitted'), findsOneWidget);
    final successImage = tester.widget<Image>(find.byType(Image));
    expect(
      (successImage.image as AssetImage).assetName,
      'assets/figma/trade/order_success.png',
    );
    expect(find.text('Close & View Later'), findsOneWidget);
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
    hip3AccountAbstractionRepositoryProvider.overrideWithValue(
      _UnifiedAccountRepository(),
    ),
    if (observability != null)
      observabilityReporterProvider.overrideWithValue(observability),
    hip3OpeningRepositoryProvider.overrideWithValue(opening ?? _Opening()),
    hip3OpeningContextProvider.overrideWith(
      (ref, product) =>
          ref.watch(hip3OpeningRepositoryProvider).context(product),
    ),
  ],
  child: buildTestApp(child),
);

final class _UnifiedAccountRepository
    implements Hip3AccountAbstractionRepository {
  _UnifiedAccountRepository();

  final bool unified = true;
  int statusCalls = 0;
  int conversionCalls = 0;

  @override
  Future<Hip3AccountAbstractionStatus> getStatus() async {
    statusCalls++;
    return Hip3AccountAbstractionStatus(
      ownerAddress: '0x0000000000000000000000000000000000000001',
      currentMode: unified
          ? Hip3AccountAbstractionMode.unifiedAccount
          : Hip3AccountAbstractionMode.defaultMode,
      switchAvailable: !unified,
    );
  }

  @override
  Future<Hip3AccountAbstractionStatus> switchToUnifiedAccount({
    required String prepareIdempotencyKey,
    required String executeIdempotencyKey,
  }) async {
    conversionCalls++;
    return const Hip3AccountAbstractionStatus(
      ownerAddress: '0x0000000000000000000000000000000000000001',
      currentMode: Hip3AccountAbstractionMode.unifiedAccount,
      switchAvailable: false,
    );
  }
}

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
    this.availableMargin = '1000',
  });
  final int maximum;
  final bool failing;
  final String maximumNotional;
  String availableMargin;
  int contextCalls = 0;
  int settingsRequests = 0;
  int leverage = 10;
  TradingMarginMode mode = TradingMarginMode.cross;
  @override
  Future<Hip3OpeningContext> context(String productOrSymbol) async {
    contextCalls++;
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
    availableMargin: DecimalValue(availableMargin),
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
    Future<bool> Function(Hip3StepConfirmation confirmation)? confirm,
  }) async {
    settingsRequests++;
    this.leverage = leverage;
    this.mode = mode;
    return context(productId);
  }
}

final class _DelayedOpening implements Hip3OpeningRepository {
  _DelayedOpening(this.delegate, this.contextResult);

  final _Opening delegate;
  final Future<Hip3OpeningContext> contextResult;

  @override
  Future<Hip3OpeningContext> context(String productOrSymbol) => contextResult;

  @override
  Future<Hip3OpeningContext> setLeverage(
    String productId,
    int leverage,
    TradingMarginMode mode, {
    required String idempotencyKey,
    Future<bool> Function(Hip3StepConfirmation confirmation)? confirm,
  }) => delegate.setLeverage(
    productId,
    leverage,
    mode,
    idempotencyKey: idempotencyKey,
  );
}

final class _ExecutableHip3Orders implements OrdersRepository {
  _ExecutableHip3Orders({
    this.expired = false,
    this.missingExecution = false,
    this.missingLiquidationPrice = false,
    this.firstQuoteLifetime,
    this.holdRequote,
  });
  final bool expired;
  final bool missingExecution;
  final bool missingLiquidationPrice;

  /// When set, only the first quote gets this (short) window.
  final Duration? firstQuoteLifetime;

  /// Holds every quote after the first, so a re-request can be observed.
  final Completer<void>? holdRequote;
  var previews = 0;

  final intents = <OrderIntent>[];

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    intents.add(intent);
    if (previews > 0 && holdRequote != null) await holdRequote!.future;
    final lifetime = previews == 0 && firstQuoteLifetime != null
        ? firstQuoteLifetime!
        : Duration(minutes: expired ? -1 : 1);
    previews++;
    return OrderPreview(
      previewId: 'hip3-preview-$previews',
      intent: intent,
      orderValue: DecimalValue('100', asset: 'USDC', unit: 'token'),
      hip3Execution: missingExecution
          ? null
          : _previewExecution(
              intent,
              slippage: intent.slippage?.value ?? '1',
              missingLiquidationPrice: missingLiquidationPrice,
            ),
      expiresAt: DateTime.now().toUtc().add(lifetime),
    );
  }

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
  String slippage = '1',
  bool missingLiquidationPrice = false,
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
  slippagePercent: DecimalValue(slippage),
  liquidationPriceUnavailableReason:
      'cross_margin_requires_full_account_simulation',
  liquidationPrice: missingLiquidationPrice ? null : DecimalValue('90'),
);

/// One transfer satisfies the order: the first session needs funding, the
/// second is already funded.
class _TransferThenFunded implements FundingRepository {
  _TransferThenFunded({required this.onTransfer});
  final void Function() onTransfer;
  int sessions = 0;
  int transfers = 0;

  @override
  Future<FundingSessionSummary> createFundingSession({
    required OrderIntent intent,
    required String idempotencyKey,
  }) async {
    sessions++;
    return FundingSessionSummary(
      sessionId: 'session-$sessions',
      status: sessions == 1 ? 'ready_to_confirm' : 'funded',
      version: 1,
      canConfirmTransfer: sessions == 1,
      expiresAt: DateTime.now().toUtc().add(const Duration(hours: 24)),
    );
  }

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async => FundingPlan(
    planId: 'hip3-plan',
    tradePreviewId: fundingSessionId,
    shortfall: DecimalValue('5'),
    status: FundingPlanState.ready,
    sourceWalletId: 'wallet-1',
    sourceAsset: 'USDC',
    sourceMaximum: DecimalValue('24', asset: 'USDC', unit: 'token'),
    legs: [
      FundingLeg(
        legId: 'leg-1',
        walletId: 'wallet-1',
        asset: 'USDC',
        maximumAmount: DecimalValue('24', asset: 'USDC', unit: 'token'),
        outputAmount: DecimalValue('24', asset: 'USDC', unit: 'token'),
        status: FundingLegState.actionReleased,
      ),
    ],
  );

  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    transfers++;
    onTransfer();
    return FundingTransfer(
      transferId: 'hip3-transfer',
      planId: planId,
      amount: DecimalValue('24'),
      status: FundingTransferState.completed,
    );
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async => FundingPlan(
    planId: id,
    tradePreviewId: 'session-1',
    shortfall: DecimalValue('0'),
    status: FundingPlanState.alreadyFunded,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FundingWallets implements WalletsRepository {
  @override
  Future<WalletAuthorization> authorizeFundingTransfer({
    required String walletId,
    required String planId,
    required String asset,
    required String maximumAmount,
    required String idempotencyKey,
  }) async => WalletAuthorization(
    authorizationId: 'funding-authorization',
    walletId: walletId,
    status: WalletAuthorizationState.authorized,
    expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ShortfallFunding extends FundedRepository {
  @override
  Future<FundingSessionSummary> createFundingSession({
    required OrderIntent intent,
    required String idempotencyKey,
  }) async => FundingSessionSummary(
    sessionId: 'session-${intent.fingerprint}',
    status: 'ready_to_confirm',
    version: 1,
    canConfirmTransfer: false,
    expiresAt: DateTime.now().toUtc().add(const Duration(hours: 24)),
  );

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async {
    previewIds.add(fundingSessionId);
    return FundingPlan(
      planId: 'hip3-plan',
      tradePreviewId: fundingSessionId,
      shortfall: DecimalValue('5'),
      status: FundingPlanState.blocked,
    );
  }

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
