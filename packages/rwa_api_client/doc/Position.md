# rwa_api_client.model.Position

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**positionId** | **String** |  | 
**symbol** | **String** |  | 
**name** | **String** |  | [optional] 
**kind** | [**ProductKind**](ProductKind.md) |  | 
**side** | **String** | 仅 HIP-3 | [optional] 
**quantity** | **String** | 十进制字符串，避免浮点误差 | 
**quantityUnit** | **String** |  | [optional] 
**valueUsd** | **String** | 现货为持仓市值，合约为仓位权益 | 
**entryPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**markPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**unrealizedPnl** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**unrealizedPnlPercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**realizedPnl** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**costBasis** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**leverage** | **String** | Decimal string leverage; allowed range is 1 to 50. | [optional] 
**marginMode** | [**MarginMode**](MarginMode.md) |  | [optional] 
**margin** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**liquidationPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**fundingPaid** | **String** | 累计资金费；负数为支付，正数为收取 | [optional] 
**takeProfitPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**stopLossPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**stopLimitPrice** | **String** | 已设置的止损限价；与 `stop_loss_price` 一起用于完整回显 TP / SL | [optional] 
**openedAt** | [**DateTime**](DateTime.md) |  | [optional] 
**updatedAt** | [**DateTime**](DateTime.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


