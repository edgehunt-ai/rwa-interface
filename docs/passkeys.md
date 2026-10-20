# Passkey 配置

`PRIVY_EXPORT_URL` 是唯一的域名来源：私钥导出打开完整 URL，原生 Passkey
登录、绑定使用其 hostname（RP ID 不含协议、端口或路径），钱包 SIWE 使用其
HTTPS origin，iOS 的 `webcredentials` 使用其 hostname。URL 可以带页面路径、
查询参数或 fragment，这些内容不会传入 RP。
代码没有默认域名，也不再读取 `PRIVY_RELYING_PARTY`。

## App 构建

在 `.env` 或 GitHub Actions Variables 设置 `PRIVY_EXPORT_URL`。运行
`make run`，或构建前执行 `make sync-privy-config ENV_FILE=.env`，即可由同一
变量生成 iOS 的 `PrivyPasskey.xcconfig`。该文件不提交到 Git；不要手动修改。
Debug、Profile、Release 均使用 `Runner.entitlements` 中的关联域名。
移动端发布流程已经从 Actions 的 `PRIVY_EXPORT_URL` 写入 `.env.ci` 并同步原生配置。

## 导出站点部署

导出站点构建时自动生成 `.well-known` 文件并复制到 `dist`。正式的 GitHub
Actions 部署要求导出 URL 和现有 Android 发布 Secret；iOS 关联文件按需配置：

| Actions Variable | 用途 |
|---|---|
| `PRIVY_EXPORT_URL` | 导出站点的稳定 HTTPS URL，必须与 App 构建一致 |
| `APPLE_TEAM_ID` | 可选；Apple Developer Team ID，用于生成 iOS AASA 文件 |
| `ANDROID_KEYSTORE_BASE64` 等 | 复用现有 Android 发布 Secret，部署时自动读取证书指纹；无需另填指纹 |

当前 iOS Bundle ID 和 Android package name 均为 `global.nobell.app`。生成器
也支持 `IOS_BUNDLE_ID`、`ANDROID_PACKAGE_NAME` 覆盖。不要新增或提交证书私钥。
Android 应使用实际安装包的签名；Google Play 分发时使用 App Signing 证书，
本地调试需要包含对应调试证书指纹。

设置 `APPLE_TEAM_ID` 后才生成 `/.well-known/apple-app-site-association`；部署任务会
从 Android keystore 自动生成 `/.well-known/assetlinks.json`。未配置 Apple Team ID
不会影响 Android 关联文件生成。

Vercel 的 prebuilt 配置让实际文件优先返回，两个文件使用 `application/json`，
缺失的 `.well-known` 路径返回 404，不落到导出页的 HTML。

本地验证构建：

```bash
node --env-file=.env scripts/generate-passkey-association-files.mjs
npm run privy:export:build
node --test scripts/generate-passkey-association-files.test.mjs scripts/sync-privy-url-scheme.test.mjs
```

## 控制台及真机验证

在 Privy Dashboard 配置相同域名和相应移动应用身份，在 Apple Developer
的 App ID/签名配置中启用 Associated Domains。部署后确认两个已配置平台的
关联 URL 返回 200 和 JSON；再在真机完成“绑定 Passkey → 退出 → Passkey
登录”的验证。更换 RP 域名后，旧域名的 Passkey 需要重新绑定。

浏览器通过 Privy 弹窗认证，WebAuthn 凭证受浏览器实际站点 origin 限制。
原生端的 RP 配置不会让另一个域名上的网页自动获得这些凭证。
