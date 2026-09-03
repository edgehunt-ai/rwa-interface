# rwa_api_client.api.AuthApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**createSession**](AuthApi.md#createsession) | **POST** /v1/auth/session | 创建或恢复产品会话
[**deleteSession**](AuthApi.md#deletesession) | **DELETE** /v1/auth/session | 退出登录
[**getAuthConfig**](AuthApi.md#getauthconfig) | **GET** /v1/auth/config | 获取客户端 Privy 配置


# **createSession**
> SessionResponse createSession(sessionRequest)

创建或恢复产品会话

客户端在 Privy SDK 登录后，把 Privy access token 直接放入 Authorization Bearer header。请求体仅包含可选语言和设备信息；响应不签发 access token。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAuthApi();
final SessionRequest sessionRequest = ; // SessionRequest | 

try {
    final response = api.createSession(sessionRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->createSession: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **sessionRequest** | [**SessionRequest**](SessionRequest.md)|  | 

### Return type

[**SessionResponse**](SessionResponse.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **deleteSession**
> deleteSession()

退出登录

结束当前产品会话，但不删除账户或资产。客户端同时调用 Privy SDK logout 清除 Privy 侧会话。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAuthApi();

try {
    api.deleteSession();
} on DioException catch (e) {
    print('Exception when calling AuthApi->deleteSession: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getAuthConfig**
> PrivyClientConfig getAuthConfig()

获取客户端 Privy 配置

Flutter 端启动时拉取，用于初始化 Privy SDK。避免把 App ID / 支持的登录方式硬编码在客户端。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAuthApi();

try {
    final response = api.getAuthConfig();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AuthApi->getAuthConfig: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**PrivyClientConfig**](PrivyClientConfig.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

