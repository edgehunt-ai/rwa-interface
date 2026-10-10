import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/observability_providers.dart';
import 'package:nobell/app/observability/observability_reporter.dart';
import 'package:nobell/data/api/idempotency_key.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/hip3_action_summary.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/application_state.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/domain/models/resource_result.dart';
import 'package:nobell/domain/repositories/orders_repository.dart';
import 'package:nobell/domain/repositories/bstocks_order_execution_repository.dart';
import 'package:nobell/domain/repositories/hip3_order_execution_repository.dart';
import 'package:nobell/ui/features/orders/providers/order_providers.dart';

void main() {
  group('bStocks Open orders', () {
    const query = (symbol: 'NVDAB', productId: 'product-nvda');

    test(
      'filters on the server before pagination and loads all pages',
      () async {
        final repository = _PagedOpenOrders();
        final container = ProviderContainer(
          overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
        );
        addTearDown(container.dispose);
        final page = await container.read(
          bstocksOpenOrdersProvider(query).future,
        );
        expect(repository.cursors, [null, 'next']);
        expect(
          repository.filters,
          everyElement((
            kind: MarketProductKind.bstock,
            symbol: 'NVDAB',
            productId: 'product-nvda',
            statusGroup: 'open',
          )),
        );
        expect(page.items.map((e) => e.resource.orderId), [
          'open-new',
          'open-old',
        ]);
        expect(page.hasMore, isFalse);
      },
    );

    test('server-filtered orders may omit optional product_id', () async {
      final repository = _PagedOpenOrders(omitProductId: true);
      final container = ProviderContainer(
        overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final page = await container.read(
        bstocksOpenOrdersProvider(query).future,
      );
      expect(page.items.map((e) => e.resource.orderId), [
        'open-new',
        'open-old',
      ]);
    });

    test(
      'invalid pagination fails instead of silently hiding orders',
      () async {
        for (final cursor in [null, 'next']) {
          final repository = _PagedOpenOrders(
            brokenCursor: true,
            nextCursor: cursor,
          );
          final container = ProviderContainer(
            overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
          );
          addTearDown(container.dispose);
          await expectLater(
            container.read(bstocksOpenOrdersProvider(query).future),
            throwsA(isA<CompatibilityFailure>()),
          );
          expect(repository.cursors.length, lessThanOrEqualTo(2));
        }
      },
    );

    test('refreshes open orders after cancellation', () async {
      final repository = _PagedOpenOrders();
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(repository),
          bstocksOrderExecutionRepositoryProvider.overrideWithValue(
            _BstocksExecution(),
          ),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        bstocksOpenOrdersProvider(query),
        (_, _) {},
      );
      addTearDown(subscription.close);
      await container.read(bstocksOpenOrdersProvider(query).future);
      await container
          .read(orderCommandProvider.notifier)
          .cancel(_openOrder('open-new', TradingOrderStatus.open));
      await container.read(bstocksOpenOrdersProvider(query).future);
      expect(repository.cursors, [null, 'next', null, 'next']);
    });
  });

  for (final status in [
    TradingOrderStatus.submitted,
    TradingOrderStatus.open,
    TradingOrderStatus.filled,
  ]) {
    for (final dismiss in [false, true]) {
      test(
        'accepted $status bStocks trade uses a new create identity on the next trade (dismiss=$dismiss)',
        () async {
          final orders = _LifecycleOrders(status: status);
          final container = ProviderContainer(
            overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
          );
          addTearDown(container.dispose);
          final notifier = container.read(orderCommandProvider.notifier);
          final intent = _intent('NVDA');
          final first = await notifier.submit(intent, previewId: 'initial-1');
          expect(first, isNotNull);
          if (dismiss) notifier.cancelSubmission();
          final second = await notifier.submit(intent, previewId: 'initial-2');
          expect(second, isNotNull);
          expect(second!.resource.orderId, isNot(first!.resource.orderId));
          expect(orders.previewIds, ['initial-1', 'initial-2']);
          expect(orders.keys.last, isNot(orders.keys.first));
        },
      );
    }
  }

  test(
    'completed continuation cannot leak its preview into a new create',
    () async {
      final orders = _LifecycleOrders(needsApproval: true);
      final execution = _BstocksExecution();
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(orders),
          bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(orderCommandProvider.notifier);
      final intent = _intent('NVDA');
      expect(await notifier.approve(intent, previewId: 'initial-1'), isNotNull);
      final completed = await notifier.submit(
        intent,
        previewId: 'continuation-1',
      );
      expect(completed, isNotNull);
      notifier.cancelSubmission();
      final next = await notifier.submit(intent, previewId: 'initial-2');
      expect(next, isNotNull);
      expect(next!.resource.orderId, isNot(completed!.resource.orderId));
      expect(orders.previewIds, ['initial-1', 'initial-2']);
      expect(execution.continuationOrders, ['original-order']);
      expect(execution.continuationPreviews, ['continuation-1']);
      expect(notifier.continuationOrderIdFor(intent), isNull);
    },
  );

  test('dismissed uncertain create replays its original request before a new trade', () async {
    final orders = _LifecycleOrders(loseFirstResponse: true);
    final container = ProviderContainer(
      overrides: [ordersRepositoryProvider.overrideWithValue(orders)],
    );
    addTearDown(container.dispose);
    final notifier = container.read(orderCommandProvider.notifier);
    final intent = _intent('NVDA');
    expect(await notifier.submit(intent, previewId: 'initial-1'), isNull);
    notifier.cancelSubmission();
    final recovered = await notifier.submit(intent, previewId: 'display-2');
    expect(recovered, isNotNull);
    expect(orders.previewIds, ['initial-1', 'initial-1']);
    expect(orders.keys.last, orders.keys.first);
    notifier.cancelSubmission();
    final next = await notifier.submit(intent, previewId: 'initial-3');
    expect(next, isNotNull);
    expect(next!.resource.orderId, isNot(recovered!.resource.orderId));
    expect(orders.previewIds.last, 'initial-3');
    expect(orders.keys.last, isNot(orders.keys.first));
  });

  for (final failure in <Object>[
    const NetworkFailure(),
    StateError('late SDK failure'),
  ]) {
    test(
      'late $failure after disposal returns null without reading disposed ref',
      () async {
        final orders = _SessionOrders();
        final reporter = _RecordingObservabilityReporter();
        final container = ProviderContainer(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(orders),
            observabilityReporterProvider.overrideWithValue(reporter),
          ],
        );
        final request = container
            .read(orderCommandProvider.notifier)
            .submit(_intent('NVDA'), previewId: 'preview-1');
        final assertion = expectLater(request, completion(isNull));
        container.dispose();
        orders.pending.single.completeError(failure);
        await assertion;
        expect(reporter.failures, isEmpty);
        expect(reporter.operations, ['create_order:started']);
      },
    );
  }

  for (final dispose in [false, true]) {
    for (final failure in <Object?>[
      null,
      const NetworkFailure(),
      StateError('late cancellation SDK failure'),
    ]) {
      test(
        'late cancellation $failure after ${dispose ? 'disposal' : 'session change'} is ignored safely',
        () async {
          final execution = _PendingCancellation();
          final reporter = _RecordingObservabilityReporter();
          var orderReads = 0;
          final container = ProviderContainer(
            overrides: [
              bstocksOrderExecutionRepositoryProvider.overrideWithValue(
                execution,
              ),
              observabilityReporterProvider.overrideWithValue(reporter),
              orderProvider('original-order').overrideWith((ref) async {
                orderReads++;
                return ResourceResult(
                  resource: _bstocksOrder(status: TradingOrderStatus.open),
                );
              }),
            ],
          );
          final subscription = container.listen(
            orderCommandProvider,
            (_, _) {},
          );
          final orderSubscription = container.listen(
            orderProvider('original-order'),
            (_, _) {},
          );
          final notifier = container.read(orderCommandProvider.notifier);
          final request = notifier.cancel(
            _bstocksOrder(status: TradingOrderStatus.open),
          );
          final assertion = expectLater(request, completes);
          await execution.started.future;
          expect(execution.isCancelled!(), isFalse);
          if (dispose) {
            container.dispose();
          } else {
            addTearDown(container.dispose);
            addTearDown(subscription.close);
            addTearDown(orderSubscription.close);
            container.read(sessionGenerationProvider.notifier).clearUserScope();
            container.read(orderCommandProvider);
            await container.read(orderProvider('original-order').future);
          }
          expect(execution.isCancelled!(), isTrue);
          final readsBefore = orderReads;
          if (failure == null) {
            execution.pending.complete(
              ResourceResult(
                resource: _bstocksOrder(status: TradingOrderStatus.cancelled),
              ),
            );
          } else {
            execution.pending.completeError(failure);
          }
          await assertion;
          if (!dispose) {
            await container.read(orderProvider('original-order').future);
            expect(orderReads, readsBefore);
          }
          expect(reporter.failures, isEmpty);
          expect(reporter.operations, ['cancel_order:started']);
        },
      );
    }
  }

  test(
    'starting or dismissing a trade leaves independent cancellation active',
    () async {
      final execution = _PendingCancellation();
      final orders = _SessionOrders();
      final container = ProviderContainer(
        overrides: [
          bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
          ordersRepositoryProvider.overrideWithValue(orders),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(orderCommandProvider.notifier);
      final cancellation = notifier.cancel(
        _bstocksOrder(status: TradingOrderStatus.open),
      );
      await execution.started.future;
      final submission = notifier.submit(
        _intent('NVDA'),
        previewId: 'preview-1',
      );
      expect(execution.isCancelled!(), isFalse);
      notifier.cancelSubmission();
      expect(execution.isCancelled!(), isFalse);
      orders.pending.single.complete(_activeBstocksOrder('new-order'));
      expect(await submission, isNull);
      execution.pending.complete(
        ResourceResult(
          resource: _bstocksOrder(status: TradingOrderStatus.cancelled),
        ),
      );
      await cancellation;
    },
  );

  for (final approvalOnly in [false, true]) {
    test(
      'a hidden action replay enters recovery for approval=$approvalOnly',
      () async {
        final execution = _RecoveryExecution()
          ..executeFailure = const UnknownFailure(
            userAction: 'Current execution is manual review',
          );
        final container = ProviderContainer(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(
              _HiddenActionReplayOrders(),
            ),
            bstocksOrderExecutionRepositoryProvider.overrideWithValue(
              execution,
            ),
          ],
        );
        addTearDown(container.dispose);
        final notifier = container.read(orderCommandProvider.notifier);
        final result = approvalOnly
            ? await notifier.approve(_intent('NVDA'), previewId: 'preview-1')
            : await notifier.submit(_intent('NVDA'), previewId: 'preview-1');
        expect(result, isNull);
        expect(execution.executedOrderIds, ['original-order']);
        expect(
          container.read(orderCommandProvider),
          isA<CommandFailure<OrderIntent, ResourceResult<TradingOrder>>>(),
        );
        expect(notifier.continuationOrderIdFor(_intent('NVDA')), isNull);
      },
    );
  }

  test(
    'a late create from an old session cannot enter the wallet executor',
    () async {
      final orders = _SessionOrders();
      final execution = _RecoveryExecution();
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(orders),
          bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(orderCommandProvider, (_, _) {});
      addTearDown(subscription.close);
      final notifier = container.read(orderCommandProvider.notifier);
      final oldRequest = notifier.submit(
        _intent('NVDA'),
        previewId: 'old-preview',
      );
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      container.read(orderCommandProvider);
      final newRequest = notifier.submit(
        _intent('NVDA'),
        previewId: 'new-preview',
      );
      orders.pending[0].complete(_activeBstocksOrder('old-order'));
      expect(await oldRequest, isNull);
      expect(execution.executedOrderIds, isEmpty);
      orders.pending[1].complete(_activeBstocksOrder('new-order'));
      expect(await newRequest, isNotNull);
      expect(execution.executedOrderIds, ['new-order']);
      expect(execution.cancellationChecks.single(), isFalse);
    },
  );

  test('a running wallet execution stays cancelled after a new session command starts', () async {
    final orders = _SessionOrders();
    final execution = _RecoveryExecution()
      ..pending = Completer<ResourceResult<TradingOrder>>();
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(orders),
        bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(orderCommandProvider, (_, _) {});
    addTearDown(subscription.close);
    final notifier = container.read(orderCommandProvider.notifier);
    final oldRequest = notifier.submit(
      _intent('NVDA'),
      previewId: 'old-preview',
    );
    orders.pending[0].complete(_activeBstocksOrder('old-order'));
    await execution.started.future;
    expect(execution.cancellationChecks.single(), isFalse);
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    container.read(orderCommandProvider);
    final newRequest = notifier.submit(
      _intent('NVDA'),
      previewId: 'new-preview',
    );
    expect(execution.cancellationChecks.single(), isTrue);
    execution.pending!.complete(_activeBstocksOrder('old-order'));
    expect(await oldRequest, isNull);
    orders.pending[1].complete(_activeBstocksOrder('new-order'));
    expect(await newRequest, isNotNull);
    expect(execution.cancellationChecks.last(), isFalse);
  });

  test('disposing the provider cancels an active wallet execution', () async {
    final orders = _SessionOrders();
    final execution = _RecoveryExecution()
      ..pending = Completer<ResourceResult<TradingOrder>>();
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(orders),
        bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
      ],
    );
    final notifier = container.read(orderCommandProvider.notifier);
    final request = notifier.submit(_intent('NVDA'), previewId: 'preview-1');
    orders.pending.single.complete(_activeBstocksOrder('old-order'));
    await execution.started.future;
    container.dispose();
    expect(execution.cancellationChecks.single(), isTrue);
    execution.pending!.complete(_activeBstocksOrder('old-order'));
    expect(await request, isNull);
  });

  test(
    'repeated approval and submission use the original continuation order',
    () async {
      final orders = _ContinuationOrders();
      final execution = _BstocksExecution();
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(orders),
          bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
        ],
      );
      addTearDown(container.dispose);
      final notifier = container.read(orderCommandProvider.notifier);
      final intent = _intent('NVDA');
      expect(
        await notifier.approve(intent, previewId: 'initial-preview'),
        isNotNull,
      );
      final preview = await container.read(orderPreviewProvider(intent).future);
      expect(preview.approvalRequired, isTrue);
      expect(orders.continuationOrderIds, ['original-order']);

      // A lost action response freezes its preview for retries despite a newer
      // display quote. After confirmation the next command can use a fresh P.
      execution.failContinuationOnce = true;
      expect(
        await notifier.approve(intent, previewId: preview.previewId),
        isNull,
      );
      expect(
        await notifier.approve(intent, previewId: 'newer-display-preview'),
        isNotNull,
      );
      expect(notifier.continuationOrderIdFor(intent), 'original-order');
      execution.failContinuationOnce = true;
      expect(
        await notifier.submit(intent, previewId: 'execution-preview'),
        isNull,
      );
      expect(
        await notifier.submit(intent, previewId: 'newer-execution-preview'),
        isNotNull,
      );
      expect(orders.createCalls, 1);
      expect(execution.continuationOrders, everyElement('original-order'));
      expect(execution.continuationPreviews, [
        'continuation-preview',
        'continuation-preview',
        'execution-preview',
        'execution-preview',
      ]);
      expect(execution.approvalStops, [true, true, false, false]);
      expect(notifier.continuationOrderIdFor(intent), isNull);
    },
  );

  test('concurrent bStocks cancellations share the recovery request', () async {
    final execution = _BstocksExecution();
    final container = ProviderContainer(
      overrides: [
        bstocksOrderExecutionRepositoryProvider.overrideWithValue(execution),
      ],
    );
    addTearDown(container.dispose);
    final notifier = container.read(orderCommandProvider.notifier);
    await Future.wait(
      List.generate(
        10,
        (_) => notifier.cancel(_bstocksOrder(status: TradingOrderStatus.open)),
      ),
    );
    expect(execution.cancelCalls, 1);
    await notifier.cancel(_bstocksOrder(status: TradingOrderStatus.open));
    expect(execution.cancelCalls, 2);
  });

  for (final kind in [MarketProductKind.bstock, MarketProductKind.perp]) {
    test(
      'refreshing a $kind quote uses a new key while replay shares its key',
      () async {
        final repository = _QuoteOrders();
        final container = ProviderContainer(
          overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
        );
        addTearDown(container.dispose);
        final intent = OrderIntent(
          symbol: 'NVDA',
          kind: kind,
          side: kind == MarketProductKind.perp
              ? TradingSide.long
              : TradingSide.buy,
          type: TradingOrderType.market,
          amount: DecimalValue('15'),
        );
        final provider = orderPreviewProvider(intent);
        final subscription = container.listen(provider, (_, _) {});
        addTearDown(subscription.close);
        await container.read(provider.future);
        await container.read(provider.future);
        expect(repository.previewKeys, hasLength(1));
        container.invalidate(provider);
        await container.read(provider.future);
        expect(repository.previewKeys, hasLength(2));
        expect(repository.previewKeys[1], isNot(repository.previewKeys[0]));
      },
    );
  }
  test(
    'late HIP3 create success or failure cannot update a new session',
    () async {
      for (final fail in [false, true]) {
        final repository = _DeferredOrders();
        final container = ProviderContainer(
          overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
        );
        final subscription = container.listen(orderCommandProvider, (_, _) {});
        final intent = OrderIntent(
          symbol: 'NVDA',
          kind: MarketProductKind.perp,
          side: TradingSide.long,
          type: TradingOrderType.market,
          quantity: DecimalValue('1'),
        );
        final notifier = container.read(orderCommandProvider.notifier);
        final requests = Future.wait([
          notifier.submit(intent),
          notifier.submit(intent),
        ]);
        container.read(sessionGenerationProvider.notifier).clearUserScope();
        expect(
          container.read(orderCommandProvider),
          isA<CommandIdle<OrderIntent, ResourceResult<TradingOrder>>>(),
        );
        if (fail) {
          repository.pending.completeError(const NetworkFailure());
        } else {
          repository.pending.complete(ResourceResult(resource: _perpOrder()));
        }
        expect(await requests, everyElement(isNull));
        expect(
          container.read(orderCommandProvider),
          isA<CommandIdle<OrderIntent, ResourceResult<TradingOrder>>>(),
        );
        subscription.close();
        container.dispose();
      }
    },
  );
  test('HIP3 listing passes perp without changing the unscoped list', () async {
    final repository = _OrdersRepository();
    final container = ProviderContainer(
      overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    await container.read(hip3OrdersProvider(null).future);
    expect(repository.listedKind, MarketProductKind.perp);
    await container.read(ordersProvider(null).future);
    expect(repository.listedKind, isNull);
  });
  test('resting HIP3 cancellation uses the signing repository', () async {
    final execution = _CancelExecution();
    final container = ProviderContainer(
      overrides: [
        ordersRepositoryProvider.overrideWithValue(_OrdersRepository()),
        hip3OrderExecutionRepositoryProvider.overrideWithValue(execution),
      ],
    );
    addTearDown(container.dispose);
    await container.read(orderCommandProvider.notifier).cancel(_perpOrder());
    expect(execution.orderId, 'perp-1');
    expect(execution.key, scopedIdempotencyKey('hip3-cancel-perp-1'));
  });
  test(
    '20 concurrent submits share one request and one idempotency key',
    () async {
      final repository = _OrdersRepository();
      final container = ProviderContainer(
        overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final notifier = container.read(orderCommandProvider.notifier);
      final intent = _intent('NVDA');
      final results = await Future.wait(
        List.generate(20, (_) => notifier.submit(intent)),
      );
      expect(repository.createCalls, 1);
      expect(results.whereType<ResourceResult<TradingOrder>>(), hasLength(20));
      final firstKey = repository.keys.single;
      await notifier.submit(intent);
      expect(repository.keys.last, isNot(firstKey));
      await notifier.submit(_intent('TSLA'));
      expect(repository.keys.last, isNot(firstKey));
    },
  );

  test(
    'failed order submission exposes a stable recoverable command state',
    () async {
      final observability = _RecordingObservabilityReporter();
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(
            _FailingOrdersRepository(),
          ),
          observabilityReporterProvider.overrideWithValue(observability),
        ],
      );
      addTearDown(container.dispose);

      final result = await container
          .read(orderCommandProvider.notifier)
          .submit(_intent('NVDA'));

      expect(result, isNull);
      final state = container.read(orderCommandProvider);
      expect(
        state,
        isA<CommandFailure<OrderIntent, ResourceResult<TradingOrder>>>(),
      );
      expect((state as CommandFailure).failure, isA<NetworkFailure>());
      expect(observability.operations, [
        'create_order:started',
        'create_order:failed',
      ]);
      expect(observability.failures, hasLength(1));
    },
  );

  for (final status in [
    TradingOrderStatus.failed,
    TradingOrderStatus.manualReview,
    TradingOrderStatus.ambiguous,
  ]) {
    test(
      'a returned $status bStocks order records failure instead of acceptance',
      () async {
        final container = ProviderContainer(
          overrides: [
            ordersRepositoryProvider.overrideWithValue(
              _FailedBstocksOrders(status),
            ),
          ],
        );
        addTearDown(container.dispose);
        expect(
          await container
              .read(orderCommandProvider.notifier)
              .submit(_intent('NVDA'), previewId: 'preview-1'),
          isNull,
        );
        final state = container.read(orderCommandProvider);
        expect(
          state,
          isA<CommandFailure<OrderIntent, ResourceResult<TradingOrder>>>(),
        );
        expect(
          (state as CommandFailure).failure.userAction,
          'Chain execution failed',
        );
      },
    );
  }

  for (final approvalOnly in [true, false]) {
    for (final code in [
      'preview_expired',
      'bstocks_preview_changed',
      'bstocks_preview_already_consumed',
      null,
    ]) {
      test(
        'approval=$approvalOnly retry only replaces the key for rejected preview $code',
        () async {
          final repository = _RejectedApprovalOrders(
            code == null
                ? const NetworkFailure()
                : ServerFailure(statusCode: 409, code: code),
          );
          final container = ProviderContainer(
            overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
          );
          addTearDown(container.dispose);
          final notifier = container.read(orderCommandProvider.notifier);
          Future<ResourceResult<TradingOrder>?> run(String previewId) =>
              approvalOnly
              ? notifier.approve(_intent('NVDA'), previewId: previewId)
              : notifier.submit(_intent('NVDA'), previewId: previewId);
          expect(await run('old-preview'), isNull);
          expect(await run('fresh-preview'), isNotNull);
          expect(repository.keys, hasLength(2));
          expect(
            repository.keys.last,
            code == null ? repository.keys.first : isNot(repository.keys.first),
          );
          expect(repository.previewIds, [
            'old-preview',
            code == null ? 'old-preview' : 'fresh-preview',
          ]);
        },
      );
    }
  }
}

