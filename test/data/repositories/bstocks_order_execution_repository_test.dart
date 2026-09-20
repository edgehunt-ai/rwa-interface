import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/repositories/bstocks_order_execution_repository_impl.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/domain/repositories/bstocks_order_action_repository.dart';
import 'package:rwa_interface/domain/repositories/orders_repository.dart';
import 'package:rwa_interface/domain/services/embedded_wallet_transaction_sender.dart';

void main() {
  test('approval confirmation recreates the order and executes the swap', () async {
    final approval = _action(
      orderId: 'order-1',
      stepId: 'approval-1',
      kind: BstocksOrderActionKind.erc20Approval,
    );
    final swap = _action(
      orderId: 'order-2',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.spotSwap,
    );
    final orders = _ScriptedOrders(
      initial: _order('order-1', action: approval),
      refreshes: [
        _order(
          'order-1',
          action: approval,
          actionStatus: BstocksOrderActionStatus.submitted,
        ),
        _order('order-1', actionStatus: BstocksOrderActionStatus.confirmed),
        _order('order-2', action: swap),
        _order(
          'order-2',
          status: TradingOrderStatus.filled,
          actionStatus: BstocksOrderActionStatus.confirmed,
        ),
      ],
      recreated: _order('order-2', action: swap),
    );
    final actions = _Actions();
    final sender = _Sender();

    final result = await BstocksOrderExecutionRepositoryImpl(
      orders,
      actions,
      sender,
    ).execute(
      intent: _intent(),
      created: ResourceResult(resource: orders.initial),
    );

    expect(result.resource.status, TradingOrderStatus.filled);
    expect(sender.steps, ['approval-1', 'swap-1']);
    expect(actions.steps, ['approval-1', 'swap-1']);
    expect(orders.createCalls, 1);
  });

  test('a submitted action is not sent again while confirmation is pending', () async {
    final swap = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.spotSwap,
    );
    final orders = _ScriptedOrders(
      initial: _order('order-1', action: swap),
      refreshes: [
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
    );

    expect(sender.steps, ['swap-1']);
  });

  test('polls when the order is created before its first action is released', () async {
    final swap = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.spotSwap,
    );
    final orders = _ScriptedOrders(
      initial: _order(
        'order-1',
        status: TradingOrderStatus.pendingSignature,
      ),
      refreshes: [
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
    );

    expect(sender.steps, ['swap-1']);
  });

  test('wallet action without an embedded signer fails before submission', () async {
    final action = _action(
      orderId: 'order-1',
      stepId: 'swap-1',
      kind: BstocksOrderActionKind.spotSwap,
    );
    final actions = _Actions();

    expect(
      () => BstocksOrderExecutionRepositoryImpl(
        _ScriptedOrders(
          initial: _order('order-1', action: action),
          refreshes: const [],
        ),
        actions,
        null,
      ).execute(
        intent: _intent(),
        created: ResourceResult(resource: _order('order-1', action: action)),
      ),
      throwsA(isA<Exception>()),
    );
    expect(actions.steps, isEmpty);
  });
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
}) => BstocksOrderAction(
  orderId: orderId,
  stepId: stepId,
  ordinal: kind == BstocksOrderActionKind.erc20Approval ? 1 : 2,
  kind: kind,
  chainId: 56,
  from: '0x1111111111111111111111111111111111111111',
  to: '0x2222222222222222222222222222222222222222',
  data: kind == BstocksOrderActionKind.erc20Approval ? '0xaa' : '0xbb',
  value: '0x0',
  payloadHash: 'hash-$stepId',
  validUntil: DateTime.utc(2030),
);

TradingOrder _order(
  String orderId, {
  BstocksOrderAction? action,
  BstocksOrderActionStatus? actionStatus,
  TradingOrderStatus status = TradingOrderStatus.submitted,
}) => TradingOrder(
  orderId: orderId,
  symbol: 'NVDAB',
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.market,
  status: status,
  createdAt: DateTime.utc(2026),
  nextAction: action,
  actionStatus: actionStatus,
);

final class _ScriptedOrders implements OrdersRepository {
  _ScriptedOrders({
    required this.initial,
    required this.refreshes,
    this.recreated,
  });

  final TradingOrder initial;
  final List<TradingOrder> refreshes;
  final TradingOrder? recreated;
  var createCalls = 0;
  var _refreshIndex = 0;

  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) async =>
      ResourceResult(
        resource: refreshes[_refreshIndex++],
      );

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    createCalls++;
    return ResourceResult(resource: recreated!);
  }

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) => throw UnimplementedError();

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
}

final class _Actions implements BstocksOrderActionRepository {
  final steps = <String>[];

  @override
  Future<BstocksWalletActionSubmission> submit({
    required String orderId,
    required String stepId,
    required String transactionHash,
    required String idempotencyKey,
  }) async {
    steps.add(stepId);
    return BstocksWalletActionSubmission(
      orderId: orderId,
      actionId: stepId,
      status: 'submitted',
      transactionHash: transactionHash,
      updatedAt: DateTime.utc(2026),
    );
  }
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
