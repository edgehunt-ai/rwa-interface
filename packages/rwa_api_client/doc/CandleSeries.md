# rwa_api_client.model.CandleSeries

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**symbol** | **String** |  | 
**kind** | [**ProductKind**](ProductKind.md) |  | 
**range** | [**ChartRange**](ChartRange.md) |  | 
**interval** | **String** |  | [optional] 
**from** | [**DateTime**](DateTime.md) |  | [optional] 
**to** | [**DateTime**](DateTime.md) |  | [optional] 
**changeAbsolute** | **String** | 区间涨跌额，用于图表标题 `+$4.12 (+2.31%) 24h` | [optional] 
**changePercent** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**points** | [**BuiltList&lt;CandlePoint&gt;**](CandlePoint.md) | 链上产品价格序列 | 
**referencePoints** | [**BuiltList&lt;CandlePoint&gt;**](CandlePoint.md) | 美股参考价序列。仅在美股有报价的时段有值 —— 隔夜与休市时段为空洞， 前端应断开连线或画虚线。  | [optional] 
**sessions** | [**BuiltList&lt;SessionSegment&gt;**](SessionSegment.md) | 该区间内的时段分段，用于绘制底部色带 | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