TradingOrder _openOrder(
  String id,
  TradingOrderStatus status, {
  String symbol = 'NVDAB',
  String? productId = 'product-nvda',
}) => TradingOrder(
  orderId: id,
  symbol: symbol,
  productId: productId,
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.limit,
  status: status,
  createdAt: DateTime.utc(2026),
);

final class _PagedOpenOrders extends _OrdersRepository {
  _PagedOpenOrders({
    this.brokenCursor = false,
    this.nextCursor = 'next',
    this.omitProductId = false,
  });
  final bool brokenCursor;
  final bool omitProductId;
  final String? nextCursor;
  final cursors = <String?>[];
  final filters = <Object>[];

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async {
    cursors.add(cursor);
    filters.add((
      kind: kind,
      symbol: symbol,
      productId: productId,
      statusGroup: statusGroup,
    ));
    return DomainPage(
      items: [
        ResourceResult(
          resource: _openOrder(
            'open-new',
            TradingOrderStatus.open,
            productId: omitProductId ? null : 'product-nvda',
          ),
        ),
        if (cursor != null)
          ResourceResult(
            resource: _openOrder(
              'open-old',
              TradingOrderStatus.partiallyFilled,
              productId: omitProductId ? null : 'product-nvda',
            ),
          ),
        for (final status in [
          TradingOrderStatus.pending,
          TradingOrderStatus.awaitingConfirmation,
          TradingOrderStatus.submitted,
          TradingOrderStatus.ambiguous,
          TradingOrderStatus.manualReview,
          TradingOrderStatus.filled,
        ])
          ResourceResult(resource: _openOrder(status.name, status)),
        ResourceResult(
          resource: _openOrder(
            'other-symbol',
            TradingOrderStatus.open,
            symbol: 'TSLAB',
          ),
        ),
        ResourceResult(
          resource: _openOrder(
            'other-product',
            TradingOrderStatus.open,
            productId: 'other-product',
          ),
        ),
      ],
      hasMore: cursor == null || brokenCursor,
      nextCursor: cursor == null || brokenCursor ? nextCursor : null,
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) async => ResourceResult(
    resource: _openOrder(orderId, TradingOrderStatus.cancelled),
  );
}

/// Models immutable create replay and rejects continuation previews at create.
final class _LifecycleOrders extends _OrdersRepository {
  _LifecycleOrders({
    this.status = TradingOrderStatus.open,
    this.needsApproval = false,
    this.loseFirstResponse = false,
  });

