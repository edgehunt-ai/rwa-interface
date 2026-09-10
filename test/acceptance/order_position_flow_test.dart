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
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
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
        _json('PUT', '/v1/positions/position-1/tpsl', 200, {
          ..._positionJson,
          'take_profit_price': '120',
          'stop_loss_price': '90',
        }),
        _json('DELETE', '/v1/positions/position-1/tpsl', 200, _positionJson),
        _json('PATCH', '/v1/positions/position-1/leverage', 200, {
          ..._positionJson,
          'leverage': '3',
        }),
        _json(
          'POST',
          '/v1/positions/position-1/close',
          201,
          _orderJson(status: 'submitted'),
        ),
      ]);
      final source = _source(adapter);
      final container = ProviderContainer(
        overrides: [
          ordersRepositoryProvider.overrideWithValue(
            OrdersRepositoryImpl(
              GeneratedOrdersService(source.client.getOrdersApi()),
            ),
          ),
          positionsRepositoryProvider.overrideWithValue(
            PositionsRepositoryImpl(
              GeneratedPositionsService(
                source.client.getPositionsApi(),
                source.client.getOrdersApi(),
                _FakeHip3Signer(),
              ),
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      final commandSubscription = container.listen(
        orderCommandProvider,
        (_, _) {},
      );
      addTearDown(commandSubscription.close);

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
      expect(position.positionId, 'position-1');

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

final class _FakeHip3Signer implements Hip3TypedDataSigner {
  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) => throw UnimplementedError('This flow does not submit a HIP3 action');
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
