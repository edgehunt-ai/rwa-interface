# rwa_interface

Cross-platform RWA trading interface.

## Generated API ownership

`openapi/main.yaml` is the only wire-contract source. Files under
`packages/rwa_api_client` are generated and must not be edited manually.
Authentication, failure mapping, SSE, repositories, and Riverpod state are
application-owned; presentation code must not import generated wire models or
Dio response types.

本功能的规格、计划、任务与集成说明统一使用中文。`openapi/main.yaml` 是唯一 wire contract；
`packages/rwa_api_client/`（包括提交的 `*.g.dart`）由 OpenAPI Generator 7.24.0 和
`dart-dio` 生成，禁止手改。生成器版本记录在 `openapitools.json` 和生成包的
`.openapi-generator/VERSION`，可据此追溯 source identity。

应用只通过 `lib/data/services/`、repository 和 domain model 消费 generated client。
Dio 负责 HTTP、超时、认证 header 与取消；Riverpod 只负责依赖装配、生命周期和异步状态，
不会替代 Dio，也不会形成一个永久的全局 AppState。query 默认 auto-dispose，刷新保留已有数据；
命令防重复提交并保留调用方的 Idempotency-Key。登出或换用户通过 session generation 清理用户态，
public provider 不受影响。

普通请求使用显式 connect/send/receive timeout。SSE 使用独立的无 receive-timeout 长连接，支持 chunk frame、多行 data、heartbeat、
去重、Last-Event-ID、有界退避、取消和 `resync_required`。所有 Dio/generated 异常在 data 边界映射
为安全的 `ApiFailure`，常规诊断只记录分类、状态、code 与 request ID，不记录 token、raw body、
stack trace 或金融 payload。

完整本地验证命令是 `npm run quality:check`；Release 使用同一个 `npm run release:verify` 入口。
修改 `openapi/main.yaml` 后，可使用 `npm run client:regenerate` 依次完成正式客户端生成、
`build_runner` 辅助代码生成和完整质量验证。该命令保留并串联现有的 `client:generate`、
`client:prepare`、`client:check` 和 `quality:check`，不会替换它们。
发布时 Android/iOS 均把 artifact 大小写入 summary；大小只用于比较，不设阈值或门禁。

## Observability

Sentry error reporting and sampled performance monitoring are enabled by default. Runtime values can
be supplied without source changes:

```sh
flutter run \
  --dart-define=SENTRY_DSN=https://public-key@example.ingest.sentry.io/project \
  --dart-define=SENTRY_ENVIRONMENT=staging \
  --dart-define=SENTRY_TRACES_SAMPLE_RATE=0.10 \
  --dart-define=SENTRY_PROFILES_SAMPLE_RATE=0.10 \
  --dart-define=SENTRY_RELEASE=app@1.0.0+1
```

Set `SENTRY_DSN` to an empty value to disable telemetry. Never commit a Sentry auth token; release,
source-map, and debug-symbol upload credentials belong in CI secret storage.

GitHub Actions runs quality checks for pushes and pull requests. Changing the version name in
`pubspec.yaml` on `main` triggers Android and iOS release builds, creates the matching `v<version>`
tag, and publishes a GitHub Release whose notes list commits since the previous stable version tag.
A manual release workflow run builds artifacts without publishing a tag or Release. Configure
runtime values under Actions **Variables**:

Android releases include a universal APK plus smaller `arm64-v8a`, `armeabi-v7a`, and `x86_64`
packages. Modern physical devices should normally use the `arm64-v8a` package.

```text
SENTRY_DSN
SENTRY_ENVIRONMENT
SENTRY_TRACES_SAMPLE_RATE
SENTRY_PROFILES_SAMPLE_RATE
SENTRY_ORG=dodo-k4
SENTRY_PROJECT=flutter
```

Configure `SENTRY_AUTH_TOKEN` under Actions **Secrets** to upload Dart debug symbols, Android R8
mappings, and iOS dSYM files. When the secret is absent, packaging still succeeds and only symbol
upload is skipped. Never write this token to source, variables, logs, or workflow files.

The iOS artifact is unsigned. Producing an installable or App Store IPA additionally requires Apple
distribution certificate and provisioning-profile secrets. Android release builds enable R8 code
and resource shrinking; Sentry's Android Gradle plugin uploads the generated mapping when the token
is available.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## OpenAPI contract

`openapi/main.yaml` is the single public product contract shared by the backend and clients. It
uses OpenAPI 3.0.3 and exposes explicit `/v1` paths. Runtime availability still requires a mounted
backend route; a declared path is not evidence that an asset operation is enabled.

Install and run the contract gate with Node.js 22:

```sh
npm ci --ignore-scripts
npm run contract:check
```

The gate runs custom semantic rules, Redocly CLI 2.50.0 lint, and OpenAPI Generator 7.24.0
validation through wrapper 2.40.1. Generator validation is configured with `useDocker: true` so it
does not depend on the host Java version; Docker must be available locally and in CI.


### Generated Dart API client

The formal Flutter app consumes the same `openapi/main.yaml` contract through a generated `dart-dio` package:

```sh
npm run client:generate
npm run client:check
```

Before analyzing or building Flutter, generate the `built_value` parts:

```sh
(cd packages/rwa_api_client && dart pub get && dart run build_runner build)
```

Generated files live under `packages/rwa_api_client` and must not be edited by hand. The app wraps the package in `lib/data/api`; repositories must map generated wire DTOs to domain models before exposing them to UI code. The Privy adapter supplies the current access token to the Dio interceptor. A 401 triggers at most one Privy refresh and replay, then returns the app to its login state if refresh fails. Privy remains the only owner of refresh tokens. The generator uses OpenAPI Generator 7.24.0 with `dart-dio`, `enumUnknownDefaultCase=true`, and `legacyDiscriminatorBehavior=false`.

The custom rules reject duplicate or missing `operationId` values, unresolved references,
incomplete path parameters, orphan schemas, financial commands without a required
`Idempotency-Key`, `409`, and `422`, missing protected/public error response sets,
server-owned request fields, non-Decimal financial wire values, and responses that omit
`X-Request-ID`.

`.github/CODEOWNERS` documents that contract changes are checked by the approval workflow.
The `Contract approvals` workflow requires at least one authorized repository
collaborator with write-level permission to approve the exact PR head commit whenever contract
governance files change. Configure the repository ruleset to require the
`Require an authorized contract approval` status check before merging to `main`.
