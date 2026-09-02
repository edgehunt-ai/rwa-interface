import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for ChartsApi
void main() {
  final instance = RwaApiClient().getChartsApi();

  group(ChartsApi, () {
    // K 线 / 价格序列
    //
    // 详情页图表数据。同时返回链上产品价格序列与美股参考价序列 —— 参考价仅在 美股有报价的时段（盘前 / 开盘 / 盘后）存在，其余时段为空洞，前端据此画虚线。 
    //
    //Future<CandleSeries> getCandles(String symbol, ProductKind kind, { ChartRange range, DateTime from, DateTime to, String interval }) async
    test('test getCandles', () async {
      // TODO
    });

    // 美股交易时段
    //
    // 返回当前时段（盘前 / 开盘 / 盘后 / 隔夜 / 休市）、距下一次切换的倒计时， 以及给定区间内的时段分段（用于图表底部的时段色带与轴标签）。 链上产品 24×7 可交易，但不同时段的参考价新鲜度与深度不同。 
    //
    //Future<MarketSessionInfo> getMarketSessions({ DateTime from, DateTime to }) async
    test('test getMarketSessions', () async {
      // TODO
    });

    // 美股参考价
    //
    // 最近一次美股参考报价及其时段与新鲜度。休市时停留在最近收盘价。
    //
    //Future<ReferencePrice> getReferencePrice(String symbol) async
    test('test getReferencePrice', () async {
      // TODO
    });

  });
}
