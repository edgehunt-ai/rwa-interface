# rwa_api_client.model.OrderPreview

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**kind** | **String** |  | 
**network** | **String** |  | 
**settlementAsset** | **String** |  | 
**previewId** | **String** | 本次报价的标识。下单时回传到 `CreateOrderRequest.preview_id` 可锁定价格； 超过 `quote_expires_at` 后失效，需重新预览。  | 
**symbol** | **String** |  | 
**side** | [**OrderSide**](OrderSide.md) |  | 
**type** | [**OrderType**](OrderType.md) |  | 
**marketPrice** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**estimatedPrice** | **String** | 预计成交价；与 `market_price` 不同时前端提示「价格已更新」 | [optional] 
**priceUpdated** | **bool** | 报价较用户上次看到的价格是否已变化 | [optional] 
**estimatedQuantity** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**estimatedReceive** | **String** | 预计获得数量（扣除滑点后） | [optional] 
**estimatedReceiveUnit** | **String** |  | [optional] 
**orderValue** | **String** | 十进制字符串，避免浮点误差 | 
**fee** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**feeRate** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**slippagePercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**orderBookImpactPercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**networkFee** | **String** | Network fee as a decimal string. The asset is carried separately in fee_asset. | [optional] 
**settlementAccount** | [**AccountKind**](AccountKind.md) | 成交后资产的到账账户 | [optional] 
**settlementAccountLabel** | **String** |  | [optional] 
**marginRequired** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**liquidationPrice** | **String** | 仅 HIP-3 | [optional] 
**quoteExpiresAt** | [**DateTime**](DateTime.md) |  | [optional] 
**details** | [**BuiltList&lt;KeyValue&gt;**](KeyValue.md) | 「查看详情」中逐行展示的键值对 | [optional] 
**feeAsset** | **String** | Asset used to denominate network_fee, for example BNB or USDC. | [optional] 
**feeNote** | **String** | Optional localized display note, for example Included. | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


