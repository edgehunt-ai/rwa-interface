# rwa_api_client.model.ProductDetail

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
**title** | **String** | 产品标题，如 `BSC bStocks Token` / `HIP-3 Perpetual` | [optional] 
**badge** | **String** | 角标，如 `Spot · BSC` / `Isolated margin` | [optional] 
**description** | **String** | 产品说明长文案 | [optional] 
**quote** | [**Quote**](Quote.md) |  | 
**stats** | [**MarketStats**](MarketStats.md) |  | [optional] 
**assetInfo** | [**AssetInfo**](AssetInfo.md) |  | 
**tradingHours** | **String** | 交易时间说明 | [optional] [default to '24x7']

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


