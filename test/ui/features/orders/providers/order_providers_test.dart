import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
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
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(
            _FailingOrdersRepository(),
          ),
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
    },
  );
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
