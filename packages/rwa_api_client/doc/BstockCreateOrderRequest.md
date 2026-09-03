# rwa_api_client.model.BstockCreateOrderRequest

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**symbol** | **String** |  | 
**kind** | **String** |  | 
**side** | **String** |  | 
**type** | [**OrderType**](OrderType.md) |  | 
**amount** | **String** | 市价买入时的 USDC 金额 | [optional] 
**quantity** | **String** | 市价卖出或限价单的基础资产数量 | [optional] 
**limitPrice** | **String** | 限价单的 USDC 价格 | [optional] 
**slippagePercent** | **String** | 最大可接受滑点；超出则下单失败 | [optional] 
**tpSl** | [**TpSlSpec**](TpSlSpec.md) |  | [optional] 
**previewId** | **String** | 传入预览返回的报价 id 可锁定价格；过期后需重新预览 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


