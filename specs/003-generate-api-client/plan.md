# 实施计划：优化 API 客户端与状态管理

**分支**：`003-generate-api-client` | **日期**：2026-09-03 | **规格**：[spec.md](spec.md)

## 摘要

沿用 OpenAPI Generator 7.24.0 `dart-dio`，先精简并加固生成流程，再在应用数据边界实现环境
配置、超时、安全重试、统一失败和真正的 SSE；repository 隔离 wire/domain，Riverpod 负责依赖
装配、查询/命令状态和最小范围实时失效。统一本地、CI、Release 验证，保留明确排除项。

## 技术上下文

**语言/版本**：Dart 3.13.0、Flutter 3.47.0、Node.js 22

**主要依赖**：OpenAPI Generator 7.24.0 `dart-dio`；Dio、built_value、built_collection、one_of、
flutter_riverpod 使用 `pubspec.yaml` 中的受约束版本范围，并由 `pubspec.lock` 固定解析结果。
Node 生成工具使用 `package-lock.json` 固定版本；generated package 的 build_runner、
built_value_generator 和 test 均使用有上限的版本范围，禁止 `any`。

**存储**：无新增持久化；Provider 仅持有内存状态，离线缓存不在范围

**测试**：package:test、flutter_test、Dio adapter/fixture、Node test；边界测试零外网

**目标平台**：Flutter Android、iOS、Web、macOS、Windows、Linux；发布 Android/iOS。
最低版本和浏览器支持在首个生产客户端发布前由发布配置确认：Android API 级别、iOS
最低版本、macOS/Windows/Linux 桌面版本，以及 Chrome/Edge/Safari 的当前两个稳定大版本。

**项目类型**：Flutter 应用 + 仓库内生成 Dart package + Node 契约工具

**性能目标**：1,000 条任意分片 SSE 按序恰好一次；20 个并发 401 单次刷新；取消后零交付；
高频事件仅通知相关 Provider

**约束**：金融值保持 String；生成文件不手改；生产 Base URL 必填；普通 HTTP/SSE timeout
分离；不设体积门禁；契约变更需一名具备仓库写入级别权限的协作者批准当前 head SHA；不改
`diff -qr`、action `@v*`

**多语言边界**：本功能不引入 Flutter l10n 或 ARB 资源；data/domain 只输出稳定的 failure
`code`、`userAction` 和结构化字段。用户文案由后续 l10n 功能按 locale 映射，后端 `message`
只作为受控兜底，不在 Provider 或诊断中硬编码翻译。

**范围**：49 个 path、约 60 个 operation、11 个 tag API、约 140 个 wire model；实现共享边界和
代表性 repository/state slice，不实现全部业务页面

## 宪章检查

*GATE：Phase 0 前检查，Phase 1 后复核。*

- **规格与追踪：通过。** 设计映射 FR-001–FR-063、SC-001–SC-032；契约命名改动须兼容审查。
- **分层：通过。** Widget → Riverpod → repository/use case → service → generated client；
  generated/Dio 类型不越过数据层。
- **正确性：通过。** 覆盖请求、401 竞态、金额 round-trip、SSE、Provider race/disposal、fixture。
- **安全：通过。** token 运行时注入和脱敏；命令只安全重放；认证失败关闭。
- **状态与 UX：通过。** 区分 loading/empty/data/refreshing/failure 和 command 状态。
- **模块与渲染：通过。** 默认 auto-dispose，family/select 最小监听，SSE 不保存无限历史。
- **依赖：通过。** 仅新增 Riverpod，兼任 DI、async state、stream composition，无重复能力。
- **规模：通过。** generated 文件豁免；手写 parser、mapper、state owner 按职责拆分。

Phase 1 复核：数据模型和三份内部契约保持上述边界，无宪章例外。

## 设计细化（分析后）

- **依赖与缓存**：Node cache key 同时包含 `package-lock.json` 和 Node 版本；Flutter cache key
  包含 `pubspec.lock`、Flutter/Dart 版本和生成器版本。缓存只加速下载，不跳过 `quality:check`。
