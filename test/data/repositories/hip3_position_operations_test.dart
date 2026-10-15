import 'package:nobell/domain/models/hip3_protection.dart';
import 'package:nobell/data/services/hip3_action_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/repositories/positions_repository_impl.dart';
import 'package:nobell/data/repositories/orders_repository_impl.dart';
import 'package:nobell/data/services/positions_service.dart';
import 'package:nobell/data/services/hip3_position_action_service.dart';
import 'package:nobell/data/services/hip3_position_action_executor.dart';
import 'package:nobell/domain/services/hip3_typed_data_signer.dart';
import 'package:nobell/domain/models/position_operation.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/hip3_action_pending.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/position_close_preview.dart';

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
        'next_action': null,
        'wallet_action_blocker': 'not_applicable',
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

  test(
    'close display preview maps estimates without creating any action',
    () async {
      final position = await repo.get('p-tsla');
      final preview = await repo.previewClose(
        position,
        quantity: '0.25',
        type: TradingOrderType.limit,
        limitPrice: '110',
        idempotencyKey: 'display-preview',
      );
      expect(actions.positionId, position.positionId);
      expect(actions.request!.quantity, '0.25');
      expect(actions.request!.percent, isNull);
      expect(actions.request!.type!.name, 'limit');
      expect(actions.request!.limitPrice, '110');
      expect(preview.previewId, 'preview-display-preview');
      expect(preview.quantity.value, '0.25');
      expect(preview.notional.value, '25');
      expect(preview.entryPrice.value, '99');
      expect(preview.markPrice.value, '100');
      expect(preview.estimatedPrice.value, '100');
      expect(preview.estimatedFee.value, '0.01');
      expect(preview.estimatedRealizedPnl.value, '0.24');
      expect(preview.liquidationPrice, isNull);
      expect(preview.expiresAt, DateTime.utc(2099));
      expect(preview.observedAt, DateTime.utc(2026, 9, 10));
      expect(actions.created, isEmpty);
      expect(actions.keys, isEmpty);
    },
  );

  test(
    'display preview rejects invalid inputs and mismatched response',
    () async {
      final position = await repo.get('p-tsla');
      for (final quantity in ['0', '-1', '1.000000000000000001']) {
        await expectLater(
          repo.previewClose(
            position,
            quantity: quantity,
            idempotencyKey: 'invalid',
          ),
          throwsArgumentError,
        );
      }
      await expectLater(
        repo.previewClose(
          position,
          quantity: '0.25',
          type: TradingOrderType.limit,
          idempotencyKey: 'no-price',
        ),
        throwsArgumentError,
      );
      expect(actions.previewCalls, 0);
      actions.wrongProduct = true;
      await expectLater(
        repo.previewClose(
          position,
          quantity: '0.25',
          idempotencyKey: 'wrong-product',
        ),
        throwsFormatException,
      );
      actions.wrongProduct = false;
      actions.previewQuantity = '0.5';
      await expectLater(
        repo.previewClose(
          position,
          quantity: '0.25',
          idempotencyKey: 'wrong-size',
        ),
        throwsArgumentError,
      );
      actions.previewQuantity = null;
      actions.previewLimit = '109';
      await expectLater(
        repo.previewClose(
          position,
          quantity: '0.25',
          type: TradingOrderType.limit,
          limitPrice: '110',
          idempotencyKey: 'wrong-limit',
        ),
        throwsFormatException,
      );
      expect(actions.created, isEmpty);
    },
  );

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
            hip3CurrentIntent(actions.created.single).oneOf.value,
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

  test(
    'accepted visible preview is executed without requesting another',
    () async {
      final position = await repo.get('p-tsla');
      final preview = _acceptedPreview(position, previewId: 'visible-preview');

      await repo.close(
        position.positionId,
        expectedPosition: position,
        quantity: '0.25',
        preview: preview,
        idempotencyKey: 'accepted',
      );

      expect(actions.previewCalls, 0);
      final intent = hip3CurrentIntent(actions.created.single).oneOf.value;
      expect(intent, isA<api.Hip3CloseActionRequest>());
      expect(
        (intent as api.Hip3CloseActionRequest).previewId,
        'visible-preview',
      );
    },
  );

  test('expired or mismatched accepted preview is rejected', () async {
    final position = await repo.get('p-tsla');
    for (final preview in [
      _acceptedPreview(position, expiresAt: DateTime.utc(2020)),
      _acceptedPreview(position, productId: 'xyz:NVDA'),
    ]) {
      await expectLater(
        repo.close(
          position.positionId,
          expectedPosition: position,
          quantity: '0.25',
          preview: preview,
          idempotencyKey: 'rejected-${preview.productId}-${preview.expiresAt}',
        ),
        throwsFormatException,
      );
    }
    expect(actions.previewCalls, 0);
    expect(actions.created, isEmpty);
  });

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

  test(
    'modify and cancel bind exact system IDs and preserve their role',
    () async {
      final position = await repo.get('p-tsla');
      final result = await repo.manageTpSl(
        position,
        changes: [
          Hip3ProtectionChange.modify(
            orderId: 'tp-1',
            protection: Hip3ProtectionParameters(
              role: 'takeProfit',
              triggerPrice: DecimalValue('130'),
              quantity: DecimalValue('0.25'),
            ),
          ),
          const Hip3ProtectionChange.cancel('sl-1'),
        ],
        idempotencyKey: 'modify',
      );
      expect(result.isSuccessful, isTrue);
      expect(result.protectionOrders, hasLength(3));
      final changes = actions.created.single.intent['changes']!.value as List;
      expect(changes[0]['operation'], 'modify');
      expect(changes[0]['order_id'], 'tp-1');
      expect(changes[1], {'operation': 'cancel', 'order_id': 'sl-1'});
      await expectLater(
        repo.manageTpSl(
          position,
          changes: [
            Hip3ProtectionChange.modify(
              orderId: 'tp-1',
              protection: Hip3ProtectionParameters(
                role: 'stopLoss',
                triggerPrice: DecimalValue('90'),
              ),
            ),
          ],
          idempotencyKey: 'wrong-role',
        ),
        throwsFormatException,
      );
      expect(actions.created, hasLength(1));
    },
  );
  test(
    'mixed batch results retain success and failure independently',
    () async {
      actions.partialFailure = true;
      final position = await repo.get('p-tsla');
      final result = await repo.manageTpSl(
        position,
        changes: [
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: 'takeProfit',
              triggerPrice: DecimalValue('130'),
            ),
          ),
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: 'stopLoss',
              triggerPrice: DecimalValue('90'),
            ),
          ),
        ],
        idempotencyKey: 'partial',
      );
      expect(result.isSuccessful, isFalse);
      expect(result.protectionOrders[0].isConfirmed, isTrue);
      expect(result.protectionOrders[1].isFailed, isTrue);
      expect(result.protectionOrders[1].failureReason, 'Venue rejected stop');
    },
  );
  test('clearing one leg and creating another uses one mixed action', () async {
    final position = await repo.get('p-tsla');
    await repo.updateTpSl(
      position,
      stopLoss: '90',
      quantity: '0.2',
      clearScope: ProtectionClearScope.takeProfit,
      idempotencyKey: 'edit',
    );
    expect(actions.created.map((a) => a.operation), ['manage_tpsl']);
    final wire = actions.created.single.intent['changes']!.value as List;
    expect(wire[0], {'operation': 'cancel', 'order_id': 'tp-1'});
    expect(wire[1]['operation'], 'create');
    expect(wire[1]['protection']['quantity'], '0.2');
    expect(actions.keys, ['edit']);
  });

  test(
    'both off cancels explicit IDs; a pending batch is not recreated',
    () async {
      final position = await repo.get('p-tsla');
      await repo.updateTpSl(
        position,
        clearScope: ProtectionClearScope.both,
        idempotencyKey: 'clear',
      );
      expect(actions.created, hasLength(1));
      expect(actions.created.single.intent['changes']!.value, [
        {'operation': 'cancel', 'order_id': 'tp-1'},
        {'operation': 'cancel', 'order_id': 'sl-1'},
      ]);
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
      expect(actions.created.last.operation, 'manage_tpsl');
      expect(actions.keys, ['clear', 'pending']);
    },
  );
}

