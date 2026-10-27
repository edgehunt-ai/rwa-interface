# Passkey 配置

`PRIVY_EXPORT_URL` 是唯一的域名来源：私钥导出打开完整 URL，原生 Passkey
登录、绑定及钱包 SIWE 使用其 HTTPS origin（如 `https://example.com`），
iOS 的 `webcredentials` 使用其 hostname。Privy 的 `relyingParty` 参数要求
HTTPS origin；WebAuthn 凭证中的 hostname RP ID 由 SDK/服务端处理，不应把
SDK 参数改成裸域名。URL 可以带页面路径、查询参数或 fragment，这些内容
不会传入 RP。
代码没有默认域名，也不再读取 `PRIVY_RELYING_PARTY`。

当前私钥导出地址为 `https://rwa-interface.vercel.app/export-private-key`，与 Flutter Web
主站独立部署。导出站点的 Vercel 路由支持 `/export-private-key`，静态脚本及
`/.well-known` 关联文件仍从域名根路径加载。仅添加页面路径不会改变 Passkey
使用的 origin 或 hostname；已安装 App 需重新构建安装后才会使用新地址。

## App 构建

在 `.env` 或 GitHub Actions Variables 设置 `PRIVY_EXPORT_URL`。运行
`make run`，或构建前执行 `make sync-privy-config ENV_FILE=.env`，即可由同一
变量生成 iOS 的 `PrivyPasskey.xcconfig`。该文件不提交到 Git；不要手动修改。
Debug、Profile、Release 均使用 `Runner.entitlements` 中的关联域名。
移动端发布流程已经从 Actions 的 `PRIVY_EXPORT_URL` 写入 `.env.ci` 并同步原生配置。

## 导出站点部署

导出站点构建时自动生成 `.well-known` 文件并复制到 `dist`。正式的 GitHub
Actions 部署要求导出 URL 和证书指纹；iOS 关联文件按需配置：

| Actions Variable | 用途 |
|---|---|
| `PRIVY_EXPORT_URL` | 导出站点的稳定 HTTPS URL，必须与 App 构建一致 |
| `APPLE_TEAM_ID` | 可选；Apple Developer Team ID，用于生成 iOS AASA 文件 |
| `ANDROID_SHA256_CERT_FINGERPRINTS` | 必填；逗号分隔的公开 SHA-256 指纹列表 |

当前 iOS Bundle ID 和 Android package name 均为 `global.nobell.app`。生成器
也支持 `IOS_BUNDLE_ID`、`ANDROID_PACKAGE_NAME` 覆盖。不要新增或提交证书私钥。

`ANDROID_SHA256_CERT_FINGERPRINTS` 必须覆盖用户实际会安装的每一种签名：

- Google Play 分发时使用 App Signing 证书（Console → 测试和发布 → 应用完整性 →
  应用签名），该指纹只在首次上传 AAB 之后才存在。
- GitHub Release 与本地 release 构建使用上传密钥证书（CI keystore）。
- 两者都必须列出，否则对应渠道的 Passkey 会静默失效。

部署站点不再读取 keystore，因此 web 部署流程不持有任何签名私钥。指纹是公开
信息，可直接放在 Actions Variables。更换上传密钥或做 app signing key upgrade
后需同步更新该变量并重新部署。

关联声明同时包含 Privy Android 设置指南要求的
`delegate_permission/common.handle_all_urls` 和凭证共享使用的
`delegate_permission/common.get_login_creds`。

参考官方文档：[Passkey 参数](https://docs.privy.io/authentication/user-authentication/login-methods/passkey)、
[Android 设置](https://docs.privy.io/basics/android/advanced/setup-passkeys)。
修改生成器后需重新部署导出站点，确认线上关联 JSON 包含这两个 relation。
App 的 origin 参数修复也需重新构建安装；仅修改站点无法修正已发布的 APK。

设置 `APPLE_TEAM_ID` 后才生成 `/.well-known/apple-app-site-association`；
`ANDROID_SHA256_CERT_FINGERPRINTS` 非空时才生成 `/.well-known/assetlinks.json`。
未配置 Apple Team ID 不会影响 Android 关联文件生成。

Vercel 的 prebuilt 配置让实际文件优先返回，两个文件使用 `application/json`，
缺失的 `.well-known` 路径返回 404，不落到导出页的 HTML。

本地验证构建（将示例替换为完整的实际 SHA-256 指纹；`export` 让后续构建也能
读取同一份配置）：

```bash
export ANDROID_SHA256_CERT_FINGERPRINTS='AB:CD:...'
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

Play 版本与 GitHub Release APK 使用不同签名证书，两者无法互相覆盖安装，
切换渠道需卸载重装。`release.yml` 只产出 `--split-per-abi` 的 arm64 与
x86_64 APK（versionCode 带 ABI 前缀，如 `2026`）；不要改发通用 APK，也不
要加 `-P force-version-code-ignoring-abi=true`，否则同一渠道内的版本号会
回落到 AAB 的纯 build number，导致升级失败。