  final TradingOrderStatus status;
  final bool needsApproval;
  final bool loseFirstResponse;
  final previewIds = <String?>[];
  final _created = <String, ResourceResult<TradingOrder>>{};

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    keys.add(idempotencyKey);
    previewIds.add(previewId);
    if (previewId?.startsWith('continuation-') ?? false) {
      throw const ServerFailure(
        statusCode: 409,
        code: 'bstocks_preview_changed',
      );
    }
    if (_created[idempotencyKey] case final replay?) return replay;
    createCalls++;
    final result = ResourceResult(
      resource: needsApproval && createCalls == 1
          ? _bstocksOrder()
          : TradingOrder(
              orderId: 'order-$createCalls',
              symbol: intent.symbol,
              kind: intent.kind,
              side: intent.side,
              type: intent.type,
              status: status,
              createdAt: DateTime.utc(2026),
            ),
    );
    _created[idempotencyKey] = result;
    if (loseFirstResponse && keys.length == 1) throw const NetworkFailure();
    return result;
  }
}

final class _FailedBstocksOrders extends _OrdersRepository {
  _FailedBstocksOrders(this.status);
  final TradingOrderStatus status;
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async => ResourceResult(
    resource: TradingOrder(
      orderId: 'failed-order',
      symbol: intent.symbol,
      kind: intent.kind,
      side: intent.side,
      type: intent.type,
      status: status,
      failureReason: 'Chain execution failed',
      createdAt: DateTime.utc(2026),
    ),
  );
}

