# rwa_api_client.model.ProductListing

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**symbol** | **String** |  | 
**name** | **String** |  | [optional] 
**kind** | [**ProductKind**](ProductKind.md) |  | 
**productType** | **String** |  | [optional] 
**label** | **String** | 展示名，`bStocks` 或 `HIP-3` | [optional] 
**price** | **String** | 十进制字符串，避免浮点误差 | 
**change24hPercent** | **String** | 24h 涨跌幅（百分比数值，如 `\"0.47\"`） | [optional] 
**spreadVsReferencePercent** | **String** | 相对美股参考价的价差百分比 | [optional] 
**volume24h** | **String** | 24h 成交量（以基础资产计价） | [optional] 
**volume24hUnit** | **String** |  | [optional] 
**turnover24hUsd** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**hotRank** | **int** |  | [optional] 
**isFavorite** | **bool** |  | [optional] [default to false]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


