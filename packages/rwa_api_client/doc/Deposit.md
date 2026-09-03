# rwa_api_client.model.Deposit

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**depositId** | **String** |  | 
**chain** | [**Chain**](Chain.md) |  | 
**token** | **String** |  | 
**amount** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**status** | [**DepositStatus**](DepositStatus.md) |  | 
**confirmations** | **int** |  | [optional] 
**confirmationsRequired** | **int** |  | [optional] 
**creditedTo** | [**AccountKind**](AccountKind.md) |  | [optional] 
**requiresTransfer** | **bool** | 为 `true` 表示资金进入 App 可用余额，交易前仍需划转至交易账户； 外部导入模式为 `false`。  | [optional] 
**txHash** | **String** |  | [optional] 
**activityId** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | [optional] 
**creditedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**instructions** | [**DepositAddress**](DepositAddress.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


