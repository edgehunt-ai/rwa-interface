# rwa_api_client.model.WithdrawalQuote

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**quoteId** | **String** | 本次报价的标识，回传到 `CreateWithdrawalRequest.quote_id` 可锁定费率 | 
**asset** | **String** |  | [optional] 
**chain** | [**Chain**](Chain.md) |  | [optional] 
**amount** | **String** | 十进制字符串，避免浮点误差 | 
**needsConvert** | **bool** | 目标资产非 USDC 时需内部 Convert | [optional] 
**convertRoute** | **String** |  | [optional] 
**transferRoute** | **String** |  | [optional] 
**needsBridge** | **bool** |  | [optional] 
**bridgeRoute** | **String** |  | [optional] 
**convertTransferFee** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**bridgeFee** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**networkFee** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**totalFee** | **String** | 十进制字符串，避免浮点误差 | 
**estimatedReceive** | **String** | 十进制字符串，避免浮点误差 | 
**estimatedTime** | **String** |  | [optional] 
**sufficient** | **bool** | 提现金额是否足以覆盖费用 | 
**details** | [**BuiltList&lt;KeyValue&gt;**](KeyValue.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


