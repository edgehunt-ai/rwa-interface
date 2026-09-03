import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for AppVersionInfo
void main() {
  final instance = AppVersionInfoBuilder();
  // TODO add properties to the builder and call build()

  group(AppVersionInfo, () {
    // 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。 
    // String platform
    test('to test the property `platform`', () async {
      // TODO
    });

    // 当前已发布的最新版本
    // String latestVersion
    test('to test the property `latestVersion`', () async {
      // TODO
    });

    // 仍被支持的最低版本。客户端版本低于此值时必须强制升级， 不允许继续使用（用于服务端接口不兼容变更后的兜底）。 
    // String minSupportedVersion
    test('to test the property `minSupportedVersion`', () async {
      // TODO
    });

    // String releaseNotes
    test('to test the property `releaseNotes`', () async {
      // TODO
    });

    // App Store / 应用市场地址
    // String storeUrl
    test('to test the property `storeUrl`', () async {
      // TODO
    });

    // DateTime publishedAt
    test('to test the property `publishedAt`', () async {
      // TODO
    });

    // DateTime updatedAt
    test('to test the property `updatedAt`', () async {
      // TODO
    });

  });
}
