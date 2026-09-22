import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:math';

import '../../../../app/providers/observability_providers.dart';
import '../../../../domain/models/hip3_opening_context.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/application_state.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/hip3_action_summary.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/order_preview.dart';
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
      return ref
          .watch(ordersRepositoryProvider)
          .preview(
            intent,
            // A new quote must not reuse an expired immutable server preview.
            idempotencyKey:
                'preview-${List.generate(16, (_) => Random.secure().nextInt(256).toRadixString(16).padLeft(2, '0')).join()}',
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
  Future<ResourceResult<TradingOrder>>? _inFlight;
  var _submissionGeneration = 0;

  @override
  CommandState<OrderIntent, ResourceResult<TradingOrder>> build() {
    ref.watch(sessionGenerationProvider);
    _fingerprint = null;
    _idempotencyKey = null;
    _inFlight = null;
    _submissionGeneration = 0;
    return const CommandIdle();
  }

  Future<ResourceResult<TradingOrder>?> submit(
    OrderIntent intent, {
    String? previewId,
  }) async {
    const operation = 'create_order';
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
    if (_fingerprint != intent.fingerprint) {
      _fingerprint = intent.fingerprint;
      _idempotencyKey = 'order-${DateTime.now().microsecondsSinceEpoch}';
    }
    final key = _idempotencyKey!;
    debugPrint(
      'bStocks/order submit: creating order '
      'preview=$previewId key=$key kind=${intent.kind.name}',
    );
    state = CommandSubmitting<OrderIntent, ResourceResult<TradingOrder>>(
      intent,
      key,
    );
    final request = _submitOrder(
      intent,
      idempotencyKey: key,
      previewId: previewId,
      submissionGeneration: submissionGeneration,
    );
    _inFlight = request;
    ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result = await request;
      if (!isCurrent()) return null;
      state = CommandAccepted(
        intent: intent,
        idempotencyKey: key,
        result: result,
      );
      ref.invalidate(ordersProvider);
      ref.invalidate(bstocksOrdersProvider);
      ref.invalidate(hip3OrdersProvider);
      ref.invalidate(orderProvider(result.resource.orderId));
      ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
      return result;
    } on CancelledFailure {
      if (isCurrent()) state = const CommandIdle();
      return null;
    } on ApiFailure catch (failure, stackTrace) {
      ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      if (!isCurrent()) return null;
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
      // SDK/plugin exceptions are not always ApiFailure instances. Convert
      // them here so the order sheet can show the provider's actual reason.
      final message = error.toString().trim();
      final failure = UnknownFailure(
        retryable: true,
        userAction: message.isEmpty ? '订单提交失败' : '订单提交失败: $message',
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
      if (!isCurrent()) return null;
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
    required int submissionGeneration,
  }) async {
    final created = await ref
        .read(ordersRepositoryProvider)
        .create(intent, idempotencyKey: idempotencyKey, previewId: previewId);
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
    final shouldExecuteBstocks =
        intent.kind == MarketProductKind.bstock &&
        !order.isTerminal &&
        order.status != TradingOrderStatus.manualReview &&
        (order.nextAction != null ||
            order.actionStatus != null ||
            order.walletActionBlocker == 'action_not_ready');
    if (!shouldExecuteBstocks) {
      return created;
    }
    return ref
        .read(bstocksOrderExecutionRepositoryProvider)
        .execute(
          intent: intent,
          created: created,
          isCancelled: () => _submissionGeneration != submissionGeneration,
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
    final key =
        'cancel-${order.orderId}-${DateTime.now().microsecondsSinceEpoch}';
    ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result =
          order.kind == MarketProductKind.perp &&
              (order.status == TradingOrderStatus.open ||
                  order.status == TradingOrderStatus.partiallyFilled)
          ? await ref
                .read(hip3OrderExecutionRepositoryProvider)
                .cancelOrder(
                  order.orderId,
                  idempotencyKey: 'hip3-cancel-${order.orderId}',
                )
          : await ref
                .read(ordersRepositoryProvider)
                .cancel(order.orderId, idempotencyKey: key);
      ref.invalidate(ordersProvider);
      ref.invalidate(bstocksOrdersProvider);
      ref.invalidate(orderProvider(result.resource.orderId));
      ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
    } on ApiFailure catch (failure, stackTrace) {
      ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      rethrow;
    } finally {
      ref.invalidate(hip3OrdersProvider);
      ref.invalidate(hip3OpenOrdersProvider);
      ref.invalidate(orderProvider(order.orderId));
    }
  }
}
