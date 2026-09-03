import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for ReferencePrice
void main() {
  final instance = ReferencePriceBuilder();
  // TODO add properties to the builder and call build()

  group(ReferencePrice, () {
    // String symbol
    test('to test the property `symbol`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String price
    test('to test the property `price`', () async {
      // TODO
    });

    // SessionKind session
    test('to test the property `session`', () async {
      // TODO
    });

    // DateTime asOf
    test('to test the property `asOf`', () async {
      // TODO
    });

    // 休市 / 隔夜时段为 `true`，前端应提示参考价停留在最近收盘水平
    // bool isStale
    test('to test the property `isStale`', () async {
      // TODO
    });

  });
}
