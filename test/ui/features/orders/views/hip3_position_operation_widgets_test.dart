import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/services/tpsl_risk_consent_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/position_close_preview.dart';
import 'package:rwa_interface/domain/models/position_leverage_context.dart';
import 'package:rwa_interface/domain/models/position_operation.dart';
import 'package:rwa_interface/domain/models/hip3_action_pending.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_close_position_sheet.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_segmented_control.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_open_orders_panel.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_position_settings_sheet.dart';
import 'package:rwa_interface/ui/features/orders/views/trade_screen.dart';
import 'package:rwa_interface/ui/features/orders/views/tp_sl_editor_card.dart';
import 'package:rwa_interface/ui/features/orders/views/tpsl_risk_agreement_sheet.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/display_config.dart';
import '../../../../helpers/test_app.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({TpSlRiskConsentService.key: true});
  });

  for (final entry in {
    'unknown': 'Protection status unknown — not confirmed active',
    'pendingSubmission': 'Protection not submitted',
    'waitingForParent': 'Protection waiting for parent fill — not active',
    'pendingConfirmation': 'Protection activation awaiting confirmation',
    'active': null,
    'inactive': 'Protection is no longer active',
  }.entries) {
    testWidgets('conditional order distinguishes ${entry.key}', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: buildTestApp(
            Hip3OpenOrderCard(
              order: _order(
                'child',
                conditional: true,
                activationStatus: entry.key,
              ),
              onChanged: () {},
            ),
          ),
        ),
      );
      if (entry.value != null) {
        expect(find.text(entry.value!), findsOneWidget);
      }
      expect(find.text('Attached to order: parent'), findsOneWidget);
      if (entry.key == 'active') {
        expect(find.text('Protection active'), findsNothing);
      }
    });
  }
  testWidgets('cancelled child warns about remaining position protection', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          Hip3OpenOrderCard(
            order: _order(
              'child',
              conditional: true,
              activationStatus: 'active',
              status: TradingOrderStatus.cancelled,
              warningCode: 'parentCancelledCheckRemainingPositionProtection',
            ),
            onChanged: () {},
          ),
        ),
      ),
    );
    expect(find.text('Protection active'), findsNothing);
    expect(
      find.textContaining('Parent cancelled: this protection is inactive.'),
      findsOneWidget,
    );
    expect(
      tester.widget<OutlinedButton>(find.byType(OutlinedButton)).onPressed,
      isNull,
    );
  });
  testWidgets('parent warns before cancellation about attached protection', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          Hip3OpenOrderCard(order: _order('parent'), onChanged: () {}),
        ),
      ),
    );
    expect(
      find.textContaining(
        'replacement protection is not created automatically',
      ),
      findsOneWidget,
    );
  });
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
    expect(find.text('Take Profit & stop loss'), findsOneWidget);
    expect(
      find.textContaining('Fixed quantity will not adjust automatically'),
      findsNothing,
    );
    expect(find.text('Order TP/SL'), findsNothing);
    final input = tester.widget<TextField>(
      find.byKey(const Key('protection-quantity')),
    );
    expect(input.controller!.text, '1');
    expect(
      tester
          .widget<Slider>(find.byKey(const Key('protection-percentage-slider')))
          .value,
      100,
    );
    await tester.ensureVisible(
      find.widgetWithText(FilledButton, 'Sign and confirm'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
    await tester.pumpAndSettle();
    expect(repo.quantity, '1');
    expect(repo.takeProfit, '130');
    expect(repo.stopLoss, isNull);
  });

  testWidgets(
    'position settings signs and submits without a second confirmation',
    (tester) async {
      await configureDisplay(tester, size: const Size(800, 800));
      final repo = _Positions();
      final leverageDone = Completer<void>();
      repo.leverageDelay = leverageDone.future;
      final position = _position();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            positionsRepositoryProvider.overrideWithValue(repo),
            positionLeverageContextProvider(position.productId!).overrideWith(
              (_) async => PositionLeverageContext(
                productId: position.productId!,
                current: DecimalValue('2'),
                maximum: DecimalValue('20'),
                marginMode: PositionMarginMode.cross,
                marginModes: const {
                  PositionMarginMode.cross,
                  PositionMarginMode.isolated,
                },
                validUntil: DateTime.utc(2099),
                canChange: true,
              ),
            ),
          ],
          child: buildTestApp(Hip3PositionSettingsSheet(position: position)),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
        findsOneWidget,
      );
      await tester.tap(find.text('5x'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pump();
      expect(repo.leverage, '5');
      leverageDone.complete();
      await tester.pumpAndSettle();

      expect(repo.leverage, '5');
      expect(repo.leverageConfirmBeforeSigning, isFalse);
    },
  );

  testWidgets(
    'position settings maps wallet signing failures to readable copy',
    (tester) async {
      await configureDisplay(tester, size: const Size(800, 800));
      final repo = _Positions()
        ..leverageError = const Hip3SigningFailure(
          Hip3SigningFailureCode.rejected,
        );
      final position = _position();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            positionsRepositoryProvider.overrideWithValue(repo),
            positionLeverageContextProvider(position.productId!).overrideWith(
              (_) async => PositionLeverageContext(
                productId: position.productId!,
                current: DecimalValue('2'),
                maximum: DecimalValue('20'),
                marginMode: PositionMarginMode.cross,
                marginModes: const {
                  PositionMarginMode.cross,
                  PositionMarginMode.isolated,
                },
                validUntil: DateTime.utc(2099),
                canChange: true,
              ),
            ),
          ],
          child: buildTestApp(Hip3PositionSettingsSheet(position: position)),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('5x'));
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();

      expect(find.text('Signature request was cancelled.'), findsOneWidget);
      expect(find.text("Instance of 'Hip3SigningFailure'"), findsNothing);
    },
  );

  for (final (name, error, message) in <(String, Object, String)>[
    (
      'API message',
      const ServerFailure(
        statusCode: 422,
        code: 'close_quantity_too_small',
        message: '  Close quantity is below the minimum.  ',
        failureReason: 'A less specific reason',
      ),
      'Close quantity is below the minimum.',
    ),
    (
      'API failure reason',
      const ServerFailure(
        statusCode: 422,
        code: 'close_rejected',
        message: ' ',
        failureReason: '  Reduce-only order rejected.  ',
      ),
      'Reduce-only order rejected.',
    ),
    (
      'execution failure reason',
      const Hip3SigningFailure(
        Hip3SigningFailureCode.invalidPayload,
        reason: '  Order size must be at least 10 USDC.  ',
      ),
      'Order size must be at least 10 USDC.',
    ),
    (
      'signature rejection',
      const Hip3SigningFailure(Hip3SigningFailureCode.rejected),
      'Signature request was cancelled.',
    ),
    (
      'changed position',
      const FormatException('Position changed; refresh before closing'),
      'Position changed; refresh before closing',
    ),
    (
      'empty format error',
      const FormatException(),
      'Close could not be completed. Refresh the position and retry.',
    ),
    (
      'unexpected error reason',
      StateError('Close execution failed'),
      'Bad state: Close execution failed',
    ),
    (
      'unknown error fallback',
      const Object(),
      'Close was not completed. Check pending actions and refresh the position before changing this request.',
    ),
  ]) {
    testWidgets('close displays $name in the error notice', (tester) async {
      final repo = _Positions()..closeError = error;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
        ),
      );
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.5');
      await tester.pump();
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      await _settleClosePreview(tester);
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pumpAndSettle();

      expect(repo.closeCalls, 1);
      expect(find.text(message), findsOneWidget);
      final text = tester.widget<Text>(find.text(message));
      final semantic = Theme.of(tester.element(find.text(message)))
          .extension<AppSemanticColors>()!;
      expect(text.style!.color, semantic.loss);
      expect(find.text("Instance of 'Hip3SigningFailure'"), findsNothing);
    });
  }

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
    await tester.enterText(find.byKey(const Key('close-quantity')), '1');
    await tester.pump();
    await _settleClosePreview(tester);
    await tester.tap(find.byKey(const Key('close-review')));
    await tester.pumpAndSettle();
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
      expect(find.text('Short TSLA'), findsOneWidget);
      final slider = tester.widget<Slider>(
        find.byKey(const Key('close-percentage-slider')),
      );
      expect(slider.value, 0);
      slider.onChanged!(50);
      await tester.pump();
      final quantity = tester.widget<TextField>(
        find.byKey(const Key('close-quantity')),
      );
      expect(quantity.controller!.text, '0.5');
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      await _settleClosePreview(tester);
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pumpAndSettle();
      expect(repo.closePosition, same(position));
      expect(repo.percent, isNull);
      expect(repo.quantity, '0.5');
      expect(repo.type, TradingOrderType.market);
      expect(repo.closePreview?.previewId, 'preview-0.5');
    },
  );

  testWidgets('close starts empty and enables only for valid required inputs', (
    tester,
  ) async {
    final repo = _Positions();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
      ),
    );
    final quantityFinder = find.byKey(const Key('close-quantity'));
    final priceFinder = find.byKey(const Key('close-limit-price'));
    final buttonFinder = find.byKey(const Key('close-review'));
    void expectEnabled(bool enabled) => expect(
      tester.widget<FilledButton>(buttonFinder).onPressed,
      enabled ? isNotNull : isNull,
    );
    final quantity = tester.widget<TextField>(quantityFinder);
    expect(quantity.controller!.text, isEmpty);
    expect(quantity.decoration!.hintText, '0.0');
    expectEnabled(false);
    for (final value in ['0', '-1', 'abc', '2', '']) {
      await tester.enterText(quantityFinder, value);
      await tester.pump();
      expectEnabled(false);
    }
    await tester.enterText(quantityFinder, '0.5');
    await tester.pump();
    expectEnabled(false);
    await _settleClosePreview(tester);
    expectEnabled(true);
    await tester.tap(find.text('Limit'));
    await tester.pumpAndSettle();
    expectEnabled(false);
    await tester.enterText(priceFinder, '120');
    await tester.pump();
    expectEnabled(false);
    await _settleClosePreview(tester);
    expectEnabled(true);
    await tester.enterText(priceFinder, '');
    await tester.pump();
    expectEnabled(false);
    await tester.tap(find.text('Market'));
    await tester.pumpAndSettle();
    await _settleClosePreview(tester);
    expectEnabled(true);
    await tester.enterText(quantityFinder, '');
    await tester.pump();
    expectEnabled(false);
    final slider = tester.widget<Slider>(
      find.byKey(const Key('close-percentage-slider')),
    );
    slider.onChanged!(50);
    await tester.pump();
    await _settleClosePreview(tester);
    expectEnabled(true);
    slider.onChanged!(0);
    await tester.pump();
    expectEnabled(false);
    expect(repo.closeCalls, 0);
  });

  testWidgets('custom market close validates then sends exact quantity', (
    tester,
  ) async {
    final repo = _Positions();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
      ),
    );
    expect(find.byType(SegmentedButton<TradingOrderType>), findsNothing);
    expect(find.byKey(const Key('close-order-type-tabs')), findsOneWidget);
    expect(find.byKey(const Key('close-limit-price')), findsNothing);
    expect(find.text('Amount'), findsOneWidget);
    expect(
      tester
          .widget<Slider>(find.byKey(const Key('close-percentage-slider')))
          .value,
      0,
    );
    await tester.enterText(find.byKey(const Key('close-quantity')), '2');
    await tester.pump();
    await tester.ensureVisible(find.byKey(const Key('close-review')));
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('close-review')))
          .onPressed,
      isNull,
    );
    await _settleClosePreview(tester);
    await tester.tap(find.byKey(const Key('close-review')));
    await tester.pumpAndSettle();
    expect(repo.closeCalls, 0);
    await tester.enterText(find.byKey(const Key('close-quantity')), '0.125');
    await tester.pump();
    expect(
      tester
          .widget<Slider>(find.byKey(const Key('close-percentage-slider')))
          .value,
      12.5,
    );
    await tester.ensureVisible(find.byKey(const Key('close-review')));
    await _settleClosePreview(tester);
    await tester.tap(find.byKey(const Key('close-review')));
    await tester.pump();
    await tester.pump();
    expect(repo.closeCalls, 1);
    expect(repo.quantity, '0.125');
    expect(repo.percent, isNull);
    expect(repo.limitPrice, isNull);
    expect(repo.type, TradingOrderType.market);
    expect(
      find.text('Close order submitted. Check the order for fills.'),
      findsOneWidget,
    );
  });

  testWidgets('close preview debounces edits and displays only this close', (
    tester,
  ) async {
    final repo = _Positions();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
      ),
    );
    addTearDown(() => tester.pumpWidget(const SizedBox.shrink()));
    expect(repo.previewRequests, isEmpty);
    expect(find.text('Estimated close PnL'), findsOneWidget);
    expect(find.text('Unrealized PnL'), findsNothing);
    await tester.enterText(find.byKey(const Key('close-quantity')), '0.2');
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byKey(const Key('close-preview-loading')), findsNWidgets(5));
    expect(find.byType(SkeletonBlock), findsNWidgets(5));
    expect(find.text('Loading'), findsNothing);
    expect(find.text('Value'), findsOneWidget);
    expect(find.text('Entry'), findsOneWidget);
    expect(repo.previewRequests, isEmpty);
    await tester.enterText(find.byKey(const Key('close-quantity')), '0.25');
    await _settleClosePreview(tester);
    expect(repo.previewRequests, hasLength(1));
    expect(repo.previewRequests.single.quantity, '0.25');
    expect(repo.previewRequests.single.type, TradingOrderType.market);
    expect(find.byType(SkeletonBlock), findsNothing);
    expect(find.text(r'$25'), findsOneWidget);
    expect(find.text(r'$99'), findsOneWidget);
    expect(find.text(r'$100'), findsOneWidget);
    expect(find.text(r'$70'), findsOneWidget);
    expect(find.text(r'+$0.24'), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('close-review')))
          .onPressed,
      isNotNull,
    );
    await tester.tap(find.text('Limit'));
    await tester.pumpAndSettle();
    expect(find.text(r'$25'), findsNothing);
    await tester.enterText(find.byKey(const Key('close-limit-price')), '110');
    await _settleClosePreview(tester);
    expect(repo.previewRequests.last.type, TradingOrderType.limit);
    expect(repo.previewRequests.last.limitPrice, '110');
    expect(repo.closeCalls, 0);
  });

  testWidgets(
    'late close preview cannot replace a newer edit or cleared inputs',
    (tester) async {
      final first = Completer<PositionClosePreview>();
      final second = Completer<PositionClosePreview>();
      final repo = _Positions()
        ..previewCompletions['0.25'] = first
        ..previewCompletions['0.5'] = second;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
        ),
      );
      addTearDown(() => tester.pumpWidget(const SizedBox.shrink()));
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.25');
      await _settleClosePreview(tester);
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.5');
      await _settleClosePreview(tester);
      expect(repo.previewRequests, hasLength(2));
      second.complete(_closePreview('0.5', value: '50'));
      await tester.pumpAndSettle();
      expect(find.text(r'$50'), findsOneWidget);
      first.complete(_closePreview('0.25'));
      await tester.pumpAndSettle();
      expect(find.text(r'$50'), findsOneWidget);
      expect(find.text(r'$25'), findsNothing);
      await tester.enterText(find.byKey(const Key('close-quantity')), '');
      await tester.pumpAndSettle();
      expect(find.text(r'$50'), findsNothing);
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('close-review')))
            .onPressed,
        isNull,
      );
      expect(repo.closeCalls, 0);
    },
  );

  testWidgets(
    'close preview errors block submission without retry and edits re-preview',
    (tester) async {
      final repo = _Positions()
        ..previewError = const ServerFailure(
          statusCode: 422,
          code: 'close_below_minimum',
          message:
              'Increase the quantity or close the entire remaining position.',
        );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
        ),
      );
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.25');
      await _settleClosePreview(tester);
      expect(
        find.text(
          'Increase the quantity or close the entire remaining position.',
        ),
        findsOneWidget,
      );
      expect(find.text(r'$25'), findsNothing);
      expect(find.byKey(const Key('close-preview-retry')), findsNothing);
      expect(find.text('Retry'), findsNothing);
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('close-review')))
            .onPressed,
        isNull,
      );
      repo.previewError = null;
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.5');
      await _settleClosePreview(tester);
      expect(repo.previewKeys.toSet(), hasLength(2));
      expect(repo.previewRequests.last.quantity, '0.5');
      expect(find.text(r'$25'), findsOneWidget);
      expect(find.byKey(const Key('close-preview-retry')), findsNothing);
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('close-review')))
            .onPressed,
        isNotNull,
      );
      expect(repo.closeCalls, 0);
    },
  );

  testWidgets('close preview timeout has no retry and ignores the late quote', (
    tester,
  ) async {
    final delayed = Completer<PositionClosePreview>();
    final repo = _Positions()..previewCompletions['0.25'] = delayed;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
      ),
    );
    await tester.enterText(find.byKey(const Key('close-quantity')), '0.25');
    await _settleClosePreview(tester);
    expect(find.byKey(const Key('close-preview-loading')), findsNWidgets(5));
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('close-preview-retry')), findsNothing);
    expect(find.text('Retry'), findsNothing);
    expect(find.byKey(const Key('close-preview-loading')), findsNothing);
    delayed.complete(_closePreview('0.25'));
    await tester.pumpAndSettle();
    expect(find.text(r'$25'), findsNothing);
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('close-review')))
          .onPressed,
      isNull,
    );
    expect(repo.previewRequests, hasLength(1));
    expect(repo.closeCalls, 0);
  });

  testWidgets(
    'expired close preview refreshes and blocks submission while loading',
    (tester) async {
      final repo = _Positions()..previewLifetime = const Duration(seconds: 1);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
        ),
      );
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.25');
      await _settleClosePreview(tester);
      expect(find.text(r'$25'), findsOneWidget);
      final refreshed = Completer<PositionClosePreview>();
      repo.previewCompletions['0.25'] = refreshed;
      await tester.pump(const Duration(seconds: 1));
      await _settleClosePreview(tester);
      expect(find.text(r'$25'), findsNothing);
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('close-review')))
            .onPressed,
        isNull,
      );
      expect(repo.previewRequests, hasLength(2));
      expect(repo.previewKeys.toSet(), hasLength(2));
      refreshed.complete(_closePreview('0.25'));
      await tester.pumpAndSettle();
      expect(find.text(r'$25'), findsOneWidget);
    },
  );

  for (final short in [false, true]) {
    testWidgets('limit close sends exact price and quantity, short=$short', (
      tester,
    ) async {
      final repo = _Positions();
      final position = _position(short: short);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: position)),
        ),
      );
      await tester.tap(find.text('Limit'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('close-limit-price')),
        '123.4567890123456789',
      );
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.125');
      await tester.pump();
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      await _settleClosePreview(tester);
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pumpAndSettle();
      expect(repo.closeCalls, 1);
      expect(repo.closePosition, same(position));
      expect(repo.type, TradingOrderType.limit);
      expect(repo.limitPrice, '123.4567890123456789');
      expect(repo.quantity, '0.125');
      expect(repo.percent, isNull);
    });
  }

  for (final price in ['', '0', '-1', 'abc']) {
    testWidgets('limit close stays disabled with invalid price "$price"', (
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
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('close-limit-price')), price);
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.5');
      await tester.pump();
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('close-review')))
            .onPressed,
        isNull,
      );
      await _settleClosePreview(tester);
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pumpAndSettle();
      expect(repo.closeCalls, 0);
    });
  }

  testWidgets('switching back to market keeps quantity and omits limit price', (
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
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('close-limit-price')), '120');
    await tester.enterText(find.byKey(const Key('close-quantity')), '0.5');
    await tester.tap(find.text('Market'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('close-limit-price')), findsNothing);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('close-quantity')))
          .controller!
          .text,
      '0.5',
    );
    await tester.tap(find.text('Limit'));
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('close-limit-price')))
          .controller!
          .text,
      '120',
    );
    await tester.tap(find.text('Market'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.byKey(const Key('close-review')));
    await _settleClosePreview(tester);
    await tester.tap(find.byKey(const Key('close-review')));
    await tester.pumpAndSettle();
    expect(repo.type, TradingOrderType.market);
    expect(repo.limitPrice, isNull);
    expect(repo.quantity, '0.5');
  });

  testWidgets(
    'limit close locks tabs and inputs during submission and pending',
    (tester) async {
      final delay = Completer<void>();
      final repo = _Positions()
        ..closeDelay = delay.future
        ..pending = true;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
        ),
      );
      await tester.tap(find.text('Limit'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byKey(const Key('close-limit-price')), '120');
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.5');
      await tester.pump();
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      await _settleClosePreview(tester);
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pump();
      void expectLocked() {
        expect(
          tester
              .widget<Hip3SegmentedControl<TradingOrderType>>(
                find.byKey(const Key('close-order-type-tabs')),
              )
              .onChanged,
          isNull,
        );
        for (final key in ['close-limit-price', 'close-quantity']) {
          expect(
            tester.widget<TextField>(find.byKey(Key(key))).enabled,
            isFalse,
          );
        }
      }

      expectLocked();
      delay.complete();
      await tester.pumpAndSettle();
      expectLocked();
      expect(repo.closeCalls, 1);
    },
  );

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
      await tester.pumpAndSettle();
      await tester.tap(find.byType(Switch).first);
      await tester.pump();
      if (both) {
        await tester.tap(find.byType(Switch).last);
        await tester.pump();
      }
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();
      expect(
        repo.clearScope,
        both ? ProtectionClearScope.both : ProtectionClearScope.takeProfit,
      );
      expect(repo.takeProfit, isNull);
      expect(repo.stopLoss, both ? null : '90');
    });
  }

  for (final price in ['', '0', '0.00']) {
    for (final scope in ProtectionClearScope.values) {
      testWidgets('unset trigger "$price" cancels existing ${scope.name}', (
        tester,
      ) async {
        final repo = _Positions();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
            child: buildTestApp(PositionTpSlSheet(position: _position())),
          ),
        );
        await tester.pumpAndSettle();
        if (scope != ProtectionClearScope.stopLoss) {
          await tester.enterText(
            find.byKey(const Key('position-protection-take-profit')),
            price,
          );
        }
        if (scope != ProtectionClearScope.takeProfit) {
          await tester.enterText(
            find.byKey(const Key('position-protection-stop-loss')),
            price,
          );
        }
        await tester.ensureVisible(
          find.widgetWithText(FilledButton, 'Sign and confirm'),
        );
        await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
        await tester.pumpAndSettle();

        expect(repo.protectionCalls, 1);
        expect(repo.clearScope, scope);
        expect(
          repo.takeProfit,
          scope == ProtectionClearScope.stopLoss ? '110' : null,
        );
        expect(
          repo.stopLoss,
          scope == ProtectionClearScope.takeProfit ? '90' : null,
        );
        expect(find.byType(TpSlInlineError), findsNothing);
      });
    }
  }

  for (final take in [false, true]) {
    testWidgets('new protection permits setting only ${take ? 'TP' : 'SL'}', (
      tester,
    ) async {
      final repo = _Positions();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(
            PositionTpSlSheet(position: _position(withProtection: false)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        take ? '110' : '0',
      );
      await tester.enterText(
        find.byKey(const Key('position-protection-stop-loss')),
        take ? '0' : '90',
      );
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();

      expect(repo.protectionCalls, 1);
      expect(repo.clearScope, isNull);
      expect(repo.takeProfit, take ? '110' : null);
      expect(repo.stopLoss, take ? null : '90');
      expect(find.byType(TpSlInlineError), findsNothing);
    });
  }

  for (final price in ['', '0']) {
    testWidgets('both new triggers "$price" submit no protection action', (
      tester,
    ) async {
      final repo = _Positions();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(
            PositionTpSlSheet(position: _position(withProtection: false)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        price,
      );
      await tester.enterText(
        find.byKey(const Key('position-protection-stop-loss')),
        price,
      );
      tester
          .widget<Slider>(find.byKey(const Key('protection-percentage-slider')))
          .onChanged!(0);
      await tester.pump();
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();

      expect(repo.protectionCalls, 0);
      expect(find.byType(TpSlInlineError), findsNothing);
    });
  }

  testWidgets('zero trigger also omits its existing limit price', (
    tester,
  ) async {
    final repo = _Positions();
    final position = _position(protectionIds: ['tp-1']);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(repo),
          positionProtectionOrdersProvider(position).overrideWith(
            (_) async => [
              _order('tp-1', conditional: true, executionType: 'limit'),
            ],
          ),
        ],
        child: buildTestApp(PositionTpSlSheet(position: position)),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('position-protection-take-profit')),
      '0',
    );
    await tester.ensureVisible(
      find.widgetWithText(FilledButton, 'Sign and confirm'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
    await tester.pumpAndSettle();

    expect(repo.protectionCalls, 1);
    expect(repo.clearScope, ProtectionClearScope.takeProfit);
    expect(repo.takeProfit, isNull);
    expect(repo.takeLimit, isNull);
    expect(repo.stopLoss, isNull);
    expect(repo.quantity, isNull);
    expect(find.byType(TpSlInlineError), findsNothing);
  });

  for (final short in [false, true]) {
    for (final take in [false, true]) {
      for (final equal in [false, true]) {
        testWidgets(
          'direction error identifies leg, short=$short take=$take equal=$equal',
          (tester) async {
            final repo = _Positions();
            final mustBeAbove = !short == take;
            final price = equal
                ? '100'
                : mustBeAbove
                ? '99.999999999999999999'
                : '100.000000000000000001';
            await tester.pumpWidget(
              ProviderScope(
                overrides: [
                  positionsRepositoryProvider.overrideWithValue(repo),
                ],
                child: buildTestApp(
                  PositionTpSlSheet(
                    position: _position(short: short, withProtection: false),
                  ),
                  locale: const Locale('zh'),
                ),
              ),
            );
            await tester.pumpAndSettle();
            await tester.enterText(
              find.byKey(
                Key(
                  take
                      ? 'position-protection-take-profit'
                      : 'position-protection-stop-loss',
                ),
              ),
              price,
            );
            await tester.ensureVisible(
              find.widgetWithText(FilledButton, '签名并确认'),
            );
            await tester.tap(find.widgetWithText(FilledButton, '签名并确认'));
            await tester.pumpAndSettle();

            expect(repo.protectionCalls, 0);
            expect(
              find.text(
                '${short ? '空仓' : '多仓'}${take ? '止盈' : '止损'}价格必须${mustBeAbove ? '高于' : '低于'}当前标记价格（100）。',
              ),
              findsOneWidget,
            );
            expect(find.byType(TpSlInlineError), findsOneWidget);
            expect(
              find.text('Trigger price conflicts with mark and position side'),
              findsNothing,
            );
          },
        );
      }
    }
  }

  testWidgets(
    'profitable stop validates against mark rather than entry price',
    (tester) async {
      final repo = _Positions();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(
            PositionTpSlSheet(
              position: _position(
                withProtection: false,
                mark: '120',
                entry: '100',
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('position-protection-stop-loss')),
        '110',
      );
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();

      expect(repo.protectionCalls, 1);
      expect(repo.stopLoss, '110');
      expect(find.byType(TpSlInlineError), findsNothing);
    },
  );

  testWidgets('direction failure after refresh preserves the actual reason', (
    tester,
  ) async {
    final repo = _Positions()
      ..protectionError = ArgumentError(
        'Trigger price conflicts with mark and position side',
      );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(
          PositionTpSlSheet(position: _position()),
          locale: const Locale('zh'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.widgetWithText(FilledButton, '签名并确认'));
    await tester.tap(find.widgetWithText(FilledButton, '签名并确认'));
    await tester.pumpAndSettle();

    expect(repo.protectionCalls, 1);
    expect(find.text('无法保存止盈/止损。请检查价格后重试。'), findsNothing);
    expect(
      find.text('Trigger price conflicts with mark and position side'),
      findsOneWidget,
    );
  });

  for (final price in ['abc', '-1', '1e2']) {
    testWidgets('invalid protection price "$price" stays an input error', (
      tester,
    ) async {
      final repo = _Positions();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(
            PositionTpSlSheet(position: _position()),
            locale: const Locale('zh'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        price,
      );
      await tester.ensureVisible(find.widgetWithText(FilledButton, '签名并确认'));
      await tester.tap(find.widgetWithText(FilledButton, '签名并确认'));
      await tester.pumpAndSettle();

      expect(repo.protectionCalls, 0);
      expect(find.text('止盈: 请输入有效的正数价格。'), findsOneWidget);
      expect(find.text('无法完成保护更新，请刷新后重试。'), findsNothing);
      final notice = find.byKey(const Key('tpsl-inline-error'));
      final container = tester.widget<Container>(notice);
      expect(
        (container.decoration! as BoxDecoration).color,
        const Color(0xFFFFEEF0),
      );
      final text = tester.widget<Text>(
        find.descendant(of: notice, matching: find.byType(Text)),
      );
      final semantic = Theme.of(tester.element(notice))
          .extension<AppSemanticColors>()!;
      expect(text.style!.color, semantic.loss);
    });
  }

  for (final quantity in ['', 'abc', '0', '2']) {
    testWidgets('invalid fixed protection quantity "$quantity" blocks submit', (
      tester,
    ) async {
      final repo = _Positions();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(PositionTpSlSheet(position: _position())),
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const Key('protection-quantity')));
      if (quantity.isEmpty) {
        await tester.enterText(
          find.byKey(const Key('protection-quantity')),
          '0.5',
        );
        await tester.pump();
      }
      await tester.enterText(
        find.byKey(const Key('protection-quantity')),
        quantity,
      );
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();

      expect(repo.protectionCalls, 0);
      expect(
        find.text(
          'Enter a positive quantity no greater than the current position.',
        ),
        findsOneWidget,
      );
      expect(find.byType(TpSlInlineError), findsOneWidget);
    });
  }

  testWidgets('protection load failure uses an inline notice and blocks save', (
    tester,
  ) async {
    final repo = _Positions();
    final position = _position(protectionIds: ['tp-1']);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(repo),
          positionProtectionOrdersProvider(position).overrideWith(
            (_) async => throw const FormatException('Unsupported protection'),
          ),
        ],
        child: buildTestApp(PositionTpSlSheet(position: position)),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Could not read existing protection sizes. Close and refresh before editing.',
      ),
      findsOneWidget,
    );
    expect(find.byType(TpSlInlineError), findsOneWidget);
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Sign and confirm'),
          )
          .onPressed,
      isNull,
    );
    expect(repo.protectionCalls, 0);
  });

  for (final (name, error, message) in <(String, Object, String)>[
    (
      'API message',
      const ServerFailure(
        statusCode: 422,
        code: 'protection_quantity_too_small',
        message: '  Protection quantity is below the minimum.  ',
        failureReason: 'A less specific reason',
      ),
      'Protection quantity is below the minimum.',
    ),
    (
      'API failure reason',
      const ServerFailure(
        statusCode: 422,
        code: 'protection_rejected',
        message: ' ',
        failureReason: '  Trigger price has invalid precision.  ',
      ),
      'Trigger price has invalid precision.',
    ),
    (
      'API status, code and details',
      const ServerFailure(
        statusCode: 409,
        code: 'position_version_conflict',
        details: {'position_version': 'v2'},
      ),
      'HTTP 409 position_version_conflict (position_version: v2)',
    ),
    (
      'network transport reason',
      const NetworkFailure(userAction: '  Connection refused.  '),
      'Connection refused.',
    ),
    (
      'network unavailable',
      const NetworkFailure(),
      'Network unavailable. Check your connection and try again.',
    ),
    (
      'request timeout',
      const TimeoutFailure(),
      'The TP/SL request timed out. Check protection orders before retrying.',
    ),
    (
      'execution failure reason',
      const Hip3SigningFailure(
        Hip3SigningFailureCode.invalidPayload,
        reason: '  Order size must be at least 10 USDC.  ',
      ),
      'Order size must be at least 10 USDC.',
    ),
    (
      'signature rejection',
      const Hip3SigningFailure(Hip3SigningFailureCode.rejected),
      'Signature request was cancelled.',
    ),
    (
      'expired signing request',
      const Hip3SigningFailure(Hip3SigningFailureCode.actionExpired),
      'This signing request expired. Prepare the order again.',
    ),
    (
      'changed position',
      const FormatException('Position changed'),
      'Position changed',
    ),
    (
      'unexpected error reason',
      StateError('Update failed'),
      'Bad state: Update failed',
    ),
    (
      'empty format error fallback',
      const FormatException(),
      'Could not save TP/SL. Check the prices and try again.',
    ),
    (
      'unknown error fallback',
      const Object(),
      'Could not save TP/SL. Check the prices and try again.',
    ),
  ]) {
    testWidgets('protection displays $name in the inline error notice', (
      tester,
    ) async {
      final repo = _Positions()..protectionError = error;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(PositionTpSlSheet(position: _position())),
        ),
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();

      expect(repo.protectionCalls, 1);
      expect(find.byType(TpSlInlineError), findsOneWidget);
      expect(find.text(message), findsOneWidget);
      expect(
        find.text(
          'Protection update was not completed. A cancellation may already have succeeded. Retry the same edit or check pending actions before changing it.',
        ),
        findsNothing,
      );
    });
  }

  testWidgets('position TP/SL uses the opening-order price editors', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(_Positions()),
        ],
        child: buildTestApp(PositionTpSlSheet(position: _position())),
      ),
    );

    expect(find.byType(TpSlEditorCard), findsNWidgets(2));
    expect(
      find.byKey(const Key('position-protection-take-profit')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('position-take-profit-ruler')), findsOneWidget);
    expect(
      find.byKey(const Key('position-protection-stop-loss')),
      findsOneWidget,
    );
    expect(find.byKey(const Key('position-stop-loss-ruler')), findsOneWidget);
    expect(find.byType(DropdownButton<bool>), findsNothing);
    expect(find.byKey(const Key('tpsl-risk-checkbox')), findsOneWidget);
    expect(find.byKey(const Key('tpsl-risk-details')), findsOneWidget);
    expect(find.textContaining('position size at trigger time'), findsNothing);
    expect(
      find.textContaining('Trigger execution needs no new signature.'),
      findsNothing,
    );
  });

  for (final short in [false, true]) {
    for (final percentage in [20.0, 100.0]) {
      testWidgets('protection slider submits $percentage%, short=$short', (
        tester,
      ) async {
        await configureDisplay(tester, size: Size(short ? 320 : 393, 760));
        final repo = _Positions();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
            child: buildTestApp(
              PositionTpSlSheet(position: _position(short: short)),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final slider = find.byKey(const Key('protection-percentage-slider'));
        await tester.ensureVisible(slider);
        final rect = tester.getRect(slider);
        await tester.tapAt(
          Offset(
            (rect.left + rect.width * percentage / 100).clamp(
              rect.left + 1,
              rect.right - 1,
            ),
            rect.center.dy,
          ),
        );
        await tester.pumpAndSettle();
        expect(tester.widget<Slider>(slider).value, percentage);
        expect(find.text('${percentage.round()}%'), findsOneWidget);

        await tester.ensureVisible(
          find.widgetWithText(FilledButton, 'Sign and confirm'),
        );
        await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
        await tester.pumpAndSettle();
        expect(repo.protectionCalls, 1);
        if (percentage == 100) {
          expect(repo.quantity, isNull);
        } else {
          expect(
            DecimalValue(repo.quantity!).compareTo(DecimalValue('0.2')),
            0,
          );
        }
        expect(tester.takeException(), isNull);
      });
    }
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
      await tester.ensureVisible(find.byKey(const Key('protection-quantity')));
      await tester.enterText(
        find.byKey(const Key('protection-quantity')),
        '0.123',
      );
      await tester.pump();
      expect(
        find.textContaining('will not adjust automatically'),
        findsNothing,
      );
      expect(
        tester
            .widget<Slider>(
              find.byKey(const Key('protection-percentage-slider')),
            )
            .value,
        closeTo(12.3, 0.001),
      );
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
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
      expect(find.text('TSLA/USDC'), findsOneWidget);
      await tester.ensureVisible(
        find.byKey(const Key('hip3-orders-load-more')),
      );
      await tester.tap(find.byKey(const Key('hip3-orders-load-more')));
      await tester.pumpAndSettle();
      expect(repo.queries.last, ('TSLA', 'xyz:TSLA', 'open', 'page-2'));
      expect(find.text('TSLA/USDC'), findsNWidgets(2));
      expect(find.text('TP'), findsOneWidget);
      expect(find.text('25%'), findsOneWidget);
      expect(find.byKey(const Key('hip3-orders-load-more')), findsNothing);
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _settleClosePreview(WidgetTester tester) async {
  addTearDown(() => tester.pumpWidget(const SizedBox.shrink()));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 301));
  await tester.pumpAndSettle();
}

