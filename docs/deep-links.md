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

## HTTPS App Links / Universal Links

沿用 `PRIVY_EXPORT_URL` 的 hostname，与 Passkey 站点共用关联文件。例如：

    https://rwa-interface.vercel.app/trade?symbol=ETH&kind=perp
    https://rwa-interface.vercel.app/activity/order%2F123

App 外部 HTTPS 链接使用实际路径，不使用 Web 的 `/#/trade` 格式。关联范围
限定为 `/trade`、`/markets` 和 `/activity/*`，私钥导出页仍在浏览器打开。

构建前运行 `make sync-privy-config ENV_FILE=.env`，同步 Android host 资源和
iOS 配置。iOS entitlements 同时包含 webcredentials 和 applinks。
关联文件生成器保留 Passkey 配置，并新增 App Links / Universal Links 权限。

执行已有导出站点部署流程，发布 `/.well-known/apple-app-site-association` 和
`/.well-known/assetlinks.json`。iOS 需配置 `APPLE_TEAM_ID`、Associated Domains
capability 和签名；Android 证书指纹必须与实际安装包一致。Google Play App
Signing 证书可能与上传证书不同。详见 [Passkey 配置](passkeys.md)。

HTTPS 唤起需要关联文件部署、重新构建并安装后验证。仅修改 App 代码不会
发布关联文件。未安装 App 时仍由 HTTPS 站点处理请求，当前导出站点不会
自动展示市场详情。

## 验证

先安装新构建的 App。Android 冷启动：

    adb shell am force-stop global.nobell.app
    adb shell am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d 'nobell-app://app/trade?symbol=ETH&kind=perp'

保持 App 打开，再用其他产品链接验证运行中切换。HTTPS 验证：

    adb shell pm verify-app-links --re-verify global.nobell.app
    adb shell pm get-app-links global.nobell.app
    adb shell am start -W -a android.intent.action.VIEW -d 'https://rwa-interface.vercel.app/trade?symbol=TSLA&kind=bstock'

iOS 模拟器：

    xcrun simctl openurl booted 'nobell-app://app/trade?symbol=ETH&kind=perp'

Universal Links 最终应在签名真机上从短信或其他 App 点击 HTTPS 链接验证。
同时回归 Privy 登录回调，确认仍可正常返回 App。
