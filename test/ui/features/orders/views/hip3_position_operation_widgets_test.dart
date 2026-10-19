import 'package:nobell/domain/models/hip3_protection.dart';
import 'package:nobell/domain/models/hip3_action_summary.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/data/services/tpsl_risk_consent_service.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/position_close_preview.dart';
import 'package:nobell/domain/models/position_leverage_context.dart';
import 'package:nobell/domain/models/position_operation.dart';
import 'package:nobell/domain/models/hip3_action_pending.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/repositories/positions_repository.dart';
import 'package:nobell/domain/repositories/orders_repository.dart';
import 'package:nobell/domain/repositories/hip3_order_execution_repository.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';
import 'package:nobell/ui/features/positions/providers/position_providers.dart';
import 'package:nobell/ui/features/positions/views/hip3_protection_order_results.dart';
import 'package:nobell/ui/features/orders/views/hip3_close_position_sheet.dart';
import 'package:nobell/ui/features/orders/views/hip3_segmented_control.dart';
import 'package:nobell/ui/features/orders/views/hip3_open_orders_panel.dart';
import 'package:nobell/ui/features/orders/views/hip3_position_settings_sheet.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/orders/views/tp_sl_editor_card.dart';
import 'package:nobell/ui/features/orders/views/tpsl_risk_agreement_sheet.dart';
import 'package:nobell/ui/core/feedback/app_toast.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/core/feedback/inline_error_notice.dart';
import 'package:nobell/ui/core/feedback/loading_skeleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/display_config.dart';
import '../../../../helpers/test_app.dart';

