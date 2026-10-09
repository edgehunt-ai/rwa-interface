import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/observability_providers.dart';
import '../../../../domain/models/hip3_opening_context.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../data/api/idempotency_key.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/application_state.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/hip3_action_summary.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/order_preview.dart';
import '../../portfolio/providers/portfolio_providers.dart';
import '../../../../domain/models/resource_result.dart';

final hip3OpeningContextProvider = FutureProvider.autoDispose
    .family<Hip3OpeningContext, String>((ref, product) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(hip3OpeningRepositoryProvider).context(product);
    });

final ordersProvider = FutureProvider.autoDispose
    .family<DomainPage<ResourceResult<TradingOrder>>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(ordersRepositoryProvider).list(cursor: cursor);
    });

final bstocksOrdersProvider = FutureProvider.autoDispose
    .family<DomainPage<ResourceResult<TradingOrder>>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(ordersRepositoryProvider)
          .list(cursor: cursor, kind: MarketProductKind.bstock);
    });

typedef BstocksOpenOrderQuery = ({String symbol, String? productId});

/// Fetch every server-filtered page so the existing Open tab needs no new flow.
final bstocksOpenOrdersProvider = FutureProvider.autoDispose
    .family<DomainPage<ResourceResult<TradingOrder>>, BstocksOpenOrderQuery>(
      (ref, query) async {
        ref.watch(sessionGenerationProvider);
        final repository = ref.watch(ordersRepositoryProvider);
        final orders = <String, ResourceResult<TradingOrder>>{};
        final cursors = <String>{};
        String? cursor;
        do {
          final page = await repository.list(
            kind: MarketProductKind.bstock,
            symbol: query.symbol,
            productId: query.productId,
            statusGroup: 'open',
            cursor: cursor,
          );
          if (!ref.mounted) throw const CancelledFailure();
          for (final item in page.items) {
            final order = item.resource;
            if (order.kind == MarketProductKind.bstock &&
                order.symbol == query.symbol &&
                (query.productId == null ||
                    order.productId == null ||
                    order.productId == query.productId) &&
                order.isOpen) {
              orders[order.orderId] = item;
            }
          }
          if (!page.hasMore) break;
          cursor = page.nextCursor;
          if (cursor == null || cursor.isEmpty || !cursors.add(cursor)) {
            throw const CompatibilityFailure(
              userAction: 'Open orders pagination is incomplete',
            );
          }
        } while (true);
        return DomainPage(items: List.unmodifiable(orders.values));
      },
      retry: (count, error) => error is CompatibilityFailure
          ? null
          : ProviderContainer.defaultRetry(count, error),
    );

final hip3OrdersProvider = FutureProvider.autoDispose
    .family<DomainPage<ResourceResult<TradingOrder>>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(ordersRepositoryProvider)
          .list(cursor: cursor, kind: MarketProductKind.perp);
    });

typedef Hip3OpenOrderQuery = ({
  String symbol,
  String? productId,
  String? cursor,
});

/// Filter before pagination, never after fetching an arbitrary history page.
final hip3OpenOrdersProvider = FutureProvider.autoDispose
    .family<DomainPage<ResourceResult<TradingOrder>>, Hip3OpenOrderQuery>((
      ref,
      query,
    ) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(ordersRepositoryProvider)
          .list(
            kind: MarketProductKind.perp,
            symbol: query.symbol,
            productId: query.productId,
            statusGroup: 'open',
            cursor: query.cursor,
          );
    });

final orderProvider = FutureProvider.autoDispose
    .family<ResourceResult<TradingOrder>, String>((ref, orderId) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(ordersRepositoryProvider).get(orderId);
    });

final orderPreviewProvider = FutureProvider.autoDispose
    .family<OrderPreview, OrderIntent>((ref, intent) {
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(ordersRepositoryProvider);
      final command = ref.watch(orderCommandProvider);
      final acceptedOrderId = switch (command) {
        CommandAccepted<OrderIntent, ResourceResult<TradingOrder>>(
          intent: final acceptedIntent,
          result: final result,
        )
            when acceptedIntent.fingerprint == intent.fingerprint &&
                result.resource.kind == MarketProductKind.bstock &&
                result.resource.status ==
                    TradingOrderStatus.awaitingConfirmation =>
          result.resource.orderId,
        _ => null,
      };
      final continuationOrderId =
          acceptedOrderId ??
          ref
              .read(orderCommandProvider.notifier)
              .continuationOrderIdFor(intent);
      if (continuationOrderId != null) {
        return repository.previewContinuation(
          continuationOrderId,
          intent,
          idempotencyKey: newIdempotencyKey(),
        );
      }
      return repository.preview(
        intent,
        // A new quote must not reuse an expired immutable server preview.
        idempotencyKey: newIdempotencyKey(),
      );
    });

