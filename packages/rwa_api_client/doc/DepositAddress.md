# rwa_api_client.model.DepositAddress

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**chain** | [**Chain**](Chain.md) |  | 
**token** | **String** |  | 
**address** | **String** |  | 
**memo** | **String** | 部分链需要的备注 / tag | [optional] 
**qrPayload** | **String** | 二维码内容，通常是 `ethereum:0x…@56/transfer?address=…` 形式的 URI | [optional] 
**minDeposit** | **String** | 十进制字符串，避免浮点误差 | [optional] 
**confirmationsRequired** | **int** |  | [optional] 
**creditedTo** | [**AccountKind**](AccountKind.md) |  | [optional] 
**warning** | **String** |  | [optional] 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


