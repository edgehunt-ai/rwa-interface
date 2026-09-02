import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for TpSlSpec
void main() {
  final instance = TpSlSpecBuilder();
  // TODO add properties to the builder and call build()

  group(TpSlSpec, () {
    // bool enabled (default value: false)
    test('to test the property `enabled`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String takeProfitPrice
    test('to test the property `takeProfitPrice`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String stopLossPrice
    test('to test the property `stopLossPrice`', () async {
      // TODO
    });

    // 仅限价单
    // String stopLimitPrice
    test('to test the property `stopLimitPrice`', () async {
      // TODO
    });

    // 与价格互算，二者传其一即可
    // String takeProfitPercent
    test('to test the property `takeProfitPercent`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String stopLossPercent
    test('to test the property `stopLossPercent`', () async {
      // TODO
    });

    // 与 `stop_limit_price` 互算，二者传其一即可
    // String stopLimitPercent
    test('to test the property `stopLimitPercent`', () async {
      // TODO
    });

  });
}