final hip3ActionsProvider = FutureProvider.autoDispose
    .family<DomainPage<Hip3ActionSummary>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(hip3OrderExecutionRepositoryProvider)
          .listActions(cursor: cursor);
    });

final hip3ActionProvider = FutureProvider.autoDispose
    .family<Hip3ActionSummary, String>((ref, actionId) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(hip3OrderExecutionRepositoryProvider)
          .getAction(actionId);
    });

final hip3ActionCommandsProvider = Provider.autoDispose(
  (ref) => Hip3ActionCommands(ref),
);

final class Hip3ActionCommands {
  Hip3ActionCommands(this._ref);

  final Ref _ref;
  final IdempotentCommandGuard _commands = IdempotentCommandGuard();

  Future<Hip3ActionSummary> cancel(String actionId) async {
    const operation = 'cancel_hip3_action';
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result = await _commands.run(
        operation: 'cancel-hip3-action',
        fingerprint: actionId,
        command: (key) => _ref
            .read(hip3OrderExecutionRepositoryProvider)
            .cancelAction(actionId, idempotencyKey: key),
      );
      _ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
      _ref.invalidate(hip3ActionsProvider);
      _ref.invalidate(hip3ActionProvider(actionId));
      return result;
    } on ApiFailure catch (failure, stackTrace) {
      _ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      rethrow;
    }
  }
}

final orderCommandProvider =
    NotifierProvider<
      OrderCommandNotifier,
      CommandState<OrderIntent, ResourceResult<TradingOrder>>
    >(OrderCommandNotifier.new);

