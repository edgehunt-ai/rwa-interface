import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for CandleSeries
void main() {
  final instance = CandleSeriesBuilder();
  // TODO add properties to the builder and call build()

  group(CandleSeries, () {
    // String symbol
    test('to test the property `symbol`', () async {
      // TODO
    });

    // ProductKind kind
    test('to test the property `kind`', () async {
      // TODO
    });

    // ChartRange range
    test('to test the property `range`', () async {
      // TODO
    });

    // String interval
    test('to test the property `interval`', () async {
      // TODO
    });

    // DateTime from
    test('to test the property `from`', () async {
      // TODO
    });

    // DateTime to
    test('to test the property `to`', () async {
      // TODO
    });

    // 区间涨跌额，用于图表标题 `+$4.12 (+2.31%) 24h`
    // String changeAbsolute
    test('to test the property `changeAbsolute`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String changePercent
    test('to test the property `changePercent`', () async {
      // TODO
    });

    // 链上产品价格序列
    // BuiltList<CandlePoint> points
    test('to test the property `points`', () async {
      // TODO
    });

    // 美股参考价序列。仅在美股有报价的时段有值 —— 隔夜与休市时段为空洞， 前端应断开连线或画虚线。 
    // BuiltList<CandlePoint> referencePoints
    test('to test the property `referencePoints`', () async {
      // TODO
    });

    // 该区间内的时段分段，用于绘制底部色带
    // BuiltList<SessionSegment> sessions
    test('to test the property `sessions`', () async {
      // TODO
    });

  });
}
