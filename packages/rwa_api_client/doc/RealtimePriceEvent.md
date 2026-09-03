# rwa_api_client.model.RealtimePriceEvent

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**eventId** | **String** | 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重 | 
**emittedAt** | [**DateTime**](DateTime.md) |  | 
**event** | **String** |  | 
**data** | [**RealtimePriceUpdate**](RealtimePriceUpdate.md) |  | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


