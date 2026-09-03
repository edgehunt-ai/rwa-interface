import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for DeviceInfo
void main() {
  final instance = DeviceInfoBuilder();
  // TODO add properties to the builder and call build()

  group(DeviceInfo, () {
    // 客户端生成并持久化的设备标识，用于 upsert
    // String deviceId
    test('to test the property `deviceId`', () async {
      // TODO
    });

    // 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
    // String platform
    test('to test the property `platform`', () async {
      // TODO
    });

    // String appVersion
    test('to test the property `appVersion`', () async {
      // TODO
    });

    // String pushToken
    test('to test the property `pushToken`', () async {
      // TODO
    });

  });
}
