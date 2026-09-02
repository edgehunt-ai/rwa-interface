import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for DepositAddress
void main() {
  final instance = DepositAddressBuilder();
  // TODO add properties to the builder and call build()

  group(DepositAddress, () {
    // Chain chain
    test('to test the property `chain`', () async {
      // TODO
    });

    // String token
    test('to test the property `token`', () async {
      // TODO
    });

    // String address
    test('to test the property `address`', () async {
      // TODO
    });

    // 部分链需要的备注 / tag
    // String memo
    test('to test the property `memo`', () async {
      // TODO
    });

    // 二维码内容，通常是 `ethereum:0x…@56/transfer?address=…` 形式的 URI
    // String qrPayload
    test('to test the property `qrPayload`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String minDeposit
    test('to test the property `minDeposit`', () async {
      // TODO
    });

    // int confirmationsRequired
    test('to test the property `confirmationsRequired`', () async {
      // TODO
    });

    // AccountKind creditedTo
    test('to test the property `creditedTo`', () async {
      // TODO
    });

    // String warning
    test('to test the property `warning`', () async {
      // TODO
    });

  });
}
