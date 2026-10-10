import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/api/api_environment.dart';
import 'package:nobell/data/api/rwa_api_data_source.dart';
import 'package:nobell/data/services/generated_orders_service.dart';

import '../../helpers/controlled_api_adapter.dart';
import '../../helpers/trading_provider_harness.dart';

void main() {
  test('continuation preview sends its required empty JSON object', () async {
    const orderId = 'bstocks-order:00000000-0000-0000-0000-000000000001';
    final adapter = ControlledApiAdapter([
      ControlledResponse.json(
        method: 'POST',
        path: '/v1/orders/$orderId/preview',
        statusCode: 200,
        body: const {'bound_order_id': orderId, 'preview': _previewJson},
      ),
    ]);
    final source = RwaApiDataSource.create(
      tokenProvider: FakePrivyAccessTokenProvider(),
      environment: const ApiEnvironment(baseUrl: 'https://controlled.invalid'),
    );
    source.dio.httpClientAdapter = adapter;
    final service = GeneratedOrdersService(source.client.getOrdersApi());

    final response = await service.previewBstocksOrderContinuation(
      orderId: orderId,
      idempotencyKey: 'continuation-key',
    );

    expect(response.boundOrderId, orderId);
    expect(jsonDecode(utf8.decode(adapter.requests.single.body)), isEmpty);
  });
}

const _previewJson = {
  'kind': 'bstock',
  'network': 'BSC',
  'settlement_asset': 'USDT',
  'settlement_chain_id': 56,
  'settlement_asset_id':
      'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955',
  'settlement_token_contract': '0x55d398326f99059ff775485246999027b3197955',
  'settlement_token_decimals': 18,
  'preview_id': '00000000-0000-0000-0000-000000000002',
  'symbol': 'NVDAB',
  'side': 'buy',
  'type': 'market',
  'market_price': '100',
  'estimated_price': '100.1',
  'estimated_quantity': '1',
  'order_value': '100.1',
  'fee': '0.1',
  'quote_expires_at': '2027-01-01T00:00:00Z',
};
