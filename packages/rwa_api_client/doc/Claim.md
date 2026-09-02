# rwa_api_client.model.Claim

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**claimId** | **String** |  | 
**transferId** | **String** |  | 
**asset** | **String** |  | 
**amount** | **String** | 十进制字符串，避免浮点误差 | 
**creditedTo** | [**AccountKind**](AccountKind.md) |  | [optional] 
**status** | [**ActivityStatus**](ActivityStatus.md) |  | 
**failureReason** | **String** |  | [optional] 
**txHash** | **String** |  | [optional] 
**activityId** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**completedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


