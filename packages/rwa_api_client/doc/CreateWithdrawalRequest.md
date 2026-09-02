# rwa_api_client.model.CreateWithdrawalRequest

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**asset** | **String** |  | 
**chain** | [**Chain**](Chain.md) |  | 
**amount** | **String** | 十进制字符串，避免浮点误差 | 
**address** | **String** |  | 
**authorizationId** | **String** | 已授权且尚未消费的钱包操作授权 ID | 
**memo** | **String** |  | [optional] 
**quoteId** | **String** |  | [optional] 
**saveAddress** | **bool** |  | [optional] [default to false]
**addressLabel** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


