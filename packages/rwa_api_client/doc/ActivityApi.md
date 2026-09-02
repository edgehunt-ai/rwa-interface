# rwa_api_client.api.ActivityApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**listActivity**](ActivityApi.md#listactivity) | **GET** /v1/activity | 交易与资金活动列表


# **listActivity**
> ListActivity200Response listActivity(category, status, cursor, limit)

交易与资金活动列表

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getActivityApi();
final ActivityCategory category = ; // ActivityCategory | 
final ActivityStatus status = ; // ActivityStatus | 
final String cursor = cursor_example; // String | 上一页返回的 `next_cursor`
final int limit = 56; // int | 

try {
    final response = api.listActivity(category, status, cursor, limit);
    print(response);
} on DioException catch (e) {
    print('Exception when calling ActivityApi->listActivity: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **category** | [**ActivityCategory**](.md)|  | [optional] 
 **status** | [**ActivityStatus**](.md)|  | [optional] 
 **cursor** | **String**| 上一页返回的 `next_cursor` | [optional] 
 **limit** | **int**|  | [optional] [default to 20]

### Return type

[**ListActivity200Response**](ListActivity200Response.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

