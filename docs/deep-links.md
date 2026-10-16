# 外部链接与 App 唤起

Android、iOS 使用 Flutter 自带的 deep link handler，将外部 URL 交给
GoRouter。支持冷启动和 App 已运行时打开。

## 链接格式

业务 scheme 为 `PRIVY_APP_URL_SCHEME` 加 `-app`，默认为 `nobell-app`。业务链接使用
host `app`，避免与 Privy 的 `nobell://` 登录回调混淆。

- bStocks：`nobell-app://app/trade?symbol=TSLA&kind=bstock`
- 永续：`nobell-app://app/trade?symbol=ETH&kind=perp`
- 市场列表：`nobell-app://app/markets`
- Activity 详情：`nobell-app://app/activity/order%2F123`

产品参数用 `AppRoutes.tradeLocation` 生成，记录 ID 用
`AppRoutes.activityDetailLocation` 编码，不要直接拼接未经编码的值。

当前只支持自定义 scheme。HTTPS 链接不会直接拉起 App，仍由现有 Web 服务
处理；Passkey 所需的关联文件配置见 [Passkey 配置](passkeys.md)。

## 验证

先安装新构建的 App。Android 冷启动：

    adb shell am force-stop global.nobell.app
    adb shell am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d 'nobell-app://app/trade?symbol=ETH&kind=perp'

保持 App 打开，再用其他产品链接验证运行中切换。

iOS 模拟器：

    xcrun simctl openurl booted 'nobell-app://app/trade?symbol=ETH&kind=perp'

同时回归 Privy 登录回调，确认仍可正常返回 App。
