# rwa_api_client.model.OrderPreviewRequest

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
**amount** | **String** | 市价单的 USDC 名义价值 | [optional] 
**quantity** | **String** | 限价单的基础资产数量 | [optional] 
**limitPrice** | **String** | 限价单的 USDC 价格 | [optional] 
**slippagePercent** | **String** | 最大可接受滑点；超出则下单失败 | [optional] 
**tpSl** | [**TpSlSpec**](TpSlSpec.md) |  | [optional] 
**leverage** | **String** | Decimal string leverage; allowed range is 1 to 50. | [optional] 
**marginMode** | [**MarginMode**](MarginMode.md) |  | [optional] 
**reduceOnly** | **bool** |  | [optional] [default to false]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


