# rwa_api_client.model.MarketSessionInfo

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**timezone** | **String** |  | 
**current** | [**SessionKind**](SessionKind.md) |  | 
**currentLabel** | **String** |  | [optional] 
**currentDescription** | **String** |  | [optional] 
**nextSession** | [**SessionKind**](SessionKind.md) |  | [optional] 
**nextTransitionAt** | [**DateTime**](DateTime.md) |  | [optional] 
**secondsUntilTransition** | **int** | 距下一次时段切换的秒数，用于「距开盘 02:14:33」倒计时 | [optional] 
**isHoliday** | **bool** |  | [optional] 
**holidayName** | **String** |  | [optional] 
**segments** | [**BuiltList&lt;SessionSegment&gt;**](SessionSegment.md) |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


