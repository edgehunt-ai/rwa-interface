# rwa_api_client.api.SystemApi

## Load the API package
```dart
import 'package:rwa_api_client/api.dart';
```

All URIs are relative to *https://rwa-api-staging.dxd.ink*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getDisclosures**](SystemApi.md#getdisclosures) | **GET** /v1/system/disclosures | 产品说明文案
[**listAppVersions**](SystemApi.md#listappversions) | **GET** /v1/system/app-version | 各平台最新版本
[**streamEvents**](SystemApi.md#streamevents) | **GET** /v1/events | 实时事件流（SSE）


# **getDisclosures**
> Disclosures getDisclosures(locale)

产品说明文案

返回 24×7 交易说明、各交易时段说明、产品风险提示等长文案， 便于不发版调整措辞与多语言。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getSystemApi();
final String locale = zh-CN; // String | 

try {
    final response = api.getDisclosures(locale);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SystemApi->getDisclosures: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **locale** | **String**|  | [optional] 

### Return type

[**Disclosures**](Disclosures.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **listAppVersions**
> ListAppVersions200Response listAppVersions(platform)

各平台最新版本

返回所有平台的版本信息。客户端拿自己的版本和对应平台的条目比较：  * `current < min_supported_version` → 强制升级，阻断使用 * `current < latest_version` → 提示有新版本，可跳过  比较放在客户端而不是服务端，是为了避免「查版本」这一个接口出现 「带参数算结果」和「不带参数列数据」两种模式。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getSystemApi();
final String platform = platform_example; // String | 只取某个平台；不传则返回全部

try {
    final response = api.listAppVersions(platform);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SystemApi->listAppVersions: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **platform** | **String**| 只取某个平台；不传则返回全部 | [optional] 

### Return type

[**ListAppVersions200Response**](ListAppVersions200Response.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **streamEvents**
> RealtimeEvent streamEvents(channels, lastEventID)

实时事件流（SSE）

Server-Sent Events。推送价格、订单状态、持仓与余额变化， 替代前端轮询。每条事件同时以 SSE 的 `id:` 字段和载荷的 `event_id` 给出可续传 标识；断线重连时客户端带上最近收到的 `Last-Event-ID`，服务端补发其后的事件。 事件名与强类型 `data` 结构见 `RealtimeEvent`。 

### Example
```dart
import 'package:rwa_api_client/api.dart';

final api = RwaApiClient().getSystemApi();
final String channels = channels_example; // String | 订阅频道，如 `prices:NVDA:perp,orders,positions`
final String lastEventID = lastEventID_example; // String | SSE 断线重连时传入最后成功处理的 `event_id`。服务端应从该事件之后补发； 若保留窗口已过期，则发送一条 `resync_required` 事件并由客户端重新拉取快照。 

try {
    final response = api.streamEvents(channels, lastEventID);
    print(response);
} on DioException catch (e) {
    print('Exception when calling SystemApi->streamEvents: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **channels** | **String**| 订阅频道，如 `prices:NVDA:perp,orders,positions` | [optional] 
 **lastEventID** | **String**| SSE 断线重连时传入最后成功处理的 `event_id`。服务端应从该事件之后补发； 若保留窗口已过期，则发送一条 `resync_required` 事件并由客户端重新拉取快照。  | [optional] 

### Return type

[**RealtimeEvent**](RealtimeEvent.md)

### Authorization

[bearerAuth](../README.md#bearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/event-stream, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

