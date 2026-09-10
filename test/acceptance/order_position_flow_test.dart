import 'dart:convert';

import 'package:rwa_interface/data/services/hip3_position_action_service.dart';
import 'package:rwa_interface/data/services/hip3_position_action_executor.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/api/api_environment.dart';
import 'package:rwa_interface/data/api/rwa_api_data_source.dart';
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/repositories/positions_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_orders_service.dart';
import 'package:rwa_interface/data/services/generated_positions_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/resource_result.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';

import '../helpers/controlled_api_adapter.dart';
import '../helpers/trading_provider_harness.dart';

void main() {
  test(
    'order and position commands traverse the complete controlled boundary',
    () async {
      final adapter = ControlledApiAdapter([
        _json('POST', '/v1/orders/preview', 200, _previewJson),
        _json(
          'POST',
          '/v1/orders',
          201,
          _orderJson(status: 'pending_signature'),
        ),
        _json('GET', '/v1/orders/order-1', 200, _orderJson(status: 'open')),
        _json(
          'DELETE',
          '/v1/orders/order-1',
          200,
          _orderJson(status: 'cancelled'),
        ),
        _json('GET', '/v1/positions/position-1', 200, _positionJson),
        ..._workflow('set_tpsl', _setIntent),
        _json('GET', '/v1/positions/position-1', 200, _protectedPosition),
        _json('GET', '/v1/positions/position-1', 200, _protectedPosition),
        ..._workflow('clear_tpsl', _clearIntent),
        _json('GET', '/v1/positions/position-1', 200, _positionJson),
        _json(
          'GET',
          '/v1/hip3/products/xyz:NVDA/trading-context',
          200,
          _context,
        ),
        ..._workflow('set_leverage', _leverageIntent),
        _json('GET', '/v1/positions/position-1', 200, {
          ..._positionJson,
          'leverage': '3',
        }),
        _json('GET', '/v1/positions/position-1', 200, {
          ..._positionJson,
          'leverage': '3',
        }),
        _json(
          'POST',
          '/v1/positions/position-1/close/preview',
          200,
          _closePreview,
        ),
        ..._workflow('close_position', const {
          'operation': 'close_position',
          'preview_id': 'cp1',
        }),
        _json('GET', '/v1/orders/close-1', 200, {
          ..._orderJson(status: 'submitted'),
          'order_id': 'close-1',
          'kind': 'perp',
          'side': 'short',
        }),
      ]);
      final source = _source(adapter);
      final actions = GeneratedHip3PositionActionService(
        source.client.getOrdersApi(),
      );
      final signer = _Signer();
      final confirmations = <String>[];
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(
            OrdersRepositoryImpl(
              GeneratedOrdersService(source.client.getOrdersApi()),
            ),
          ),
          positionsRepositoryProvider.overrideWithValue(
            PositionsRepositoryImpl(
              GeneratedPositionsService(source.client.getPositionsApi()),
              actions: actions,
              executor: Hip3PositionActionExecutor(actions, signer),
              confirm: (summary) async {
                confirmations.add(summary.actionId);
                return true;
              },
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final commandSubscription = container.listen(
        orderCommandProvider,
        (_, _) {},
      );
      final positionCommandSubscription = container.listen(
        positionCommandProvider,
        (_, _) {},
      );
      addTearDown(commandSubscription.close);
      addTearDown(positionCommandSubscription.close);

      final intent = OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.market,
        quantity: DecimalValue('1', unit: 'quantity'),
      );
      final preview = await container.read(orderPreviewProvider(intent).future);
      expect(preview.previewId, 'preview-1');
      expect(preview.fee?.value, '0.1');
      expect(preview.settlementAsset, 'USDT');

      final notifier = container.read(orderCommandProvider.notifier);
      final submitted = await Future.wait([
        notifier.submit(intent, previewId: preview.previewId),
        notifier.submit(intent, previewId: preview.previewId),
      ]);
      final created = submitted.first as ResourceResult<TradingOrder>;
      expect(created.resource.status, TradingOrderStatus.pendingSignature);
      expect(created.capability?.code, 'order_signature_not_supported');
      expect(created.capability?.retryable, isFalse);

      final authoritative = await container.read(
        orderProvider('order-1').future,
      );
      expect(authoritative.resource.status, TradingOrderStatus.open);
      await notifier.cancel(authoritative.resource);

      final position = await container.read(
        positionProvider('position-1').future,
      );
      final positionCommands = container.read(positionCommandProvider);
      final withRisk = await positionCommands.updateTpSl(
        position,
        takeProfit: '120',
        stopLoss: '90',
      );
      expect(withRisk.takeProfitPrice?.value, '120');
      expect(
        (await positionCommands.clearTpSl('position-1')).takeProfitPrice,
        isNull,
      );
      expect(
        (await positionCommands.updateLeverage(position, '3')).leverage?.value,
        '3',
      );
      final closeOrder = await positionCommands.close(
        'position-1',
        percent: '100',
      );
      expect(closeOrder.status, TradingOrderStatus.submitted);
      expect(closeOrder.side, TradingSide.short);

      expect(signer.calls, 4);
      expect(confirmations, [
        'a-set_tpsl',
        'a-clear_tpsl',
        'a-set_leverage',
        'a-close_position',
      ]);
      final submissions = adapter.requests.where(
        (r) => r.path.endsWith('/submissions'),
      );
      expect(submissions, hasLength(4));
      for (final submission in submissions) {
        final body = jsonDecode(utf8.decode(submission.body)) as Map;
        expect(body.keys, ['signature']);
        expect(submission.headers['idempotency-key'], isNotNull);
      }
      expect(
        adapter.requests.where(
          (r) =>
              r.path.startsWith('/v1/positions/') &&
              r.method != 'GET' &&
              !r.path.endsWith('/close/preview'),
        ),
        isEmpty,
      );
      final createRequests = adapter.requests.where(
        (request) => request.method == 'POST' && request.path == '/v1/orders',
      );
      expect(createRequests, hasLength(1));
      expect(createRequests.single.headers['idempotency-key'], isNotNull);
      expect(
        adapter.requests.map((request) => request.path),
        isNot(contains(contains('wallet-actions'))),
      );
    },
  );
}

RwaApiDataSource _source(ControlledApiAdapter adapter) {
  final source = RwaApiDataSource.create(
    tokenProvider: FakePrivyAccessTokenProvider(),
    environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
  );
  source.dio.httpClientAdapter = adapter;
  return source;
}

ControlledResponse _json(String method, String path, int status, Object body) =>
    ControlledResponse.json(
      method: method,
      path: path,
      statusCode: status,
      body: body,
    );

const _previewJson = {
  'kind': 'bstock',
  'network': 'BSC',
  'settlement_asset': 'USDT',
  'settlement_chain_id': 56,
  'settlement_asset_id':
      'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955',
  'settlement_token_contract': '0x55d398326f99059ff775485246999027b3197955',
  'settlement_token_decimals': 18,
  'preview_id': 'preview-1',
  'symbol': 'NVDA',
  'side': 'buy',
  'type': 'market',
  'market_price': '100',
  'estimated_price': '100.1',
  'estimated_quantity': '1',
  'order_value': '100.1',
  'fee': '0.1',
  'quote_expires_at': '2027-01-01T00:00:00Z',
};

Map<String, Object?> _orderJson({required String status}) => {
  'order_id': 'order-1',
  'symbol': 'NVDA',
  'kind': 'bstock',
  'side': 'buy',
  'type': 'market',
  'status': status,
  'quantity': '1',
  'order_value': '100.1',
  'fee': '0.1',
  'created_at': '2026-01-01T00:00:00Z',
};

const _positionJson = {
  'position_id': 'position-1',
  'product_id': 'xyz:NVDA',
  'position_version': 'v1',
  'margin_mode': 'cross',
  'symbol': 'NVDA',
  'kind': 'perp',
  'side': 'long',
  'quantity': '1',
  'quantity_unit': 'contract',
  'value_usd': '100',
  'entry_price': '100',
  'mark_price': '101',
  'leverage': '2',
  'updated_at': '2026-01-01T00:00:00Z',
};

const _setIntent = <String, Object?>{
  'operation': 'set_tpsl',
  'position_id': 'position-1',
  'position_version': 'v1',
  'protection': {
    'size_mode': 'entire_position',
    'take_profit': {
      'trigger_price': '120',
      'trigger_reference': 'mark',
      'execution_type': 'market',
    },
    'stop_loss': {
      'trigger_price': '90',
      'trigger_reference': 'mark',
      'execution_type': 'market',
    },
  },
};
const _clearIntent = <String, Object?>{
  'operation': 'clear_tpsl',
  'position_id': 'position-1',
  'position_version': 'v1',
  'scope': 'both',
};
const _leverageIntent = <String, Object?>{
  'operation': 'set_leverage',
  'context_id': 'ctx1',
  'leverage': '3',
  'margin_mode': 'cross',
};
const _protectedPosition = {
  ..._positionJson,
  'take_profit_price': '120',
  'stop_loss_price': '90',
};
const _context = <String, Object?>{
  'context_id': 'ctx1',
  'environment': 'testnet',
  'product_id': 'xyz:NVDA',
  'symbol': 'NVDA',
  'venue': 'xyz',
  'settlement_asset': 'USDC',
  'current_leverage': '2',
  'current_margin_mode': 'cross',
  'available_margin_usdc': '100',
  'withdrawable_usdc': '100',
  'supported_operations': ['set_leverage'],
  'observed_at': '2026-09-10T00:00:00Z',
  'valid_until': '2099-01-01T00:00:00Z',
  'rules': {
    'rules_version': 'r1',
    'size_decimals': 3,
    'price_max_significant_digits': 5,
    'price_max_decimals': 3,
    'integer_prices_allowed': true,
    'minimum_notional_usdc': '10',
    'max_leverage': '10',
    'margin_modes': ['cross'],
    'order_types': ['market', 'limit'],
    'time_in_force': ['gtc', 'ioc'],
    'trigger_references': ['mark'],
    'observed_at': '2026-09-10T00:00:00Z',
  },
};
const _closePreview = <String, Object?>{
  'preview_id': 'cp1',
  'position_id': 'position-1',
  'position_version': 'v1',
  'environment': 'testnet',
  'product_id': 'xyz:NVDA',
  // Close preview side is the order direction, opposite to the long position.
  'side': 'short',
  'type': 'market',
  'time_in_force': 'ioc',
  'quantity': '1',
  'remaining_quantity': '0',
  'entry_price': '100',
  'mark_price': '101',
  'estimated_price': '101',
  'notional_usdc': '101',
  'estimated_fee_usdc': '0.1',
  'estimated_realized_pnl_usdc': '0.9',
  'slippage_percent': '1',
  'quote_expires_at': '2099-01-01T00:00:00Z',
  'observed_at': '2026-09-10T00:00:00Z',
};

List<ControlledResponse> _workflow(
  String operation,
  Map<String, Object?> intent,
) {
  Map<String, Object?> action(bool done) => {
    'action_id': 'a-$operation',
    'intent': intent,
    'operation': operation,
    'environment': 'testnet',
    'product_id': 'xyz:NVDA',
    'position_id': 'position-1',
    if (operation == 'close_position') 'order_id': 'close-1',
    if (operation == 'close_position') 'close_preview': _closePreview,
    'status': done ? 'succeeded' : 'awaiting_signature',
    'current_step_id': done ? null : 's1',
    'steps': [
      {
        'step_id': 's1',
        'sequence': 1,
        'kind': switch (operation) {
          'set_tpsl' => 'place_take_profit',
          'clear_tpsl' => 'cancel_take_profit',
          _ => operation,
        },
        'status': done ? 'succeeded' : 'prepared',
        if (operation == 'set_tpsl')
          'normalized_protection': {
            'size_mode': 'quantity',
            'quantity': '1',
            'take_profit': {
              'trigger_price': '120',
              'trigger_reference': 'mark',
              'execution_type': 'market',
            },
            'stop_loss': {
              'trigger_price': '90',
              'trigger_reference': 'mark',
              'execution_type': 'market',
            },
          },
        if (!done)
          'signing': {
            'expected_signer': '0x0000000000000000000000000000000000000001',
            'signing_method': 'eth_signTypedData_v4',
            'signature_format': 'r_s_v',
            'signing_typed_data': {
              'domain': {
                'name': 'Exchange',
                'version': '1',
                'chainId': 1337,
                'verifyingContract':
                    '0x0000000000000000000000000000000000000000',
              },
              'types': {
                'Agent': [
                  {'name': 'source', 'type': 'string'},
                  {'name': 'connectionId', 'type': 'bytes32'},
                ],
              },
              'primaryType': 'Agent',
              'message': {'source': 'b', 'connectionId': '0x${'ab' * 32}'},
            },
            'signing_digest': '0x${'cd' * 32}',
            'nonce': 1000,
            'expires_after': 2000,
            'valid_until': '2099-01-01T00:00:00Z',
          },
      },
    ],
    'affected_order_ids': <String>[],
    'effects_applied': done,
    'created_at': '2026-09-10T00:00:00Z',
    'updated_at': '2026-09-10T00:00:00Z',
  };
  return [
    _json('POST', '/v1/hip3/actions', 201, action(false)),
    _json('GET', '/v1/hip3/actions/a-$operation', 200, action(false)),
    _json(
      'POST',
      '/v1/hip3/actions/a-$operation/steps/s1/submissions',
      200,
      action(true),
    ),
  ];
}

final class _Signer implements Hip3TypedDataSigner {
  int calls = 0;
  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) async {
    calls++;
    return '0x${'11' * 32}${'22' * 32}00';
  }
}
