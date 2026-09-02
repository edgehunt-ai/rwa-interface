# rwa_api_client.model.MarketStats

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**high24h** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**low24h** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**turnover24hUsd** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**volume24h** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**volume24hUnit** | **String** |  | [optional] 
**referenceLabel** | **String** | bStocks 为 `US Stock Reference`；HIP-3 为 `Spot / Reference Price` | [optional] 
**referencePrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**relativeLabel** | **String** | bStocks 为 `Premium`；HIP-3 为 `Basis` | [optional] 
**relativePercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**spreadPercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**bestBid** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**bestAsk** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**fundingRate** | **String** | 仅 HIP-3。正费率多头付空头，负费率反向。 | [optional] 
**nextFundingAt** | [**DateTime**](DateTime.md) |  | [optional] 
**openInterestUsd** | **String** | 仅 HIP-3 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


