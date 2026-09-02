# rwa_api_client.api.ChartsApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getCandles**](ChartsApi.md#getcandles) | **GET** /v1/markets/{symbol}/products/{kind}/candles | K 线 / 价格序列
[**getMarketSessions**](ChartsApi.md#getmarketsessions) | **GET** /v1/markets/sessions | 美股交易时段
[**getReferencePrice**](ChartsApi.md#getreferenceprice) | **GET** /v1/markets/{symbol}/reference-price | 美股参考价


# **getCandles**
> CandleSeries getCandles(symbol, kind, range, from, to, interval)

K 线 / 价格序列

详情页图表数据。同时返回链上产品价格序列与美股参考价序列 —— 参考价仅在 美股有报价的时段（盘前 / 开盘 / 盘后）存在，其余时段为空洞，前端据此画虚线。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getChartsApi();
final String symbol = NVDA; // String | 股票代码
final ProductKind kind = ; // ProductKind | 
final ChartRange range = ; // ChartRange | 预设区间；与 `from` / `to` 二选一
final DateTime from = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime to = 2013-10-20T19:20:30+01:00; // DateTime | 
final String interval = interval_example; // String | 采样粒度，缺省由 `range` 推导

try {
    final response = api.getCandles(symbol, kind, range, from, to, interval);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ChartsApi->getCandles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 
 **kind** | [**ProductKind**](.md)|  | 
 **range** | [**ChartRange**](.md)| 预设区间；与 `from` / `to` 二选一 | [optional] 
 **from** | **DateTime**|  | [optional] 
 **to** | **DateTime**|  | [optional] 
 **interval** | **String**| 采样粒度，缺省由 `range` 推导 | [optional] 

### Return type

[**CandleSeries**](CandleSeries.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMarketSessions**
> MarketSessionInfo getMarketSessions(from, to)

美股交易时段

返回当前时段（盘前 / 开盘 / 盘后 / 隔夜 / 休市）、距下一次切换的倒计时， 以及给定区间内的时段分段（用于图表底部的时段色带与轴标签）。 链上产品 24×7 可交易，但不同时段的参考价新鲜度与深度不同。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getChartsApi();
final DateTime from = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime to = 2013-10-20T19:20:30+01:00; // DateTime | 

try {
    final response = api.getMarketSessions(from, to);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ChartsApi->getMarketSessions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **from** | **DateTime**|  | [optional] 
 **to** | **DateTime**|  | [optional] 

### Return type

[**MarketSessionInfo**](MarketSessionInfo.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReferencePrice**
> ReferencePrice getReferencePrice(symbol)

美股参考价

最近一次美股参考报价及其时段与新鲜度。休市时停留在最近收盘价。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getChartsApi();
final String symbol = NVDA; // String | 股票代码

try {
    final response = api.getReferencePrice(symbol);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ChartsApi->getReferencePrice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 

### Return type

[**ReferencePrice**](ReferencePrice.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

