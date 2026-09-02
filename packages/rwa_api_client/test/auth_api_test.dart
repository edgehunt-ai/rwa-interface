import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for AuthApi
void main() {
  final instance = RwaApiClient().getAuthApi();

  group(AuthApi, () {
    // 创建或恢复产品会话
    //
    // 客户端在 Privy SDK 登录后，把 Privy access token 直接放入 Authorization Bearer header。请求体仅包含可选语言和设备信息；响应不签发 access token。
    //
    //Future<SessionResponse> createSession(SessionRequest sessionRequest) async
    test('test createSession', () async {
      // TODO
    });

    // 退出登录
    //
    // 结束当前产品会话，但不删除账户或资产。客户端同时调用 Privy SDK logout 清除 Privy 侧会话。
    //
    //Future deleteSession() async
    test('test deleteSession', () async {
      // TODO
    });

    // 获取客户端 Privy 配置
    //
    // Flutter 端启动时拉取，用于初始化 Privy SDK。避免把 App ID / 支持的登录方式硬编码在客户端。 
    //
    //Future<PrivyClientConfig> getAuthConfig() async
    test('test getAuthConfig', () async {
      // TODO
    });

  });
}
