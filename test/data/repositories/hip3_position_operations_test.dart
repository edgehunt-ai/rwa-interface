import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/positions_repository_impl.dart';
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/positions_service.dart';
import 'package:rwa_interface/data/services/hip3_position_action_service.dart';
import 'package:rwa_interface/data/services/hip3_position_action_executor.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
import 'package:rwa_interface/domain/models/position_operation.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/hip3_action_pending.dart';

void main() {
  test('wire conditional details survive repository mapping', () {
    final order = api.standardSerializers.deserializeWith(
      api.Order.serializer,
      {
        'order_id': 'tp',
        'product_id': 'xyz:TSLA',
        'position_id': 'p-tsla',
        'symbol': 'TSLA',
        'kind': 'perp',
        'side': 'short',
        'type': 'market',
        'status': 'partially_filled',
        'quantity': '0.5',
        'filled_quantity': '0.1',
        'created_at': '2026-09-10T00:00:00Z',
        'conditional': {
          'role': 'take_profit',
          'trigger_price': '130',
          'trigger_reference': 'mark',
          'execution_type': 'market',
          'trigger_status': 'triggered',
          'protection_group_id': 'p-tsla',
          'position_id': 'p-tsla',
          'size_mode': 'quantity',
          'quantity': '0.5',
          'reduce_only': true,
        },
      },
    )!;
    final mapped = mapOrder(order);
    expect(mapped.productId, 'xyz:TSLA');
    expect(mapped.conditional!.role, 'takeProfit');
    expect(mapped.conditional!.triggerPrice.value, '130');
    expect(mapped.conditional!.triggerStatus, 'triggered');
    expect(mapped.conditional!.sizeMode, 'quantity');
    expect(mapped.filledQuantity!.value, '0.1');
  });
  late _Positions positions;
  late _Actions actions;
  late PositionsRepositoryImpl repo;
  setUp(() {
    positions = _Positions();
    actions = _Actions();
    repo = PositionsRepositoryImpl(
      positions,
      actions: actions,
      executor: Hip3PositionActionExecutor(actions, _Signer()),
      confirm: (_) async => false,
    );
  });

  for (final type in TradingOrderType.values) {
    for (final short in [false, true]) {
      test(
        '$type close binds non-NVDA product, direction and frozen preview, short=$short',
        () async {
          positions.short = short;
          actions.short = short;
          final position = await repo.get('p-tsla');
          await repo.close(
            position.positionId,
            expectedPosition: position,
            type: type,
            limitPrice: type == TradingOrderType.limit ? '110' : null,
            quantity: '0.25',
            idempotencyKey: 'close-1',
          );
          expect(actions.previewCalls, 1);
          expect(actions.request!.type!.name, type.name);
          expect(actions.request!.quantity, '0.25');
          expect(actions.request!.percent, isNull);
          expect(actions.positionId, 'p-tsla');
          expect(
            actions.created.single.intent.oneOf.value,
            isA<api.Hip3CloseActionRequest>(),
          );
          expect(actions.created.single.productId, 'xyz:TSLA');
          await repo.close(
            position.positionId,
            expectedPosition: position,
            type: type,
            limitPrice: type == TradingOrderType.limit ? '110' : null,
            quantity: '0.25',
            idempotencyKey: 'close-1',
          );
          expect(
            actions.previewCalls,
            1,
            reason: 'retry must preserve preview',
          );
          expect(actions.keys.toSet(), {'close-1'});
        },
      );
    }
  }

  test('all and partial percentages travel unchanged; invalid inputs never call provider', () async {
    await repo.close('p-tsla', percent: '50', idempotencyKey: 'half');
    expect(actions.request!.percent, '50');
    await repo.close('p-tsla', idempotencyKey: 'all');
    expect(actions.request!.percent, '100');
    final before = actions.previewCalls;
    for (final value in ['0', '-1', '100.000000000000000001']) {
      await expectLater(
        repo.close('p-tsla', percent: value, idempotencyKey: value),
        throwsArgumentError,
      );
    }
    await expectLater(
      repo.close(
        'p-tsla',
        quantity: '1.000000000000000001',
        idempotencyKey: 'oversize',
      ),
      throwsArgumentError,
    );
    await expectLater(
      repo.close(
        'p-tsla',
        type: TradingOrderType.limit,
        idempotencyKey: 'no-price',
      ),
      throwsArgumentError,
    );
    expect(actions.previewCalls, before);
  });

  test('changed position or mismatched preview is rejected before creating an action', () async {
    final position = await repo.get('p-tsla');
    positions.short = true;
    await expectLater(
      repo.close(
        'p-tsla',
        expectedPosition: position,
        idempotencyKey: 'changed',
      ),
      throwsFormatException,
    );
    expect(actions.previewCalls, 0);
    positions.short = false;
    actions.wrongProduct = true;
    await expectLater(
      repo.close('p-tsla', idempotencyKey: 'wrong'),
      throwsFormatException,
    );
    expect(actions.created, isEmpty);
  });

  test('percent close cannot be expanded by the preview, decimal limits may normalize safely', () async {
    actions.previewQuantity = '1';
    await expectLater(
      repo.close('p-tsla', percent: '50', idempotencyKey: 'too-large'),
      throwsArgumentError,
    );
    expect(actions.created, isEmpty);
    actions.previewQuantity = null;
    actions.previewLimit = '110.00';
    await repo.close(
      'p-tsla',
      quantity: '0.25',
      type: TradingOrderType.limit,
      limitPrice: '110',
      idempotencyKey: 'normalize',
    );
    actions.previewLimit = '109.9';
    await expectLater(
      repo.close(
        'p-tsla',
        quantity: '0.25',
        type: TradingOrderType.limit,
        limitPrice: '110',
        idempotencyKey: 'bad-limit',
      ),
      throwsFormatException,
    );
  });

  test('switching one leg off cancels its exact scope before setting the retained leg', () async {
    final position = await repo.get('p-tsla');
    await repo.updateTpSl(
      position,
      stopLoss: '90',
      quantity: '0.2',
      clearScope: ProtectionClearScope.takeProfit,
      idempotencyKey: 'edit',
    );
    expect(actions.created.map((a) => a.operation.name), [
      'clearTpsl',
      'setTpsl',
    ]);
    final clear =
        actions.created.first.intent.oneOf.value
            as api.Hip3ClearTpSlActionRequest;
    expect(clear.scope.name, 'takeProfit');
    final set =
        actions.created.last.intent.oneOf.value as api.Hip3SetTpSlActionRequest;
    expect(set.protection.sizeMode.name, 'quantity');
    expect(set.protection.quantity, '0.2');
    expect(set.protection.takeProfit, isNull);
    expect(set.protection.stopLoss!.triggerPrice, '90');
    expect(actions.keys, ['edit-clear', 'edit-set']);
  });

  test(
    'both off only clears, pending cancellation never proceeds to set',
    () async {
      final position = await repo.get('p-tsla');
      await repo.updateTpSl(
        position,
        clearScope: ProtectionClearScope.both,
        idempotencyKey: 'clear',
      );
      expect(actions.created, hasLength(1));
      actions.pending = true;
      await expectLater(
        repo.updateTpSl(
          position,
          stopLoss: '90',
          clearScope: ProtectionClearScope.takeProfit,
          idempotencyKey: 'pending',
        ),
        throwsA(isA<Hip3ActionPending>()),
      );
      expect(actions.created.last.operation, api.Hip3Operation.clearTpsl);
      expect(
        actions.created.where((a) => a.operation == api.Hip3Operation.setTpsl),
        isEmpty,
      );
    },
  );
}

