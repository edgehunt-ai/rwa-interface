# rwa_api_client.model.ClosePositionRequest

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**type** | [**OrderType**](OrderType.md) |  | [optional] [default to OrderType.market]
**quantity** | **String** | 与 `percent` 二选一；均不传表示全部平仓 | [optional] 
**percent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**limitPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**slippagePercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


