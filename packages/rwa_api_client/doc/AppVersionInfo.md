# rwa_api_client.model.AppVersionInfo

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**platform** | **String** | 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。  | 
**latestVersion** | **String** | 当前已发布的最新版本 | 
**minSupportedVersion** | **String** | 仍被支持的最低版本。客户端版本低于此值时必须强制升级， 不允许继续使用（用于服务端接口不兼容变更后的兜底）。  | 
**releaseNotes** | **String** |  | [optional] 
**storeUrl** | **String** | App Store / 应用市场地址 | [optional] 
**publishedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**updatedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


