# rwa_api_client.model.Withdrawal

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**withdrawalId** | **String** |  | 
**asset** | **String** |  | 
**chain** | [**Chain**](Chain.md) |  | 
**amount** | **String** | 十进制字符串，避免浮点误差 | 
**receivedAmount** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**totalFee** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**address** | **String** |  | [optional] 
**memo** | **String** |  | [optional] 
**status** | [**WithdrawalStatus**](WithdrawalStatus.md) |  | 
**failureReason** | **String** |  | [optional] 
**txHash** | **String** |  | [optional] 
**activityId** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 
**completedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


