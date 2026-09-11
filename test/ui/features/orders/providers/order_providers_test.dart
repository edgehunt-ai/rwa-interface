import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/observability_providers.dart';
import 'package:rwa_interface/app/observability/observability_reporter.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/hip3_action_summary.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/application_state.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/repositories/hip3_order_execution_repository.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';

void main() {
  test(
    'refreshing an HIP3 quote uses a new key while replay shares its key',
    () async {
      final repository = _QuoteOrders();
      final container = ProviderContainer(
        overrides: [ordersRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final intent = OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.perp,
        side: TradingSide.long,
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
    expect(execution.key, 'hip3-cancel-perp-1');
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
      expect(repository.keys.last, firstKey);
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
}

final class _RecordingObservabilityReporter implements ObservabilityReporter {
  final List<String> operations = [];
  final List<ApiFailure> failures = [];

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