PositionClosePreview _acceptedPreview(
  Position position, {
  String previewId = 'accepted-preview',
  String? productId,
  DateTime? expiresAt,
}) => PositionClosePreview(
  previewId: previewId,
  positionId: position.positionId,
  productId: productId ?? position.productId!,
  positionVersion: position.positionVersion!,
  environment: 'testnet',
  side: PositionSide.short,
  type: TradingOrderType.market,
  quantity: DecimalValue('0.25'),
  notional: DecimalValue('25'),
  entryPrice: DecimalValue('99'),
  markPrice: DecimalValue('100'),
  estimatedPrice: DecimalValue('100'),
  estimatedFee: DecimalValue('0.01'),
  estimatedRealizedPnl: DecimalValue('0.24'),
  expiresAt: expiresAt ?? DateTime.utc(2099),
  observedAt: DateTime.utc(2026, 9, 10),
);

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
        'protection_orders': [
          for (final role in ['take_profit', 'stop_loss'])
            {
              'order_id': role == 'take_profit' ? 'tp-1' : 'sl-1',
              'role': role,
              'size_mode': 'entire_position',
              'quantity': '1',
              'trigger_price': role == 'take_profit' ? '110' : '90',
              'trigger_reference': 'mark',
              'execution_type': 'market',
              'limit_price': null,
              'activation_status': 'active',
            },
        ],
      })!;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Actions implements Hip3PositionActionService {
  String? previewQuantity, previewLimit;
  bool short = false, wrongProduct = false, pending = false;
  bool partialFailure = false;
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
        'status': pending
            ? 'manual_review'
            : partialFailure
            ? 'failed'
            : 'succeeded',
        'steps': [
          if (wire['operation'] == 'manage_tpsl')
            for (final cancel in [true, false])
              if ((wire['changes'] as List).any(
                (dynamic change) => cancel
                    ? change['operation'] != 'create'
                    : change['operation'] != 'cancel',
              ))
                {
                  'step_id': cancel ? 'cancel' : 'place',
                  'sequence': cancel ? 1 : 2,
                  'kind': cancel ? 'cancel_protection' : 'place_protection',
                  'status': pending
                      ? 'manual_review'
                      : partialFailure
                      ? 'failed'
                      : 'succeeded',
                  'signing': null,
                  'failure_reason': null,
                  'protection_orders': [
                    for (var i = 0; i < (wire['changes'] as List).length; i++)
                      if (cancel
                          ? (wire['changes'] as List)[i]['operation'] !=
                                'create'
                          : (wire['changes'] as List)[i]['operation'] !=
                                'cancel')
                        {
                          'change_index': i,
                          'order_id': cancel
                              ? (wire['changes'] as List)[i]['order_id']
                              : 'new-$i',
                          'replaced_order_id': cancel
                              ? null
                              : (wire['changes'] as List)[i]['order_id'],
                          'role':
                              (wire['changes'] as List)[i]['protection'] != null
                              ? ((wire['changes'] as List)[i]['protection']
                                            as Map)
                                        .containsKey('take_profit')
                                    ? 'take_profit'
                                    : 'stop_loss'
                              : (wire['changes'] as List)[i]['order_id'] ==
                                    'tp-1'
                              ? 'take_profit'
                              : 'stop_loss',
                          'status': pending
                              ? 'unknown'
                              : partialFailure && i == 1
                              ? 'rejected'
                              : 'confirmed',
                          'failure_reason': partialFailure && i == 1
                              ? 'Venue rejected stop'
                              : null,
                          'protection':
                              (wire['changes'] as List)[i]['protection'] ??
                              {
                                'size_mode': 'entire_position',
                                (wire['changes'] as List)[i]['order_id'] ==
                                        'tp-1'
                                    ? 'take_profit'
                                    : 'stop_loss': {
                                  'trigger_price':
                                      (wire['changes']
                                              as List)[i]['order_id'] ==
                                          'tp-1'
                                      ? '110'
                                      : '90',
                                  'trigger_reference': 'mark',
                                  'execution_type': 'market',
                                },
                              },
                        },
                  ],
                },
        ],
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
        'type': request?.type?.name ?? 'market',
        'status': 'open',
        'next_action': null,
        'wallet_action_blocker': 'not_applicable',
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
