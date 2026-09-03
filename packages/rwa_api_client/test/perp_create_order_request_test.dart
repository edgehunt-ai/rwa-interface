import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for PerpCreateOrderRequest
void main() {
  final instance = PerpCreateOrderRequestBuilder();
  // TODO add properties to the builder and call build()

  group(PerpCreateOrderRequest, () {
    // String symbol
    test('to test the property `symbol`', () async {
      // TODO
    });

    // String kind
    test('to test the property `kind`', () async {
      // TODO
    });

    // String side
    test('to test the property `side`', () async {
      // TODO
    });

    // OrderType type
    test('to test the property `type`', () async {
      // TODO
    });

    // 市价单的 USDC 名义价值
    // String amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // 限价单的基础资产数量
    // String quantity
    test('to test the property `quantity`', () async {
      // TODO
    });

    // 限价单的 USDC 价格
    // String limitPrice
    test('to test the property `limitPrice`', () async {
      // TODO
    });

    // Decimal string leverage; allowed range is 1 to 50.
    // String leverage
    test('to test the property `leverage`', () async {
      // TODO
    });

    // MarginMode marginMode
    test('to test the property `marginMode`', () async {
      // TODO
    });

    // bool reduceOnly (default value: false)
    test('to test the property `reduceOnly`', () async {
      // TODO
    });

    // 最大可接受滑点；超出则下单失败
    // String slippagePercent
    test('to test the property `slippagePercent`', () async {
      // TODO
    });

    // TpSlSpec tpSl
    test('to test the property `tpSl`', () async {
      // TODO
    });

    // 传入预览返回的报价 id 可锁定价格；过期后需重新预览
    // String previewId
    test('to test the property `previewId`', () async {
      // TODO
    });

  });
}
