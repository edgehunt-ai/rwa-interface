# RWA Interface

跨平台 RWA 交易界面，基于 Flutter 构建，支持 Android、iOS 和 Web。

## 技术栈

- Flutter 3.47 / Dart 3.13
- Riverpod、GoRouter、Dio
- OpenAPI Generator `dart-dio` 客户端
- Privy 身份认证与 Reown AppKit 钱包连接

## 快速开始

### 环境要求

- Node.js 22
- Flutter 3.47 / Dart 3.13
- Docker daemon（仅在更新或生成 API 客户端时需要）

### 安装依赖

```bash
npm ci --ignore-scripts
flutter pub get
```

### 配置环境变量

复制配置模板并填写本地开发所需的公开客户端配置：

```bash
cp .env.example .env
```

至少需要配置 API 地址、Privy App/Client ID 和 Reown Project ID。密钥、token 或其他服务端凭据不得写入 `.env`、源码或构建参数。

### 启动应用

```bash
make run
```

也可以指定环境文件和 Flutter 参数：

```bash
make run ENV_FILE=.env.staging FLUTTER_ARGS='-d android'
```

Web 端需要先生成 Privy 浏览器 bundle：

```bash
npm run privy:web:build
flutter run -d chrome --dart-define-from-file=.env
```

## 项目结构

```text
lib/                         Flutter 应用、domain、data 和 presentation 层
packages/rwa_api_client/     由 OpenAPI 生成的 Dart 客户端
contracts/rwa-api-contract/  API 契约 submodule，只读输入
private-key-export/          私钥导出页
web/privy-auth/              Web 端 Privy bridge
assets/                      设计稿和应用资源
test/                        单元测试和 Widget 测试
scripts/                     API 客户端和构建辅助脚本
```

## 架构约束

应用请求遵循以下依赖方向：

```text
Widget/页面 → Riverpod provider/notifier → repository/use case
           → data service → generated dart-dio client → Dio
```

- 页面和普通业务类不得直接创建 Dio 或调用 generated API。
- Repository 负责将 wire DTO 映射为 domain model。
- Presentation/state 层只暴露 domain value 和稳定的 `ApiFailure`。
- API 和金融数值处理保持无损；金融数值使用 `String` 表示。
- 只有启动初始化、非 Flutter isolate、传输基础设施和 focused test 可以在明确记录理由后调用底层 API。

## API 客户端

`git@github.com:edgehunt-ai/rwa-api-contract.git` 是后端和客户端共享的 API 契约。本仓库通过
`contracts/rwa-api-contract` submodule 固定消费契约版本，不要直接修改该目录或手动编辑生成文件。

初始化或更新客户端：

```bash
# 初始化契约 submodule
npm run api:init

# 更新默认契约分支并生成客户端
npm run api:update

# 更新指定契约分支并生成客户端
npm run api:update:branch -- feat/mainnet-cross-chain-acceptance
```

生成流程会运行格式化、静态分析和测试。OpenAPI Generator 配置位于 `openapitools.json`，生成版本记录在
`packages/rwa_api_client/.openapi-generator/VERSION`。

## 认证与平台支持

- Android 支持 API 28+；iOS 支持 iOS 17+。
- Android/iOS 使用 `privy_flutter`，Web 使用 React Privy bridge。
- 当前支持 email、Google OAuth、passkey 和外部 EVM 钱包登录。
- macOS、Windows 和 Linux 会返回明确的 `unsupportedPlatform` 状态，不初始化 native channel。
- Privy SDK 独占身份凭据持久化；应用不保存或记录 access token、邮件验证码和原始 SDK 错误。

完整的设备联调说明和构建参数请参考 `specs/005-privy-auth-integration/`。

## 测试与质量检查

运行完整质量检查：

```bash
npm run quality:check
```

该命令包含 Dart 格式检查、静态分析和 Flutter 测试。单独运行测试：

```bash
flutter test
```

## CI 与发布

GitHub Actions 会在 push 和 pull request 上运行质量检查。`main` 分支的版本变更可触发移动端构建和 GitHub Release；Web 和私钥导出页的部署由对应 workflow 负责。

发布构建所需的 GitHub Actions Variables、Secrets 和签名配置不放在 README 中，具体以 workflow 文件和仓库设置为准。

## 相关文档

- [API 客户端和应用调用边界](#api-客户端)
- [推送通知配置](docs/push-notifications.md)
- [Flutter 文档](https://docs.flutter.dev/)

## 许可证

本项目采用 [GNU General Public License v3.0](LICENSE) 授权。
