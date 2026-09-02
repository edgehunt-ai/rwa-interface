# rwa_api_client.model.Device

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**deviceId** | **String** |  | 
**platform** | **String** | 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。  | 
**appVersion** | **String** | 用于推送内容分流；客户端未上报过时为 null | [optional] 
**pushProvider** | **String** |  | [optional] 
**pushTokenRegistered** | **bool** | 出于安全考虑不回显令牌本身，只告知是否已登记 | [optional] 
**lastSeenAt** | [**DateTime**](DateTime.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


