# rwa_api_client.api.PositionsApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**clearPositionTpSl**](PositionsApi.md#clearpositiontpsl) | **DELETE** /v1/positions/{position_id}/tpsl | 清除止盈止损
[**closePosition**](PositionsApi.md#closeposition) | **POST** /v1/positions/{position_id}/close | 平仓（支持部分平仓）
[**getPosition**](PositionsApi.md#getposition) | **GET** /v1/positions/{position_id} | 仓位详情
[**listPositions**](PositionsApi.md#listpositions) | **GET** /v1/positions | 持仓列表
[**updatePositionLeverage**](PositionsApi.md#updatepositionleverage) | **PATCH** /v1/positions/{position_id}/leverage | 调整杠杆 / 保证金模式
[**updatePositionTpSl**](PositionsApi.md#updatepositiontpsl) | **PUT** /v1/positions/{position_id}/tpsl | 设置 / 修改止盈止损


# **clearPositionTpSl**
> Position clearPositionTpSl(positionId, idempotencyKey)

清除止盈止损

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPositionsApi();
final String positionId = positionId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.

try {
    final response = api.clearPositionTpSl(positionId, idempotencyKey);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PositionsApi->clearPositionTpSl: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **positionId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 

### Return type

[**Position**](Position.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **closePosition**
> Order closePosition(positionId, idempotencyKey, closePositionRequest)

平仓（支持部分平仓）

HIP-3 仓位的市价 / 限价平仓，可指定数量或百分比。 bStocks 现货的「卖出」走 `POST /v1/orders`，本接口仅用于合约。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPositionsApi();
final String positionId = positionId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final ClosePositionRequest closePositionRequest = ; // ClosePositionRequest | 

try {
    final response = api.closePosition(positionId, idempotencyKey, closePositionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PositionsApi->closePosition: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **positionId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **closePositionRequest** | [**ClosePositionRequest**](ClosePositionRequest.md)|  | 

### Return type

[**Order**](Order.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getPosition**
> Position getPosition(positionId)

仓位详情

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPositionsApi();
final String positionId = positionId_example; // String | 

try {
    final response = api.getPosition(positionId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PositionsApi->getPosition: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **positionId** | **String**|  | 

### Return type

[**Position**](Position.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listPositions**
> ListPositions200Response listPositions(symbol, kind, cursor, limit)

持仓列表

同时返回 bStocks 现货持仓与 HIP-3 合约仓位。资产页按股票分组展示， 详情页按 `symbol` + `kind` 过滤后展示单个仓位。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPositionsApi();
final String symbol = symbol_example; // String | 
final ProductKind kind = ; // ProductKind | 
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listPositions(symbol, kind, cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PositionsApi->listPositions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **symbol** | **String**|  | [optional] 
 **kind** | [**ProductKind**](.md)|  | [optional] 
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListPositions200Response**](ListPositions200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePositionLeverage**
> Position updatePositionLeverage(positionId, idempotencyKey, updatePositionLeverageRequest)

调整杠杆 / 保证金模式

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPositionsApi();
final String positionId = positionId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final UpdatePositionLeverageRequest updatePositionLeverageRequest = ; // UpdatePositionLeverageRequest | 

try {
    final response = api.updatePositionLeverage(positionId, idempotencyKey, updatePositionLeverageRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PositionsApi->updatePositionLeverage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **positionId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **updatePositionLeverageRequest** | [**UpdatePositionLeverageRequest**](UpdatePositionLeverageRequest.md)|  | 

### Return type

[**Position**](Position.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updatePositionTpSl**
> Position updatePositionTpSl(positionId, idempotencyKey, tpSlUpdateRequest)

设置 / 修改止盈止损

对应「编辑止盈止损」弹窗。校验规则： Long 时 TP 需高于入场价、SL 需低于入场价；Short 反之。 传 `null` 表示清除该条件单。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getPositionsApi();
final String positionId = positionId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final TpSlUpdateRequest tpSlUpdateRequest = ; // TpSlUpdateRequest | 

try {
    final response = api.updatePositionTpSl(positionId, idempotencyKey, tpSlUpdateRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling PositionsApi->updatePositionTpSl: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **positionId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **tpSlUpdateRequest** | [**TpSlUpdateRequest**](TpSlUpdateRequest.md)|  | 

### Return type

[**Position**](Position.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

