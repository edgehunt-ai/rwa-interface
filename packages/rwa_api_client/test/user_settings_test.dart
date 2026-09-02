import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for UserSettings
void main() {
  final instance = UserSettingsBuilder();
  // TODO add properties to the builder and call build()

  group(UserSettings, () {
    // 界面语言。服务端也用它决定推送通知的语言 —— 推送由后端发起， 拿不到请求头里的 `Accept-Language`，所以这个偏好必须存在服务端。 
    // String language (default value: 'zh-CN')
    test('to test the property `language`', () async {
      // TODO
    });

    // 推送总开关。关闭后后端不再向该用户的任何设备推送， 下面三个分类开关的取值被忽略（但保留，重新打开总开关后恢复原样）。 
    // bool pushEnabled (default value: true)
    test('to test the property `pushEnabled`', () async {
      // TODO
    });

    // 订单成交。市价成交、限价单被撮合、止盈止损触发都归这一类。
    // bool notifyOrderFilled (default value: true)
    test('to test the property `notifyOrderFilled`', () async {
      // TODO
    });

    // 订单失败。下单被拒、超出滑点、资金准备失败等。
    // bool notifyOrderFailed (default value: true)
    test('to test the property `notifyOrderFailed`', () async {
      // TODO
    });

    // 强平预警。仅对 HIP-3 合约仓位有效，现货持仓不会触发。 触发阈值由平台统一设定，暂不支持用户自定义。 
    // bool notifyLiquidationWarning (default value: true)
    test('to test the property `notifyLiquidationWarning`', () async {
      // TODO
    });

  });
}
