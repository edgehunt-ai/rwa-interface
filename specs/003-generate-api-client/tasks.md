# 任务：优化 API 客户端与状态管理

**输入**：`specs/003-generate-api-client/` 下的 spec、plan、research、data-model、contracts 和 quickstart

**测试要求**：规格明确要求自动化验证；各用户故事先编写失败测试，再完成实现。

**格式**：`[ID] [P?] [Story] 描述（含精确文件路径）`

## Phase 1：项目准备

**目标**：加入 Riverpod 并建立应用自有 API、domain、state 测试骨架。

- [X] T001 在 `pubspec.yaml` 添加与 Flutter 3.47/Dart 3.13 兼容并由 lockfile 固定的 `flutter_riverpod` 依赖
- [X] T002 更新 `lib/app.dart`，在应用根部安装唯一 `ProviderScope` 且保持现有路由与观测初始化不变
- [X] T003 [P] 创建 API 测试 fixture 与禁止真实网络的公共 helper 于 `test/helpers/api_test_harness.dart`
- [X] T004 [P] 创建 Riverpod `ProviderContainer` 测试 helper 于 `test/helpers/provider_test_harness.dart`
- [X] T005 更新 `README.md`，先记录 generated/application-owned 文件边界和本功能统一中文文档约定

---

## Phase 2：阻塞性基础设施

**目标**：使生成包安全、精简、可直接编译，并建立所有故事共享的配置和领域边界。

**⚠️ 阻塞**：本阶段完成前不开始用户故事实现。

- [X] T006 为 inline page/composition schema 与 `ApiError` 重命名编写兼容性规则测试于 `scripts/openapi-contract-rules.test.mjs`
- [X] T007 更新 `openapi/main.yaml`，将重要 inline page/composition schema 具名并把组件 `Error` 改为 `ApiError`，保持 wire format 不变
- [X] T008 更新 `openapitools.json`，禁用 api/model placeholder tests 和逐 API/model docs，并修正 package description、repository、SDK metadata
- [X] T009 为生成目标 allowlist、仓库根目录、外部目录和 symlink escape 编写 Node 测试于 `scripts/generate-dart-client.test.mjs`
- [X] T010 加固 `scripts/generate-dart-client.mjs`，删除前仅允许 canonical package 或 `.contract-cache` 子目录且拒绝 symlink escape
- [X] T011 固定 generated package 的 build_runner、built_value generator 与 test 版本来源于 `openapitools.json` 和生成配置
- [X] T012 更新 `scripts/generate-dart-client.mjs`，生成后自动完成 pub resolve 和 build_runner secondary generation
- [X] T013 重新生成 `packages/rwa_api_client/`，提交 compile-ready `*.g.dart` 并确认无 placeholder tests/docs
- [X] T014 更新 `scripts/check-dart-client.mjs`，让现有 `diff -qr` 比较完整 runtime 与 secondary generated artifacts
- [X] T015 [P] 创建生成器 construct fixture 于 `scripts/fixtures/openapi-generator/main.yaml`，覆盖 oneOf/discriminator、allOf、nullable/absent、多成功码、204、decimal string、unknown enum 和 SSE
- [X] T016 创建 fixture 验证脚本与测试于 `scripts/check-openapi-generator-fixture.mjs` 和 `scripts/openapi-generator-fixture.test.mjs`
- [X] T017 [P] 创建领域分页与 session generation 基础类型于 `lib/domain/models/domain_page.dart` 和 `lib/domain/models/session_generation.dart`
- [X] T018 [P] 创建 API environment 模型和验证测试于 `test/data/api/api_environment_test.dart`
- [X] T019 实现 production URL 必填、禁止隐式 staging fallback 和普通请求 timeout 的 `lib/data/api/api_environment.dart`

**检查点**：生成包在 clean checkout 可编译；共享模型、fixture 和安全生成边界就绪。

---

## Phase 3：用户故事 1—安全消费生成请求（P1）🎯 MVP

**目标**：通过窄 service/repository 安全调用 public、authenticated、分页、金融命令与空响应。

**独立测试**：使用 fixture 覆盖 public、token、20 并发 401、安全重放、Idempotency-Key、分页和 204；无需 UI/Provider。

### 测试

- [X] T020 [P] [US1] 编写 public/authenticated header 与 204 空成功测试于 `test/data/services/generated_api_service_test.dart`
- [X] T021 [P] [US1] 扩展 single-flight、20 并发 401、最多一次重试和失败关闭测试于 `test/data/api/privy_auth_interceptor_test.dart`
- [X] T022 [P] [US1] 编写 GET、无幂等键 mutation、有幂等键可重放 mutation 的重试矩阵测试于 `test/data/api/request_replay_policy_test.dart`
- [X] T023 [P] [US1] 编写分页映射与金融 String round-trip 测试于 `test/data/repositories/markets_repository_test.dart`

