# rwa_api_client.model.DeviceRegisterRequest

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**deviceId** | **String** |  | 
**platform** | **String** | 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。  | 
**appVersion** | **String** | 当前安装的版本号，可选。**用途是推送内容分流，不是设备统计**—— 比如老版本不支持富通知（图片 / 按钮）或某种深链格式时， 后端据此回退成纯文本推送，避免老版本收到解析不了的 payload。  与令牌一样会过期：客户端每次上报令牌时应一并带上当前版本号， 不需要单独维护更新时机。  | [optional] 
**pushToken** | **String** | APNs / FCM 推送令牌 | 
**pushProvider** | **String** | 不传则由后端按 `platform` 推断 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


