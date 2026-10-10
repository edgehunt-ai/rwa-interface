import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_platform_interface.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/data/repositories/bstocks_order_execution_repository_impl.dart';
import 'package:nobell/data/api/idempotency_key.dart';
import 'package:nobell/data/services/bstocks_broadcast_journal.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/repositories/bstocks_order_action_repository.dart';
import 'package:nobell/domain/repositories/orders_repository.dart';
import 'package:nobell/domain/services/embedded_wallet_transaction_sender.dart';
import 'package:nobell/domain/services/wallet_authorization_signer.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/domain/repositories/wallet_action_execution_repository.dart';
import 'package:nobell/data/services/bstocks_sponsored_execution_journal.dart';
import 'package:nobell/ui/features/orders/providers/order_providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  for (final sponsored in [false, true]) {
    test(
      'cancellation during ${sponsored ? 'authorization' : 'broadcast'} persistence sends nothing and permits retry',
      () async {
        var cancelled = false;
        final originalStore = SharedPreferencesStorePlatform.instance;
        final store = _MarkerStore(() => cancelled = true);
        SharedPreferencesStorePlatform.instance = store;
        addTearDown(
          () => SharedPreferencesStorePlatform.instance = originalStore,
        );
        final action = _action(
          orderId: 'order-1',
          stepId: 'swap-1',
          kind: BstocksOrderActionKind.executeIocOrder,
        );
        final current = _order('order-1', action: action);
        final orders = _ScriptedOrders(
          initial: current,
          refreshes: [
            current,
            current,
            _order('order-1', status: TradingOrderStatus.filled),
          ],
        );
        final actions = _Actions();
        final sender = _Sender();
        final signer = _Signer();
        final executions = _Executions(action, [
          _execution(
            action,
            WalletActionExecutionState.awaitingUserAuthorization,
          ),
          _execution(
            action,
            WalletActionExecutionState.awaitingUserAuthorization,
          ),
        ]);
        BstocksOrderExecutionRepositoryImpl repository() =>
            BstocksOrderExecutionRepositoryImpl(
              orders,
              actions,
              sponsored ? null : sender,
              sponsoredExecutions: sponsored ? executions : null,
              authorizationSigner: sponsored ? signer : null,
              broadcastJournal: BstocksBroadcastJournal.persistent(),
              sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
            );
        await expectLater(
          repository().executeExisting(
            order: ResourceResult(resource: current),
            isCancelled: () => cancelled,
          ),
          throwsA(isA<CancelledFailure>()),
        );
        expect(store.markerWrites, 1);
        expect(sender.steps, isEmpty);
        expect(executions.submitCalls, 0);
        expect(actions.steps, isEmpty);
        expect(
          await BstocksBroadcastJournal.persistent().transactionHash(action),
          isNull,
        );
        expect(
          await BstocksSponsoredExecutionJournal.persistent().submissionStarted(
            'execution-1',
          ),
          isFalse,
        );
        // Rebuild storage and repository as on a page/session reload.
        cancelled = false;
        store.onMarker = null;
        await (await SharedPreferences.getInstance()).reload();
        final result = await repository().executeExisting(
          order: ResourceResult(resource: current),
        );
        expect(result.resource.status, TradingOrderStatus.filled);
        expect(sender.steps, hasLength(sponsored ? 0 : 1));
        expect(executions.submitCalls, sponsored ? 1 : 0);
        if (sponsored) expect(executions.createKeys, hasLength(1));
      },
    );
  }

  test(
    'cancellation while broadcast is in flight preserves its hash for recovery',
    () async {
      var cancelled = false;
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final current = _order('order-1', action: action);
      final orders = _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          current,
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      );
      final actions = _Actions();
      final sender = _PendingSender();
      BstocksOrderExecutionRepositoryImpl repository() =>
          BstocksOrderExecutionRepositoryImpl(
            orders,
            actions,
            sender,
            broadcastJournal: BstocksBroadcastJournal.persistent(),
          );
      final request = repository().executeExisting(
        order: ResourceResult(resource: current),
        isCancelled: () => cancelled,
      );
      final assertion = expectLater(request, throwsA(isA<CancelledFailure>()));
      await sender.started.future;
      cancelled = true;
      sender.result.complete('0x${'ab' * 32}');
      await assertion;
      expect(actions.steps, isEmpty);
      await (await SharedPreferences.getInstance()).reload();
      expect(
        await BstocksBroadcastJournal.persistent().transactionHash(action),
        '0x${'ab' * 32}',
      );
      await repository().executeExisting(
        order: ResourceResult(resource: current),
      );
      expect(sender.calls, 1);
      expect(actions.transactionHashes, ['0x${'ab' * 32}']);
    },
  );

  test('cancellation after authorization POST begins keeps unknown submission locked', () async {
    var cancelled = false;
    final action = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.executeIocOrder,
    );
    final current = _order('order-1', action: action);
    final awaiting = _execution(
      action,
      WalletActionExecutionState.awaitingUserAuthorization,
    );
    final orders = _ScriptedOrders(
      initial: current,
      refreshes: [current, current],
    );
    final started = Completer<void>();
    final finish = Completer<void>();
    final executions =
        _Executions(action, [awaiting, awaiting, awaiting, awaiting, awaiting])
          ..submitFailure = const NetworkFailure()
          ..beforeSubmit = () {
            started.complete();
            return finish.future;
          };
    final signer = _Signer();
    BstocksOrderExecutionRepositoryImpl repository() =>
        BstocksOrderExecutionRepositoryImpl(
          orders,
          _Actions(),
          null,
          sponsoredExecutions: executions,
          authorizationSigner: signer,
          sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
          sponsoredReconciliationAttempts: 2,
          sponsoredReconciliationDelay: Duration.zero,
        );
    final assertion = expectLater(
      repository().executeExisting(
        order: ResourceResult(resource: current),
        isCancelled: () => cancelled,
      ),
      throwsA(isA<UnknownFailure>()),
    );
    await started.future;
    cancelled = true;
    finish.complete();
    await assertion;
    await (await SharedPreferences.getInstance()).reload();
    expect(
      await BstocksSponsoredExecutionJournal.persistent().submissionStarted(
        'execution-1',
      ),
      isTrue,
    );
    await expectLater(
      repository().executeExisting(order: ResourceResult(resource: current)),
      throwsA(isA<UnknownFailure>()),
    );
    expect(executions.submitCalls, 1);
    expect(signer.requests, hasLength(1));
  });

  test(
    'cancellation during execution creation saves identity without signing',
    () async {
      var cancelled = false;
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final current = _order('order-1', action: action);
      final orders = _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          current,
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      );
      final executions = _Executions(action, [
        _execution(
          action,
          WalletActionExecutionState.awaitingUserAuthorization,
        ),
      ])..onCreate = () => cancelled = true;
      final signer = _Signer();
      BstocksOrderExecutionRepositoryImpl repository() =>
          BstocksOrderExecutionRepositoryImpl(
            orders,
            _Actions(),
            null,
            sponsoredExecutions: executions,
            authorizationSigner: signer,
            sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
          );
      await expectLater(
        repository().executeExisting(
          order: ResourceResult(resource: current),
          isCancelled: () => cancelled,
        ),
        throwsA(isA<CancelledFailure>()),
      );
      expect(executions.getIds, isEmpty);
      expect(signer.requests, isEmpty);
      expect(executions.submitCalls, 0);
      await (await SharedPreferences.getInstance()).reload();
      expect(
        await BstocksSponsoredExecutionJournal.persistent().executionId(action),
        'execution-1',
      );
      await repository().executeExisting(
        order: ResourceResult(resource: current),
      );
      expect(executions.createKeys, hasLength(1));
      expect(executions.submitCalls, 1);
    },
  );

  for (final existingAction in [false, true]) {
    test(
      'session change during ${existingAction ? 'existing' : 'new'} cancellation signing prevents authorization POST',
      () async {
        // Focused provider-to-data boundary regression using the real executor.
        final action = _action(
          orderId: 'order-1',
          stepId: 'cancel-1',
          kind: BstocksOrderActionKind.cancelOrder,
        );
        final open = _order('order-1', status: TradingOrderStatus.open);
        final cancelling = _order(
          'order-1',
          status: TradingOrderStatus.open,
          action: action,
        );
        final orders = _ScriptedOrders(
          initial: open,
          refreshes: existingAction ? [cancelling] : [open, cancelling],
        )..cancelResult = cancelling;
        final executions = _Executions(action, [
          _execution(
            action,
            WalletActionExecutionState.awaitingUserAuthorization,
          ),
        ]);
        final signer = _PendingSigner();
        final repository = BstocksOrderExecutionRepositoryImpl(
          orders,
          _Actions()..currentAction = action,
          null,
          sponsoredExecutions: executions,
          authorizationSigner: signer,
        );
        final container = ProviderContainer(
          overrides: [
            bstocksOrderExecutionRepositoryProvider.overrideWithValue(
              repository,
            ),
          ],
        );
        addTearDown(container.dispose);
        final subscription = container.listen(orderCommandProvider, (_, _) {});
        addTearDown(subscription.close);
        final request = container
            .read(orderCommandProvider.notifier)
            .cancel(open);
        final assertion = expectLater(request, completes);
        await signer.started.future;
        container.read(sessionGenerationProvider.notifier).clearUserScope();
        container.read(orderCommandProvider);
        signer.result.complete('old-session-signature');
        await assertion;
        expect(executions.submitCalls, 0);
        expect(orders.cancelKeys, hasLength(existingAction ? 0 : 1));
      },
    );
  }

  test('cancellation during order read prevents DELETE', () async {
    var cancelled = false;
    final open = _order('order-1', status: TradingOrderStatus.open);
    final orders = _ScriptedOrders(initial: open, refreshes: [open])
      ..onGet = () => cancelled = true;
    await expectLater(
      BstocksOrderExecutionRepositoryImpl(
        orders,
        _Actions(),
        _Sender(),
      ).cancelOrder('order-1', isCancelled: () => cancelled),
      throwsA(isA<CancelledFailure>()),
    );
    expect(orders.cancelKeys, isEmpty);
  });

  for (final failure in <ApiFailure>[
    const AuthenticationFailure(),
    const ServerFailure(statusCode: 403, code: 'forbidden'),
    const ServerFailure(statusCode: 429, code: 'rate_limited', retryable: true),
  ]) {
    test(
      'a pre-relay ${failure.kind.name} rejection permits a new submission after reconstruction',
      () async {
        final action = _action(
          orderId: 'order-1',
          stepId: 'swap-1',
          kind: BstocksOrderActionKind.executeIocOrder,
        );
        final current = _order('order-1', action: action);
        final awaiting = _execution(
          action,
          WalletActionExecutionState.awaitingUserAuthorization,
        );
        final orders = _ScriptedOrders(
          initial: current,
          refreshes: [
            current,
            current,
            _order('order-1', status: TradingOrderStatus.filled),
          ],
        );
        final executions = _Executions(action, [awaiting, awaiting])
          ..submitFailure = failure;
        final signer = _ChangingSigner();
        BstocksOrderExecutionRepositoryImpl repository() =>
            BstocksOrderExecutionRepositoryImpl(
              orders,
              _Actions(),
              null,
              sponsoredExecutions: executions,
              authorizationSigner: signer,
              sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
            );
        await expectLater(
          repository().executeExisting(
            order: ResourceResult(resource: current),
          ),
          throwsA(same(failure)),
        );
        expect(
          await BstocksSponsoredExecutionJournal.persistent().submissionStarted(
            'execution-1',
          ),
          isFalse,
        );
        executions.submitFailure = null;
        final result = await repository().executeExisting(
          order: ResourceResult(resource: current),
        );
        expect(result.resource.status, TradingOrderStatus.filled);
        expect(executions.createKeys, hasLength(1));
        expect(executions.getIds, ['execution-1', 'execution-1']);
        expect(executions.submitCalls, 2);
        expect(executions.submitSignatures, ['signature-1', 'signature-2']);
        expect(executions.submitKeys.toSet(), hasLength(2));
        expect(signer.requests, hasLength(2));
      },
    );
  }

  for (final failure in <ApiFailure>[
    const NetworkFailure(),
    const TimeoutFailure(),
    const DecodingFailure(),
    const ServerFailure(statusCode: 409, code: 'execution_in_progress'),
    const ServerFailure(statusCode: 422, code: 'execution_rejected'),
    const ServerFailure(statusCode: 503, code: 'provider_unavailable'),
  ]) {
    test(
      'a ${failure.kind.name} submission failure without pre-relay proof stays locked',
      () async {
        final action = _action(
          orderId: 'order-1',
          stepId: 'swap-1',
          kind: BstocksOrderActionKind.executeIocOrder,
        );
        final current = _order('order-1', action: action);
        final awaiting = _execution(
          action,
          WalletActionExecutionState.awaitingUserAuthorization,
        );
        final orders = _ScriptedOrders(
          initial: current,
          refreshes: [current, current],
        );
        final executions = _Executions(action, [awaiting, awaiting, awaiting])
          ..submitFailure = failure;
        final signer = _Signer();
        BstocksOrderExecutionRepositoryImpl repository() =>
            BstocksOrderExecutionRepositoryImpl(
              orders,
              _Actions(),
              null,
              sponsoredExecutions: executions,
              authorizationSigner: signer,
              sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
              sponsoredReconciliationAttempts: 1,
              sponsoredReconciliationDelay: Duration.zero,
            );
        await expectLater(
          repository().executeExisting(
            order: ResourceResult(resource: current),
          ),
          throwsA(isA<UnknownFailure>()),
        );
        expect(
          await BstocksSponsoredExecutionJournal.persistent().submissionStarted(
            'execution-1',
          ),
          isTrue,
        );
        executions.submitFailure = null;
        await expectLater(
          repository().executeExisting(
            order: ResourceResult(resource: current),
          ),
          throwsA(isA<UnknownFailure>()),
        );
        expect(executions.createKeys, hasLength(1));
        expect(executions.submitCalls, 1);
        expect(signer.requests, hasLength(1));
      },
    );
  }
  for (final status in [
    TradingOrderStatus.filled,
    TradingOrderStatus.manualReview,
  ]) {
    test(
      'an initial replay uses current order $status before signing',
      () async {
        final stale = _order(
          'order-1',
          action: _action(
            orderId: 'order-1',
            stepId: 'swap-1',
            kind: BstocksOrderActionKind.executeIocOrder,
          ),
        );
        final orders = _ScriptedOrders(
          initial: stale,
          refreshes: [_order('order-1', status: status)],
        );
        final sender = _Sender();
        final actions = _Actions();
        final request =
            BstocksOrderExecutionRepositoryImpl(
              orders,
              actions,
              sender,
            ).execute(
              intent: _intent(),
              created: ResourceResult(resource: stale),
              previewId: 'preview-1',
            );
        if (status == TradingOrderStatus.filled) {
          expect((await request).resource.status, status);
        } else {
          await expectLater(request, throwsA(isA<UnknownFailure>()));
        }
        expect(sender.steps, isEmpty);
        expect(actions.steps, isEmpty);
      },
    );
  }

  test(
    'an embedded awaiting action cannot override current manual review',
    () async {
      final stale = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final current = _order('order-1', action: stale);
      final actions = _Actions()
        ..currentAction = _action(
          orderId: 'order-1',
          stepId: 'swap-1',
          kind: stale.kind,
          status: BstocksOrderActionStatus.manualReview,
        );
      final sender = _Sender();
      await expectLater(
        BstocksOrderExecutionRepositoryImpl(
          _ScriptedOrders(initial: current, refreshes: [current]),
          actions,
          sender,
        ).executeExisting(order: ResourceResult(resource: current)),
        throwsA(isA<UnknownFailure>()),
      );
      expect(sender.steps, isEmpty);
    },
  );

  test(
    'a cancellation replay cannot restore permission after cancellation',
    () async {
      final orders =
          _ScriptedOrders(
              initial: _order('order-1'),
              refreshes: [
                _order('order-1', status: TradingOrderStatus.open),
                _order('order-1', status: TradingOrderStatus.cancelled),
              ],
            )
            ..cancelResult = _order(
              'order-1',
              status: TradingOrderStatus.open,
              action: _action(
                orderId: 'order-1',
                stepId: 'cancel-1',
                kind: BstocksOrderActionKind.cancelOrder,
              ),
            );
      final sender = _Sender();
      final result = await BstocksOrderExecutionRepositoryImpl(
        orders,
        _Actions(),
        sender,
      ).cancelOrder('order-1');
      expect(result.resource.status, TradingOrderStatus.cancelled);
      expect(sender.steps, isEmpty);
    },
  );

  for (final status in [
    WalletActionExecutionState.submitting,
    WalletActionExecutionState.providerSubmitted,
    WalletActionExecutionState.chainConfirmed,
    WalletActionExecutionState.completed,
    WalletActionExecutionState.ambiguous,
    WalletActionExecutionState.manualReview,
    WalletActionExecutionState.failed,
  ]) {
    test(
      'sponsored replay reads current $status without signing again',
      () async {
        final action = _action(
          orderId: 'order-1',
          stepId: 'swap-1',
          kind: BstocksOrderActionKind.executeIocOrder,
        );
        final current = _order('order-1', action: action);
        final executions = _Executions(action, [_execution(action, status)]);
        final signer = _Signer();
        final request = BstocksOrderExecutionRepositoryImpl(
          _ScriptedOrders(
            initial: current,
            refreshes: [
              current,
              _order('order-1', status: TradingOrderStatus.filled),
            ],
          ),
          _Actions(),
          null,
          sponsoredExecutions: executions,
          authorizationSigner: signer,
        ).executeExisting(order: ResourceResult(resource: current));
        if ([
          WalletActionExecutionState.failed,
          WalletActionExecutionState.ambiguous,
          WalletActionExecutionState.manualReview,
        ].contains(status)) {
          await expectLater(request, throwsA(isA<UnknownFailure>()));
        } else {
          expect((await request).resource.status, TradingOrderStatus.filled);
        }
        expect(executions.getIds, ['execution-1']);
        expect(signer.requests, isEmpty);
        expect(executions.submitCalls, 0);
      },
    );
  }

  test(
    'lost sponsored submission is reconciled without reconstruction',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final current = _order('order-1', action: action);
      final orders = _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          current,
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      );
      final executions = _Executions(action, [
        _execution(
          action,
          WalletActionExecutionState.awaitingUserAuthorization,
        ),
        const NetworkFailure(),
        _execution(action, WalletActionExecutionState.providerSubmitted),
      ])..submitFailure = const NetworkFailure();
      final signer = _Signer();
      BstocksOrderExecutionRepositoryImpl repository() =>
          BstocksOrderExecutionRepositoryImpl(
            orders,
            _Actions(),
            null,
            sponsoredExecutions: executions,
            authorizationSigner: signer,
            sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
            sponsoredReconciliationAttempts: 2,
            sponsoredReconciliationDelay: Duration.zero,
          );
      final result = await repository().executeExisting(
        order: ResourceResult(resource: current),
      );
      expect(result.resource.status, TradingOrderStatus.filled);
      expect(executions.createKeys, hasLength(1));
      expect(executions.submitCalls, 1);
      expect(signer.requests, hasLength(1));
      expect(signer.requests.single.headers['payload'], 'current');
    },
  );

  test(
    'uncertain sponsored submission cannot re-sign an awaiting snapshot',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final current = _order('order-1', action: action);
      final journal = BstocksSponsoredExecutionJournal.persistent();
      await journal.saveExecutionId(action, 'execution-1');
      await journal.markSubmissionStarted('execution-1');
      final executions = _Executions(action, [
        _execution(
          action,
          WalletActionExecutionState.awaitingUserAuthorization,
        ),
      ]);
      final signer = _Signer();
      await expectLater(
        BstocksOrderExecutionRepositoryImpl(
          _ScriptedOrders(initial: current, refreshes: [current]),
          _Actions(),
          null,
          sponsoredExecutions: executions,
          authorizationSigner: signer,
          sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
          sponsoredReconciliationAttempts: 1,
          sponsoredReconciliationDelay: Duration.zero,
        ).executeExisting(order: ResourceResult(resource: current)),
        throwsA(isA<UnknownFailure>()),
      );
      expect(signer.requests, isEmpty);
      expect(executions.createKeys, isEmpty);
    },
  );

  test(
    'lost sponsored response is reconciled immediately when GET succeeds',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final current = _order('order-1', action: action);
      final executions = _Executions(action, [
        _execution(
          action,
          WalletActionExecutionState.awaitingUserAuthorization,
        ),
        _execution(action, WalletActionExecutionState.submitting),
      ])..submitFailure = const NetworkFailure();
      final signer = _Signer();
      final result = await BstocksOrderExecutionRepositoryImpl(
        _ScriptedOrders(
          initial: current,
          refreshes: [
            current,
            _order('order-1', status: TradingOrderStatus.filled),
          ],
        ),
        _Actions(),
        null,
        sponsoredExecutions: executions,
        authorizationSigner: signer,
      ).executeExisting(order: ResourceResult(resource: current));
      expect(result.resource.status, TradingOrderStatus.filled);
      expect(signer.requests, hasLength(1));
      expect(executions.submitCalls, 1);
    },
  );

  for (final hidden in [false, true]) {
    test(
      'saved sponsored execution is observed with a blocker (hidden=$hidden)',
      () async {
        final action = _action(
          orderId: 'order-1',
          stepId: 'swap-1',
          kind: BstocksOrderActionKind.executeIocOrder,
        );
        final current = _order(
          'order-1',
          action: hidden ? null : action,
          currentActionId: action.actionId,
          walletActionBlocker: 'orderInFlight',
        );
        final journal = BstocksSponsoredExecutionJournal.persistent();
        await journal.saveExecutionId(action, 'execution-1');
        await journal.markSubmissionStarted('execution-1');
        final executions = _Executions(action, [
          _execution(action, WalletActionExecutionState.providerSubmitted),
        ]);
        final signer = _Signer();
        final result = await BstocksOrderExecutionRepositoryImpl(
          _ScriptedOrders(
            initial: current,
            refreshes: [
              current,
              _order('order-1', status: TradingOrderStatus.filled),
            ],
          ),
          _Actions()..currentAction = action,
          null,
          sponsoredExecutions: executions,
          authorizationSigner: signer,
          sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
        ).executeExisting(order: ResourceResult(resource: current));
        expect(result.resource.status, TradingOrderStatus.filled);
        expect(executions.getIds, ['execution-1']);
        expect(executions.createKeys, isEmpty);
        expect(signer.requests, isEmpty);
      },
    );
  }

  test(
    'a lost authorization response is reconciled without re-signing',
    () async {
      final approval = _action(
        orderId: 'order-1',
        stepId: 'approval-1',
        kind: BstocksOrderActionKind.erc20Approval,
      );
      final current = _order('order-1', action: approval);
      final approved = _order(
        'order-1',
        status: TradingOrderStatus.awaitingConfirmation,
        walletActionBlocker: 'previewRequired',
        currentActionId: approval.actionId,
      );
      final executions =
          _Executions(approval, [
              _execution(
                approval,
                WalletActionExecutionState.awaitingUserAuthorization,
              ),
              const NetworkFailure(userAction: 'Connection reset after POST'),
              _execution(approval, WalletActionExecutionState.completed),
            ])
            ..submitFailure = const NetworkFailure(
              userAction: 'Connection reset after POST',
            );
      final signer = _Signer();
      final result =
          await BstocksOrderExecutionRepositoryImpl(
            _ScriptedOrders(initial: current, refreshes: [current, approved]),
            _Actions()..currentAction = approval,
            null,
            sponsoredExecutions: executions,
            authorizationSigner: signer,
            sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
            sponsoredReconciliationDelay: Duration.zero,
          ).execute(
            intent: _intent(),
            created: ResourceResult(resource: current),
            previewId: 'preview-1',
            stopAfterApproval: true,
          );

      expect(result.resource.status, TradingOrderStatus.awaitingConfirmation);
      expect(executions.submitCalls, 1);
      expect(signer.requests, hasLength(1));
      expect(executions.getIds, ['execution-1', 'execution-1', 'execution-1']);
    },
  );

  test('restoring E never falls back to a direct sender when authorization signer is unavailable', () async {
    final action = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.executeIocOrder,
    );
    final current = _order(
      'order-1',
      action: action,
      walletActionBlocker: 'orderInFlight',
    );
    final journal = BstocksSponsoredExecutionJournal.persistent();
    await journal.saveExecutionId(action, 'execution-1');
    final executions = _Executions(action, [
      _execution(action, WalletActionExecutionState.providerSubmitted),
    ]);
    final sender = _Sender();
    final result = await BstocksOrderExecutionRepositoryImpl(
      _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      ),
      _Actions()..currentAction = action,
      sender,
      sponsoredExecutions: executions,
      sponsoredJournal: BstocksSponsoredExecutionJournal.persistent(),
    ).executeExisting(order: ResourceResult(resource: current));
    expect(result.resource.status, TradingOrderStatus.filled);
    expect(executions.getIds, ['execution-1']);
    expect(sender.steps, isEmpty);
  });
  test(
    'a stale continuation response cannot restore signing permission',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-2',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final orders = _ScriptedOrders(
        initial: _order('order-1'),
        refreshes: [
          _order('order-1', currentActionId: 'swap-2'),
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      );
      final actions = _Actions()
        ..createdAction = action
        ..currentAction = _action(
          orderId: 'order-1',
          stepId: 'swap-2',
          kind: BstocksOrderActionKind.executeIocOrder,
          status: BstocksOrderActionStatus.submitted,
        );
      final sender = _Sender();
      final result =
          await BstocksOrderExecutionRepositoryImpl(
            orders,
            actions,
            sender,
          ).continueOrder(
            intent: _intent(),
            orderId: 'order-1',
            previewId: 'preview-2',
          );
      expect(result.resource.status, TradingOrderStatus.filled);
      expect(actions.getCalls, 1);
      expect(sender.steps, isEmpty);
      expect(actions.steps, isEmpty);
    },
  );

  for (final status in [
    TradingOrderStatus.failed,
    TradingOrderStatus.manualReview,
    TradingOrderStatus.ambiguous,
  ]) {
    test('order $status cannot bypass action failure checks', () async {
      final sender = _Sender();
      await expectLater(
        BstocksOrderExecutionRepositoryImpl(
          _ScriptedOrders(
            initial: _order('order-1'),
            refreshes: [_order('order-1', status: status)],
          ),
          _Actions(),
          sender,
        ).executeExisting(
          order: ResourceResult(resource: _order('order-1', status: status)),
        ),
        throwsA(isA<UnknownFailure>()),
      );
      expect(sender.steps, isEmpty);
    });
  }

  test(
    'a lost submission recovers the persisted hash after reconstruction',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'cancel-1',
        kind: BstocksOrderActionKind.cancelOrder,
      );
      final current = _order(
        'order-1',
        status: TradingOrderStatus.open,
        action: action,
      );
      final orders = _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          current,
          _order('order-1', status: TradingOrderStatus.cancelled),
        ],
      );
      final actions = _Actions()..submitFailure = const NetworkFailure();
      final sender = _Sender();
      await expectLater(
        BstocksOrderExecutionRepositoryImpl(
          orders,
          actions,
          sender,
          broadcastJournal: BstocksBroadcastJournal.persistent(),
        ).cancelOrder('order-1'),
        throwsA(isA<NetworkFailure>()),
      );
      await BstocksOrderExecutionRepositoryImpl(
        orders,
        actions,
        null,
        broadcastJournal: BstocksBroadcastJournal.persistent(),
      ).cancelOrder('order-1');
      expect(sender.steps, hasLength(1));
      expect(actions.transactionHashes, hasLength(2));
      expect(actions.transactionHashes.toSet(), hasLength(1));
    },
  );

  test(
    'a hidden action recovers the original persisted hash without signing',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      await BstocksBroadcastJournal.persistent().broadcast(
        action,
        () async => '0xoriginal',
      );
      final orders = _ScriptedOrders(
        initial: _order('order-1'),
        refreshes: [
          _order('order-1', currentActionId: 'swap-1'),
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      );
      final actions = _Actions()..currentAction = action;
      final result =
          await BstocksOrderExecutionRepositoryImpl(
            orders,
            actions,
            null,
            broadcastJournal: BstocksBroadcastJournal.persistent(),
          ).executeExisting(
            order: ResourceResult(
              resource: _order('order-1', currentActionId: 'swap-1'),
            ),
          );
      expect(result.resource.status, TradingOrderStatus.filled);
      expect(actions.transactionHashes, ['0xoriginal']);
      expect(actions.getCalls, 1);
    },
  );

  test('a blocker prevents a fresh wallet broadcast', () async {
    final sender = _Sender();
    final actions = _Actions();
    await expectLater(
      BstocksOrderExecutionRepositoryImpl(
        _ScriptedOrders(
          initial: _order('order-1'),
          refreshes: [
            _order(
              'order-1',
              walletActionBlocker: 'orderInFlight',
              action: _action(
                orderId: 'order-1',
                stepId: 'swap-1',
                kind: BstocksOrderActionKind.executeIocOrder,
              ),
            ),
          ],
        ),
        actions,
        sender,
      ).executeExisting(
        order: ResourceResult(
          resource: _order(
            'order-1',
            walletActionBlocker: 'orderInFlight',
            action: _action(
              orderId: 'order-1',
              stepId: 'swap-1',
              kind: BstocksOrderActionKind.executeIocOrder,
            ),
          ),
        ),
      ),
      throwsA(isA<UnknownFailure>()),
    );
    expect(sender.steps, isEmpty);
    expect(actions.steps, isEmpty);
  });

  test(
    'an expired action reports its persisted hash despite a blocker',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
        validUntil: DateTime.utc(2020),
      );
      await BstocksBroadcastJournal.persistent().broadcast(
        action,
        () async => '0xoriginal',
      );
      final actions = _Actions()..currentAction = action;
      final result =
          await BstocksOrderExecutionRepositoryImpl(
            _ScriptedOrders(
              initial: _order('order-1'),
              refreshes: [
                _order(
                  'order-1',
                  action: action,
                  walletActionBlocker: 'orderInFlight',
                ),
                _order('order-1', status: TradingOrderStatus.filled),
              ],
            ),
            actions,
            null,
            broadcastJournal: BstocksBroadcastJournal.persistent(),
          ).executeExisting(
            order: ResourceResult(
              resource: _order(
                'order-1',
                action: action,
                walletActionBlocker: 'orderInFlight',
              ),
            ),
          );
      expect(result.resource.status, TradingOrderStatus.filled);
      expect(actions.transactionHashes, ['0xoriginal']);
    },
  );

  test('a failed order observed after broadcast is not accepted', () async {
    final action = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.executeIocOrder,
    );
    final sender = _Sender();
    await expectLater(
      BstocksOrderExecutionRepositoryImpl(
        _ScriptedOrders(
          initial: _order('order-1'),
          refreshes: [
            _order('order-1', action: action),
            _order('order-1', status: TradingOrderStatus.failed),
          ],
        ),
        _Actions(),
        sender,
      ).executeExisting(
        order: ResourceResult(resource: _order('order-1', action: action)),
      ),
      throwsA(isA<UnknownFailure>()),
    );
    expect(sender.steps, hasLength(1));
  });
  for (final status in [
    BstocksOrderActionStatus.failed,
    BstocksOrderActionStatus.manualReview,
  ]) {
    test(
      'a continuation action $status fails without signing or acceptance',
      () async {
        final action = _action(
          orderId: 'order-1',
          stepId: 'swap-2',
          kind: BstocksOrderActionKind.executeIocOrder,
          status: status,
        );
        final current = _order('order-1', action: action);
        final orders = _ScriptedOrders(initial: current, refreshes: [current]);
        final actions = _Actions()..createdAction = action;
        final sender = _Sender();
        await expectLater(
          BstocksOrderExecutionRepositoryImpl(
            orders,
            actions,
            sender,
          ).continueOrder(
            intent: _intent(),
            orderId: 'order-1',
            previewId: 'preview-2',
          ),
          throwsA(isA<UnknownFailure>()),
        );
        expect(sender.steps, isEmpty);
        expect(actions.steps, isEmpty);
        expect(orders.createCalls, 0);
      },
    );
  }

  test('continuation approval completes on the original order', () async {
    final approval = _action(
      orderId: 'order-1',
      stepId: 'approval-2',
      kind: BstocksOrderActionKind.erc20Approval,
    );
    final orders = _ScriptedOrders(
      initial: _order('order-1'),
      refreshes: [
        _order('order-1', action: approval),
        _order(
          'order-1',
          status: TradingOrderStatus.awaitingConfirmation,
          walletActionBlocker: 'previewRequired',
        ),
      ],
    );
    final actions = _Actions()..createdAction = approval;
    final sender = _Sender();
    final result =
        await BstocksOrderExecutionRepositoryImpl(
          orders,
          actions,
          sender,
        ).continueOrder(
          intent: _intent(),
          orderId: 'order-1',
          previewId: 'preview-2',
          stopAfterApproval: true,
        );
    expect(result.resource.orderId, 'order-1');
    expect(result.resource.status, TradingOrderStatus.awaitingConfirmation);
    expect(actions.createdPreviewIds, ['preview-2']);
    expect(sender.steps, hasLength(1));
    expect(actions.steps, ['approval-2']);
    expect(orders.createCalls, 0);
  });

  test(
    'lost cancel response replays the same command across executors',
    () async {
      final cancel = _action(
        orderId: 'order-1',
        stepId: 'cancel-1',
        kind: BstocksOrderActionKind.cancelOrder,
      );
      final orders =
          _ScriptedOrders(
              initial: _order('order-1'),
              refreshes: [
                _order('order-1', status: TradingOrderStatus.open),
                _order('order-1', status: TradingOrderStatus.open),
                _order(
                  'order-1',
                  status: TradingOrderStatus.open,
                  action: cancel,
                ),
                _order('order-1', status: TradingOrderStatus.cancelled),
              ],
            )
            ..cancelFailure = const NetworkFailure()
            ..cancelResult = _order(
              'order-1',
              action: cancel,
              status: TradingOrderStatus.open,
            );
      final actions = _Actions();
      await expectLater(
        BstocksOrderExecutionRepositoryImpl(
          orders,
          actions,
          _Sender(),
        ).cancelOrder('order-1'),
        throwsA(isA<NetworkFailure>()),
      );
      await BstocksOrderExecutionRepositoryImpl(
        orders,
        actions,
        _Sender(),
      ).cancelOrder('order-1');
      expect(orders.cancelKeys, [
        scopedIdempotencyKey('bstocks-cancel-order-1'),
        scopedIdempotencyKey('bstocks-cancel-order-1'),
      ]);
    },
  );

  test(
    'rejected signature resumes the existing cancel without a new DELETE',
    () async {
      final cancel = _action(
        orderId: 'order-1',
        stepId: 'cancel-1',
        kind: BstocksOrderActionKind.cancelOrder,
      );
      final current = _order(
        'order-1',
        action: cancel,
        status: TradingOrderStatus.open,
      );
      final orders = _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          current,
          _order('order-1', status: TradingOrderStatus.cancelled),
        ],
      );
      await expectLater(
        BstocksOrderExecutionRepositoryImpl(
          orders,
          _Actions(),
          _RejectingSender(),
        ).cancelOrder('order-1'),
        throwsA(isA<CancelledFailure>()),
      );
      final sender = _Sender();
      final actions = _Actions();
      await BstocksOrderExecutionRepositoryImpl(
        orders,
        actions,
        sender,
      ).cancelOrder('order-1');
      expect(orders.cancelKeys, isEmpty);
      expect(sender.steps, hasLength(1));
      expect(actions.steps, ['cancel-1']);
    },
  );

  test(
    'an old random-key cancellation conflict restores its original action',
    () async {
      final cancel = _action(
        orderId: 'order-1',
        stepId: 'legacy-cancel',
        kind: BstocksOrderActionKind.cancelOrder,
      );
      final orders =
          _ScriptedOrders(
              initial: _order('order-1'),
              refreshes: [
                _order('order-1', status: TradingOrderStatus.open),
                _order(
                  'order-1',
                  action: cancel,
                  status: TradingOrderStatus.open,
                ),
                _order(
                  'order-1',
                  action: cancel,
                  status: TradingOrderStatus.open,
                ),
                _order('order-1', status: TradingOrderStatus.cancelled),
              ],
            )
            ..cancelFailure = const ServerFailure(
              statusCode: 409,
              code: 'cancellation_in_progress',
            );
      final sender = _Sender();
      final actions = _Actions()..currentAction = cancel;
      final result = await BstocksOrderExecutionRepositoryImpl(
        orders,
        actions,
        sender,
      ).cancelOrder('order-1');
      expect(result.resource.status, TradingOrderStatus.cancelled);
      expect(sender.steps, hasLength(1));
      expect(actions.steps, ['legacy-cancel']);
      expect(orders.cancelKeys, hasLength(1));
    },
  );

  test('a definitely failed cancel permits a distinct new command', () async {
    final old = _action(
      orderId: 'order-1',
      stepId: 'cancel-old',
      kind: BstocksOrderActionKind.cancelOrder,
    );
    final next = _action(
      orderId: 'order-1',
      stepId: 'cancel-new',
      kind: BstocksOrderActionKind.cancelOrder,
    );
    final orders =
        _ScriptedOrders(
            initial: _order('order-1'),
            refreshes: [
              _order(
                'order-1',
                status: TradingOrderStatus.open,
                currentActionId: old.actionId,
              ),
              _order('order-1', action: next, status: TradingOrderStatus.open),
              _order('order-1', status: TradingOrderStatus.cancelled),
            ],
          )
          ..cancelResult = _order(
            'order-1',
            action: next,
            status: TradingOrderStatus.open,
          );
    final sender = _Sender();
    final actions = _Actions()
      ..currentAction = _action(
        orderId: old.orderId,
        stepId: old.actionId,
        kind: old.kind,
        status: BstocksOrderActionStatus.failed,
      );
    await BstocksOrderExecutionRepositoryImpl(
      orders,
      actions,
      sender,
    ).cancelOrder('order-1');
    expect(
      orders.cancelKeys.single,
      scopedIdempotencyKey('bstocks-cancel-order-1-after-cancel-old'),
    );
    expect(sender.steps, hasLength(1));
    expect(actions.steps, ['cancel-new']);
  });

  for (final status in [
    BstocksOrderActionStatus.submitted,
    BstocksOrderActionStatus.failed,
    BstocksOrderActionStatus.manualReview,
  ]) {
    test(
      'cancel action $status is never signed again or reported as success',
      () async {
        final cancel = _action(
          orderId: 'order-1',
          stepId: 'cancel-1',
          kind: BstocksOrderActionKind.cancelOrder,
          status: status,
        );
        final orders = _ScriptedOrders(
          initial: _order('order-1'),
          refreshes: [
            _order(
              'order-1',
              status: TradingOrderStatus.open,
              action: cancel,
              currentActionId: 'cancel-1',
            ),
            _order('order-1', status: TradingOrderStatus.cancelled),
          ],
        );
        final actions = _Actions()..currentAction = cancel;
        final sender = _Sender();
        final request =
            BstocksOrderExecutionRepositoryImpl(
              orders,
              actions,
              sender,
            ).executeExisting(
              order: ResourceResult(
                resource: _order(
                  'order-1',
                  status: TradingOrderStatus.open,
                  currentActionId: 'cancel-1',
                  action: _action(
                    orderId: 'order-1',
                    stepId: 'cancel-1',
                    kind: BstocksOrderActionKind.cancelOrder,
                    status: status,
                  ),
                ),
              ),
            );
        if (status == BstocksOrderActionStatus.submitted) {
          expect((await request).resource.status, TradingOrderStatus.cancelled);
        } else {
          await expectLater(request, throwsA(isA<UnknownFailure>()));
        }
        expect(sender.steps, isEmpty);
      },
    );
  }

  for (final status in [
    BstocksOrderActionStatus.submitted,
    BstocksOrderActionStatus.manualReview,
  ]) {
    test('hidden cancellation $status is queried without re-signing', () async {
      final current = _order(
        'order-1',
        status: TradingOrderStatus.open,
        currentActionId: 'cancel-1',
      );
      final orders = _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          current,
          _order('order-1', status: TradingOrderStatus.cancelled),
        ],
      );
      final actions = _Actions()
        ..currentAction = _action(
          orderId: 'order-1',
          stepId: 'cancel-1',
          kind: BstocksOrderActionKind.cancelOrder,
          status: status,
        );
      final sender = _Sender();
      final request = BstocksOrderExecutionRepositoryImpl(
        orders,
        actions,
        sender,
      ).cancelOrder('order-1');
      if (status == BstocksOrderActionStatus.submitted) {
        expect((await request).resource.status, TradingOrderStatus.cancelled);
      } else {
        await expectLater(request, throwsA(isA<UnknownFailure>()));
      }
      expect(actions.getCalls, greaterThan(0));
      expect(sender.steps, isEmpty);
      expect(orders.cancelKeys, isEmpty);
    });
  }

  test(
    'a recorded cancel transaction hash is reported without broadcasting again',
    () async {
      final hash = '0x${'ab' * 32}';
      final action = _action(
        orderId: 'order-1',
        stepId: 'cancel-1',
        kind: BstocksOrderActionKind.cancelOrder,
        submittedTransactionHash: hash,
      );
      final current = _order(
        'order-1',
        status: TradingOrderStatus.open,
        action: action,
      );
      final orders = _ScriptedOrders(
        initial: current,
        refreshes: [
          current,
          _order('order-1', status: TradingOrderStatus.cancelled),
        ],
      );
      final sender = _Sender();
      final actions = _Actions()..currentAction = action;
      await BstocksOrderExecutionRepositoryImpl(
        orders,
        actions,
        sender,
      ).cancelOrder('order-1');
      expect(sender.steps, isEmpty);
      expect(actions.steps, ['cancel-1']);
      expect(actions.transactionHashes, [hash]);
      expect(orders.cancelKeys, isEmpty);
    },
  );

  test(
    'approval confirmation preserves the order and waits for a new preview',
    () async {
      final approval = _action(
        orderId: 'order-1',
        stepId: 'approval-1',
        kind: BstocksOrderActionKind.erc20Approval,
      );
      final orders = _ScriptedOrders(
        initial: _order('order-1', action: approval),
        refreshes: [
          _order('order-1', action: approval),
          _order(
            'order-1',
            action: approval,
            actionStatus: BstocksOrderActionStatus.submitted,
          ),
          _order(
            'order-1',
            status: TradingOrderStatus.awaitingConfirmation,
            walletActionBlocker: 'previewRequired',
          ),
        ],
      );
      final actions = _Actions();
      final sender = _Sender();

      final result =
          await BstocksOrderExecutionRepositoryImpl(
            orders,
            actions,
            sender,
          ).execute(
            intent: _intent(),
            created: ResourceResult(resource: orders.initial),
            previewId: 'preview-1',
            stopAfterApproval: true,
          );

      expect(result.resource.orderId, 'order-1');
      expect(result.resource.status, TradingOrderStatus.awaitingConfirmation);
      expect(sender.steps, ['approval-1']);
      expect(actions.steps, ['approval-1']);
      expect(orders.createCalls, 0);
    },
  );

  test(
    'a submitted action is not sent again while confirmation is pending',
    () async {
      final swap = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final orders = _ScriptedOrders(
        initial: _order('order-1', action: swap),
        refreshes: [
          _order('order-1', action: swap),
          _order(
            'order-1',
            action: swap,
            actionStatus: BstocksOrderActionStatus.submitted,
          ),
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      );
      final sender = _Sender();

      await BstocksOrderExecutionRepositoryImpl(
        orders,
        _Actions(),
        sender,
      ).execute(
        intent: _intent(),
        created: ResourceResult(resource: orders.initial),
        previewId: 'preview-1',
      );

      expect(sender.steps, ['swap-1']);
    },
  );

  test('returns when a GTC placement is confirmed but still open', () async {
    final swap = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.placeGtcOrder,
    );
    final orders = _ScriptedOrders(
      initial: _order('order-1', action: swap),
      refreshes: [
        _order('order-1', action: swap),
        _order('order-1', status: TradingOrderStatus.open),
      ],
    );
    final sender = _Sender();

    final result =
        await BstocksOrderExecutionRepositoryImpl(
          orders,
          _Actions(),
          sender,
        ).execute(
          intent: _intent(),
          created: ResourceResult(resource: orders.initial),
          previewId: 'preview-1',
        );

    expect(result.resource.status, TradingOrderStatus.open);
    expect(result.resource.nextAction, isNull);
    expect(sender.steps, ['swap-1']);
  });

  test('cancel action waits for the canonical cancelled order state', () async {
    final cancel = _action(
      orderId: 'order-1',
      stepId: 'cancel-1',
      kind: BstocksOrderActionKind.cancelOrder,
    );
    final orders = _ScriptedOrders(
      initial: _order(
        'order-1',
        action: cancel,
        status: TradingOrderStatus.open,
      ),
      refreshes: [
        _order('order-1', action: cancel, status: TradingOrderStatus.open),
        _order('order-1', status: TradingOrderStatus.open),
        _order('order-1', status: TradingOrderStatus.cancelled),
      ],
    );

    final result = await BstocksOrderExecutionRepositoryImpl(
      orders,
      _Actions(),
      _Sender(),
    ).executeExisting(order: ResourceResult(resource: orders.initial));

    expect(result.resource.status, TradingOrderStatus.cancelled);
    expect(orders.getCalls, 3);
  });

  test('approval-only execution stops before recreating the swap', () async {
    final approval = _action(
      orderId: 'order-1',
      stepId: 'approval-1',
      kind: BstocksOrderActionKind.erc20Approval,
    );
    final orders = _ScriptedOrders(
      initial: _order('order-1', action: approval),
      refreshes: [
        _order('order-1', action: approval),
        _order(
          'order-1',
          action: approval,
          actionStatus: BstocksOrderActionStatus.submitted,
        ),
        _order(
          'order-1',
          status: TradingOrderStatus.awaitingConfirmation,
          walletActionBlocker: 'previewRequired',
        ),
      ],
    );
    final actions = _Actions();
    final sender = _Sender();

    final result =
        await BstocksOrderExecutionRepositoryImpl(
          orders,
          actions,
          sender,
        ).execute(
          intent: _intent(),
          created: ResourceResult(resource: orders.initial),
          previewId: 'preview-1',
          stopAfterApproval: true,
        );

    expect(result.resource.status, TradingOrderStatus.awaitingConfirmation);
    expect(sender.steps, ['approval-1']);
    expect(actions.steps, ['approval-1']);
    expect(orders.createCalls, 0);
  });

  test('approval-only execution refuses a swap action', () async {
    final swap = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.executeIocOrder,
    );
    final sender = _Sender();

    await expectLater(
      BstocksOrderExecutionRepositoryImpl(
        _ScriptedOrders(
          initial: _order('order-1', action: swap),
          refreshes: [_order('order-1', action: swap)],
        ),
        _Actions(),
        sender,
      ).execute(
        intent: _intent(),
        created: ResourceResult(resource: _order('order-1', action: swap)),
        previewId: 'preview-1',
        stopAfterApproval: true,
      ),
      throwsA(isA<CompatibilityFailure>()),
    );
    expect(sender.steps, isEmpty);
  });

  test(
    'polls when the order is created before its first action is released',
    () async {
      final swap = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final orders = _ScriptedOrders(
        initial: _order('order-1', status: TradingOrderStatus.pendingSignature),
        refreshes: [
          _order('order-1', status: TradingOrderStatus.pendingSignature),
          _order('order-1', action: swap),
          _order('order-1', status: TradingOrderStatus.filled),
        ],
      );
      final sender = _Sender();

      await BstocksOrderExecutionRepositoryImpl(
        orders,
        _Actions(),
        sender,
      ).execute(
        intent: _intent(),
        created: ResourceResult(resource: orders.initial),
        previewId: 'preview-1',
      );

      expect(sender.steps, ['swap-1']);
    },
  );

  test(
    'wallet action without an embedded signer fails before submission',
    () async {
      final action = _action(
        orderId: 'order-1',
        stepId: 'swap-1',
        kind: BstocksOrderActionKind.executeIocOrder,
      );
      final actions = _Actions();

      expect(
        () =>
            BstocksOrderExecutionRepositoryImpl(
              _ScriptedOrders(
                initial: _order('order-1', action: action),
                refreshes: [_order('order-1', action: action)],
              ),
              actions,
              null,
            ).execute(
              intent: _intent(),
              created: ResourceResult(
                resource: _order('order-1', action: action),
              ),
              previewId: 'preview-1',
            ),
        throwsA(isA<Exception>()),
      );
      expect(actions.steps, isEmpty);
    },
  );
}