### 实现

- [X] T024 [P] [US1] 实现请求方法、幂等键和 body 可重放判断于 `lib/data/api/request_replay_policy.dart`
- [X] T025 [US1] 加固 `lib/data/api/privy_auth_interceptor.dart`，实现 single-flight、每请求最多一次和 replay policy
- [X] T026 [US1] 更新 `lib/data/api/rwa_api_data_source.dart`，从 `ApiEnvironment` 创建应用自有 Dio 并显式配置普通 timeout
- [X] T027 [P] [US1] 定义窄 `MarketsService`、`OrdersService`、`SessionService` 接口于 `lib/data/services/markets_service.dart`、`lib/data/services/orders_service.dart`、`lib/data/services/session_service.dart`
- [X] T028 [US1] 实现上述 generated service adapters 于 `lib/data/services/generated_markets_service.dart`、`lib/data/services/generated_orders_service.dart`、`lib/data/services/generated_session_service.dart`
- [X] T029 [P] [US1] 定义代表性 domain `Stock` 与 repository contract 于 `lib/domain/models/stock.dart` 和 `lib/domain/repositories/markets_repository.dart`
- [X] T030 [US1] 实现 generated stock/page 到 domain 的 mapper 和 repository 于 `lib/data/repositories/markets_repository_impl.dart`
- [X] T031 [US1] 运行并修复 `test/data/services/`、`test/data/api/` 和 `test/data/repositories/` 的 US1 测试，确认 presentation/state 源码未导入 generated、Response 或 DioException 类型

**检查点**：US1 可独立交付；调用者只面对 service/repository/domain，不接触 generated 复杂度。

---

## Phase 4：用户故事 2—统一失败处理（P2）

**目标**：所有声明错误、网络、超时、取消、解码、认证和兼容问题转换为安全 `ApiFailure`。

**独立测试**：注入各失败类型，验证 status/code/retry/userAction/requestId 与脱敏结果。

### 测试

- [X] T032 [P] [US2] 编写 `ApiFailure` 值语义与安全字段测试于 `test/domain/models/api_failure_test.dart`
- [X] T033 [P] [US2] 编写 ApiError、空/畸形 error body、header/body request ID 和 Dio 分类测试于 `test/data/api/api_failure_mapper_test.dart`
- [X] T034 [P] [US2] 编写 token、stack trace、raw body 与金融 payload 不进入 diagnostics 的测试于 `test/data/api/api_diagnostics_test.dart`

### 实现

- [X] T035 [P] [US2] 实现 sealed failure family 于 `lib/domain/models/api_failure.dart`
- [X] T036 [US2] 实现 generated `ApiError` 与 Dio 分类映射于 `lib/data/api/api_failure_mapper.dart`
- [X] T037 [P] [US2] 实现安全诊断摘要与 request ID 提取于 `lib/data/api/api_diagnostics.dart`
- [X] T038 [US2] 集成 failure mapper 到 `lib/data/services/generated_markets_service.dart`、`lib/data/services/generated_orders_service.dart` 和 `lib/data/services/generated_session_service.dart`
- [X] T039 [US2] 运行并修复 `test/domain/models/api_failure_test.dart` 与 `test/data/api/` 的 US2 测试，确认上层无 raw exception、secret 或 stack trace

**检查点**：US2 可独立验证，业务层可稳定区分恢复动作。

---

## Phase 5：用户故事 3—可靠实时事件（P3）

**目标**：实现真实 SSE frame、typed event、取消、重连、Last-Event-ID 与 resync-required。

**独立测试**：1,000 条任意分片流按序恰好一次；heartbeat、多行、畸形、重连、resync、取消全部可验证。

### 测试

- [X] T040 [P] [US3] 编写 LF/CRLF、任意 chunk、多 frame、字段、多行 data、comment 和 EOF parser 测试于 `test/data/api/sse_parser_test.dart`
- [X] T041 [P] [US3] 编写 generated serializer、unknown variant、malformed JSON 和 resync 测试于 `test/data/api/realtime_event_decoder_test.dart`
- [X] T042 [P] [US3] 编写 1,000 事件顺序/去重、Last-Event-ID、bounded backoff 和 cancel 生命周期测试于 `test/data/services/realtime_service_test.dart`

### 实现