final class _RejectedApprovalOrders extends _OrdersRepository {
  _RejectedApprovalOrders(this.failure);

  final ApiFailure failure;
  final previewIds = <String?>[];

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) {
    previewIds.add(previewId);
    if (keys.isEmpty) {
      keys.add(idempotencyKey);
      throw failure;
    }
    return super.create(
      intent,
      idempotencyKey: idempotencyKey,
      previewId: previewId,
    );
  }
}

final class _RecordingObservabilityReporter implements ObservabilityReporter {
  final List<String> operations = [];
  final List<ApiFailure> failures = [];
  final List<Object> errors = [];

  @override
  Future<void> clearUser() async {}

  @override
  void recordApiFailure({
    required String operation,
    required ApiFailure failure,
    StackTrace? stackTrace,
  }) {
    failures.add(failure);
    recordOperation(operation, outcome: 'failed');
  }

  @override
  void recordError({
    required String operation,
    required Object error,
    StackTrace? stackTrace,
  }) {
    errors.add(error);
    recordOperation(operation, outcome: 'failed');
  }

  @override
  void recordOperation(String operation, {required String outcome}) {
    operations.add('$operation:$outcome');
  }

  @override
  Future<void> setUserId(String userId) async {}
}

OrderIntent _intent(String symbol) => OrderIntent(
  symbol: symbol,
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.market,
  quantity: DecimalValue('1', unit: 'quantity'),
);

