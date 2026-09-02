# rwa_api_client.api.PortfolioApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getPortfolioSummary**](PortfolioApi.md#getportfoliosummary) | **GET** /v1/portfolio/summary | 资产总览
[**listAccounts**](PortfolioApi.md#listaccounts) | **GET** /v1/portfolio/accounts | 各账户余额
[**listHoldings**](PortfolioApi.md#listholdings) | **GET** /v1/portfolio/holdings | 按股票分组的持仓


# **getPortfolioSummary**
> PortfolioSummary getPortfolioSummary()

资产总览

资产页顶部：总资产、今日盈亏、可用于交易的金额（Available to trade）、 占用保证金（Margin in use）。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPortfolioApi();

try {
    final response = api.getPortfolioSummary();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PortfolioApi->getPortfolioSummary: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PortfolioSummary**](PortfolioSummary.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAccounts**
> ListAccounts200Response listAccounts()

各账户余额

App 采用三段式账户结构，前端在资金流程中需要分别展示：  * `app` —— App 可用余额（聚合账户，入金默认到账处）； * `bstocks` —— BSC Wallet，bStocks 现货交易账户； * `hip3` —— HIP-3 交易账户（Hyperliquid 保证金）。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPortfolioApi();

try {
    final response = api.listAccounts();
    print(response);
} on DioException catch (e) {
    print('Exception when calling PortfolioApi->listAccounts: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ListAccounts200Response**](ListAccounts200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listHoldings**
> ListHoldings200Response listHoldings(cursor, limit)

按股票分组的持仓

资产页 Stocks 区块：每支股票一组，组内列出该股票下的各产品持仓。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPortfolioApi();
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listHoldings(cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PortfolioApi->listHoldings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListHoldings200Response**](ListHoldings200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

