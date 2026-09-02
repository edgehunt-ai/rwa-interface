# rwa_api_client.model.Error

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**code** | **String** | Stable machine-readable error code | 
**message** | **String** | Localized user-facing message | 
**retryable** | **bool** | Whether retrying the same request can succeed | 
**userAction** | **String** | Stable client action hint, or null | 
**details** | [**BuiltMap&lt;String, JsonObject&gt;**](JsonObject.md) |  | 
**requestId** | **String** | Matches the X-Request-ID response header | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


