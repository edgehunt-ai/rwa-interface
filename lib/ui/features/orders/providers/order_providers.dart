import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:math';

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
            idempotencyKey: intent.kind != MarketProductKind.perp
                ? 'preview-${intent.fingerprint.hashCode}'
                : 'preview-${List.generate(16, (_) => Random.secure().nextInt(256).toRadixString(16).padLeft(2, '0')).join()}',
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
    final result = await _commands.run(
      operation: 'cancel-hip3-action',
      fingerprint: actionId,
      command: (key) => _ref
          .read(hip3OrderExecutionRepositoryProvider)
          .cancelAction(actionId, idempotencyKey: key),
    );
    _ref.invalidate(hip3ActionsProvider);
    _ref.invalidate(hip3ActionProvider(actionId));
    return result;
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

  @override
  CommandState<OrderIntent, ResourceResult<TradingOrder>> build() {
    ref.watch(sessionGenerationProvider);
    _fingerprint = null;
    _idempotencyKey = null;
    _inFlight = null;
    return const CommandIdle();
  }

  Future<ResourceResult<TradingOrder>?> submit(
    OrderIntent intent, {
    String? previewId,
  }) async {
    final generation = ref.read(sessionGenerationProvider);
    bool isCurrent() =>
        ref.mounted && ref.read(sessionGenerationProvider) == generation;
    if (_inFlight case final active?) {
      try {
        final result = await active;
        return isCurrent() ? result : null;
      } on ApiFailure {
        return null;
      }
    }
    if (_fingerprint != intent.fingerprint) {
      _fingerprint = intent.fingerprint;
      _idempotencyKey = 'order-${DateTime.now().microsecondsSinceEpoch}';
    }
    final key = _idempotencyKey!;
    state = CommandSubmitting<OrderIntent, ResourceResult<TradingOrder>>(
      intent,
      key,
    );
    final request = ref
        .read(ordersRepositoryProvider)
        .create(intent, idempotencyKey: key, previewId: previewId);
    _inFlight = request;
    try {
      final result = await request;
      if (!isCurrent()) return null;
      state = CommandAccepted(
        intent: intent,
        idempotencyKey: key,
        result: result,
      );
      ref.invalidate(ordersProvider);
      ref.invalidate(hip3OrdersProvider);
      ref.invalidate(orderProvider(result.resource.orderId));
      return result;
    } on ApiFailure catch (failure) {
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

  Future<void> cancel(TradingOrder order) async {
    final key =
        'cancel-${order.orderId}-${DateTime.now().microsecondsSinceEpoch}';
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
      ref.invalidate(orderProvider(result.resource.orderId));
    } finally {
      ref.invalidate(hip3OrdersProvider);
      ref.invalidate(hip3OpenOrdersProvider);
      ref.invalidate(orderProvider(order.orderId));
    }
  }
}
