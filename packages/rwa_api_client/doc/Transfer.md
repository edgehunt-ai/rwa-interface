# rwa_api_client.model.Transfer

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**transferId** | **String** |  | 
**asset** | **String** |  | 
**amount** | **String** | 十进制字符串，避免浮点误差 | 
**fromAccount** | [**AccountKind**](AccountKind.md) |  | 
**toAccount** | [**AccountKind**](AccountKind.md) |  | 
**status** | [**TransferStatus**](TransferStatus.md) |  | 
**failureReason** | **String** |  | [optional] 
**txHash** | **String** |  | [optional] 
**activityId** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**completedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


