# rwa_interface

跨平台 RWA 交易界面（Flutter）。

## 快速开始

环境要求：Node.js 22、Flutter 3.47/Dart 3.13。生成 API 客户端时还需要可用的 Docker daemon。

安装依赖：

```bash
npm ci --ignore-scripts
flutter pub get
```

完整质量验证：

```bash
npm run quality:check
```

## API 客户端

### 契约与生成

`git@github.com:edgehunt-ai/rwa-api-contract.git` 是后端和客户端共享的唯一公共 API 契约。
本仓库通过 `contracts/rwa-api-contract` submodule 固定消费其某个 commit；不得在本仓库修改该目录内容。
使用以下命令管理 API 客户端：

```bash
# 初始化契约 submodule
npm run api:init

# 拉取当前配置分支（默认 main）的最新契约，生成并检查
npm run api:update

# 切换到指定契约分支，拉取最新契约，生成并检查
npm run api:update:branch -- feat/mainnet-cross-chain-acceptance
```

`api:update` 和 `api:update:branch` 会更新 submodule、生成 Dart 客户端，并运行 Flutter 的格式、分析和测试。
成功后提交 submodule 指针、`.gitmodules`（仅切换分支时）和 `packages/rwa_api_client`。

客户端使用 OpenAPI Generator 7.24.0 的 `dart-dio` 生成器，并通过 Docker 运行，以避免依赖宿主机
Java 版本。生成配置位于 `openapitools.json`，生成器版本记录在：

```text
openapitools.json
packages/rwa_api_client/.openapi-generator/VERSION
```

生成文件位于 `packages/rwa_api_client`，不得手动编辑。

### 应用调用边界

API 请求的标准依赖方向是：

```text
Widget/页面 → Riverpod provider/notifier → repository/use case
           → data service → generated dart-dio client → Dio
```

- Widget、页面和普通业务类不得直接创建 Dio 或调用 generated API。
- Riverpod 负责依赖装配、生命周期和异步状态，不替代 Dio。
- Repository 负责将 wire DTO 映射为 domain model。
- Presentation/state 层只暴露 domain value 和稳定的 `ApiFailure`，不暴露 DTO、`Response` 或
  `DioException`。
- 只有启动初始化、非 Flutter isolate、传输基础设施和 focused test 可以在明确记录理由后直接调用
  底层 API。

### 请求、失败与实时事件

- 普通请求使用显式 connect/send/receive timeout。
- 401 使用 single-flight refresh，每个请求最多安全重试一次；重要命令只有在可证明可重放且带
  `Idempotency-Key` 时才允许重试。
- 所有 Dio/generated 异常在 data 边界映射为 `ApiFailure`，诊断不记录 token、raw body、stack
  trace 或金融 payload。
- SSE 使用独立的长连接，支持 chunk frame、多行 `data`、heartbeat、去重、Last-Event-ID、有界
  退避、取消和 `resync_required`。
- 金融数值保持无损 `String`；分页保留 items 和 continuation cursor。

## 可观测性

默认启用 Sentry 错误上报和采样性能监控。运行时参数通过 `--dart-define` 提供：

```bash
flutter run \
  --dart-define=SENTRY_DSN=https://public-key@example.ingest.sentry.io/project \
  --dart-define=SENTRY_ENVIRONMENT=staging \
  --dart-define=SENTRY_TRACES_SAMPLE_RATE=0.10 \
  --dart-define=SENTRY_PROFILES_SAMPLE_RATE=0.10 \
  --dart-define=SENTRY_RELEASE=app@1.0.0+1
```

将 `SENTRY_DSN` 设为空值可禁用遥测。禁止把 Sentry auth token 写入源码、变量、日志或 workflow；
`SENTRY_AUTH_TOKEN` 只能存放在 GitHub Actions Secrets 中。

Actions Variables：

```text
REOWN_PROJECT_ID
SENTRY_DSN
SENTRY_ENVIRONMENT
SENTRY_TRACES_SAMPLE_RATE
SENTRY_PROFILES_SAMPLE_RATE
SENTRY_ORG=dodo-k4
SENTRY_PROJECT=flutter
```

未配置 `SENTRY_AUTH_TOKEN` 时，打包仍会成功，只跳过 Dart 调试符号、Android R8 mapping 和 iOS
dSYM 上传。iOS artifact 默认未签名；可安装或 App Store IPA 还需要 Apple 证书和 provisioning
profile secrets。Android release 启用 R8 代码和资源压缩。

## CI 与发布

- GitHub Actions 对 push 和 pull request 执行 Flutter 的 `npm run quality:check`。
- GitHub Actions 会在 `main` 推送后构建并部署 Flutter Web 到 Vercel；同仓库 PR 会部署 Vercel Preview，来自 fork 的 PR 会跳过部署，避免向不受信任代码提供部署凭据。
- PR 使用 concurrency，新提交会取消旧的质量运行；Release 运行不会自动取消。
- `main` 上修改 `pubspec.yaml` 版本会触发 Android/iOS 发布构建、创建 `v<version>` 标签并发布
  GitHub Release。
- 手动 Release 只构建产物，不创建标签或 Release。
- Release 使用同一 commit 的完整质量验证后才打包，并只在 summary 中报告 artifact size；不设置
  体积阈值，不生成 checksum，也不做 production URL 阻断。