OrderIntent _intent() => OrderIntent(
  symbol: 'NVDAB',
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.market,
  amount: DecimalValue('10', asset: 'USDT', unit: 'token'),
);

BstocksOrderAction _action({
  required String orderId,
  required String stepId,
  required BstocksOrderActionKind kind,
  BstocksOrderActionStatus status = BstocksOrderActionStatus.awaitingSignature,
  String? submittedTransactionHash,
  DateTime? validUntil,
}) => BstocksOrderAction(
  orderId: orderId,
  actionId: stepId,
  kind: kind,
  status: status,
  submittedTransactionHash: submittedTransactionHash,
  chainId: 56,
  from: '0x1111111111111111111111111111111111111111',
  to: '0x2222222222222222222222222222222222222222',
  data: kind == BstocksOrderActionKind.erc20Approval ? '0xaa' : '0xbb',
  value: '0x0',
  payloadHash: 'hash-$stepId',
  validUntil: validUntil ?? DateTime.utc(2030),
);

TradingOrder _order(
  String orderId, {
  BstocksOrderAction? action,
  BstocksOrderActionStatus? actionStatus,
  TradingOrderStatus status = TradingOrderStatus.submitted,
  String? walletActionBlocker,
  String? currentActionId,
}) => TradingOrder(
  orderId: orderId,
  symbol: 'NVDAB',
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.market,
  status: status,
  createdAt: DateTime.utc(2026),
  nextAction: action == null || actionStatus == null
      ? action
      : BstocksOrderAction(
          orderId: action.orderId,
          actionId: action.actionId,
          kind: action.kind,
          status: actionStatus,
          chainId: action.chainId,
          from: action.from,
          to: action.to,
          data: action.data,
          value: action.value,
          payloadHash: action.payloadHash,
          validUntil: action.validUntil,
        ),
  walletActionBlocker: walletActionBlocker,
  currentActionId: currentActionId,
);