- **Release 同 SHA**：自动发布必须读取当前 `GITHUB_SHA` 对应的 CI workflow run，检查 workflow
  conclusion 为 success 且 head SHA 完全相等；找不到匹配 run 或 required check 失败时不得进入
  Android/iOS packaging。手动发布先执行同一 `release:verify`。
- **实时与快照**：snapshot refresh 以权威快照建立新基线；refresh 期间按 event ID 缓存有限
  的后续事件，快照成功后只重放基线之后的事件，重复 ID 丢弃，超出上限转 `resync_required`。
- **状态参数**：family key 包含所有影响结果的 query 参数和 `SessionGeneration`；public query
  不依赖 session generation，用户 query/command/SSE 依赖它并在 logout 时失效。
- **追踪**：`tasks.md` 的每个任务须可映射到一个 US 和至少一个 FR/SC；实现评审使用
  `Task → FR/SC → Test` 表，不以“全部勾选”替代验收证据。

## 项目结构

```text
specs/003-generate-api-client/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/{api-boundary,riverpod-state,sse-stream}.md
└── tasks.md

lib/
├── app/providers/             # 环境、session、组合根
├── data/api/                  # Dio、鉴权、failure、SSE
├── data/services/             # 窄 generated API 边界
├── data/repositories/         # wire → domain
├── domain/{models,repositories,use_cases}/
└── ui/features/*/providers/   # AsyncNotifier/Notifier/StreamProvider

packages/rwa_api_client/       # 完全生成且可编译
scripts/fixtures/openapi-generator/
test/{data,app,ui}/
```

**结构决策**：沿用分层 + feature UI。generated package 留在 `packages/`；transport 在 data，
domain 向内，Riverpod 仅位于组合根和 presentation state 边界。

## 实施阶段

### A. 生成链路

禁用 placeholder tests/docs；generation 后执行 build_runner 并提交 `*.g.dart`；固定依赖并修正
metadata；删除目标只允许 canonical package/contract cache 且拒绝 symlink；将 inline page/
composition 具名并把 Error 改 ApiError（wire 不变）；增加 generator regression fixture。

### B. 网络边界

生产显式 ApiEnvironment；应用拥有 Dio 和 timeout；加固 single-flight 401 retry（GET 或带幂等键
且 body 可重放的命令，最多一次）；ApiFailureMapper 解析 ApiError/X-Request-ID；建立窄 service、
repository 和 mapper。

### C. SSE

独立 Dio byte stream，不调用 generated 单响应方法；增量解析 CRLF/LF、chunk、多 frame、id、
event、multiline data、comment；generated serializer 解码 RealtimeEvent；实现 cancel、bounded
backoff、Last-Event-ID、resync-required，且无普通 receive timeout。

### D. Riverpod

ProviderScope 装配 environment/token/Dio/service/repository；query 用 AsyncNotifier family +
auto-dispose 并防 stale commit；command 用独立 Notifier、去重并保留 idempotency key；stream
Provider 按实体最小更新；logout invalidate 用户域，测试全部 override。

### E. CI/Release

共享 prepare/contract/client/app quality 命令；PR concurrency 与安全 cache；Release 等同一 SHA
完整 CI，手动路径自验；Android/iOS 共用构建路径并产出非门禁 size report；审批要求至少一名
具备仓库写入级别权限的协作者批准当前 SHA；`diff -qr`、action `@v*` 无其他功能变化。

## 复杂度跟踪

无宪章违规。

## 最终落地复核

实现与 FR-001–FR-063、FR-066、SC-001–SC-032、SC-034 保持一致。唯一实现细节是生成脚本在提交 `*.g.dart`
后删除包含本机绝对路径的 `.dart_tool` cache；它不属于 runtime artifact，且 `client:prepare`
会在 build/analyze/test 前自动重建。未引入 template customization、size gate、跨平台 diff
替代或 Action SHA 固定，审批工作流仅将契约批准门槛改为一名具备写入级别权限的协作者。