void main() {
  testWidgets('position TP/SL risk consent stays synchronized with details', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(600, 1200));
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(_Positions()),
        ],
        child: buildTestApp(PositionTpSlSheet(position: _position())),
      ),
    );
    await tester.pumpAndSettle();
    final outer = find.byKey(const Key('tpsl-risk-checkbox'));
    final details = find.byKey(const Key('tpsl-risk-details'));
    final inner = find.byKey(const Key('tpsl-risk-agreement-checkbox'));
    final confirm = find.byKey(const Key('tpsl-risk-confirm'));
    expect(tester.widget<Checkbox>(outer).value, isFalse);
    await tester.ensureVisible(outer);
    await tester.tap(outer);
    await tester.pumpAndSettle();
    await tester.tap(details);
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(inner).value, isTrue);
    expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);

    await tester.tap(inner);
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);
    await tester.tap(find.byKey(const Key('tpsl-risk-close')));
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(outer).value, isFalse);

    await tester.tap(details);
    await tester.pumpAndSettle();
    expect(tester.widget<Checkbox>(inner).value, isFalse);
    await tester.tap(inner);
    await tester.pumpAndSettle();
    await tester.tap(confirm);
    await tester.pumpAndSettle();
    expect(inner, findsNothing);
    expect(tester.widget<Checkbox>(outer).value, isTrue);
    expect(tester.takeException(), isNull);
  });

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
      expect(find.text('Attached to order: parent'), findsNothing);
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
  for (final conditional in [true, false]) {
    testWidgets(
      'open order price prefers ${conditional ? 'conditional trigger' : 'limit'} price',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            child: buildTestApp(
              Hip3OpenOrderCard(
                order: _order(
                  'price-priority',
                  conditional: conditional,
                  executionType: 'limit',
                  limitPrice: '125',
                ),
                onChanged: () {},
              ),
            ),
          ),
        );
        expect(find.text(conditional ? '130' : '125'), findsOneWidget);
        expect(find.text(conditional ? '125' : '130'), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('parent omits the cancellation protection warning', (
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
      findsNothing,
    );
    final role = find.text('Long / Limit');
    final date = find.text('2026/01/01');
    expect(tester.getSize(role).height, tester.getSize(date).height);
    expect(tester.getCenter(role).dy, tester.getCenter(date).dy);
  });
  for (final side in [TradingSide.long, TradingSide.short]) {
    for (final legs in ['both', 'tp', 'sl', 'none']) {
      testWidgets('limit $side displays $legs protection and tooltip', (
        tester,
      ) async {
        await configureDisplay(tester, size: const Size(393, 852));
        await tester.pumpWidget(
          ProviderScope(
            child: buildTestApp(
              Hip3OpenOrderCard(
                order: _order(
                  'parent',
                  side: side,
                  tpSl: legs == 'none'
                      ? null
                      : TakeProfitStopLoss(
                          takeProfit: legs != 'sl' ? DecimalValue('200') : null,
                          stopLoss: legs != 'tp' ? DecimalValue('130') : null,
                        ),
                ),
                onChanged: () {},
              ),
            ),
          ),
        );
        final badge = tester.widget<Text>(
          find.text('${side == TradingSide.long ? 'Long' : 'Short'} / Limit'),
        );
        expect(
          badge.style!.color,
          side == TradingSide.long ? const Color(0xFF04A08B) : kShortTradeColor,
        );
        if (legs == 'none') {
          expect(find.text('TP/SL pending'), findsNothing);
          expect(find.byIcon(Icons.help_outline), findsNothing);
        } else {
          expect(find.text('TP/SL pending'), findsOneWidget);
          final iconBounds = tester.getRect(find.byIcon(Icons.help_outline));
          final summaryBounds = tester.getRect(
            find
                .ancestor(
                  of: find.byIcon(Icons.help_outline),
                  matching: find.byType(Container),
                )
                .first,
          );
          expect(summaryBounds.right - iconBounds.right, 8);
          expect(
            find.text(switch (legs) {
              'both' => 'TP 200 / SL 130',
              'tp' => 'TP 200',
              _ => 'SL 130',
            }),
            findsOneWidget,
          );
          await tester.tap(find.byIcon(Icons.help_outline));
          await tester.pump();
          expect(
            find.text(
              'These TP/SL orders have not been placed yet. They will be placed automatically after this limit order is filled.',
              findRichText: true,
            ),
            findsOneWidget,
          );
          await tester.tap(find.byIcon(Icons.help_outline));
          await tester.pump();
        }
        expect(tester.takeException(), isNull);
      });
    }
  }
  testWidgets('open order card localizes metrics and protection summary', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await tester.pumpWidget(
      ProviderScope(
        child: buildTestApp(
          Hip3OpenOrderCard(
            order: _order(
              'parent',
              tpSl: TakeProfitStopLoss(
                takeProfit: DecimalValue('200'),
                stopLoss: DecimalValue('130'),
              ),
            ),
            onChanged: () {},
          ),
          locale: const Locale('zh'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('已成交 / 总计'), findsOneWidget);
    expect(find.text('价格'), findsOneWidget);
    expect(find.text('进度'), findsOneWidget);
    expect(find.text('止盈 200 / 止损 130'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('parent cancellation displays the actual server rejection', (
    tester,
  ) async {
    final execution = _CancellingHip3Orders()
      ..error = const ServerFailure(
        statusCode: 409,
        code: 'order_already_filled',
        failureReason: 'This order has already filled and cannot be cancelled.',
      );
    var changed = false;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hip3OrderExecutionRepositoryProvider.overrideWithValue(execution),
        ],
        child: buildTestApp(
          Hip3OpenOrderCard(
            order: _order('parent'),
            onChanged: () => changed = true,
          ),
        ),
      ),
    );
    await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
    await tester.pumpAndSettle();
    expect(
      find.text('This order has already filled and cannot be cancelled.'),
      findsOneWidget,
    );
    expect(changed, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('successful parent cancellation shows a success toast', (
    tester,
  ) async {
    final execution = _CancellingHip3Orders();
    var changed = false;
    addTearDown(AppToast.dismiss);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          hip3OrderExecutionRepositoryProvider.overrideWithValue(execution),
        ],
        child: buildTestApp(
          Hip3OpenOrderCard(
            order: _order('parent'),
            onChanged: () => changed = true,
          ),
        ),
      ),
    );

    await tester.tap(find.widgetWithText(OutlinedButton, 'Cancel'));
    await tester.pump();

    expect(execution.cancelledOrderId, 'parent');
    expect(changed, isTrue);
    expect(
      find.text(
        'Cancellation submitted. Refresh to confirm the final order status.',
      ),
      findsOneWidget,
    );
    expect(
      find.textContaining(
        'replacement protection is not created automatically',
      ),
      findsNothing,
    );
  });

  testWidgets(
    'pending protection automatically signs the same action without another confirmation',
    (tester) async {
      addTearDown(AppToast.dismiss);
      await configureDisplay(tester, size: const Size(600, 1200));
      const awaiting = Hip3ActionSummary(
        actionId: 'protection-result',
        productId: 'xyz:TSLA',
        operation: 'manageTpsl',
        status: 'awaitingSignature',
        effectsApplied: false,
        canResumePositionAction: true,
      );
      final repo = _Positions()
        ..protectionResult = const Hip3ActionSummary(
          actionId: 'protection-result',
          productId: 'xyz:TSLA',
          operation: 'manageTpsl',
          status: 'reconciling',
          effectsApplied: false,
          canResumePositionAction: true,
        );
      final resume = Completer<void>();
      repo.resumeDelay = resume.future;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(
            Builder(
              builder: (context) => FilledButton(
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => PositionTpSlSheet(
                    position: _position(withProtection: false),
                  ),
                ),
                child: const Text('Open protection'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open protection'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        '111',
      );
      final submit = find.widgetWithText(FilledButton, 'Sign and confirm');
      await tester.ensureVisible(submit);
      await tester.tap(submit);
      await tester.pump();
      await tester.pump();
      expect(repo.protectionReads, 1);
      repo.protectionResult = awaiting;
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();
      await tester.pump();
      expect(find.text('Waiting for your signature'), findsNothing);
      expect(find.text('Continue action'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(repo.protectionReads, 2);
      await tester.pump(const Duration(seconds: 6));
      await tester.pump();
      expect(repo.protectionReads, 2);

      expect(repo.resumedActions, ['protection-result']);
      expect(repo.protectionCalls, 1);
      expect(
        tester.widget<FilledButton>(find.byType(FilledButton).last).onPressed,
        isNull,
      );
      repo.protectionResult = const Hip3ActionSummary(
        actionId: 'protection-result',
        productId: 'xyz:TSLA',
        operation: 'manageTpsl',
        status: 'succeeded',
        effectsApplied: true,
        canResumePositionAction: false,
      );
      resume.complete();
      await tester.pump();
      for (
        var frame = 0;
        frame < 10 && find.byType(PositionTpSlSheet).evaluate().isNotEmpty;
        frame++
      ) {
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(repo.protectionReads, 3);
      expect(repo.protectionCalls, 1);
      expect(find.byType(PositionTpSlSheet), findsNothing);
      expect(find.text('Confirmed'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  for (final (failure, message) in <(Object, String)>[
    (
      const Hip3SigningFailure(Hip3SigningFailureCode.rejected),
      'Signature request was cancelled.',
    ),
    (
      const NetworkFailure(),
      'Network unavailable. Check your connection and try again.',
    ),
    (
      const TimeoutFailure(),
      'The TP/SL request timed out. Check protection orders before retrying.',
    ),
  ]) {
    testWidgets(
      'failed automatic protection signature can retry the same action: $failure',
      (tester) async {
        addTearDown(AppToast.dismiss);
        await configureDisplay(tester, size: const Size(600, 1200));
        const awaiting = Hip3ActionSummary(
          actionId: 'protection-result',
          productId: 'xyz:TSLA',
          operation: 'manageTpsl',
          status: 'awaitingSignature',
          effectsApplied: false,
          canResumePositionAction: true,
        );
        final repo = _Positions()
          ..protectionResult = const Hip3ActionSummary(
            actionId: 'protection-result',
            productId: 'xyz:TSLA',
            operation: 'manageTpsl',
            status: 'reconciling',
            effectsApplied: false,
            canResumePositionAction: true,
          );
        final resume = Completer<void>();
        repo.resumeDelay = resume.future;
        await tester.pumpWidget(
          ProviderScope(
            overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
            child: buildTestApp(
              Builder(
                builder: (context) => FilledButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => PositionTpSlSheet(
                      position: _position(withProtection: false),
                    ),
                  ),
                  child: const Text('Open protection'),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('Open protection'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('position-protection-take-profit')),
          '111',
        );
        final submit = find.widgetWithText(FilledButton, 'Sign and confirm');
        await tester.ensureVisible(submit);
        await tester.tap(submit);
        await tester.pump();
        await tester.pump();
        expect(repo.protectionReads, 1);
        repo.protectionResult = awaiting;
        await tester.pump(const Duration(seconds: 2));
        await tester.pump();
        await tester.pump();
        expect(find.text('Waiting for your signature'), findsNothing);
        expect(find.text('Continue action'), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(repo.protectionReads, 2);
        await tester.pump(const Duration(seconds: 6));
        await tester.pump();
        expect(repo.protectionReads, 2);

        expect(repo.resumedActions, ['protection-result']);
        expect(repo.protectionCalls, 1);
        expect(
          tester.widget<FilledButton>(find.byType(FilledButton).last).onPressed,
          isNull,
        );
        resume.completeError(failure);
        for (var frame = 0; frame < 10; frame++) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(find.text(message), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        final retry = find.widgetWithText(FilledButton, 'Sign and confirm');
        expect(find.text('Retry'), findsNothing);
        expect(tester.widget<FilledButton>(retry).onPressed, isNotNull);
        // An error must wait for an explicit retry, without reopening the wallet.
        await tester.pump(const Duration(seconds: 6));
        expect(repo.resumedActions, ['protection-result']);
        expect(repo.protectionCalls, 1);
        for (final card in tester.widgetList<TpSlEditorCard>(
          find.byType(TpSlEditorCard),
        )) {
          expect(card.onEnabledChanged, isNull);
        }

        final retried = Completer<void>();
        repo.resumeDelay = retried.future;
        await tester.ensureVisible(retry);
        await tester.tap(retry);
        await tester.pump();
        expect(find.text(message), findsNothing);
        expect(repo.resumedActions, ['protection-result', 'protection-result']);
        expect(repo.protectionCalls, 1);
        expect(
          tester.widget<FilledButton>(find.byType(FilledButton).last).onPressed,
          isNull,
        );
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        repo.protectionResult = const Hip3ActionSummary(
          actionId: 'protection-result',
          productId: 'xyz:TSLA',
          operation: 'manageTpsl',
          status: 'succeeded',
          effectsApplied: true,
          canResumePositionAction: false,
        );
        retried.complete();
        await tester.pump();
        for (
          var frame = 0;
          frame < 10 && find.byType(PositionTpSlSheet).evaluate().isNotEmpty;
          frame++
        ) {
          await tester.pump(const Duration(milliseconds: 100));
        }
        expect(repo.protectionCalls, 1);
        expect(find.byType(PositionTpSlSheet), findsNothing);
        expect(find.text('Confirmed'), findsOneWidget);
        expect(tester.takeException(), isNull);
      },
    );
  }

  for (final initiallyPending in [false, true]) {
    testWidgets(
      'protection success closes the sheet and uses the existing toast, initiallyPending=$initiallyPending',
      (tester) async {
        addTearDown(AppToast.dismiss);
        final parameters = Hip3ProtectionParameters(
          role: 'takeProfit',
          triggerPrice: DecimalValue('111'),
        );
        Hip3ActionSummary result(String status) => Hip3ActionSummary(
          actionId: 'protection-result',
          productId: 'xyz:TSLA',
          operation: 'manageTpsl',
          status: status == 'confirmed' ? 'succeeded' : 'reconciling',
          effectsApplied: status == 'confirmed',
          canResumePositionAction: status != 'confirmed',
          protectionResultsComplete: status == 'confirmed',
          protectionOrders: [
            Hip3ProtectionOrderResult(
              stepId: 'place',
              changeIndex: 0,
              orderId: 'new-tp',
              protection: parameters,
              status: status,
              isCancellation: false,
            ),
          ],
        );
        final completed = result('confirmed');
        final repo = _Positions()
          ..protectionResult = initiallyPending
              ? result('acknowledged')
              : completed;
        final refreshed = Completer<Hip3ActionSummary>();
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              positionsRepositoryProvider.overrideWithValue(repo),
              hip3ProtectionActionProvider('protection-result')
                  .overrideWith((_) => refreshed.future),
            ],
            child: buildTestApp(
              Builder(
                builder: (context) => FilledButton(
                  onPressed: () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => PositionTpSlSheet(
                      position: _position(withProtection: false),
                    ),
                  ),
                  child: const Text('Open protection'),
                ),
              ),
            ),
          ),
        );
        await tester.tap(find.text('Open protection'));
        await tester.pumpAndSettle();
        await tester.enterText(
          find.byKey(const Key('position-protection-take-profit')),
          '111',
        );
        final submit = find.widgetWithText(FilledButton, 'Sign and confirm');
        await tester.ensureVisible(submit);
        await tester.tap(submit);
        await tester.pump();
        await tester.pump(const Duration(milliseconds: 500));
        await tester.pump();

        expect(repo.protectionCalls, 1);
        expect(repo.protectionConfirmBeforeSigning, isFalse);
        expect(find.byType(AlertDialog), findsNothing);
        if (initiallyPending) {
          expect(find.byType(PositionTpSlSheet), findsOneWidget);
          expect(find.text('Protection order results'), findsNothing);
          expect(find.byType(Hip3ProtectionOrderResults), findsNothing);
          expect(find.text('Waiting for confirmation'), findsNothing);
          expect(find.text('Check progress'), findsNothing);
          expect(find.text('protection-result'), findsNothing);
          expect(find.text('new-tp'), findsNothing);
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          expect(find.text('Confirmed'), findsNothing);
          refreshed.complete(completed);
          await tester.pump();
          for (
            var frame = 0;
            frame < 10 && find.byType(PositionTpSlSheet).evaluate().isNotEmpty;
            frame++
          ) {
            await tester.pump(const Duration(milliseconds: 100));
          }
        }

        expect(find.byType(PositionTpSlSheet), findsNothing);
        expect(find.text('Protection order results'), findsNothing);
        expect(find.text('Confirmed'), findsOneWidget);
        expect(find.text('Open protection'), findsOneWidget);
        await tester.pump(const Duration(seconds: 3));
        await tester.pump();
        expect(find.text('Confirmed'), findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets(
    'existing multiple TP orders are preserved when adding protection',
    (tester) async {
      final repo = _Positions();
      final position = _position(
        withProtection: false,
        protectionOrders: [
          for (final (id, price) in [('tp-first', '110'), ('tp-second', '120')])
            Hip3PositionProtectionOrder(
              orderId: id,
              protection: Hip3ProtectionParameters(
                role: 'takeProfit',
                triggerPrice: DecimalValue(price),
              ),
            ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(PositionTpSlSheet(position: position)),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(DropdownButtonFormField<String>), findsNothing);
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        '130',
      );
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();
      expect(repo.protectionChanges, hasLength(1));
      final create = repo.protectionChanges.singleWhere(
        (change) => change.operation == ProtectionChangeOperation.create,
      );
      expect(create.orderId, isNull);
      expect(create.protection!.triggerPrice.value, '130');
      expect(create.protection!.quantity, isNull);
    },
  );

  testWidgets(
    'existing protection is not read or prefilled when adding protection',
    (tester) async {
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
      for (final key in [
        'position-protection-take-profit',
        'position-protection-stop-loss',
      ]) {
        expect(
          tester.widget<TextField>(find.byKey(Key(key))).controller!.text,
          '',
        );
      }
      expect(find.text('Take Profit & stop loss'), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsNothing);
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
            .widget<Slider>(
              find.byKey(const Key('protection-percentage-slider')),
            )
            .value,
        100,
      );
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        '131',
      );
      await tester.ensureVisible(
        find.widgetWithText(FilledButton, 'Sign and confirm'),
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
      await tester.pumpAndSettle();
      expect(repo.quantity, isNull);
      expect(repo.takeProfit, '131');
      expect(repo.stopLoss, isNull);
      expect(repo.protectionChanges, hasLength(1));
      expect(
        repo.protectionChanges.single.operation,
        ProtectionChangeOperation.create,
      );
      expect(repo.protectionChanges.single.orderId, isNull);
    },
  );

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
      final notice = find.byKey(const Key('position-settings-error'));
      final button = find.widgetWithText(FilledButton, 'Sign and confirm');
      expect(tester.getTopLeft(button).dy - tester.getBottomLeft(notice).dy, 8);
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
      final notice = find.byKey(const Key('close-error'));
      expect(
        tester.getTopLeft(find.byKey(const Key('close-review'))).dy -
            tester.getBottomLeft(notice).dy,
        8,
      );
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
    'close conflict refreshes the authoritative position before another preview',
    (tester) async {
      final initial = _position();
      final refreshed = _position(positionVersion: 'v2', quantity: '0.5');
      final repo = _Positions()
        ..currentPosition = refreshed
        ..closeError = const ServerFailure(
          statusCode: 409,
          code: 'close_preview_binding_changed',
          message: 'The close action no longer matches the position or signer. Request a new preview.',
        );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: initial)),
        ),
      );
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.75');
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      await _settleClosePreview(tester);
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pumpAndSettle();

      expect(repo.getCalls, 1);
      expect(find.text('Balance: 0.5'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('close-review')))
            .onPressed,
        isNull,
      );

      await tester.enterText(find.byKey(const Key('close-quantity')), '0.25');
      await _settleClosePreview(tester);
      expect(repo.previewRequests.last.position, same(refreshed));
      expect(repo.previewRequests.last.position.positionVersion, 'v2');
    },
  );

  testWidgets(
    'close preview polls but submit keeps the preview rendered at tap time',
    (tester) async {
      final refreshed = Completer<PositionClosePreview>();
      final repo = _Positions()..previewCallCompletions[2] = refreshed;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
        ),
      );
      await tester.enterText(find.byKey(const Key('close-quantity')), '0.5');
      await tester.ensureVisible(find.byKey(const Key('close-review')));
      await _settleClosePreview(tester);
      expect(repo.previewRequests, hasLength(1));

      await tester.pump(const Duration(seconds: 5));
      await tester.pump(const Duration(milliseconds: 301));
      expect(repo.previewRequests, hasLength(2));
      expect(repo.previewKeys.toSet(), hasLength(2));
      expect(
        tester
            .widget<FilledButton>(find.byKey(const Key('close-review')))
            .onPressed,
        isNotNull,
      );

      refreshed.complete(_closePreview('0.5', previewId: 'preview-refreshed'));
      await tester.idle();
      await tester.tap(find.byKey(const Key('close-review')));
      await tester.pumpAndSettle();

      expect(repo.closeCalls, 1);
      expect(repo.closePreview?.previewId, 'preview-0.5');
    },
  );

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
      await tester.pumpAndSettle();
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

  testWidgets('close quantity uses the product size decimals', (tester) async {
    final repo = _Positions()..sizeDecimalsValue = 2;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(Hip3ClosePositionSheet(position: _position())),
      ),
    );
    await tester.pumpAndSettle();

    final quantity = find.byKey(const Key('close-quantity'));
    await tester.enterText(quantity, '0.1234');
    await _settleClosePreview(tester);

    expect(tester.widget<TextField>(quantity).controller!.text, '0.12');
    expect(repo.previewRequests.single.quantity, '0.12');
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
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 1050)),
      );
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
    testWidgets(
      'disabled new protection leaves existing orders unchanged, both=$both',
      (tester) async {
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
        expect(repo.protectionCalls, 0);
        expect(repo.protectionChanges, isEmpty);
        expect(repo.takeProfit, isNull);
        expect(repo.stopLoss, isNull);
      },
    );
  }

  for (final price in ['', '0', '0.00']) {
    for (final scope in ProtectionClearScope.values) {
      testWidgets(
        'unset new trigger "$price" preserves existing ${scope.name}',
        (tester) async {
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
          await tester.tap(
            find.widgetWithText(FilledButton, 'Sign and confirm'),
          );
          await tester.pumpAndSettle();

          expect(repo.protectionCalls, 0);
          expect(repo.protectionChanges, isEmpty);
          expect(repo.takeProfit, null);
          expect(repo.stopLoss, null);
          expect(find.byType(TpSlInlineError), findsNothing);
        },
      );
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

    expect(repo.protectionCalls, 0);
    expect(repo.protectionChanges, isEmpty);
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
    await tester.enterText(
      find.byKey(const Key('position-protection-take-profit')),
      '111',
    );
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
      expect(
        tester.widget<InlineErrorNotice>(notice).message,
        '止盈: 请输入有效的正数价格。',
      );
      final button = find.widgetWithText(FilledButton, '签名并确认');
      expect(tester.getTopLeft(button).dy - tester.getBottomLeft(notice).dy, 8);
    });
  }

  testWidgets('malformed fixed protection quantity edit is rejected', (
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
    final quantity = find.byKey(const Key('protection-quantity'));
    await tester.ensureVisible(quantity);
    final initial = tester.widget<TextField>(quantity).controller!.text;

    await tester.enterText(quantity, 'abc');
    await tester.pump();

    expect(tester.widget<TextField>(quantity).controller!.text, initial);
    expect(repo.protectionCalls, 0);
  });

  testWidgets('missing product context explains why protection is locked', (
    tester,
  ) async {
    final repo = _Positions();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(
          PositionTpSlSheet(position: _position(productId: null)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Trading service is unavailable. Try again in a moment.'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(
            find.widgetWithText(FilledButton, 'Sign and confirm'),
          )
          .onPressed,
      isNull,
    );
  });

  testWidgets('missing product context explains why close is locked', (
    tester,
  ) async {
    final repo = _Positions();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(
          Hip3ClosePositionSheet(position: _position(productId: null)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Trading service is unavailable. Try again in a moment.'),
      findsOneWidget,
    );
    expect(
      tester
          .widget<FilledButton>(find.byKey(const Key('close-review')))
          .onPressed,
      isNull,
    );
  });

  for (final quantity in ['', '0', '2']) {
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
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        '110',
      );
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

  testWidgets('adding protection never reads existing orders', (tester) async {
    final repo = _Positions();
    final position = _position(protectionIds: ['tp-1']);
    var reads = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(repo),
          positionProtectionOrdersProvider(position).overrideWith((_) async {
            reads++;
            throw const FormatException('Unsupported protection');
          }),
        ],
        child: buildTestApp(PositionTpSlSheet(position: position)),
      ),
    );
    await tester.pumpAndSettle();
    expect(reads, 0);
    expect(find.byType(TpSlInlineError), findsNothing);
    for (final (key, price) in [
      ('position-protection-take-profit', '110'),
      ('position-protection-stop-loss', '90'),
    ]) {
      expect(
        tester.widget<TextField>(find.byKey(Key(key))).controller!.text,
        '',
      );
      await tester.enterText(find.byKey(Key(key)), price);
    }
    await tester.ensureVisible(
      find.widgetWithText(FilledButton, 'Sign and confirm'),
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Sign and confirm'));
    await tester.pumpAndSettle();
    expect(reads, 0);
    expect(repo.protectionCalls, 1);
    expect(repo.protectionChanges, hasLength(2));
    for (final change in repo.protectionChanges) {
      expect(change.operation, ProtectionChangeOperation.create);
      expect(change.orderId, isNull);
    }
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
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        '111',
      );
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
    expect(find.byType(DropdownButtonFormField<String>), findsNothing);
    expect(find.byKey(const Key('tpsl-risk-checkbox')), findsOneWidget);
    expect(find.byKey(const Key('tpsl-risk-details')), findsOneWidget);
    expect(find.textContaining('position size at trigger time'), findsNothing);
    expect(
      find.textContaining('Trigger execution needs no new signature.'),
      findsNothing,
    );
  });

  for (final (side, label) in [
    (PositionSide.long, 'Long'),
    (PositionSide.short, 'Short'),
    (PositionSide.none, '—'),
  ]) {
    testWidgets('position TP/SL labels the ${side.name} position as $label', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            positionsRepositoryProvider.overrideWithValue(_Positions()),
          ],
          child: buildTestApp(
            PositionTpSlSheet(position: _position(side: side)),
          ),
        ),
      );

      expect(find.text(label), findsOneWidget);
      expect(find.text('Buy'), findsNothing);
      expect(find.text('Sell'), findsNothing);
    });
  }

  for (final short in [false, true]) {
    testWidgets(
      'default 100% protection displays the full ${short ? 'short' : 'long'} position quantity',
      (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              positionsRepositoryProvider.overrideWithValue(_Positions()),
            ],
            child: buildTestApp(
              PositionTpSlSheet(
                position: _position(short: short, quantity: '1.2345'),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        final quantity = tester.widget<TextField>(
          find.byKey(const Key('protection-quantity')),
        );
        expect(quantity.controller!.text, '1.2345');
        expect(
          tester
              .widget<Slider>(
                find.byKey(const Key('protection-percentage-slider')),
              )
              .value,
          100,
        );
      },
    );
  }

  testWidgets('quantity input stays above the keyboard in the bottom sheet', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(393, 760);
    addTearDown(() {
      tester.view.resetDevicePixelRatio();
      tester.view.resetPhysicalSize();
      tester.view.resetViewInsets();
    });
    final position = _position();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          positionsRepositoryProvider.overrideWithValue(_Positions()),
        ],
        child: buildTestApp(
          Builder(
            builder: (context) => FilledButton(
              onPressed: () => showModalBottomSheet<void>(
                context: context,
                isScrollControlled: true,
                builder: (_) => PositionTpSlSheet(position: position),
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    final quantity = find.byKey(const Key('protection-quantity'));
    await tester.tap(quantity);
    await tester.pump();

    const keyboardHeight = 300.0;
    tester.view.viewInsets = const FakeViewPadding(bottom: keyboardHeight);
    await tester.pumpAndSettle();

    final keyboardTop = tester.view.physicalSize.height - keyboardHeight;
    expect(tester.getBottomLeft(quantity).dy, lessThanOrEqualTo(keyboardTop));
    expect(tester.takeException(), isNull);
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
        await tester.enterText(
          find.byKey(const Key('position-protection-take-profit')),
          short ? '90' : '110',
        );
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
        if (percentage == 100) {
          expect(
            tester
                .widget<TextField>(find.byKey(const Key('protection-quantity')))
                .controller!
                .text,
            '1',
          );
        }

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
      await tester.enterText(
        find.byKey(const Key('position-protection-take-profit')),
        '110',
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

  testWidgets('protection quantity uses the product size decimals', (
    tester,
  ) async {
    final repo = _Positions()..sizeDecimalsValue = 2;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(PositionTpSlSheet(position: _position())),
      ),
    );
    await tester.pumpAndSettle();

    final quantity = find.byKey(const Key('protection-quantity'));
    await tester.ensureVisible(quantity);
    await tester.enterText(quantity, '0.1234');
    await tester.pump();

    expect(tester.widget<TextField>(quantity).controller!.text, '0.12');
  });

  testWidgets('100% protection keeps the product size decimals', (
    tester,
  ) async {
    final repo = _Positions()..sizeDecimalsValue = 2;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [positionsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(
          PositionTpSlSheet(position: _position(quantity: '1.2345')),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final slider = find.byKey(const Key('protection-percentage-slider'));
    await tester.ensureVisible(slider);
    final rect = tester.getRect(slider);
    await tester.tapAt(Offset(rect.left + rect.width * 0.2, rect.center.dy));
    await tester.pumpAndSettle();
    await tester.tapAt(Offset(rect.right - 1, rect.center.dy));
    await tester.pumpAndSettle();

    expect(tester.widget<Slider>(slider).value, 100);
    expect(
      tester
          .widget<TextField>(find.byKey(const Key('protection-quantity')))
          .controller!
          .text,
      '1.23',
    );
  });

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
  String? previewId,
  String value = '25',
  Duration lifetime = const Duration(minutes: 1),
  PositionSide side = PositionSide.short,
  TradingOrderType type = TradingOrderType.market,
  String? limitPrice,
}) => PositionClosePreview(
  previewId: previewId ?? 'preview-$quantity',
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
  String? productId = 'xyz:TSLA',
  bool short = false,
  PositionSide? side,
  bool withProtection = true,
  String mark = '100',
  String? entry,
  String positionVersion = 'v1',
  String quantity = '1',
  List<String> protectionIds = const [],
  List<Hip3PositionProtectionOrder>? protectionOrders,
}) => Position(
  positionId: 'p-tsla',
  productId: productId,
  positionVersion: positionVersion,
  protectionOrderIds: protectionIds,
  protectionOrders:
      protectionOrders ??
      (withProtection && protectionIds.isEmpty
          ? [
              for (final role in ['takeProfit', 'stopLoss'])
                Hip3PositionProtectionOrder(
                  orderId: role == 'takeProfit' ? 'tp-1' : 'sl-1',
                  protection: Hip3ProtectionParameters(
                    role: role,
                    triggerPrice: DecimalValue(
                      (role == 'takeProfit') != short ? '110' : '90',
                    ),
                  ),
                ),
            ]
          : const []),
  symbol: 'TSLA',
  kind: MarketProductKind.perp,
  side: side ?? (short ? PositionSide.short : PositionSide.long),
  quantity: DecimalValue(
    (side ?? (short ? PositionSide.short : PositionSide.long)) ==
            PositionSide.short
        ? '-$quantity'
        : quantity,
  ),
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
  TradingSide side = TradingSide.long,
  TakeProfitStopLoss? tpSl,
  String executionType = 'market',
  String limitPrice = '130',
  String activationStatus = 'unknown',
  String? warningCode,
  TradingOrderStatus status = TradingOrderStatus.open,
}) => TradingOrder(
  orderId: id,
  productId: 'xyz:TSLA',
  positionId: 'p-tsla',
  symbol: 'TSLA',
  kind: MarketProductKind.perp,
  side: conditional ? TradingSide.short : side,
  tpSl: tpSl,
  type: TradingOrderType.limit,
  status: status,
  createdAt: DateTime.utc(2026),
  quantity: DecimalValue('1'),
  limitPrice: executionType == 'limit' ? DecimalValue(limitPrice) : null,
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
  Position currentPosition = _position();
  int getCalls = 0;
  int sizeDecimalsValue = 8;

  @override
  Future<int> sizeDecimals(String productId) async => sizeDecimalsValue;

  @override
  Future<Position> get(String positionId) async {
    getCalls++;
    return currentPosition;
  }

  Object? previewError;
  final previewRequests = <PositionClosePreviewRequest>[];
  final previewKeys = <String>[];
  final previewCompletions = <String, Completer<PositionClosePreview>>{};
  final previewCallCompletions = <int, Completer<PositionClosePreview>>{};
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
    final callCompletion = previewCallCompletions[previewRequests.length];
    if (callCompletion != null) return callCompletion.future;
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
  List<Hip3ProtectionChange> protectionChanges = const [];
  Object? protectionError;
  Hip3ActionSummary? protectionResult;
  bool? protectionConfirmBeforeSigning;
  int protectionReads = 0;
  final resumedActions = <String>[];
  Future<void>? resumeDelay;

  @override
  Future<Hip3ActionSummary> hip3Action(String actionId) async {
    protectionReads++;
    return protectionResult!;
  }

  @override
  Future<void> resumeHip3Action(String actionId) async {
    resumedActions.add(actionId);
    await resumeDelay;
  }

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
  Future<Hip3ActionSummary> manageTpSl(
    Position position, {
    required List<Hip3ProtectionChange> changes,
    required String idempotencyKey,
    bool confirmBeforeSigning = true,
  }) async {
    protectionConfirmBeforeSigning = confirmBeforeSigning;
    String? take, stop, takeLimit, stopLimit, quantity;
    final cancelled = <String>[];
    protectionChanges = List.unmodifiable(changes);
    for (final change in changes) {
      if (change.operation == ProtectionChangeOperation.cancel) {
        final order = position.protectionOrders
            .where((order) => order.orderId == change.orderId)
            .firstOrNull;
        cancelled.add(
          order?.protection.role ??
              (change.orderId!.startsWith('tp') ? 'takeProfit' : 'stopLoss'),
        );
      } else {
        final parameters = change.protection!;
        quantity = parameters.quantity?.value;
        if (parameters.role == 'takeProfit') {
          take = parameters.triggerPrice.value;
          takeLimit = parameters.limitPrice?.value;
        } else {
          stop = parameters.triggerPrice.value;
          stopLimit = parameters.limitPrice?.value;
        }
      }
    }
    await updateTpSl(
      position,
      takeProfit: take,
      takeLimit: takeLimit,
      stopLoss: stop,
      stopLimit: stopLimit,
      quantity: quantity,
      clearScope: cancelled.length == 2
          ? ProtectionClearScope.both
          : cancelled.contains('takeProfit')
          ? ProtectionClearScope.takeProfit
          : cancelled.contains('stopLoss')
          ? ProtectionClearScope.stopLoss
          : null,
      idempotencyKey: idempotencyKey,
    );
    return protectionResult ??
        Hip3ActionSummary(
          actionId: 'protection-result',
          productId: position.productId!,
          operation: 'manageTpsl',
          status: 'succeeded',
          effectsApplied: true,
          canResumePositionAction: false,
        );
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

class _CancellingHip3Orders implements Hip3OrderExecutionRepository {
  String? cancelledOrderId;
  Object? error;

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  }) async {
    cancelledOrderId = orderId;
    if (error case final failure?) throw failure;
    return ResourceResult(
      resource: _order(orderId, status: TradingOrderStatus.cancelled),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
