import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for DeviceRegisterRequest
void main() {
  final instance = DeviceRegisterRequestBuilder();
  // TODO add properties to the builder and call build()

  group(DeviceRegisterRequest, () {
    // String deviceId
    test('to test the property `deviceId`', () async {
      // TODO
    });

    // 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
    // String platform
    test('to test the property `platform`', () async {
      // TODO
    });

    // 当前安装的版本号，可选。**用途是推送内容分流，不是设备统计**—— 比如老版本不支持富通知（图片 / 按钮）或某种深链格式时， 后端据此回退成纯文本推送，避免老版本收到解析不了的 payload。  与令牌一样会过期：客户端每次上报令牌时应一并带上当前版本号， 不需要单独维护更新时机。 
    // String appVersion
    test('to test the property `appVersion`', () async {
      // TODO
    });

    // APNs / FCM 推送令牌
    // String pushToken
    test('to test the property `pushToken`', () async {
      // TODO
    });

    // 不传则由后端按 `platform` 推断
    // String pushProvider
    test('to test the property `pushProvider`', () async {
      // TODO
    });

  });
}
