# rwa_api_client.model.Order

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**orderId** | **String** |  | 
**clientOrderId** | **String** |  | [optional] 
**symbol** | **String** |  | 
**kind** | [**ProductKind**](ProductKind.md) |  | 
**side** | [**OrderSide**](OrderSide.md) |  | 
**type** | [**OrderType**](OrderType.md) |  | 
**status** | [**OrderStatus**](OrderStatus.md) |  | 
**limitPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**quantity** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**filledQuantity** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**averageFillPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**orderValue** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**fee** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**leverage** | **String** | Decimal string leverage; allowed range is 1 to 50. | [optional] 
**marginMode** | [**MarginMode**](MarginMode.md) |  | [optional] 
**reduceOnly** | **bool** |  | [optional] [default to false]
**tpSl** | [**TpSlSpec**](TpSlSpec.md) |  | [optional] 
**positionId** | **String** |  | [optional] 
**realizedPnl** | **String** | 平仓单的已实现盈亏 | [optional] 
**txHash** | **String** |  | [optional] 
**failureReason** | **String** |  | [optional] 
**createdAt** | [**DateTime**](DateTime.md) |  | 
**updatedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