final class _ScriptedOrders implements OrdersRepository {
  _ScriptedOrders({required this.initial, required this.refreshes});

  final TradingOrder initial;
  final List<TradingOrder> refreshes;
  var createCalls = 0;
  var getCalls = 0;
  void Function()? onGet;
  ApiFailure? cancelFailure;
  TradingOrder? cancelResult;
  final cancelKeys = <String>[];
  final createdPreviewIds = <String?>[];
  var _refreshIndex = 0;

  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) async {
    getCalls++;
    onGet?.call();
    return ResourceResult(resource: refreshes[_refreshIndex++]);
  }

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    createCalls++;
    createdPreviewIds.add(previewId);
    throw StateError('A continuation must not create a second order');
  }

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) async {
    cancelKeys.add(idempotencyKey);
    final failure = cancelFailure;
    cancelFailure = null;
    if (failure != null) throw failure;
    return ResourceResult(resource: cancelResult!);
  }

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) => throw UnimplementedError();

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<OrderPreview> previewContinuation(
    String orderId,
    OrderIntent intent, {
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

final class _Actions implements BstocksOrderActionRepository {
  final steps = <String>[];
  final transactionHashes = <String>[];
  int getCalls = 0;
  BstocksOrderAction? createdAction;
  BstocksOrderAction? currentAction;
  ApiFailure? submitFailure;
  final createdPreviewIds = <String>[];

  @override
  Future<BstocksOrderAction> create({
    required String orderId,
    required String previewId,
    required String idempotencyKey,
  }) async {
    createdPreviewIds.add(previewId);
    return createdAction!;
  }

  @override
  Future<BstocksOrderAction> get({
    required String orderId,
    required String actionId,
  }) async {
    getCalls++;
    final configured = currentAction ?? createdAction;
    if (configured != null && configured.actionId == actionId) {
      return configured;
    }
    return _action(
      orderId: orderId,
      stepId: actionId,
      kind: actionId.startsWith('approval')
          ? BstocksOrderActionKind.erc20Approval
          : actionId.contains('cancel')
          ? BstocksOrderActionKind.cancelOrder
          : BstocksOrderActionKind.executeIocOrder,
    );
  }

  @override
  Future<BstocksWalletActionSubmission> submit({
    required String orderId,
    required String actionId,
    required String transactionHash,
    required String idempotencyKey,
  }) async {
    steps.add(actionId);
    transactionHashes.add(transactionHash);
    final failure = submitFailure;
    submitFailure = null;
    if (failure != null) throw failure;
    return BstocksWalletActionSubmission(
      orderId: orderId,
      actionId: actionId,
      status: 'submitted',
      transactionHash: transactionHash,
      updatedAt: DateTime.utc(2026),
    );
  }
}

final class _RejectingSender implements EmbeddedWalletTransactionSender {
  @override
  Future<String> sendTransaction({
    required String expectedSigner,
    required int chainId,
    required String to,
    required String data,
    required String value,
  }) async => throw const CancelledFailure();
}

final class _Sender implements EmbeddedWalletTransactionSender {
  final steps = <String>[];

  @override
  Future<String> sendTransaction({
    required String expectedSigner,
    required int chainId,
    required String to,
    required String data,
    required String value,
  }) async {
    steps.add(data == '0xaa' ? 'approval-1' : 'swap-1');
    return '0x${'ab' * 32}';
  }
}

WalletActionExecution _execution(
  BstocksOrderAction action,
  WalletActionExecutionState status, {
  String payload = 'current',
}) => WalletActionExecution(
  executionId: 'execution-1',
  resourceId: action.orderId,
  chainId: action.chainId,
  walletAddress: action.from,
  mode: GasPaymentMode.appSponsored,
  status: status,
  transaction: FrozenTransaction(
    to: action.to,
    data: action.data,
    value: action.value,
  ),
  gasPayment: GasPaymentQuote(
    mode: GasPaymentMode.appSponsored,
    decision: GasSponsorshipDecision.eligible,
    platformPays: true,
    nativeAsset: 'BNB',
    estimatedNativeFee: DecimalValue('0', asset: 'BNB', unit: 'token'),
    estimatedFeeUsd: DecimalValue('0', asset: 'USD', unit: 'usd'),
    fallbackAllowed: false,
    eip7702Required: false,
  ),
  authorization: status == WalletActionExecutionState.awaitingUserAuthorization
      ? WalletAuthorizationRequest(
          version: 1,
          method: 'POST',
          url: 'https://api.privy.io/v1/wallets/wallet-1/rpc',
          headers: {'payload': payload},
          body: const {},
          referenceId: 'execution-1',
          sponsor: true,
          caip2: 'eip155:${action.chainId}',
          transaction: AuthorizedTransaction(
            from: action.from,
            to: action.to,
            data: action.data,
            value: action.value,
          ),
        )
      : null,
  authorizationExpiresAt: DateTime.utc(2030),
);

final class _Executions implements WalletActionExecutionRepository {
  _Executions(this.action, this.reads);
  final BstocksOrderAction action;
  final List<Object> reads;
  final createKeys = <String>[];
  final getIds = <String>[];
  final submitKeys = <String>[];
  final submitSignatures = <String>[];
  var submitCalls = 0;
  ApiFailure? submitFailure;

  @override
  Future<WalletActionExecution> get(String executionId) async {
    getIds.add(executionId);
    final next = reads.removeAt(0);
    if (next is ApiFailure) throw next;
    return next as WalletActionExecution;
  }

  @override
  Future<WalletActionExecution> createOrderWalletActionExecution({
    required String orderId,
    required String actionId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async {
    createKeys.add(idempotencyKey);
    onCreate?.call();
    return _execution(
      action,
      WalletActionExecutionState.awaitingUserAuthorization,
      payload: 'stale',
    );
  }

  @override
  Future<WalletActionExecution> submitAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  }) async {
    submitCalls++;
    submitKeys.add(idempotencyKey);
    submitSignatures.add(signature);
    await beforeSubmit?.call();
    if (submitFailure case final failure?) throw failure;
    return _execution(action, WalletActionExecutionState.providerSubmitted);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  void Function()? onCreate;
  Future<void> Function()? beforeSubmit;
}

final class _MarkerStore extends InMemorySharedPreferencesStore {
  _MarkerStore(this.onMarker) : super.empty();

  void Function()? onMarker;
  int markerWrites = 0;

  @override
  Future<bool> setValue(String valueType, String key, Object value) async {
    if (key.startsWith('flutter.bstocks.broadcast.') && value == '' ||
        key.startsWith('flutter.bstocks.execution.submitted.')) {
      markerWrites++;
      onMarker?.call();
    }
    return super.setValue(valueType, key, value);
  }
}

final class _PendingSender implements EmbeddedWalletTransactionSender {
  final started = Completer<void>();
  final result = Completer<String>();
  int calls = 0;

  @override
  Future<String> sendTransaction({
    required String expectedSigner,
    required int chainId,
    required String to,
    required String data,
    required String value,
  }) {
    calls++;
    started.complete();
    return result.future;
  }
}

final class _PendingSigner implements WalletAuthorizationSigner {
  final started = Completer<void>();
  final result = Completer<String>();

  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) {
    started.complete();
    return result.future;
  }
}

final class _Signer implements WalletAuthorizationSigner {
  final requests = <WalletAuthorizationRequest>[];

  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) async {
    requests.add(request);
    return 'signature';
  }
}

final class _ChangingSigner extends _Signer {
  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) async {
    await super.signWalletAuthorization(
      expectedSigner: expectedSigner,
      request: request,
    );
    return 'signature-${requests.length}';
  }
}
