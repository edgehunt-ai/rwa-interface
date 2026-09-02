import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for AccountApi
void main() {
  final instance = RwaApiClient().getAccountApi();

  group(AccountApi, () {
    // 注销推送设备
    //
    // 退出登录时调用，避免继续向该设备推送已登出账户的消息。
    //
    //Future deleteDevice(String deviceId) async
    test('test deleteDevice', () async {
      // TODO
    });

    // 当前登录账户
    //
    // 用户偏好作为 `settings` 子对象一并返回；更新走 `PATCH /v1/me/settings`。
    //
    //Future<User> getMe() async
    test('test getMe', () async {
      // TODO
    });

    // 已注册的推送设备
    //
    //Future<ListDevices200Response> listDevices({ String cursor, int limit }) async
    test('test listDevices', () async {
      // TODO
    });

    // 注册 / 更新当前设备的推送令牌
    //
    // 按 `device_id` upsert。APNs / FCM 令牌会在重装、系统升级、长期未启动后轮换， 因此客户端应在 **每次启动拿到令牌时** 都调一次，而不只在登录时提交一次。  登录时 `SessionRequest.device` 里带的信息等价于调用一次本接口， 两者可任选其一；令牌轮换只能靠本接口。 
    //
    //Future<Device> registerDevice(DeviceRegisterRequest deviceRegisterRequest) async
    test('test registerDevice', () async {
      // TODO
    });

    // 更新当前用户的设置
    //
    // 部分更新：**所有字段都是可选的，传什么改什么，未传的字段保持不变**。  **没有对应的 `GET`** —— 设置作为 `User.settings` 子对象随 `GET /v1/me` 一起返回， 只存在一份定义，不会出现两个来源不一致的情况。 
    //
    //Future<UserSettings> updateSettings(UserSettingsUpdate userSettingsUpdate) async
    test('test updateSettings', () async {
      // TODO
    });

  });
}
