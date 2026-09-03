import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for ClosePositionRequest
void main() {
  final instance = ClosePositionRequestBuilder();
  // TODO add properties to the builder and call build()

  group(ClosePositionRequest, () {
    // OrderType type (default value: OrderType.market)
    test('to test the property `type`', () async {
      // TODO
    });

    // 与 `percent` 二选一；均不传表示全部平仓
    // String quantity
    test('to test the property `quantity`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String percent
    test('to test the property `percent`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String limitPrice
    test('to test the property `limitPrice`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String slippagePercent
    test('to test the property `slippagePercent`', () async {
      // TODO
    });

  });
}
