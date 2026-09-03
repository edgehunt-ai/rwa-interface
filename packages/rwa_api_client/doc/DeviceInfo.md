# rwa_api_client.model.DeviceInfo

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**deviceId** | **String** | 客户端生成并持久化的设备标识，用于 upsert | [optional] 
**platform** | **String** | 客户端平台。当前为 `ios` / `android`，**后续可能新增**（如 `harmony`、`web`）。  这里刻意用开放字符串而不是枚举：服务端新增平台时，老客户端反序列化 不会因为遇到未知枚举值而崩溃。客户端只需认得自己那个值。  | [optional] 
**appVersion** | **String** |  | [optional] 
**pushToken** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