- [X] T043 [P] [US3] 实现 `RealtimeFrame` 和增量 parser 于 `lib/data/api/sse_frame.dart` 和 `lib/data/api/sse_parser.dart`
- [X] T044 [P] [US3] 实现 realtime envelope、subscription state 和 backoff policy 于 `lib/domain/models/realtime_envelope.dart`、`lib/domain/models/realtime_subscription_state.dart` 和 `lib/data/api/reconnect_policy.dart`
- [X] T045 [US3] 实现 generated serializer event decoder 于 `lib/data/api/realtime_event_decoder.dart`
- [X] T046 [US3] 定义并实现独立长连接 `RealtimeService` 于 `lib/data/services/realtime_service.dart` 和 `lib/data/services/dio_realtime_service.dart`
- [X] T047 [US3] 在 `lib/data/services/dio_realtime_service.dart` 集成 bearer、无普通 receive timeout、cancel、backoff、Last-Event-ID 和 resync signal
- [X] T048 [US3] 运行并修复 US3 测试，确认不调用 generated 单响应 `streamEvents()` 且不积累历史事件

**检查点**：US3 可独立订阅、恢复和取消，不依赖页面或 Riverpod。

---

## Phase 6：用户故事 4—管理请求型状态（P4）

**目标**：Riverpod 统一 DI、query、command、session 和实时最小更新，不制造永久全局业务状态。

**独立测试**：Provider override 覆盖 load/data/empty/refresh/error/race/dispose/duplicate/logout/realtime，零外网。

### 测试

- [X] T049 [P] [US4] 编写 environment、Dio、service、repository override 和惰性创建测试于 `test/app/providers/api_providers_test.dart`
- [X] T050 [P] [US4] 编写 query 初载、空、保留数据刷新、失败重试、family 参数、dispose、100 次竞态，以及 snapshot 与 SSE 基线协调测试于 `test/ui/features/api_example/providers/stocks_provider_test.dart`
- [X] T051 [P] [US4] 编写 command 20 次重复提交、显式重试复用 key 和最小 invalidate 测试于 `test/ui/features/api_example/providers/order_command_provider_test.dart`
- [X] T052 [P] [US4] 编写 logout/换用户清理用户状态并保留 public 状态测试于 `test/app/providers/session_scope_test.dart`
- [X] T053 [P] [US4] 编写 SSE 按实体最小更新且无关 observer 零通知测试于 `test/app/providers/realtime_providers_test.dart`

### 实现

- [X] T054 [P] [US4] 实现 environment、token、Dio、service、repository 顶层 providers 于 `lib/app/providers/api_providers.dart`
- [X] T055 [P] [US4] 实现 session generation 和用户态统一 invalidate 于 `lib/app/providers/session_scope.dart`
- [X] T056 [US4] 实现代表性 `StocksNotifier` family/auto-dispose/refresh/race guard，并按 SessionGeneration 隔离用户 query 于 `lib/ui/features/api_example/providers/stocks_provider.dart`
- [X] T057 [US4] 实现代表性下单 command state、去重和 idempotency intent 于 `lib/ui/features/api_example/providers/order_command_provider.dart`
- [X] T058 [US4] 实现 typed realtime stream provider 与按实体最小 invalidation 于 `lib/app/providers/realtime_providers.dart`
- [X] T059 [US4] 运行并修复 `test/app/providers/` 与 `test/ui/features/api_example/providers/` 的 US4 测试，确认 Provider 不直接构造请求、解析 wire 或暴露 generated/Dio 类型

**检查点**：US4 可由 ProviderContainer 独立演示，默认 auto-dispose，无全局 AppState。

---

## Phase 7：用户故事 5—契约变化下可验证优化（P5）

**目标**：统一生成与质量命令，CI/Release 对同一 SHA 执行完整验证和安全发布。

**独立测试**：clean checkout 执行一个质量命令；stale output、fixture 破坏、生成/契约配置错误、CI 失败均阻断，size 仅报告。

### 测试

- [X] T060 [P] [US5] 扩展生成脚本测试，验证无 TODO tests/docs、metadata、source identity 和二次生成零 diff 于 `scripts/generate-dart-client.test.mjs`
- [X] T061 [P] [US5] 编写统一命令组成与失败传播测试于 `scripts/quality-check.test.mjs`
- [X] T062 [P] [US5] 为 CI concurrency、Release 同 SHA 依赖、手动自验和非门禁 size report 编写静态 workflow 测试于 `scripts/workflow-policy.test.mjs`

### 实现

