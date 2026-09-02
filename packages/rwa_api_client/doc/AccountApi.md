# rwa_api_client.api.AccountApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteDevice**](AccountApi.md#deletedevice) | **DELETE** /v1/me/devices/{device_id} | 注销推送设备
[**getMe**](AccountApi.md#getme) | **GET** /v1/me | 当前登录账户
[**listDevices**](AccountApi.md#listdevices) | **GET** /v1/me/devices | 已注册的推送设备
[**registerDevice**](AccountApi.md#registerdevice) | **POST** /v1/me/devices | 注册 / 更新当前设备的推送令牌
[**updateSettings**](AccountApi.md#updatesettings) | **PATCH** /v1/me/settings | 更新当前用户的设置


# **deleteDevice**
> deleteDevice(deviceId)

注销推送设备

退出登录时调用，避免继续向该设备推送已登出账户的消息。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAccountApi();
final String deviceId = deviceId_example; // String | 

try {
    api.deleteDevice(deviceId);
} on DioException catch (e) {
    print('Exception when calling AccountApi->deleteDevice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deviceId** | **String**|  | 

### Return type

void (empty response body)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getMe**
> User getMe()

当前登录账户

用户偏好作为 `settings` 子对象一并返回；更新走 `PATCH /v1/me/settings`。

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAccountApi();

try {
    final response = api.getMe();
    print(response);
} on DioException catch (e) {
    print('Exception when calling AccountApi->getMe: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**User**](User.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listDevices**
> ListDevices200Response listDevices(cursor, limit)

已注册的推送设备

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAccountApi();
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listDevices(cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AccountApi->listDevices: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListDevices200Response**](ListDevices200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **registerDevice**
> Device registerDevice(deviceRegisterRequest)

注册 / 更新当前设备的推送令牌

按 `device_id` upsert。APNs / FCM 令牌会在重装、系统升级、长期未启动后轮换， 因此客户端应在 **每次启动拿到令牌时** 都调一次，而不只在登录时提交一次。  登录时 `SessionRequest.device` 里带的信息等价于调用一次本接口， 两者可任选其一；令牌轮换只能靠本接口。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAccountApi();
final DeviceRegisterRequest deviceRegisterRequest = ; // DeviceRegisterRequest | 

try {
    final response = api.registerDevice(deviceRegisterRequest);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AccountApi->registerDevice: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deviceRegisterRequest** | [**DeviceRegisterRequest**](DeviceRegisterRequest.md)|  | 

### Return type

[**Device**](Device.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **updateSettings**
> UserSettings updateSettings(userSettingsUpdate)

更新当前用户的设置

部分更新：**所有字段都是可选的，传什么改什么，未传的字段保持不变**。  **没有对应的 `GET`** —— 设置作为 `User.settings` 子对象随 `GET /v1/me` 一起返回， 只存在一份定义，不会出现两个来源不一致的情况。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getAccountApi();
final UserSettingsUpdate userSettingsUpdate = ; // UserSettingsUpdate | 

try {
    final response = api.updateSettings(userSettingsUpdate);
    print(response);
} on DioException catch (e) {
    print('Exception when calling AccountApi->updateSettings: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **userSettingsUpdate** | [**UserSettingsUpdate**](UserSettingsUpdate.md)|  | 

### Return type

[**UserSettings**](UserSettings.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

