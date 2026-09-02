# rwa_api_client.api.MarketsApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**addFavorite**](MarketsApi.md#addfavorite) | **PUT** /v1/markets/{symbol}/products/{kind}/favorite | 加入自选
[**getAssetInfo**](MarketsApi.md#getassetinfo) | **GET** /v1/markets/{symbol}/asset-info | 资产详情与权益
[**getOrderBook**](MarketsApi.md#getorderbook) | **GET** /v1/markets/{symbol}/products/{kind}/orderbook | 订单簿深度
[**getProduct**](MarketsApi.md#getproduct) | **GET** /v1/markets/{symbol}/products/{kind} | 产品详情
[**getProductStats**](MarketsApi.md#getproductstats) | **GET** /v1/markets/{symbol}/products/{kind}/stats | 24h 行情统计
[**listProducts**](MarketsApi.md#listproducts) | **GET** /v1/markets/products | 产品列表 / 分组
[**listStocks**](MarketsApi.md#liststocks) | **GET** /v1/markets/stocks | 股票分组列表
[**removeFavorite**](MarketsApi.md#removefavorite) | **DELETE** /v1/markets/{symbol}/products/{kind}/favorite | 取消自选
[**replaceFavorites**](MarketsApi.md#replacefavorites) | **PUT** /v1/markets/favorites | 覆盖自选列表（用于排序）


# **addFavorite**
> addFavorite(symbol, kind)

加入自选

幂等操作。路径放在产品资源下，避免与产品详情路由产生模板歧义。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final String symbol = NVDA; // String | 股票代码
final ProductKind kind = ; // ProductKind | 

try {
    api.addFavorite(symbol, kind);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->addFavorite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 
 **kind** | [**ProductKind**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAssetInfo**
> AssetInfo getAssetInfo(symbol, kind)

资产详情与权益

「资产详情与权益」弹窗的内容。bStocks 说明发行方、1:1 股票支持、公司行动、 股息再投资、投票权；HIP-3 说明合约形态、无股东权益、保证金模式、资金费率方向。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final String symbol = NVDA; // String | 股票代码
final ProductKind kind = ; // ProductKind | 

try {
    final response = api.getAssetInfo(symbol, kind);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->getAssetInfo: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 
 **kind** | [**ProductKind**](.md)|  | 

### Return type

[**AssetInfo**](AssetInfo.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrderBook**
> OrderBook getOrderBook(symbol, kind, depth)

订单簿深度

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final String symbol = NVDA; // String | 股票代码
final ProductKind kind = ; // ProductKind | 
final int depth = 56; // int | 

try {
    final response = api.getOrderBook(symbol, kind, depth);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->getOrderBook: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 
 **kind** | [**ProductKind**](.md)|  | 
 **depth** | **int**|  | [optional] [default to 20]

### Return type

[**OrderBook**](OrderBook.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProduct**
> ProductDetail getProduct(symbol, kind)

产品详情

详情页顶部报价、产品说明、资产权益与行情统计的聚合接口。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final String symbol = NVDA; // String | 股票代码
final ProductKind kind = ; // ProductKind | 

try {
    final response = api.getProduct(symbol, kind);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->getProduct: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 
 **kind** | [**ProductKind**](.md)|  | 

### Return type

[**ProductDetail**](ProductDetail.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getProductStats**
> MarketStats getProductStats(symbol, kind)

24h 行情统计

24h 高 / 低、成交额、成交量、参考价与相对偏离（bStocks 为 Premium，HIP-3 为 Basis）、 价差、买一卖一；HIP-3 额外返回资金费率与未平仓合约量。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final String symbol = NVDA; // String | 股票代码
final ProductKind kind = ; // ProductKind | 

try {
    final response = api.getProductStats(symbol, kind);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->getProductStats: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 
 **kind** | [**ProductKind**](.md)|  | 

### Return type

[**MarketStats**](MarketStats.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listProducts**
> ListProducts200Response listProducts(group, productType, q, cursor, limit)

产品列表 / 分组

首页和市场页的扁平产品列表统一数据源。用 `group` 区分「热门 / 涨幅 / 跌幅 / 成交量 / 自选」；`favorites` 仅返回当前登录用户的自选产品。 `product_type` 对应首页一级筛选（全部 / 现货 / 合约）。每项仍带 `is_favorite`，用于渲染收藏状态。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final MarketProductGroup group = ; // MarketProductGroup | 列表分组；`favorites` 为当前用户自选列表
final ProductType productType = ; // ProductType | 
final String q = q_example; // String | 
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listProducts(group, productType, q, cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->listProducts: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **group** | [**MarketProductGroup**](.md)| 列表分组；`favorites` 为当前用户自选列表 | [optional] 
 **productType** | [**ProductType**](.md)|  | [optional] 
 **q** | **String**|  | [optional] 
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListProducts200Response**](ListProducts200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listStocks**
> ListStocks200Response listStocks(q, cursor, limit)

股票分组列表

市场页「股票」Tab。每支股票包含美股参考价与其支持的产品（bStocks / HIP-3）， 每个产品带自己的链上价格与相对参考价的价差。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final String q = q_example; // String | 按代码或公司名模糊搜索
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listStocks(q, cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->listStocks: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**| 按代码或公司名模糊搜索 | [optional] 
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListStocks200Response**](ListStocks200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **removeFavorite**
> removeFavorite(symbol, kind)

取消自选

幂等操作。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final String symbol = NVDA; // String | 股票代码
final ProductKind kind = ; // ProductKind | 

try {
    api.removeFavorite(symbol, kind);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->removeFavorite: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**| 股票代码 | 
 **kind** | [**ProductKind**](.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **replaceFavorites**
> replaceFavorites(replaceFavoritesRequest)

覆盖自选列表（用于排序）

仅用于将当前用户已有自选产品整体重新排序。读取自选列表统一使用 `GET /v1/markets/products?group=favorites`。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getMarketsApi();
final ReplaceFavoritesRequest replaceFavoritesRequest = ; // ReplaceFavoritesRequest | 

try {
    api.replaceFavorites(replaceFavoritesRequest);
} on DioException catch (e) {
    print('Exception when calling MarketsApi->replaceFavorites: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **replaceFavoritesRequest** | [**ReplaceFavoritesRequest**](ReplaceFavoritesRequest.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

