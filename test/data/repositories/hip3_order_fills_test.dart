import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/generated_orders_service.dart';
import 'package:rwa_interface/domain/models/order_fill.dart';

Map<String, Object?> fill(String id, {String feeAsset = 'USDC'}) => {
  'fill_id': id,
  'provider_trade_id': 'trade-$id',
  'price': '123456789012345678.123456789012345678',
  'quantity': '0.000000000000000001',
  'fee': '-0.000000000000000003',
  'fee_asset': feeAsset,
  'provider_hash': 'hash-$id',
  'executed_at': '2026-09-10T23:59:59.123-04:00',
};
Map<String, Object?> order() => {
  'order_id': 'o1',
  'symbol': 'TSLA',
  'kind': 'perp',
  'side': 'short',
  'type': 'limit',
  'status': 'filled',
  'created_at': '2026-09-10T00:00:00Z',
  'filled_quantity': '99.000000000000000001',
  'average_fill_price': '10.01',
  'realized_pnl': '-7.123456789012345678',
  'provider_observed_at': '2026-09-11T04:00:00.789Z',
  'fills': [fill('1'), fill('2', feeAsset: 'HYPE')],
};

void main() {
  late Dio dio;
  late Map<String, Object?> response;
  late OrdersRepositoryImpl repository;
  late List<RequestOptions> requests;
  setUp(() {
    response = order();
    requests = [];
    dio = Dio(BaseOptions(baseUrl: 'https://test.invalid'));
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          requests.add(request);
          handler.resolve(
            Response(requestOptions: request, statusCode: 200, data: response),
          );
        },
      ),
    );
    repository = OrdersRepositoryImpl(
      GeneratedOrdersService(api.RwaApiClient(dio: dio).getOrdersApi()),
    );
  });
  tearDown(() => dio.close(force: true));

  test(
    'fill side and raw pnl preserve facts independently from order and fees',
    () async {
      response['settlement_asset'] = 'USDH';
      response['fills'] = [
        {
          ...fill('1', feeAsset: 'HYPE'),
          'side': 'buy',
          'closed_pnl': '-1.234567890123456789',
          'pnl_asset': 'USDH',
          'position_effect': 'close_short',
        },
        {...fill('2'), 'side': 'sell', 'closed_pnl': '0', 'pnl_asset': 'USDH'},
        {...fill('3'), 'side': null, 'closed_pnl': null, 'pnl_asset': null},
      ];
      final result = (await repository.get('o1')).resource;
      final fills = result.fills!;
      expect(
        fills[0].side,
        FillSide.buy,
      ); // The order is short, not a fill effect.
      expect(fills[0].positionEffect, 'close_short');
      expect(fills[0].closedPnl!.value, '-1.234567890123456789');
      expect(fills[0].closedPnl!.asset, 'USDH');
      expect(fills[0].fee.asset, 'HYPE');
      expect(fills[0].price.asset, 'USDH');
      expect(result.settlementAsset, 'USDH');
      expect(result.averageFillPrice!.asset, 'USDH');
      expect(result.filledQuantity!.asset, 'TSLA');
      expect(result.realizedPnl!.asset, 'USDH');
      expect(fills[1].side, FillSide.sell);
      expect(fills[1].closedPnl!.value, '0');
      expect(fills[1].positionEffect, isNull);
      expect(fills[2].side, isNull);
      expect(fills[2].closedPnl, isNull);
    },
  );

  test('absent pnl currency is not guessed from settlement or fee', () async {
    response['settlement_asset'] = 'USDH';
    response['fills'] = [
      {...fill('1'), 'closed_pnl': '2.5'},
    ];
    final result = (await repository.get('o1')).resource;
    expect(result.fills!.single.closedPnl!.value, '2.5');
    expect(result.fills!.single.closedPnl!.asset, isNull);
    expect(result.fills!.single.side, isNull);
  });

  test('generated GET maps every fill, exact decimals, fee assets and UTC without aggregate substitution', () async {
    final result = (await repository.get('o1')).resource;
    expect(requests.single.method, 'GET');
    expect(requests.single.path, '/v1/orders/o1');
    expect(result.fills!.length, 2);
    final first = result.fills!.first;
    expect(first.fillId, '1');
    expect(first.providerTradeId, 'trade-1');
    expect(first.providerHash, 'hash-1');
    expect(first.executedAt, DateTime.utc(2026, 9, 11, 3, 59, 59, 123));
    expect(first.executedAt.isUtc, isTrue);
    expect(first.price.value, '123456789012345678.123456789012345678');
    expect(first.price.asset, isNull);
    expect(first.quantity.value, '0.000000000000000001');
    expect(first.quantity.asset, 'TSLA');
    expect(first.fee.value, '-0.000000000000000003');
    expect(first.fee.asset, 'USDC');
    expect(result.fills!.last.fee.asset, 'HYPE');
    expect(result.filledQuantity!.value, '99.000000000000000001');
    expect(result.averageFillPrice!.value, '10.01');
    expect(result.averageFillPrice!.asset, isNull);
    expect(result.realizedPnl!.value, '-7.123456789012345678');
    expect(result.realizedPnl!.asset, isNull);
    expect(result.fee, isNull); // Never sum incompatible fee assets.
    expect(result.providerObservedAt, DateTime.utc(2026, 9, 11, 4, 0, 0, 789));
    expect(() => result.fills!.clear(), throwsUnsupportedError);
  });

  test(
    'omitted fills and optional aggregates remain absent, empty remains empty',
    () async {
      response.remove('fills');
      response.remove('filled_quantity');
      response.remove('average_fill_price');
      response.remove('realized_pnl');
      response.remove('provider_observed_at');
      var result = (await repository.get('o1')).resource;
      expect(result.fills, isNull);
      expect(result.filledQuantity, isNull);
      expect(result.averageFillPrice, isNull);
      expect(result.realizedPnl, isNull);
      expect(result.providerObservedAt, isNull);
      response['fills'] = <Object>[];
      result = (await repository.get('o1')).resource;
      expect(result.fills, isEmpty);
    },
  );

  test(
    'missing fee currency is not replaced with USDC; optional hash stays null',
    () async {
      final value = fill('1', feeAsset: '')..remove('provider_hash');
      response['fills'] = [value];
      final result = (await repository.get('o1')).resource.fills!.single;
      expect(result.fee.asset, isNull);
      expect(result.providerHash, isNull);
    },
  );

  test('all embedded records are retained without an invented cap', () async {
    response['fills'] = List.generate(123, (i) => fill('$i'));
    expect((await repository.get('o1')).resource.fills!.length, 123);
  });

  test(
    'contract-required missing price fails visibly instead of inventing zero',
    () async {
      response['fills'] = [fill('1')..remove('price')];
      await expectLater(repository.get('o1'), throwsA(anything));
    },
  );
}
