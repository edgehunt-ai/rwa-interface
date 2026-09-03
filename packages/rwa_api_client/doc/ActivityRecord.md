# rwa_api_client.model.ActivityRecord

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**id** | **String** |  | 
**category** | [**ActivityCategory**](ActivityCategory.md) |  | 
**type** | [**ActivityType**](ActivityType.md) |  | 
**status** | [**ActivityStatus**](ActivityStatus.md) |  | 
**title** | **String** |  | 
**amount** | **String** | Decimal amount without a unit suffix. | [optional] 
**context** | **String** | 副标题，说明市场与当前状态 | [optional] 
**symbol** | **String** |  | [optional] 
**kind** | [**ProductKind**](ProductKind.md) |  | [optional] 
**fields** | [**BuiltList&lt;KeyValue&gt;**](KeyValue.md) | 展开后的键值对明细 | [optional] 
**relatedId** | **String** | 关联记录 id（如划转失败 ↔ Claim 退款） | [optional] 
**reference** | [**ActivityRecordReference**](ActivityRecordReference.md) |  | [optional] 
**chain** | [**Chain**](Chain.md) |  | [optional] 
**txHash** | **String** |  | [optional] 
**explorer** | [**ActivityRecordExplorer**](ActivityRecordExplorer.md) |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**asset** | **String** | Unit for amount, for example USDC or NVDAB. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


