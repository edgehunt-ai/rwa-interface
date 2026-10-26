import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';

abstract interface class TradeChartLiquidationsService {
  Future<api.Hip3LiquidationPage> list({
    required String productId,
    required DateTime from,
    required DateTime to,
    String? cursor,
  });
}

final class GeneratedTradeChartLiquidationsService
    implements TradeChartLiquidationsService {
  GeneratedTradeChartLiquidationsService(this._api);
  final api.OrdersApi _api;

  @override
  Future<api.Hip3LiquidationPage> list({
    required String productId,
    required DateTime from,
    required DateTime to,
    String? cursor,
  }) async {
    try {
      final page = (await _api.listHip3Liquidations(
        productId: productId,
        from: from,
        to: to,
        cursor: cursor,
      )).data;
      if (page == null) {
        throw const FormatException('Missing liquidation history');
      }
      return page;
    } on DioException catch (error) {
      throw const ApiFailureMapper().fromDio(error);
    }
  }
}
