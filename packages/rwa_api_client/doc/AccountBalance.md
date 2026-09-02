# rwa_api_client.model.AccountBalance

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**account** | [**AccountKind**](AccountKind.md) |  | 
**label** | **String** |  | [optional] 
**address** | **String** |  | [optional] 
**chain** | [**Chain**](Chain.md) |  | [optional] 
**totalValueUsd** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**availableUsd** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**marginUsedUsd** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**balances** | [**BuiltList&lt;TokenBalance&gt;**](TokenBalance.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


