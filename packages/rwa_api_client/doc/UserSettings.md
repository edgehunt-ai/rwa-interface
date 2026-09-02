# rwa_api_client.model.UserSettings

## Load the model package
```dart
import 'package:rwa_api_client/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**language** | **String** | 界面语言。服务端也用它决定推送通知的语言 —— 推送由后端发起， 拿不到请求头里的 `Accept-Language`，所以这个偏好必须存在服务端。  | [default to 'zh-CN']
**pushEnabled** | **bool** | 推送总开关。关闭后后端不再向该用户的任何设备推送， 下面三个分类开关的取值被忽略（但保留，重新打开总开关后恢复原样）。  | [default to true]
**notifyOrderFilled** | **bool** | 订单成交。市价成交、限价单被撮合、止盈止损触发都归这一类。 | [default to true]
**notifyOrderFailed** | **bool** | 订单失败。下单被拒、超出滑点、资金准备失败等。 | [default to true]
**notifyLiquidationWarning** | **bool** | 强平预警。仅对 HIP-3 合约仓位有效，现货持仓不会触发。 触发阈值由平台统一设定，暂不支持用户自定义。  | [default to true]

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


