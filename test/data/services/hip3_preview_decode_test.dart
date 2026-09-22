import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/api/order_preview_payload.dart';
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_orders_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';

Map<String, Object?> _hip3PreviewBody() => {
  'kind': 'perp',
  'network': 'Hyperliquid',
  'settlement_asset': 'USDC',
  'settlement_chain_id': 1337,
  'settlement_asset_id': 'hyperliquid:1337/perps:USDC-PERPS',
  'settlement_token_contract': '0x2100000000000000000000000000000000000000',
  'settlement_token_decimals': 8,
  'preview_id': 'pv_1',
  'symbol': 'NVDA',
  'side': 'buy',
  'type': 'market',
  'order_value': '100',
  'quote_expires_at': '2999-01-01T00:00:00Z',
  'hip3_execution': {
    'context_id': 'ctx_1',
    'product_id': 'NVDA',
    'environment': 'testnet',
    'quantity': '1',
    'type': 'market',
    'time_in_force': 'ioc',
    'limit_price': '100',
    'leverage': '3',
    'margin_mode': 'cross',
    'reduce_only': false,
    'notional_usdc': '100',
    'margin_required_usdc': '33',
    'available_margin_usdc': '500',
    'maximum_quantity': '10',
    'estimated_fee_usdc': '0.1',
    'slippage_percent': '0.5',
  },
};

Dio _respondingWith(Map<String, Object?> body) {
  final dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) => handler.resolve(
        Response(requestOptions: request, statusCode: 200, data: body),
      ),
    ),
  );
  return dio;
}

final _intent = OrderIntent(
  symbol: 'NVDA',
  kind: MarketProductKind.perp,
  side: TradingSide.long,
  type: TradingOrderType.market,
  marginMode: TradingMarginMode.cross,
  amount: DecimalValue('100'),
);

void main() {
  test('a HIP-3 preview keeps its execution terms end to end', () async {
    final repository = OrdersRepositoryImpl(
      GeneratedOrdersService(
        api.RwaApiClient(
          dio: _respondingWith(_hip3PreviewBody()),
          serializers: appApiSerializers,
        ).getOrdersApi(),
      ),
    );

    final preview = await repository.preview(_intent, idempotencyKey: 'key-1');

    expect(preview.hip3Execution, isNotNull);
    expect(preview.hip3Execution!.contextId, 'ctx_1');
    expect(preview.hip3Execution!.availableMargin.value, '500');
  });

  test(
    'an unfamiliar settlement identity stays readable and distinct',
    () async {
      // Decoding no longer picks between variants, so a settlement asset this
      // client has never seen neither fails nor gets read as a different one.
      Future<String?> settlementAssetOf(String asset) async {
        final repository = OrdersRepositoryImpl(
          GeneratedOrdersService(
            api.RwaApiClient(
              dio: _respondingWith({
                ..._hip3PreviewBody(),
                'kind': 'bstock',
                'network': 'BSC',
                'settlement_asset': asset,
              }),
              serializers: appApiSerializers,
            ).getOrdersApi(),
          ),
        );
        final preview = await repository.preview(
          _intent,
          idempotencyKey: 'key-$asset',
        );
        return preview.settlementAsset;
      }

      expect(await settlementAssetOf('TUSDT'), 'TUSDT');
      expect(await settlementAssetOf('USDT'), 'USDT');
      // A future identity the contract has not shipped yet.
      expect(await settlementAssetOf('XUSDT'), 'XUSDT');
    },
  );

  test('an undecodable success fails loudly and is reported', () async {
    final reported = <String>[];
    final repository = OrdersRepositoryImpl(
      GeneratedOrdersService(
        api.RwaApiClient(
          dio: _respondingWith({
            ..._hip3PreviewBody(),
            // A body the contract cannot describe must not be half-accepted.
            'hip3_execution': {'context_id': 'ctx_1'},
          }),
          serializers: appApiSerializers,
        ).getOrdersApi(),
        onDecodeFailure: ({required operation, required error, stackTrace}) =>
            reported.add(operation),
      ),
    );

    await expectLater(
      repository.preview(_intent, idempotencyKey: 'key-2'),
      throwsA(isA<DecodingFailure>()),
    );
    expect(reported, ['orders.preview.decode_failed']);
  });
}
