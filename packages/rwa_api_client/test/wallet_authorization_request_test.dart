import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for WalletAuthorizationRequest
void main() {
  final instance = WalletAuthorizationRequestBuilder();
  // TODO add properties to the builder and call build()

  group(WalletAuthorizationRequest, () {
    // String purpose
    test('to test the property `purpose`', () async {
      // TODO
    });

    // String asset
    test('to test the property `asset`', () async {
      // TODO
    });

    // 十进制字符串，避免浮点误差
    // String amount
    test('to test the property `amount`', () async {
      // TODO
    });

    // 绑定的服务端资源 ID；order=preview/order，transfer=funding plan，withdrawal=quote，claim=transfer
    // String resourceId
    test('to test the property `resourceId`', () async {
      // TODO
    });

  });
}
