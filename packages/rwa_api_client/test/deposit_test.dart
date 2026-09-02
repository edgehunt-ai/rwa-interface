import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for Deposit
void main() {
  final instance = DepositBuilder();
  // TODO add properties to the builder and call build()

  group(Deposit, () {
    // String depositId
    test('to test the property `depositId`', () async {
      // TODO
    });

    // Chain chain
    test('to test the property `chain`', () async {
      // TODO
    });

    // String token
    test('to test the property `token`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // DepositStatus status
    test('to test the property `status`', () async {
      // TODO
    });

    // int confirmations
    test('to test the property `confirmations`', () async {
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

    // 为 `true` 表示资金进入 App 可用余额，交易前仍需划转至交易账户； 外部导入模式为 `false`。 
    // bool requiresTransfer
    test('to test the property `requiresTransfer`', () async {
      // TODO
    });

    // String txHash
    test('to test the property `txHash`', () async {
      // TODO
    });

    // String activityId
    test('to test the property `activityId`', () async {
      // TODO
    });

    // DateTime createdAt
    test('to test the property `createdAt`', () async {
      // TODO
    });

    // DateTime creditedAt
    test('to test the property `creditedAt`', () async {
      // TODO
    });

    // DepositAddress instructions
    test('to test the property `instructions`', () async {
      // TODO
    });

  });
}