class _Positions implements PositionsService {
  bool short = false;
  @override
  Future<api.Position> getPosition(String id) async =>
      api.standardSerializers.deserializeWith(api.Position.serializer, {
        'position_id': id,
        'position_version': 'v1',
        'product_id': 'xyz:TSLA',
        'symbol': 'TSLA',
        'kind': 'perp',
        'side': short ? 'short' : 'long',
        'quantity': short ? '-1' : '1',
        'value_usd': '100',
        'mark_price': '100',
        'take_profit_price': short ? '90' : '110',
        'stop_loss_price': short ? '110' : '90',
      })!;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Actions implements Hip3PositionActionService {
  String? previewQuantity, previewLimit;
  bool short = false, wrongProduct = false, pending = false;
  int previewCalls = 0;
  String? positionId;
  api.Hip3ClosePreviewRequest? request;
  final keys = <String>[];
  final created = <api.Hip3Action>[];
  @override
  Future<api.Hip3ClosePreview> previewClose(
    String id,
    api.Hip3ClosePreviewRequest request,
    String key,
  ) async {
    previewCalls++;
    positionId = id;
    this.request = request;
    return api.standardSerializers.deserializeWith(
      api.Hip3ClosePreview.serializer,
      {
        'preview_id': 'preview-$key',
        'position_id': id,
        'position_version': 'v1',
        'product_id': wrongProduct ? 'xyz:NVDA' : 'xyz:TSLA',
        'environment': 'testnet',
        'side': short ? 'long' : 'short',
        'type': request.type!.name,
        'time_in_force': request.type!.name == 'market' ? 'ioc' : 'gtc',
        'quantity':
            previewQuantity ??
            request.quantity ??
            (request.percent == '100' ? '1' : '0.5'),
        'remaining_quantity': '0',
        'entry_price': '99',
        'mark_price': '100',
        'limit_price': previewLimit ?? request.limitPrice,
        'estimated_price': '100',
        'notional_usdc': '25',
        'estimated_fee_usdc': '0.01',
        'estimated_realized_pnl_usdc': '0.24',
        'slippage_percent': '1',
        'quote_expires_at': '2099-01-01T00:00:00Z',
        'observed_at': '2026-09-10T00:00:00Z',
      },
    )!;
  }

  @override
  Future<api.Hip3Action> create(
    api.Hip3ActionCreateRequest request,
    String key,
  ) async {
    keys.add(key);
    final wire =
        api.standardSerializers.serializeWith(
              api.Hip3ActionCreateRequest.serializer,
              request,
            )!
            as Map;
    final action = api.standardSerializers.deserializeWith(
      api.Hip3Action.serializer,
      {
        'action_id': key,
        'operation': wire['operation'],
        'intent': wire,
        'position_id': 'p-tsla',
        'product_id': 'xyz:TSLA',
        'environment': 'testnet',
        'order_id': wire['operation'] == 'close_position' ? 'order-1' : null,
        'status': pending ? 'manual_review' : 'succeeded',
        'steps': <Object>[],
        'affected_order_ids': <String>[],
        'effects_applied': !pending,
        'created_at': '2026-09-10T00:00:00Z',
        'updated_at': '2026-09-10T00:00:00Z',
      },
    )!;
    created.add(action);
    return action;
  }

  @override
  Future<api.Hip3Action> get(String id) async =>
      created.lastWhere((a) => a.actionId == id);
  @override
  Future<api.Order> order(String id) async =>
      api.standardSerializers.deserializeWith(api.Order.serializer, {
        'order_id': id,
        'symbol': 'TSLA',
        'kind': 'perp',
        'side': short ? 'long' : 'short',
        'type': request!.type!.name,
        'status': 'open',
        'created_at': '2026-09-10T00:00:00Z',
      })!;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Signer implements Hip3TypedDataSigner {
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('These completed-action fixtures must not sign');
}
