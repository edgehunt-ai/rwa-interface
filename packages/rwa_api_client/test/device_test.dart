import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for Device
void main() {
  final instance = DeviceBuilder();
  // TODO add properties to the builder and call build()

  group(Device, () {
    // String deviceId
    test('to test the property `deviceId`', () async {
      // TODO
    });

    // 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
    // String platform
    test('to test the property `platform`', () async {
      // TODO
    });

    // 用于推送内容分流；客户端未上报过时为 null
    // String appVersion
    test('to test the property `appVersion`', () async {
      // TODO
    });

    // String pushProvider
    test('to test the property `pushProvider`', () async {
      // TODO
    });

    // 出于安全考虑不回显令牌本身，只告知是否已登记
    // bool pushTokenRegistered
    test('to test the property `pushTokenRegistered`', () async {
      // TODO
    });

    // DateTime lastSeenAt
    test('to test the property `lastSeenAt`', () async {
      // TODO
    });

    // DateTime createdAt
    test('to test the property `createdAt`', () async {
      // TODO
    });

  });
}