final class OrderCommandNotifier
    extends Notifier<CommandState<OrderIntent, ResourceResult<TradingOrder>>> {
  String? _fingerprint;
  String? _idempotencyKey;
  String? _requestPreviewId;
  String? _continuationOrderId;
  String? _continuationIntentFingerprint;
  Future<ResourceResult<TradingOrder>>? _inFlight;
  IdempotentCommandGuard _cancellations = IdempotentCommandGuard();
  var _submissionGeneration = 0;

  @override
  CommandState<OrderIntent, ResourceResult<TradingOrder>> build() {
    ref.watch(sessionGenerationProvider);
    _fingerprint = null;
    _idempotencyKey = null;
    _requestPreviewId = null;
    _continuationOrderId = null;
    _continuationIntentFingerprint = null;
    _inFlight = null;
    _cancellations = IdempotentCommandGuard();
    _submissionGeneration = 0;
    return const CommandIdle();
  }

  String? continuationOrderIdFor(OrderIntent intent) =>
      _continuationIntentFingerprint == intent.fingerprint
      ? _continuationOrderId
      : null;

  Future<ResourceResult<TradingOrder>?> submit(
    OrderIntent intent, {
    String? previewId,
  }) => _runOrderCommand(intent, previewId: previewId, approvalOnly: false);

  Future<ResourceResult<TradingOrder>?> approve(
    OrderIntent intent, {
    required String previewId,
  }) => _runOrderCommand(intent, previewId: previewId, approvalOnly: true);

  Future<ResourceResult<TradingOrder>?> _runOrderCommand(
    OrderIntent intent, {
    required String? previewId,
    required bool approvalOnly,
  }) async {
    final operation = approvalOnly ? 'approve_bstocks' : 'create_order';
    final generation = ref.read(sessionGenerationProvider);
    if (_inFlight case final active?) {
      try {
        final result = await active;
        return ref.mounted && ref.read(sessionGenerationProvider) == generation
            ? result
            : null;
      } on ApiFailure {
        return null;
      } catch (_) {
        // The owner of the in-flight request records the concrete failure.
        // Concurrent callers should not leak an SDK/plugin exception.
        return null;
      }
    }
    final submissionGeneration = ++_submissionGeneration;
    bool isCurrent() =>
        ref.mounted &&
        ref.read(sessionGenerationProvider) == generation &&
        _submissionGeneration == submissionGeneration;
    final commandFingerprint =
        '${approvalOnly ? 'approval' : 'order'}|${intent.fingerprint}';
    if (_fingerprint != commandFingerprint) {
      _fingerprint = commandFingerprint;
      _idempotencyKey = newIdempotencyKey();
      _requestPreviewId = previewId;
    }
    final key = _idempotencyKey!;
    final continuationOrderId =
        _continuationIntentFingerprint == intent.fingerprint
        ? _continuationOrderId
        : switch (state) {
            CommandAccepted<OrderIntent, ResourceResult<TradingOrder>>(
              intent: final acceptedIntent,
              result: final result,
            )
                when acceptedIntent.fingerprint == intent.fingerprint &&
                    result.resource.kind == MarketProductKind.bstock &&
                    result.resource.status ==
                        TradingOrderStatus.awaitingConfirmation =>
              result.resource.orderId,
            _ => null,
          };
    // Replaying an uncertain command must preserve the entire create request,
    // even if the confirmation view has fetched a newer display quote.
    final requestPreviewId = _requestPreviewId;
    debugPrint(
      'bStocks/order submit: creating order '
      'preview=$requestPreviewId key=$key kind=${intent.kind.name}',
    );
    state = CommandSubmitting<OrderIntent, ResourceResult<TradingOrder>>(
      intent,
      key,
    );
    final request = _submitOrder(
      intent,
      idempotencyKey: key,
      previewId: requestPreviewId,
      isCancelled: () => !isCurrent(),
      stopAfterApproval: approvalOnly,
      continuationOrderId: continuationOrderId,
    );
    _inFlight = request;
    ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result = await request;
      if (!isCurrent()) return null;
      result.resource.checkBstocksExecutionFailure();
      if (approvalOnly &&
          result.resource.kind == MarketProductKind.bstock &&
          result.resource.status == TradingOrderStatus.awaitingConfirmation) {
        _continuationOrderId = result.resource.orderId;
        _continuationIntentFingerprint = intent.fingerprint;
      } else if (continuationOrderId != null) {
        _continuationOrderId = null;
        _continuationIntentFingerprint = null;
      }
      // A successful command is complete. A later trade or continuation uses
      // fresh consent and a new key; uncertain failures retain their request.
      _fingerprint = null;
      _idempotencyKey = null;
      _requestPreviewId = null;
      state = CommandAccepted(
        intent: intent,
        idempotencyKey: key,
        result: result,
      );
      ref.invalidate(ordersProvider);
      ref.invalidate(bstocksOrdersProvider);
      ref.invalidate(bstocksOpenOrdersProvider);
      ref.invalidate(hip3OrdersProvider);
      ref.invalidate(orderProvider(result.resource.orderId));
      // Order acceptance can change reserved/available balances and holdings
      // even when the order is still processing. Keep portfolio surfaces from
      // serving the pre-order snapshot while the user moves between pages.
      ref.invalidate(portfolioSummaryProvider);
      ref.invalidate(tradingAccountsProvider);
      ref.invalidate(holdingsProvider);
      ref.invalidate(bstocksSellAvailabilityProvider);
      ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
      return result;
    } on CancelledFailure {
      if (isCurrent()) state = const CommandIdle();
      return null;
    } on ApiFailure catch (failure, stackTrace) {
      if (!isCurrent()) return null;
      ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      // A rejected preview created no wallet action. A replacement quote
      // needs a new create key; ambiguous failures must keep their original key.
      if (failure is ServerFailure &&
          const {
            'preview_expired',
            'bstocks_preview_changed',
            'bstocks_preview_already_consumed',
          }.contains(failure.code)) {
        _fingerprint = null;
        _idempotencyKey = null;
        _requestPreviewId = null;
      }
      state = CommandFailure<OrderIntent, ResourceResult<TradingOrder>>(
        intent: intent,
        idempotencyKey: key,
        failure: failure,
      );
      return null;
    } on FormatException catch (error) {
      // Keep malformed server payloads from escaping the command notifier and
      // leaving the order sheet permanently in its submitting state.
      final failure = CompatibilityFailure(
        userAction: '订单响应解析失败: ${error.message}',
      );
      if (!isCurrent()) return null;
      state = CommandFailure<OrderIntent, ResourceResult<TradingOrder>>(
        intent: intent,
        idempotencyKey: key,
        failure: failure,
      );
      return null;
    } catch (error, stackTrace) {
      if (!isCurrent()) return null;
      // SDK/plugin exceptions are not always ApiFailure instances. Convert
      // them here so the order sheet can show the provider's actual reason.
      final message = error.toString().trim();
      final failure = UnknownFailure(
        retryable: true,
        userAction: message.isEmpty
            ? approvalOnly
                  ? '授权失败'
                  : '订单提交失败'
            : '${approvalOnly ? '授权失败' : '订单提交失败'}: $message',
      );
      ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'failed');
      ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      state = CommandFailure<OrderIntent, ResourceResult<TradingOrder>>(
        intent: intent,
        idempotencyKey: key,
        failure: failure,
      );
      return null;
    } finally {
      if (isCurrent() && identical(_inFlight, request)) _inFlight = null;
    }
  }

  Future<ResourceResult<TradingOrder>> _submitOrder(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
    required bool Function() isCancelled,
    required bool stopAfterApproval,
    String? continuationOrderId,
  }) async {
    if (isCancelled()) throw const CancelledFailure();
    if (continuationOrderId != null) {
      return ref
          .read(bstocksOrderExecutionRepositoryProvider)
          .continueOrder(
            intent: intent,
            orderId: continuationOrderId,
            previewId: previewId!,
            isCancelled: isCancelled,
            stopAfterApproval: stopAfterApproval,
          );
    }
    final created = await ref
        .read(ordersRepositoryProvider)
        .create(intent, idempotencyKey: idempotencyKey, previewId: previewId);
    if (isCancelled()) throw const CancelledFailure();
    debugPrint(
      'bStocks/order submit: order created '
      'order=${created.resource.orderId} '
      'status=${created.resource.status.name} '
      'action=${created.resource.actionStatus?.name} '
      'nextAction=${created.resource.nextAction?.kind.name}',
    );
    // The API may create the order before releasing its first frozen wallet
    // action. In that state `next_action` is temporarily null and the Web
    // client keeps polling. Only skip the executor for terminal/review orders
    // or clearly unrelated legacy/app-review results.
    final order = created.resource;
    order.checkBstocksExecutionFailure();
    final shouldExecuteBstocks =
        intent.kind == MarketProductKind.bstock &&
        !order.isTerminal &&
        order.status != TradingOrderStatus.manualReview &&
        (order.nextAction != null ||
            order.currentActionId != null ||
            const {
              'actionNotReady',
              'action_not_ready',
            }.contains(order.walletActionBlocker));
    if (!shouldExecuteBstocks) {
      return created;
    }
    return ref
        .read(bstocksOrderExecutionRepositoryProvider)
        .execute(
          intent: intent,
          created: created,
          previewId: previewId!,
          isCancelled: isCancelled,
          stopAfterApproval: stopAfterApproval,
        );
  }

  /// Stops client-side bStocks polling when the order sheet is dismissed.
  /// This does not cancel a transaction already accepted by the server.
  void cancelSubmission() {
    _submissionGeneration++;
    _inFlight = null;
    if (ref.mounted) state = const CommandIdle();
  }

  Future<void> cancel(TradingOrder order) async {
    const operation = 'cancel_order';
    final generation = ref.read(sessionGenerationProvider);
    bool isCurrent() =>
        ref.mounted && ref.read(sessionGenerationProvider) == generation;
    final key = newIdempotencyKey();
    ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result = order.kind == MarketProductKind.bstock
          ? await _cancellations.run(
              operation: 'cancel-bstocks',
              fingerprint: order.orderId,
              command: (_) => ref
                  .read(bstocksOrderExecutionRepositoryProvider)
                  .cancelOrder(order.orderId, isCancelled: () => !isCurrent()),
            )
          : order.kind == MarketProductKind.perp &&
                (order.status == TradingOrderStatus.open ||
                    order.status == TradingOrderStatus.partiallyFilled)
          ? await ref
                .read(hip3OrderExecutionRepositoryProvider)
                .cancelOrder(
                  order.orderId,
                  idempotencyKey: scopedIdempotencyKey(
                    'hip3-cancel-${order.orderId}',
                  ),
                )
          : await ref
                .read(ordersRepositoryProvider)
                .cancel(order.orderId, idempotencyKey: key);
      if (!isCurrent()) return;
      ref.invalidate(ordersProvider);
      ref.invalidate(bstocksOrdersProvider);
      ref.invalidate(bstocksOpenOrdersProvider);
      ref.invalidate(orderProvider(result.resource.orderId));
      ref.invalidate(bstocksSellAvailabilityProvider);
      ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
    } on ApiFailure catch (failure, stackTrace) {
      if (!isCurrent()) return;
      ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      rethrow;
    } catch (_) {
      if (!isCurrent()) return;
      rethrow;
    } finally {
      if (isCurrent()) {
        ref.invalidate(hip3OrdersProvider);
        ref.invalidate(hip3OpenOrdersProvider);
        ref.invalidate(orderProvider(order.orderId));
      }
    }
  }
}