TradingOrder _perpOrder() => TradingOrder(
  orderId: 'perp-1',
  symbol: 'xyz:NVDA',
  kind: MarketProductKind.perp,
  side: TradingSide.long,
  type: TradingOrderType.limit,
  status: TradingOrderStatus.open,
  createdAt: DateTime.utc(2026),
);

final class _CancelExecution implements Hip3OrderExecutionRepository {
  String? orderId;
  String? key;
  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  }) async {
    this.orderId = orderId;
    key = idempotencyKey;
    return ResourceResult(resource: _perpOrder());
  }

  @override
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(String orderId) =>
      throw UnimplementedError();

  @override
  Future<DomainPage<Hip3ActionSummary>> listActions({String? cursor}) async =>
      const DomainPage(items: []);

  @override
  Future<Hip3ActionSummary> getAction(String actionId) =>
      throw UnimplementedError();

  @override
  Future<Hip3ActionSummary> cancelAction(
    String actionId, {
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

final class _OrdersRepository implements OrdersRepository {
  MarketProductKind? listedKind;
  int createCalls = 0;
  final List<String> keys = [];
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    createCalls++;
    keys.add(idempotencyKey);
    await Future<void>.delayed(const Duration(milliseconds: 2));
    return ResourceResult(
      resource: TradingOrder(
        orderId: 'order-$createCalls',
        symbol: intent.symbol,
        kind: intent.kind,
        side: intent.side,
        type: intent.type,
        status: TradingOrderStatus.submitted,
        createdAt: DateTime.utc(2026),
      ),
    );
  }

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async {
    listedKind = kind;
    return const DomainPage(items: []);
  }

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
  }) => preview(intent, idempotencyKey: idempotencyKey);
  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) =>
      throw UnimplementedError();
  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

