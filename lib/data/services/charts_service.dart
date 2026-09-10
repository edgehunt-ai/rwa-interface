import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class ChartsService {
  Future<api.CandleSeries> getCandles(
    String symbol,
    api.ProductKind kind, {
    api.ChartRange? range,
    DateTime? from,
    DateTime? to,
    String? interval,
  });
  Future<api.MarketSessionInfo> getMarketSessions();
  Future<api.ReferencePrice> getReferencePrice(String symbol);
}