PositionClosePreview _closePreview(
  String quantity, {
  String value = '25',
  Duration lifetime = const Duration(minutes: 1),
  PositionSide side = PositionSide.short,
  TradingOrderType type = TradingOrderType.market,
  String? limitPrice,
}) => PositionClosePreview(
  previewId: 'preview-$quantity',
  positionId: 'p-tsla',
  productId: 'xyz:TSLA',
  positionVersion: 'v1',
  environment: 'testnet',
  side: side,
  type: type,
  quantity: DecimalValue(quantity),
  notional: DecimalValue(value),
  entryPrice: DecimalValue('99'),
  markPrice: DecimalValue('100'),
  estimatedPrice: DecimalValue('101'),
  estimatedFee: DecimalValue('0.01'),
  estimatedRealizedPnl: DecimalValue('0.24'),
  limitPrice: limitPrice == null ? null : DecimalValue(limitPrice),
  liquidationPrice: DecimalValue('70'),
  expiresAt: DateTime.now().toUtc().add(lifetime),
  observedAt: DateTime.now().toUtc(),
);

Position _position({
  bool short = false,
  bool withProtection = true,
  String mark = '100',
  String? entry,
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
  markPrice: DecimalValue(mark, asset: 'USD', unit: 'price'),
  entryPrice: entry == null
      ? null
      : DecimalValue(entry, asset: 'USD', unit: 'price'),
  takeProfitPrice: withProtection ? DecimalValue(short ? '90' : '110') : null,
  stopLossPrice: withProtection ? DecimalValue(short ? '110' : '90') : null,
);

TradingOrder _order(
  String id, {
  bool conditional = false,
  String executionType = 'market',
  String activationStatus = 'unknown',
  String? warningCode,
  TradingOrderStatus status = TradingOrderStatus.open,
}) => TradingOrder(
  orderId: id,
  productId: 'xyz:TSLA',
  positionId: 'p-tsla',
  symbol: 'TSLA',
  kind: MarketProductKind.perp,
  side: conditional ? TradingSide.short : TradingSide.long,
  type: TradingOrderType.limit,
  status: status,
  createdAt: DateTime.utc(2026),
  quantity: DecimalValue('1'),
  limitPrice: executionType == 'limit' ? DecimalValue('130') : null,
  filledQuantity: DecimalValue(conditional ? '0.25' : '0'),
  conditional: conditional
      ? ConditionalOrder(
          role: 'takeProfit',
          triggerPrice: DecimalValue('130'),
          triggerReference: 'mark',
          triggerStatus: 'untriggered',
          executionType: executionType,
          sizeMode: 'quantity',
          quantity: '1',
          activationStatus: activationStatus,
          warningCode: warningCode,
          parentOrderId: 'parent',
        )
      : null,
);

class _Positions implements PositionsRepository {
  Object? previewError;
  final previewRequests = <PositionClosePreviewRequest>[];
  final previewKeys = <String>[];
  final previewCompletions = <String, Completer<PositionClosePreview>>{};
  Duration previewLifetime = const Duration(minutes: 1);
  @override
  Future<PositionClosePreview> previewClose(
    Position position, {
    required String quantity,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    required String idempotencyKey,
  }) async {
    previewRequests.add((
      position: position,
      quantity: quantity,
      type: type,
      limitPrice: limitPrice,
    ));
    previewKeys.add(idempotencyKey);
    if (previewError case final error?) throw error;
    final completion = previewCompletions[quantity];
    if (completion != null) return completion.future;
    return _closePreview(
      quantity,
      lifetime: previewLifetime,
      side: position.side == PositionSide.long
          ? PositionSide.short
          : PositionSide.long,
      type: type,
      limitPrice: limitPrice,
    );
  }

  bool pending = false;
  Object? closeError;
  Future<void>? closeDelay;
  int closeCalls = 0;
  PositionClosePreview? closePreview;
  Position? closePosition;
  TradingOrderType? type;
  String? quantity, percent, limitPrice, takeProfit, takeLimit, stopLoss;
  String? leverage;
  bool? leverageConfirmBeforeSigning;
  Future<void>? leverageDelay;
  Object? leverageError;
  ProtectionClearScope? clearScope;
  int protectionCalls = 0;
  Object? protectionError;
  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    PositionClosePreview? preview,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    closeCalls++;
    await closeDelay;
    if (pending) throw const Hip3ActionPending('pending-close');
    if (closeError case final error?) throw error;
    closePosition = expectedPosition;
    closePreview = preview;
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
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    protectionCalls++;
    if (protectionError case final error?) throw error;
    this.takeProfit = takeProfit;
    this.takeLimit = takeLimit;
    this.stopLoss = stopLoss;
    this.quantity = quantity;
    this.clearScope = clearScope;
    return position;
  }

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    PositionMarginMode? marginMode,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    this.leverage = leverage;
    leverageConfirmBeforeSigning = confirmBeforeSigning;
    if (leverageError case final error?) throw error;
    if (leverageDelay != null) await leverageDelay;
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
