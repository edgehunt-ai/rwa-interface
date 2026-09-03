# rwa_api_client.api.WalletsApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createWalletAuthorization**](WalletsApi.md#createwalletauthorization) | **POST** /v1/me/wallets/{wallet_id}/authorizations | 创建一次性钱包授权
[**listWallets**](WalletsApi.md#listwallets) | **GET** /v1/me/wallets | 列出当前用户钱包
[**syncWallet**](WalletsApi.md#syncwallet) | **POST** /v1/me/wallets/sync | 从 Privy 权威账户同步主钱包


# **createWalletAuthorization**
> WalletAuthorization createWalletAuthorization(walletId, idempotencyKey, walletAuthorizationRequest)

创建一次性钱包授权

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getWalletsApi();
final String walletId = walletId_example; // String | 
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.
final WalletAuthorizationRequest walletAuthorizationRequest = ; // WalletAuthorizationRequest | 

try {
    final response = api.createWalletAuthorization(walletId, idempotencyKey, walletAuthorizationRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WalletsApi->createWalletAuthorization: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **walletId** | **String**|  | 
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 
 **walletAuthorizationRequest** | [**WalletAuthorizationRequest**](WalletAuthorizationRequest.md)|  | 

### Return type

[**WalletAuthorization**](WalletAuthorization.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listWallets**
> ListWallets200Response listWallets(cursor, limit)

列出当前用户钱包

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getWalletsApi();
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listWallets(cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WalletsApi->listWallets: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListWallets200Response**](ListWallets200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **syncWallet**
> Wallet syncWallet(idempotencyKey)

从 Privy 权威账户同步主钱包

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getWalletsApi();
final String idempotencyKey = 38400000-8cf0-11bd-b23e-10b96e4ef00d; // String | Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409.

try {
    final response = api.syncWallet(idempotencyKey);
    print(response);
} on DioException catch (e) {
    print('Exception when calling WalletsApi->syncWallet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **idempotencyKey** | **String**| Client-generated unique command key. A replay returns the first resource; a different request with the same key returns 409. | 

### Return type

[**Wallet**](Wallet.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

