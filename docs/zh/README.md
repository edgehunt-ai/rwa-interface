<p align="center">
  <img src="../../assets/branding/app-pink.svg" width="96" alt="Nobell 应用图标">
</p>

<h1 align="center">Nobell</h1>

<p align="center">
  基于 Flutter 构建的跨平台数字资产交易应用。
</p>

<p align="center">
  <a href="../../README.md">English</a> |
  <a href="README.md">简体中文</a>
</p>

<p align="center">
  <a href="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/ci.yml"><img src="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/ci.yml/badge.svg" alt="CI"></a>
  <a href="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/performance.yml"><img src="https://github.com/edgehunt-ai/rwa-interface/actions/workflows/performance.yml/badge.svg" alt="原生性能测试"></a>
  <img src="https://img.shields.io/badge/Flutter-3.47.6-02569B?logo=flutter" alt="Flutter 3.47.6">
  <a href="../../LICENSE"><img src="https://img.shields.io/badge/license-GPL--3.0-blue" alt="GPL-3.0 许可证"></a>
</p>

## 项目简介

Nobell 在同一套 Flutter 代码中提供行情发现、资产管理、资金操作和下单流程。
应用侧请求以 Riverpod 为边界，API 层由带版本的 OpenAPI 契约生成。

主要能力包括：

- 行情列表、搜索、自选、价格图表和产品详情。
- 代币化股票和永续合约交易，以及下单前的资金补充流程。
- 资产、充值、提现、划转和活动记录。
- 邮箱、Google OAuth、Passkey 和外部 EVM 钱包认证。
- 覆盖页面加载及买卖流程的原生性能 CI。
- Sentry 可观测性与 Firebase Cloud Messaging 集成。

## 平台支持

| 平台 | 状态 | 说明 |
|---|---|---|
| Android | 支持 | Android API 28 及以上 |
| iOS | 支持 | iOS 17 及以上 |
| Web | 支持 | 使用基于 React 的 Privy 浏览器 bridge |
| macOS、Windows、Linux | 不支持 | 返回明确的 `unsupportedPlatform` 状态 |

## 快速开始

### 环境要求

- Flutter 3.47.6 / Dart 3.13.5
- Node.js 24
- 与目标平台对应的 Android/iOS 工具链，或浏览器
- Docker，仅在更新或重新生成 API 客户端时需要

### 安装

```bash
git submodule update --init --recursive
npm ci --ignore-scripts
flutter pub get
cp .env.example .env
```

在 `.env` 中填写公开客户端配置。本地开发至少需要 API 地址、Privy App/Client ID
和 Reown Project ID。密钥、访问令牌或服务端凭据不得写入 `.env`、源码或 Dart
构建参数。

### 运行

```bash
make run
```

指定其他环境文件或 Flutter 目标：

```bash
make run ENV_FILE=.env.staging FLUTTER_ARGS='-d android'
```

运行 Web 前先生成 Privy 浏览器 bundle：

```bash
npm run privy:web:build
flutter run -d chrome --dart-define-from-file=.env
```

## 常用命令

| 命令 | 用途 |
|---|---|
| `make run` | 检查配置、同步 Privy URL scheme 并运行 Flutter |
| `npm run quality:check` | 检查格式、运行静态分析和 Flutter 测试 |
| `flutter test` | 运行 Flutter 单元测试和 Widget 测试 |
| `npm run perf:test` | 验证性能场景和报告生成逻辑 |
| `npm run perf:run -- --device DEVICE_ID` | 采集原生 profile 模式性能数据 |
| `npm run perf:report` | 生成交互式性能报告和 CI Summary |
| `npm run api:update` | 更新 API 契约 submodule 并重新生成 Dart 客户端 |

## 架构

应用请求遵循以下依赖方向：

```text
Widget / 页面
    -> Riverpod provider 或 notifier
    -> repository 或 use case
    -> data service
    -> generated dart-dio client
    -> Dio
```

- Widget 和普通业务类不直接创建 `Dio` 或调用生成的 API 操作。
- Repository 负责将传输 DTO 映射为 domain model。
- Presentation 和 state 层只暴露 domain value 和稳定失败类型。
- 金融数值保持无损，并使用字符串表示。
- 只有启动初始化、非 Flutter isolate、传输基础设施和 focused test 可以在记录理由并
  提供测试后调用底层 API。

## 仓库结构

```text
lib/                         Flutter 应用及 domain/data/UI 分层
packages/rwa_api_client/     生成的 dart-dio API 客户端
contracts/rwa-api-contract/  只读 API 契约 submodule
integration_test/            原生端到端及性能测试入口
test/                        单元、Widget 和性能流程测试
scripts/                     API、配置及报告工具
private-key-export/          独立私钥导出页
web/privy-auth/              Privy Web bridge
assets/                      应用和设计资源
```

## API 客户端

[`edgehunt-ai/rwa-api-contract`](https://github.com/edgehunt-ai/rwa-api-contract)
是 API 契约的唯一来源。本仓库通过 `contracts/rwa-api-contract` submodule 固定消费契约；
不要手动修改 submodule 内容或 `packages/rwa_api_client` 下的生成文件。

```bash
# 初始化契约 submodule
npm run api:init

# 更新默认契约分支并重新生成客户端
npm run api:update

# 更新指定契约分支并重新生成客户端
npm run api:update:branch -- feat/example
```

生成流程还会执行格式化、静态分析和测试。生成时使用的 OpenAPI 版本记录在
`packages/rwa_api_client/.openapi-generator/VERSION`。

## 质量与 CI

GitHub Actions 会在 push 和 pull request 上运行 Flutter 质量门禁。移动端发布从通过
检查的 `main` revision 构建，Flutter Web 应用和私钥导出页使用各自独立的 workflow。

原生性能 CI 使用 Android profile 模式测量页面加载、滚动、产品详情、报价、订单预览、
提交和撤单。测试使用固定 repository 数据，不会发送真实订单。Artifact 包含交互式
HTML、完整 PNG 长截图、机器参数、原生帧耗时、可选基线对比和自动总结，并会更新到
同一条 PR 评论中。详见
[原生性能测试](../performance.md)。

## 相关文档

- [原生性能测试](../performance.md)
- [推送通知配置](../push-notifications.md)（英文）
- [Flutter 文档](https://docs.flutter.dev/)

## 安全

身份凭据由 Privy 独占持久化。应用不得保存或记录访问令牌、邮箱验证码、私钥或原始
SDK 错误。CI 变量、签名材料和服务端凭据应放在仓库或部署环境的 Secrets 中，不得
提交到配置文件。

## 许可证

Nobell 使用 [GNU General Public License v3.0](../../LICENSE) 授权。
