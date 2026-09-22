import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/api/order_preview_payload.dart';
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_orders_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';

Map<String, Object?> _asset() => {
  'chain_id': 56,
  'symbol': 'USDT',
  'token_contract': '0x55d398326f99059ff775485246999027b3197955',
  'decimals': 18,
  'native': false,
};

Map<String, Object?> _fee() => {
  'status': 'not_estimated',
  'asset': _asset(),
  'amount': null,
  'rate_percent': null,
  'included_in_total_input': null,
};

Map<String, Object?> _bstocksPreviewBody(Map<String, Object?> quoteValidity) =>
    {
      'kind': 'bstock',
      'network': 'BSC',
      'settlement_asset': 'USDT',
      'preview_id': 'pv_1',
      'symbol': 'NVDAB',
      'side': 'buy',
      'type': 'market',
      'order_value': '100',
      'quote_expires_at': '2999-01-01T00:00:00Z',
      'bstocks': {
        'input_asset': _asset(),
        'nominal_input': '100',
        'total_input': '100',
        'input_semantics': 'quoted_gross_input',
        'fees': {'trading': _fee(), 'network': _fee()},
        'quote_validity': quoteValidity,
        'indicative': true,
        'requires_new_quote': true,
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
  symbol: 'NVDAB',
  kind: MarketProductKind.bstock,
  side: TradingSide.buy,
  type: TradingOrderType.market,
  amount: DecimalValue('100'),
);

Future<String> _previewIdFor(Map<String, Object?> quoteValidity) async {
  final repository = OrdersRepositoryImpl(
    GeneratedOrdersService(
      api.RwaApiClient(
        dio: _respondingWith(_bstocksPreviewBody(quoteValidity)),
        serializers: appApiSerializers,
      ).getOrdersApi(),
    ),
  );
  final preview = await repository.preview(_intent, idempotencyKey: 'key-1');
  return preview.previewId;
}

void main() {
  // The contract's quote_validity oneOf has no discriminator, and dart-dio
  // drops the constraints that would separate its variants: a block_window
  // payload satisfies both, which aborted the entire preview. The field is
  // never read, so decoding must simply keep it rather than choose.
  test('a block-window quote validity does not abort the preview', () async {
    expect(
      await _previewIdFor({
        'kind': 'block_window',
        'valid_after_block': 100,
        'valid_until_block': 120,
      }),
      'pv_1',
    );
  });

  test('a requote quote validity still decodes', () async {
    expect(await _previewIdFor({'kind': 'requote_on_confirmation'}), 'pv_1');
  });

  test('an unfamiliar quote validity kind decodes too', () async {
    expect(await _previewIdFor({'kind': 'some_future_window'}), 'pv_1');
  });
}