final class _FailingOrdersRepository extends _OrdersRepository {
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) => Future<ResourceResult<TradingOrder>>.error(const NetworkFailure());
}

final class _DeferredOrders extends _OrdersRepository {
  final pending = Completer<ResourceResult<TradingOrder>>();
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) => pending.future;
}

final class _QuoteOrders extends _OrdersRepository {
  final previewKeys = <String>[];
  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    previewKeys.add(idempotencyKey);
    return OrderPreview(
      previewId: idempotencyKey,
      intent: intent,
      orderValue: DecimalValue('15'),
    );
  }
}

TradingOrder _bstocksOrder({
  TradingOrderStatus status = TradingOrderStatus.awaitingConfirmation,
}) => TradingOrder(
  orderId: 'original-order',
  symbol: 'NVDA',
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.market,
  status: status,
  createdAt: DateTime.utc(2026),
  walletActionBlocker: status == TradingOrderStatus.awaitingConfirmation
      ? 'previewRequired'
      : null,
);

final class _ContinuationOrders extends _OrdersRepository {
  final continuationOrderIds = <String>[];
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    createCalls++;
    if (createCalls != 1) {
      throw StateError('A continuation cannot create a new order');
    }
    return ResourceResult(resource: _bstocksOrder());
  }

  @override
  Future<OrderPreview> previewContinuation(
    String orderId,
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    continuationOrderIds.add(orderId);
    return OrderPreview(
      previewId: 'continuation-preview',
      intent: intent,
      orderValue: DecimalValue('15'),
      approvalRequired: true,
    );
  }
}

