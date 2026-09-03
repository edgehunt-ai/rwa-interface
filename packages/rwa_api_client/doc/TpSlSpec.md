# rwa_api_client.model.TpSlSpec

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**enabled** | **bool** |  | [optional] [default to false]
**takeProfitPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**stopLossPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**stopLimitPrice** | **String** | 仅限价单 | [optional] 
**takeProfitPercent** | **String** | 与价格互算，二者传其一即可 | [optional] 
**stopLossPercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**stopLimitPercent** | **String** | 与 `stop_limit_price` 互算，二者传其一即可 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


