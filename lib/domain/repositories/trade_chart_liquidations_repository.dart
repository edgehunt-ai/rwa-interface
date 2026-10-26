import '../models/trade_chart_marker.dart';

abstract interface class TradeChartLiquidationsRepository {
  Future<TradeChartLiquidations> list({
    required String productId,
    required DateTime from,
    required DateTime to,
  });
}