final class _BstocksExecution implements BstocksOrderExecutionRepository {
  bool failContinuationOnce = false;
  int cancelCalls = 0;
  final continuationOrders = <String>[];
  final continuationPreviews = <String>[];
  final approvalStops = <bool>[];
  @override
  Future<ResourceResult<TradingOrder>> continueOrder({
    required OrderIntent intent,
    required String orderId,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) async {
    continuationOrders.add(orderId);
    continuationPreviews.add(previewId);
    approvalStops.add(stopAfterApproval);
    if (failContinuationOnce) {
      failContinuationOnce = false;
      throw const NetworkFailure();
    }
    return ResourceResult(
      resource: _bstocksOrder(
        status: stopAfterApproval
            ? TradingOrderStatus.awaitingConfirmation
            : TradingOrderStatus.open,
      ),
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    bool Function()? isCancelled,
  }) async {
    cancelCalls++;
    await Future<void>.delayed(const Duration(milliseconds: 2));
    return ResourceResult(
      resource: _bstocksOrder(status: TradingOrderStatus.cancelled),
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) => throw UnimplementedError();

  @override
  Future<ResourceResult<TradingOrder>> executeExisting({
    required ResourceResult<TradingOrder> order,
    bool Function()? isCancelled,
  }) => throw UnimplementedError();
}

final class _SessionOrders extends _OrdersRepository {
  final pending = <Completer<ResourceResult<TradingOrder>>>[];
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) {
    final request = Completer<ResourceResult<TradingOrder>>();
    pending.add(request);
    return request.future;
  }
}

final class _PendingCancellation extends _BstocksExecution {
  final started = Completer<void>();
  final pending = Completer<ResourceResult<TradingOrder>>();
  bool Function()? isCancelled;

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    bool Function()? isCancelled,
  }) {
    this.isCancelled = isCancelled;
    started.complete();
    return pending.future;
  }
}

