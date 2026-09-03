# rwa_api_client.model.ReferencePrice

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**symbol** | **String** |  | 
**price** | **String** | 十进制字符串，避免浮点误差 | 
**session** | [**SessionKind**](SessionKind.md) |  | 
**asOf** | [**DateTime**](DateTime.md) |  | 
**isStale** | **bool** | 休市 / 隔夜时段为 `true`，前端应提示参考价停留在最近收盘水平 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


