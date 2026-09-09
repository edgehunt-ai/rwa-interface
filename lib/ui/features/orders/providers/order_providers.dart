import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/application_state.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/order_preview.dart';
import '../../../../domain/models/resource_result.dart';

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
            idempotencyKey: 'preview-${intent.fingerprint.hashCode}',
          );
    });

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
    if (_inFlight case final active?) return active;
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
      state = CommandFailure<OrderIntent, ResourceResult<TradingOrder>>(
        intent: intent,
        idempotencyKey: key,
        failure: failure,
      );
      return null;
    } finally {
      _inFlight = null;
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
      ref.invalidate(orderProvider(order.orderId));
    }
  }
}