final class _HiddenActionReplayOrders extends _OrdersRepository {
  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async => ResourceResult(
    resource: TradingOrder(
      orderId: 'original-order',
      symbol: intent.symbol,
      kind: intent.kind,
      side: intent.side,
      type: intent.type,
      status: TradingOrderStatus.awaitingConfirmation,
      createdAt: DateTime.utc(2026),
      currentActionId: 'action-1',
      walletActionBlocker: 'orderInFlight',
    ),
  );
}

final class _RecoveryExecution extends _BstocksExecution {
  final executedOrderIds = <String>[];
  final cancellationChecks = <bool Function()>[];
  final started = Completer<void>();
  Completer<ResourceResult<TradingOrder>>? pending;
  ApiFailure? executeFailure;
  @override
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) async {
    executedOrderIds.add(created.resource.orderId);
    cancellationChecks.add(isCancelled!);
    if (!started.isCompleted) started.complete();
    if (executeFailure case final failure?) throw failure;
    if (created.resource.orderId == 'old-order' && pending != null) {
      return pending!.future;
    }
    return created;
  }
}

ResourceResult<TradingOrder> _activeBstocksOrder(String id) => ResourceResult(
  resource: TradingOrder(
    orderId: id,
    symbol: 'NVDA',
    kind: MarketProductKind.bstock,
    side: TradingSide.buy,
    type: TradingOrderType.market,
    status: TradingOrderStatus.submitted,
    createdAt: DateTime.utc(2026),
    nextAction: BstocksOrderAction(
      orderId: id,
      actionId: 'action-$id',
      kind: BstocksOrderActionKind.executeIocOrder,
      status: BstocksOrderActionStatus.awaitingSignature,
      chainId: 56,
      from: '0x1111111111111111111111111111111111111111',
      to: '0x2222222222222222222222222222222222222222',
      data: '0xbb',
      value: '0x0',
      payloadHash: 'hash',
      validUntil: DateTime.utc(2030),
    ),
  ),
);