- 契约审批、兼容性校验和文档发布由 `rwa-api-contract` 仓库负责。

## 多语言

API 生成层和 data/domain 层不保存翻译后的 UI 文案，只传递稳定的错误 `code`、`userAction` 和
结构化字段。后续 UI 本地化由 presentation 层按 locale 映射；后端 `message` 仅作为受控兜底。

## Privy 登录集成

- Android API 28+ 和 iOS 17+ 使用官方 `privy_flutter` SDK。Web 使用同站点内的 React Privy bridge，
  由 Flutter 通过条件导入调用；macOS、Windows 和 Linux 会返回明确的 `unsupportedPlatform` 状态，不会初始化
  native channel。Web bridge 的 React bundle 只位于 `web/privy-auth/dist`，不进入 APK/IPA。
- Android 使用 compile SDK 36（target SDK 仍由 Flutter 配置），用于满足当前 native plugins 与
  Privy Core 的 AndroidX metadata；最低安装版本仍为 API 28。
- App ID、移动端 Client ID 和 OAuth 回跳 scheme 通过编译期环境变量 `PRIVY_APP_ID`、`PRIVY_CLIENT_ID`、
  `PRIVY_APP_URL_SCHEME` 提供；`make run` 会将 scheme 同步到 Android 和 iOS 原生回调配置，修改时只需更新
  环境文件。允许的
  登录方式集中定义在 `lib/app/config/privy_configuration.dart`，当前包含 email、Google OAuth 和
  passkey。OAuth 回跳使用 `PRIVY_APP_URL_SCHEME`，passkey 需要
  `PRIVY_RELYING_PARTY`（默认 `https://rwa.dxd.ink`）。这些都是公开
  客户端标识，Privy secret 不得进入源码或客户端构建参数。
- `authenticationProvider` 提供启动恢复、邮件验证码请求/校验和登出命令；最终登录页面将在设计稿
  确认后消费这些状态与命令。
- Privy SDK 独占身份凭据持久化。应用不会保存或记录 access token、邮件验证码和原始 SDK 错误。

真机联调前，需在 Privy Dashboard 为 staging App 注册 Android application ID
`com.orbit.rwa_interface` 和 iOS bundle identifier，并确认 staging 配置启用了 `email` 登录。
Google OAuth 和 passkey 的原生回跳配置已在工程中注册。Android OAuth 回调由
`io.privy.sdk.oAuth.PrivyRedirectActivity` 接收；不要将同一 scheme 另行注册给 `MainActivity`。在 Privy
Dashboard 中还必须为当前 `PRIVY_CLIENT_ID` 启用 Google 登录，并登记 Android application ID
`com.orbit.rwa_interface`（iOS 为对应 bundle identifier），否则第三方登录页面无法由客户端修复。外部钱包登录使用 Reown AppKit 连接 EVM
钱包并请求 `personal_sign`，再由 Privy SIWE 登录换取现有 API 所需的 Privy access token。需要在
Privy Dashboard 启用外部 EVM 钱包登录，并在 Reown Dashboard 为对应 Android/iOS App 注册
`REOWN_PROJECT_ID` 与 `rwa://` 回跳。

复制环境配置模板并填写 Privy 和 Reown 的公开客户端标识：

```bash
cp .env.example .env
make run
```

也可以显式选择配置文件或附加 Flutter 参数：

```bash
make run ENV_FILE=.env.staging FLUTTER_ARGS='-d android'
```

Release CI 从同名 GitHub Actions Variables 生成临时 `.env.ci`，缺少 `API_BASE_URL`、
`PRIVY_APP_ID`、`PRIVY_CLIENT_ID` 或 `REOWN_PROJECT_ID` 时停止构建。

Web 发布前先生成 Privy 浏览器 bundle，再运行 Flutter Web 构建：

```bash
npm run privy:web:build
flutter build web --dart-define-from-file=.env
```

在 Privy Dashboard 的 Allowed origins 中登记 Web 的生产、staging 和本地开发地址；Web 使用的
`PRIVY_APP_ID` 与 `PRIVY_CLIENT_ID` 必须对应启用了所需登录方式的 Web app client。

Vercel 自动部署使用 GitHub Actions，不依赖 Vercel 的 Git 集成。请在仓库 Secrets 中配置
`VERCEL_TOKEN`、`VERCEL_ORG_ID` 和 `VERCEL_PROJECT_ID`；其中 ID 可通过 `vercel link` 生成的
`.vercel/project.json` 获取。Web 构建继续使用现有 GitHub Actions Variables：`API_BASE_URL`、
`PRIVY_APP_ID`、`PRIVY_CLIENT_ID`、`PRIVY_APP_URL_SCHEME`、`REOWN_PROJECT_ID`，可选
`PRIVY_RELYING_PARTY`、Sentry 变量沿用 Release CI 的命名。

## 相关文档

- 项目架构和 agent 执行约束：[AGENTS.md](AGENTS.md)
- 项目宪章：[.specify/memory/constitution.md](.specify/memory/constitution.md)
- 功能规格与实现计划：[specs/003-generate-api-client/](specs/003-generate-api-client/)
- Privy 认证规格与真机验证步骤：[specs/005-privy-auth-integration/](specs/005-privy-auth-integration/)
- [Flutter 文档](https://docs.flutter.dev/)
