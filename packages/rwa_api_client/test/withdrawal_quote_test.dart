import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for WithdrawalQuote
void main() {
  final instance = WithdrawalQuoteBuilder();
  // TODO add properties to the builder and call build()

  group(WithdrawalQuote, () {
    // 本次报价的标识，回传到 `CreateWithdrawalRequest.quote_id` 可锁定费率
    // String quoteId
    test('to test the property `quoteId`', () async {
      // TODO
    });

    // String asset
    test('to test the property `asset`', () async {
      // TODO
    });

    // Chain chain
    test('to test the property `chain`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // 目标资产非 USDC 时需内部 Convert
    // bool needsConvert
    test('to test the property `needsConvert`', () async {
      // TODO
    });

    // String convertRoute
    test('to test the property `convertRoute`', () async {
      // TODO
    });

    // String transferRoute
    test('to test the property `transferRoute`', () async {
      // TODO
    });

    // bool needsBridge
    test('to test the property `needsBridge`', () async {
      // TODO
    });

    // String bridgeRoute
    test('to test the property `bridgeRoute`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String convertTransferFee
    test('to test the property `convertTransferFee`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String bridgeFee
    test('to test the property `bridgeFee`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String networkFee
    test('to test the property `networkFee`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String totalFee
    test('to test the property `totalFee`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String estimatedReceive
    test('to test the property `estimatedReceive`', () async {
      // TODO
    });

    // String estimatedTime
    test('to test the property `estimatedTime`', () async {
      // TODO
    });

    // 提现金额是否足以覆盖费用
    // bool sufficient
    test('to test the property `sufficient`', () async {
      // TODO
    });

    // BuiltList<KeyValue> details
    test('to test the property `details`', () async {
      // TODO
    });

  });
}