- [X] T063 [US5] 在 `package.json` 定义 client:prepare、client:test、quality:check 和 release:verify 共享命令
- [X] T064 [US5] 更新 `.github/workflows/ci.yml` 使用共享命令、PR concurrency 与 lockfile/version keyed cache，并保持 `diff -qr` 和 action `@v*`
- [X] T065 [US5] 更新 `.github/workflows/release.yml`，使自动发布验证当前 `GITHUB_SHA` 对应的完整 CI run/head SHA、手动发布执行等价验证且 release 不自动取消
- [X] T066 [US5] 在 `.github/workflows/release.yml` 保持 Android/iOS 构建路径一致并记录非门禁 artifact size
- [X] T067 [US5] 在 `.github/workflows/release.yml` 输出 artifact size summary 但不设置阈值或失败条件
- [X] T068 [US5] 更新 `README.md`，记录环境、生成、验证、failure/state/SSE、snapshot 协调、多语言边界、source identity 和 Release 行为
- [X] T069 [US5] 验证 `.github/workflows/contract-approvals.yml` 保留当前 SHA 校验且具备写入级别权限的一人批准即可，并运行 US5 Node/workflow 测试

**检查点**：US5 完整证明 contract → generated → app → release 链路且不改变排除项。

---

## Phase 8：收尾与交叉验证

**目标**：完成宪章门禁、文档一致性和端到端快速验证。

- [X] T070 [P] 将 `specs/003-generate-api-client/spec.md` 现有英文正文等义转换为中文并保留 FR/SC/P 标识
- [X] T071 [P] 更新 `specs/003-generate-api-client/quickstart.md` 中最终落地的准确命令与预期输出
- [X] T072 [P] 检查所有手写 Dart 文件不超过 400 行且无未说明 TODO、secret、debug logging，结果记录于 `specs/003-generate-api-client/quickstart.md`
- [X] T073 执行 `npm run quality:check` 并修复 contract、fixture、generated、format、analyze 和 test 失败
- [X] T074 执行 `specs/003-generate-api-client/quickstart.md` 全部场景并记录验证结果
- [X] T075 复核 FR-001–FR-063、SC-001–SC-032 与宪章要求，将最终设计偏差同步到 `specs/003-generate-api-client/spec.md`、`plan.md` 和 `tasks.md`

---

## 依赖与执行顺序

### 阶段依赖

- Phase 1 无依赖。
- Phase 2 依赖 Phase 1，阻塞全部用户故事。
- US1 依赖 Phase 2，是推荐 MVP。
- US2 依赖 Phase 2；集成到 US1 services 的 T038 依赖 T028。
- US3 依赖 Phase 2；可与 US1/US2 parser 和模型工作并行，但认证集成最终依赖 T025/T036。
- US4 依赖 US1 repository；realtime provider 部分依赖 US3。
- US5 依赖 US1–US4 的最终命令和测试集合。
- Phase 8 依赖所有计划交付的用户故事。

### 用户故事依赖图

```text
Setup → Foundation → US1 ─┬→ US4 ─→ US5
                    US2 ──┤
                    US3 ──┘
```

### 故事内顺序

测试先写并确认失败 → model/policy → service/repository → integration → 独立检查点。

## 可并行机会

- Setup：T003、T004 可并行。
- Foundation：T015、T017、T018 可在生成配置链 T006–T014 之外并行。
- US1：T020–T023 测试并行；T024、T027、T029 实现并行。
- US2：T032–T034 并行；T035、T037 并行。
- US3：T040–T042 并行；T043、T044 并行。
- US4：T049–T053 并行；T054、T055 在接口稳定后并行。
- US5：T060–T062 并行。
- 收尾：T070–T072 并行。

## 并行执行示例

```text
US1: T020 + T021 + T022 + T023 → T024/T027/T029 → T025/T028/T030 → T031
US2: T032 + T033 + T034 → T035 + T037 → T036 → T038 → T039
US3: T040 + T041 + T042 → T043 + T044 → T045/T046 → T047 → T048
US4: T049 + T050 + T051 + T052 + T053 → T054 + T055 → T056/T057/T058 → T059
US5: T060 + T061 + T062 → T063 → T064/T065 → T066/T067/T068 → T069
```

## 实施策略

### MVP 优先

1. 完成 Setup 与 Foundation。
2. 完成 US1，使普通生成请求可通过安全窄边界消费。
3. 停止并独立验证 US1；之后再叠加 failure、SSE、Riverpod 和 CI。

### 增量交付

1. US1：请求边界与 repository。
2. US2：统一失败，不改变 US1 调用形态。
3. US3：独立 SSE service。
4. US4：Riverpod 把前三者组合为生命周期状态。
5. US5：把所有验证接入 CI/Release。

## 说明

- `[P]` 仅表示文件和未完成依赖允许并行，不表示可跳过阶段门禁。
- generated 文件不可手改；OpenAPI 或配置变化后必须完整 regenerate。
- 每个故事必须通过独立测试检查点后才算完成。
