# rwa_api_client.api.OrdersApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**cancelOrder**](OrdersApi.md#cancelorder) | **DELETE** /v1/orders/{order_id} | 请求取消订单
[**completeHip3AgentChallenge**](OrdersApi.md#completehip3agentchallenge) | **POST** /v1/hip3/agent/challenges/{challenge_id}/complete | 提交 HIP-3 agent challenge 签名
[**completeOrderWalletAction**](OrdersApi.md#completeorderwalletaction) | **POST** /v1/orders/{order_id}/wallet-actions/{step_id}/complete | 提交指定钱包动作的签名结果
[**createHip3AgentChallenge**](OrdersApi.md#createhip3agentchallenge) | **POST** /v1/hip3/agent/challenges | 创建 HIP-3 agent 授权 challenge
[**createOrder**](OrdersApi.md#createorder) | **POST** /v1/orders | 创建订单
[**getOrder**](OrdersApi.md#getorder) | **GET** /v1/orders/{order_id} | 订单详情与权威状态
[**listOrders**](OrdersApi.md#listorders) | **GET** /v1/orders | 订单列表
[**previewOrder**](OrdersApi.md#previeworder) | **POST** /v1/orders/preview | 预览 bStocks 或 HIP-3 订单


# **cancelOrder**
> Order cancelOrder(orderId, idempotencyKey)

请求取消订单

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String orderId = orderId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.

try {
    final response = api.cancelOrder(orderId, idempotencyKey);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->cancelOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 

### Return type

[**Order**](Order.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeHip3AgentChallenge**
> Hip3Challenge completeHip3AgentChallenge(challengeId, idempotencyKey, hip3ChallengeCompleteRequest)

提交 HIP-3 agent challenge 签名

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String challengeId = challengeId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final Hip3ChallengeCompleteRequest hip3ChallengeCompleteRequest = ; // Hip3ChallengeCompleteRequest | 

try {
    final response = api.completeHip3AgentChallenge(challengeId, idempotencyKey, hip3ChallengeCompleteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->completeHip3AgentChallenge: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **challengeId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **hip3ChallengeCompleteRequest** | [**Hip3ChallengeCompleteRequest**](Hip3ChallengeCompleteRequest.md)|  | 

### Return type

[**Hip3Challenge**](Hip3Challenge.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **completeOrderWalletAction**
> Order completeOrderWalletAction(orderId, stepId, idempotencyKey, walletActionCompleteRequest)

提交指定钱包动作的签名结果

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String orderId = orderId_example; // String | 
final String stepId = stepId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final WalletActionCompleteRequest walletActionCompleteRequest = ; // WalletActionCompleteRequest | 

try {
    final response = api.completeOrderWalletAction(orderId, stepId, idempotencyKey, walletActionCompleteRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->completeOrderWalletAction: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 
 **stepId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **walletActionCompleteRequest** | [**WalletActionCompleteRequest**](WalletActionCompleteRequest.md)|  | 

### Return type

[**Order**](Order.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createHip3AgentChallenge**
> Hip3Challenge createHip3AgentChallenge(idempotencyKey, hip3ChallengeRequest)

创建 HIP-3 agent 授权 challenge

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final Hip3ChallengeRequest hip3ChallengeRequest = ; // Hip3ChallengeRequest | 

try {
    final response = api.createHip3AgentChallenge(idempotencyKey, hip3ChallengeRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->createHip3AgentChallenge: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **hip3ChallengeRequest** | [**Hip3ChallengeRequest**](Hip3ChallengeRequest.md)|  | [optional] 

### Return type

[**Hip3Challenge**](Hip3Challenge.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **createOrder**
> Order createOrder(idempotencyKey, createOrderRequest)

创建订单

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final CreateOrderRequest createOrderRequest = ; // CreateOrderRequest | 

try {
    final response = api.createOrder(idempotencyKey, createOrderRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->createOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **createOrderRequest** | [**CreateOrderRequest**](CreateOrderRequest.md)|  | 

### Return type

[**Order**](Order.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getOrder**
> Order getOrder(orderId)

订单详情与权威状态

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String orderId = orderId_example; // String | 

try {
    final response = api.getOrder(orderId);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->getOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderId** | **String**|  | 

### Return type

[**Order**](Order.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listOrders**
> ListOrders200Response listOrders(cursor, limit)

订单列表

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listOrders(cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->listOrders: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListOrders200Response**](ListOrders200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **previewOrder**
> OrderPreview previewOrder(idempotencyKey, orderPreviewRequest)

预览 bStocks 或 HIP-3 订单

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getOrdersApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final OrderPreviewRequest orderPreviewRequest = ; // OrderPreviewRequest | 

try {
    final response = api.previewOrder(idempotencyKey, orderPreviewRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling OrdersApi->previewOrder: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **orderPreviewRequest** | [**OrderPreviewRequest**](OrderPreviewRequest.md)|  | 

### Return type

[**OrderPreview**](OrderPreview.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

