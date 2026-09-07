# Tasks: RWA 交易能力底座

**Input**: Design documents from `specs/004-trading-domain-foundation/`

**Prerequisites**: `plan.md`, `spec.md`, `research.md`, `data-model.md`, `contracts/`, `quickstart.md`

**Tests**: 规格和宪章要求自动化验证。每个用户故事中的测试任务必须先完成并确认失败，再开始对应实现。

**Scope Guard**: 不修改 `openapi/main.yaml` 或 `packages/rwa_api_client/`；不实现最终 views、订单 wallet
action、funding plan、transfer 或 Claim 的 domain/repository/Provider/命令/业务测试。

## Format: `[ID] [P?] [Story] Description`

- **[P]**: 可在依赖完成后与同阶段其他不同文件任务并行
- **[Story]**: 对应 `spec.md` 中的用户故事
- 所有任务均包含明确文件路径

## Phase 1: Setup (Shared Test Infrastructure)

**Purpose**: 建立零外网、契约驱动的通用场景测试基础，不复制服务端业务实现。

- [X] T001 在 `test/helpers/controlled_api_adapter_test.dart` 编写 method/path 匹配、请求记录、未声明请求立即失败和敏感字段不进入失败输出的测试并确认失败
- [X] T002 [P] 在 `test/helpers/trading_scenario_fixture.dart` 定义成功、空数据、分页、401/403/409/422/429/503、timeout 和 malformed response 场景构造器
- [X] T003 [P] 在 `test/helpers/requirement_scenario.dart` 定义 FR/SC/用户故事场景元数据和不少于 50 个场景的计数断言工具
- [X] T004 在 `test/helpers/controlled_api_adapter.dart` 实现按 method/path 匹配 fixture、记录请求并拒绝未声明外网请求的 Dio adapter，且通过 T001

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: 所有用户故事共享的金融值、能力状态、资源结果、失败分类、应用状态和测试装配。

**CRITICAL**: 本阶段完成前不得开始用户故事实现。

- [X] T005 [P] 在 `test/domain/models/decimal_value_test.dart` 编写十进制字符串语法、精度保留、单位隔离和非法值拒绝测试
- [X] T006 [P] 在 `test/domain/models/unsupported_capability_test.dart` 编写两个稳定 code、`wait_for_feature`、不可重试和资源关联测试
- [X] T007 [P] 在 `test/domain/models/resource_result_test.dart` 编写资源可附带 capability 且不等同于 `ApiFailure` 的测试
- [X] T008 [P] 在 `test/data/api/api_failure_mapper_test.dart` 编写 unauthorized、forbidden、validation、conflict、rate-limited、unavailable、network、unknown、request ID 和脱敏 details 映射测试并确认失败
- [X] T009 [P] 在 `test/domain/models/application_state_test.dart` 编写 `QueryState` 的 loading/data/empty/refresh/failure/capability 及 `CommandState` 的 idle/submitting/accepted/failure 状态迁移测试并确认失败
- [X] T010 在 `lib/domain/models/decimal_value.dart` 实现无损 `DecimalValue` 值对象并通过 T005
- [X] T011 [P] 在 `lib/domain/models/unsupported_capability.dart` 实现 `UnsupportedCapability`、稳定 code 和 action 并通过 T006
- [X] T012 在 `lib/domain/models/resource_result.dart` 实现资源与可选 capability 的不可变结果类型并通过 T007
- [X] T013 [P] 在 `lib/domain/models/api_failure.dart` 完善稳定 failure taxonomy，并在 `lib/data/api/api_failure_mapper.dart` 集中实现 transport-to-domain 映射且通过 T008
- [X] T014 [P] 在 `lib/domain/models/application_state.dart` 实现不可变 `QueryState<T>` 与 `CommandState<I, R>`，统一刷新保留数据、capability 和命令非终态语义且通过 T009
- [X] T015 在 `test/helpers/trading_provider_harness.dart` 建立可 override environment/token/repository/realtime、自动 dispose 和 session generation 控制的 Provider 测试容器

**Checkpoint**: 共享模型、稳定失败、统一应用状态和 controlled 测试基础可用于所有故事，且默认测试零外网。

---

## Phase 3: User Story 1 - 建立可信账户会话 (Priority: P1) MVP

**Goal**: 建立、恢复和结束会话，并提供当前账户、设置、设备及钱包状态；登出后清除用户域。

**Independent Test**: 使用 fake token 和 controlled adapter 验证有效、过期、无效凭证、会话恢复、登出及旧 generation 隔离，无需任何其他用户故事。

### Tests for User Story 1

- [X] T016 [P] [US1] 在 `test/data/services/session_account_service_test.dart` 编写 auth config、create/delete session、账户、设置、设备和钱包 generated service 契约测试并确认失败
- [X] T017 [P] [US1] 在 `test/data/repositories/session_repository_test.dart` 编写 Session/User DTO 映射、缺失字段、401 和 request ID 测试并确认失败
- [X] T018 [P] [US1] 在 `test/data/repositories/account_repository_test.dart` 编写设置 patch、设备分页和钱包状态映射测试并确认失败
- [X] T019 [P] [US1] 在 `test/ui/features/session/providers/session_provider_test.dart` 编写 create/restore/logout、重复提交和旧 generation 不提交测试并确认失败
- [X] T020 [P] [US1] 在 `test/ui/features/account/providers/account_provider_test.dart` 编写 profile/settings/devices/wallets 的 loading/data/empty/failure/refresh/dispose 测试并确认失败
- [X] T021 [US1] 在 `test/acceptance/session_account_flow_test.dart` 编写 controlled adapter → generated client → service → repository → Riverpod 的会话建立、恢复、拒绝、登出和账户隔离全链路测试并确认失败

### Implementation for User Story 1

- [X] T022 [P] [US1] 在 `lib/domain/models/product_session.dart` 和 `lib/domain/models/user_account.dart` 实现会话、账户及设置不可变模型
- [X] T023 [P] [US1] 在 `lib/domain/models/registered_device.dart` 和 `lib/domain/models/wallet.dart` 实现设备和钱包模型，确保不保存 token 或完整 push token
- [X] T024 [P] [US1] 在 `lib/domain/repositories/session_repository.dart` 和 `lib/domain/repositories/account_repository.dart` 定义会话与账户 ports
- [X] T025 [US1] 扩展 `lib/data/services/session_service.dart` 和 `lib/data/services/generated_session_service.dart` 以覆盖 auth config、create/delete session 并映射 transport failure
- [X] T026 [P] [US1] 在 `lib/data/services/account_service.dart` 和 `lib/data/services/generated_account_service.dart` 实现账户、设置和设备窄 generated-client 边界
- [X] T027 [P] [US1] 在 `lib/data/services/wallets_service.dart` 和 `lib/data/services/generated_wallets_service.dart` 实现钱包读取与同步边界
- [X] T028 [US1] 在 `lib/data/repositories/session_repository_impl.dart` 和 `lib/data/repositories/account_repository_impl.dart` 实现显式 DTO-to-domain 映射
- [X] T029 [US1] 在 `lib/ui/features/session/providers/session_provider.dart` 和 `lib/ui/features/account/providers/account_providers.dart` 实现会话/账户状态、刷新与登出清理
- [X] T030 [US1] 在 `lib/app/providers/api_providers.dart` 装配 US1 services/repositories，并在 `lib/app/providers/session_scope.dart` 完成登出 generation 失效

**Checkpoint**: US1 可通过 Provider override 独立完成会话和账户状态验证。

---

## Phase 4: User Story 2 - 获取市场与资产全貌 (Priority: P1)

**Goal**: 提供市场产品、详情、行情、收藏、组合、账户和持仓的无损 domain 状态。

**Independent Test**: 使用固定市场/组合 fixtures 验证公开与用户数据、有/空/分页、收藏隔离、现货/合约区分和金额逐字保留；会话可由测试 override 提供。

### Tests for User Story 2

- [X] T031 [P] [US2] 在 `test/data/services/generated_markets_charts_service_test.dart` 编写产品、详情、统计、订单簿、K 线、时段和参考价 service 契约测试并确认失败
- [X] T032 [P] [US2] 在 `test/data/services/generated_portfolio_service_test.dart` 编写组合汇总、账户和 holding page service 契约测试并确认失败
- [X] T033 [P] [US2] 在 `test/data/repositories/market_catalog_repository_test.dart` 编写产品判别联合、分页、收藏和 DecimalValue 映射测试并确认失败
- [X] T034 [P] [US2] 在 `test/data/repositories/portfolio_repository_test.dart` 编写账户种类、token balance、现货/合约持仓隔离和 malformed DTO 测试并确认失败
- [X] T035 [P] [US2] 在 `test/ui/features/markets/providers/market_providers_test.dart` 编写查询参数隔离、刷新保留数据、空数据、失败和 dispose 测试并确认失败
- [X] T036 [P] [US2] 在 `test/ui/features/portfolio/providers/portfolio_providers_test.dart` 编写 summary/accounts/holdings 独立状态及 session 隔离测试并确认失败

### Implementation for User Story 2

- [X] T037 [P] [US2] 在 `lib/domain/models/market_product.dart` 和 `lib/domain/models/market_snapshot.dart` 实现产品判别联合及行情模型
- [X] T038 [P] [US2] 在 `lib/domain/models/trading_account.dart` 和 `lib/domain/models/portfolio.dart` 实现账户、token balance、holding group 和组合模型
- [X] T039 [P] [US2] 在 `lib/domain/models/position.dart` 实现现货/合约仓位判别模型及风险字段约束
- [X] T040 [P] [US2] 扩展 `lib/domain/repositories/markets_repository.dart` 并在 `lib/domain/repositories/portfolio_repository.dart` 定义完整查询 ports
- [X] T041 [US2] 扩展 `lib/data/services/markets_service.dart` 和 `lib/data/services/generated_markets_service.dart` 以覆盖产品、详情、统计、订单簿和收藏
- [X] T042 [P] [US2] 在 `lib/data/services/charts_service.dart` 和 `lib/data/services/generated_charts_service.dart` 实现 K 线、市场时段和参考价边界
- [X] T043 [P] [US2] 在 `lib/data/services/portfolio_service.dart` 和 `lib/data/services/generated_portfolio_service.dart` 实现组合、账户和 holdings 边界
- [X] T044 [US2] 扩展 `lib/data/repositories/markets_repository_impl.dart` 并在 `lib/data/repositories/portfolio_repository_impl.dart` 实现 DTO-to-domain 与分页映射
- [X] T045 [P] [US2] 在 `lib/ui/features/markets/providers/market_providers.dart` 实现市场、详情、图表和收藏 query/command 状态
- [X] T046 [P] [US2] 在 `lib/ui/features/portfolio/providers/portfolio_providers.dart` 实现 summary/accounts/holdings 查询状态
- [X] T047 [US2] 在 `lib/app/providers/api_providers.dart` 装配 US2 services/repositories 并区分 public 与 session-scoped 查询

**Checkpoint**: US2 可独立返回市场和资产 domain 快照，不依赖最终页面。

---

## Phase 5: User Story 3 - 安全地下达并跟踪交易 (Priority: P1)

**Goal**: 完成无需订单钱包签名的预览、幂等下单、查询、取消及仓位管理，并安全暴露未支持签名状态。

**Independent Test**: 使用 controlled fixtures 验证现货/合约意图、预览过期/价格变化、20 次重复提交、订单状态、取消、TP/SL、杠杆和平仓；`pending_signature` 不触发 wallet action。

### Tests for User Story 3

- [X] T048 [P] [US3] 在 `test/domain/models/order_intent_test.dart` 编写 bstock/perp、market/limit、side、数量、杠杆和 TP/SL 组合校验测试并确认失败
- [X] T049 [P] [US3] 在 `test/data/services/generated_orders_positions_service_test.dart` 编写预览、订单 CRUD、仓位 CRUD 和幂等 header service 测试并确认失败
- [X] T050 [P] [US3] 在 `test/data/repositories/orders_repository_test.dart` 编写 preview/order 映射、过期报价、`pending_signature` capability 和未知状态测试并确认失败
- [X] T051 [P] [US3] 在 `test/data/repositories/positions_repository_test.dart` 编写 TP/SL 方向约束、杠杆、平仓及金融值映射测试并确认失败
- [X] T052 [P] [US3] 在 `test/ui/features/orders/providers/order_providers_test.dart` 编写预览、20 次并发提交、同 intent retry key、变更 intent 新 key 和零 wallet-action 调用测试并确认失败
- [X] T053 [P] [US3] 在 `test/ui/features/positions/providers/position_providers_test.dart` 编写列表/详情/更新/清除/关闭状态和最小失效测试并确认失败
- [X] T054 [US3] 在 `test/acceptance/order_position_flow_test.dart` 编写 controlled adapter → generated client → service → repository → Riverpod 的预览、幂等下单、回读、取消及仓位管理全链路测试并确认失败

### Implementation for User Story 3

- [X] T055 [P] [US3] 在 `lib/domain/models/order_intent.dart` 实现 bstock/perp 订单意图和 TP/SL 校验
- [X] T056 [P] [US3] 在 `lib/domain/models/order_preview.dart` 和 `lib/domain/models/order.dart` 实现预览、订单状态和 capability 关联模型
- [X] T057 [P] [US3] 在 `lib/domain/repositories/orders_repository.dart` 和 `lib/domain/repositories/positions_repository.dart` 定义订单与仓位 ports
- [X] T058 [US3] 扩展 `lib/data/services/orders_service.dart` 和 `lib/data/services/generated_orders_service.dart` 以覆盖预览、列表、详情、创建和取消，且不暴露 wallet-action 方法
- [X] T059 [P] [US3] 在 `lib/data/services/positions_service.dart` 和 `lib/data/services/generated_positions_service.dart` 实现仓位读取、TP/SL、杠杆和平仓边界
- [X] T060 [US3] 在 `lib/data/repositories/orders_repository_impl.dart` 实现意图转换、预览/订单映射、幂等调用和 `order_signature_not_supported`
- [X] T061 [P] [US3] 在 `lib/data/repositories/positions_repository_impl.dart` 实现仓位映射和方向/杠杆命令校验
- [X] T062 [US3] 在 `lib/ui/features/orders/providers/order_providers.dart` 实现查询、预览和命令状态，并替换 `lib/ui/features/api_example/providers/order_command_provider.dart` 的示例依赖
- [X] T063 [P] [US3] 在 `lib/ui/features/positions/providers/position_providers.dart` 实现仓位查询和管理命令状态
- [X] T064 [US3] 在 `lib/app/providers/api_providers.dart` 装配 US3 services/repositories，并确保未提供 `completeOrderWalletAction` 应用入口

**Checkpoint**: US3 对所有范围内订单/仓位操作可独立验证，签名订单只返回不可重试 capability。

---

## Phase 6: User Story 4 - 跟踪入金与提现 (Priority: P2)

**Goal**: 提供入金资产/网络目录，创建和跟踪入金，并获取提现报价及创建/跟踪提现；需要后续划转的入金只返回 capability。

**Independent Test**: 使用隔离 fixtures 验证钱包、funding catalog、入金、提现报价/授权/命令的 pending、成功、失败、ambiguous、manual review 和幂等行为，且 funding plan/transfer/Claim 零调用。

### Tests for User Story 4

- [X] T065 [P] [US4] 在 `test/data/services/generated_wallets_funding_service_test.dart` 编写钱包、funding catalog、deposit、withdrawal quote/CRUD 的范围内 service 测试和排除 operation 零调用断言并确认失败
- [X] T066 [P] [US4] 在 `test/data/repositories/wallets_repository_test.dart` 编写钱包同步、仅 withdrawal authorization 和过期/错误授权测试并确认失败
- [X] T067 [P] [US4] 在 `test/data/repositories/funding_repository_test.dart` 编写 funding catalog、deposit/withdrawal 映射、`requiresTransfer` capability、状态不明确和金额/网络测试并确认失败
- [X] T068 [P] [US4] 在 `test/ui/features/funding/providers/deposit_providers_test.dart` 编写 funding catalog、入金创建/查询、刷新、session 隔离和不可重试 capability 测试并确认失败
- [X] T069 [P] [US4] 在 `test/ui/features/funding/providers/withdrawal_providers_test.dart` 编写报价、授权、幂等提现、详情/列表和 session 隔离测试并确认失败
- [X] T070 [US4] 在 `test/acceptance/funding_flow_test.dart` 编写 controlled adapter → generated client → service → repository → Riverpod 的 catalog、入金、提现报价/授权/命令/回读全链路测试，并断言排除 operation 零调用后确认失败

### Implementation for User Story 4

- [X] T071 [P] [US4] 在 `lib/domain/models/funding_catalog.dart` 实现入金资产、网络、结算账户和约束的不可变目录模型
- [X] T072 [P] [US4] 在 `lib/domain/models/deposit.dart` 实现入金说明、确认数、状态和 `funding_transfer_not_supported` 关联
- [X] T073 [P] [US4] 在 `lib/domain/models/withdrawal.dart` 实现提现意图、报价、授权和提现状态模型
- [X] T074 [P] [US4] 在 `lib/domain/repositories/wallets_repository.dart` 和 `lib/domain/repositories/funding_repository.dart` 定义钱包、funding catalog、入金及提现范围内 operation 的 ports
- [X] T075 [US4] 扩展 `lib/data/services/wallets_service.dart` 和 `lib/data/services/generated_wallets_service.dart` 以支持读取/同步钱包及 withdrawal authorization
- [X] T076 [P] [US4] 在 `lib/data/services/funding_service.dart` 和 `lib/data/services/generated_funding_service.dart` 实现 funding catalog、deposit 与 withdrawal 范围内 generated-client 边界，不公开 plan/transfer/claim 方法
- [X] T077 [US4] 在 `lib/data/repositories/wallets_repository_impl.dart` 和 `lib/data/repositories/funding_repository_impl.dart` 实现钱包、funding catalog、入金和提现 DTO-to-domain 映射
- [X] T078 [P] [US4] 在 `lib/ui/features/funding/providers/deposit_providers.dart` 实现 funding catalog、入金查询/命令和 capability 状态
- [X] T079 [P] [US4] 在 `lib/ui/features/funding/providers/withdrawal_providers.dart` 实现报价、授权、提现命令及查询状态
- [X] T080 [US4] 在 `lib/app/providers/api_providers.dart` 装配 US4 范围内 services/repositories，并保持 funding plan/transfer/Claim 无应用 Provider

**Checkpoint**: US4 可独立验证 funding catalog、入金和提现，且排除的资金能力不可从应用层调用。

---

## Phase 7: User Story 5 - 保持账户状态及时且可恢复 (Priority: P2)

**Goal**: 用 SSE 更新范围内聚合，正确处理重复、乱序、断连、session 切换和权威快照重同步。

**Independent Test**: 使用 fake realtime stream 和 controlled snapshot repositories 注入价格、订单、仓位、余额、入金、提现、活动、session 与 resync 事件，验证最终状态和权威快照一致。

### Tests for User Story 5

- [X] T081 [P] [US5] 在 `test/data/repositories/activity_repository_test.dart` 编写活动分页、筛选、关联资源和金融单位映射测试并确认失败
- [X] T082 [P] [US5] 在 `test/data/repositories/realtime_repository_test.dart` 编写范围内 typed event 映射、去重、取消后不交付和旧 generation 丢弃测试并确认失败
- [X] T083 [P] [US5] 在 `test/app/providers/realtime_coordinator_test.dart` 编写快照基线、刷新缓冲、重复/乱序、溢出、resync、session 清理及 1,000 条事件按序且不重复应用测试并确认失败
- [X] T084 [P] [US5] 在 `test/ui/features/activity/providers/activity_provider_test.dart` 编写分页追加去重、筛选隔离、实时插入和失败保留旧数据测试并确认失败

### Implementation for User Story 5

- [X] T085 [P] [US5] 在 `lib/domain/models/activity_record.dart` 实现活动分类、状态、资源引用和金额单位模型
- [X] T086 [P] [US5] 在 `lib/domain/repositories/activity_repository.dart` 和 `lib/domain/repositories/realtime_repository.dart` 定义活动与 typed realtime ports
- [X] T087 [US5] 在 `lib/data/services/activity_service.dart` 和 `lib/data/services/generated_activity_service.dart` 实现活动分页窄边界
- [X] T088 [P] [US5] 在 `lib/data/repositories/activity_repository_impl.dart` 和 `lib/data/repositories/realtime_repository_impl.dart` 实现活动与现有 SSE envelope 的 domain 映射
- [X] T089 [US5] 在 `lib/app/providers/realtime_coordinator.dart` 实现按实体路由、终态防回退、有界事件缓冲和 snapshot resync 协调
- [X] T090 [P] [US5] 在 `lib/ui/features/activity/providers/activity_provider.dart` 实现分页/筛选/实时插入状态
- [X] T091 [US5] 更新 `lib/app/providers/realtime_providers.dart` 装配 coordinator、按 channels+generation 隔离并在最后消费者释放时取消连接

**Checkpoint**: US5 可独立证明断连和乱序后范围内账户状态恢复为权威快照。

---

## Phase 8: Polish & Cross-Cutting Quality Gates

**Purpose**: 完成跨故事追踪、安全、规模和验收门禁。

- [X] T092 [P] 在 `test/acceptance/application_state_performance_test.dart` 使用可重复 controlled 场景测量普通查询进入可消费终态的延迟，并断言至少 100 次样本的 p95 不超过 1 秒
- [X] T093 [P] 在 `test/acceptance/requirement_traceability_test.dart` 建立 US1-US5、FR-001-FR-023、SC-001-SC-005 到测试用例的可执行追踪矩阵并断言至少 50 个代表性场景
- [X] T094 [P] 在 `test/acceptance/scope_guard_test.dart` 扫描应用 ports/providers，断言没有 order wallet action、funding plan、transfer 或 Claim 的应用入口且未引用 generated DTO
- [X] T095 [P] 在 `test/acceptance/security_diagnostics_test.dart` 验证 token、signature、raw body、完整金融 payload 和 stack trace 不进入诊断输出
- [X] T096 [P] 在 `scripts/check-staging-readiness.test.mjs` 编写公开/授权读取、503、401、隔离证明、命令额度、reset/teardown、资源回读、幂等、SSE 和敏感输出脱敏门禁测试并确认失败
- [X] T097 在 `scripts/check-staging-readiness.mjs` 实现只读 staging preflight，逐项输出全部门禁的通过或阻断结果，记录 operation/status/request ID，并在 `service_unconfigured` 或任一证明缺失时阻断命令模式且通过 T096
- [X] T098 更新 `package.json` 添加独立 `staging:preflight` 命令，保持 `quality:check` 默认零外网
- [X] T099 按 `specs/004-trading-domain-foundation/quickstart.md` 运行 controlled 验收并将结果追加到该文件的验证记录章节
- [X] T100 运行 `npm run quality:check`，检查手写 Dart 文件/`build` 阈值、未记录 TODO、调试日志和 secret，并在 `specs/004-trading-domain-foundation/quickstart.md` 记录最终证据

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 Setup**: 无依赖，可立即开始。
- **Phase 2 Foundational**: 依赖 Phase 1，阻塞所有用户故事。
- **US1、US2、US3**: 均依赖 Phase 2；测试可用 override 独立运行，生产装配按 US1 → US2 → US3 合并。
- **US4**: 依赖 Phase 2；提现授权复用 US1 wallet model/service 时，T075-T080 还依赖 T023、T027。
- **US5**: 依赖 Phase 2；coordinator 集成依赖需要接收实时更新的已选故事完成，但 activity slice 可独立完成。
- **Phase 8 Polish**: 依赖所有计划交付的用户故事。

### User Story Dependencies

- **US1 (P1)**: Foundation 后独立；建议作为 MVP。
- **US2 (P1)**: Foundation 后可用 fake session 独立验证；生产组合根集成依赖 US1。
- **US3 (P1)**: Foundation 后可用 fake session 独立验证；实时更新延后到 US5。
- **US4 (P2)**: Foundation 后可用 fake wallet/session 独立验证；生产钱包装配复用 US1。
- **US5 (P2)**: Activity 独立；完整 coordinator 依赖已实现的 US2-US4 聚合。

### Within Each User Story

- 先完成本故事全部测试任务并确认失败，再开始 domain model 和 port。
- model/port 完成后实现 service，再实现 repository，最后实现 Provider 与组合根。
- 同一 intent 的 command retry 必须复用 Idempotency-Key；不同经济 intent 必须产生新 key。
- 每个故事 checkpoint 必须能通过 override/fake 独立验证，不依赖最终 UI 或 staging。

## Parallel Opportunities

- T002-T003、T005-T009 可在各自阶段并行；T010-T014 在对应测试完成后可按不同文件并行。
- US1 的 T016-T020、T022-T024 组内可并行；service 完成后 repository 与不同 Provider 可分工。
- US2 的 service/repository/provider 测试可并行；市场、图表和组合 service 可并行。
- US3 的订单与仓位测试、模型、service 和 Provider 可按两个子域并行。
- US4 的 deposit 与 withdrawal provider 可并行；wallet 与 funding mapper 在 ports 完成后可并行。
- US5 的 activity slice 可与 realtime coordinator 测试和实现并行。
- T092-T096 可并行；T097 依赖 T096，T099-T100 在实现完成后顺序执行。

## Parallel Examples

### User Story 1

```text
Task T016: session/account service contract tests
Task T017: session repository mapping tests
Task T018: account repository mapping tests
Task T019: session Provider lifecycle tests
Task T020: account Provider state tests
```

### User Story 2

```text
Task T031: markets/charts service tests
Task T032: portfolio service tests
Task T033: market repository tests
Task T034: portfolio repository tests
```

### User Story 3

```text
Task T048: order intent validation tests
Task T049: order/position service tests
Task T050: order repository tests
Task T051: position repository tests
```

### User Story 4

```text
Task T065: wallet/funding service tests
Task T066: wallet repository tests
Task T067: funding repository tests
Task T068: deposit Provider tests
Task T069: withdrawal Provider tests
```

### User Story 5

```text
Task T081: activity repository tests
Task T082: realtime repository tests
Task T083: realtime coordinator tests
Task T084: activity Provider tests
```

## Implementation Strategy

### MVP First

1. 完成 Phase 1 和 Phase 2。
2. 完成 US1 的 T016-T030。
3. 独立运行 US1 tests，确认会话、账户和登出隔离。
4. 停止并评审 MVP，再选择继续 US2 或 US3。

### Incremental Delivery

1. Setup + Foundation：确定性测试与稳定 domain primitives。
2. US1：会话和账户。
3. US2：市场和组合只读能力。
4. US3：范围内订单与仓位命令。
5. US4：funding catalog、入金与提现。
6. US5：实时协调和活动。
7. Polish：追踪、范围保护、安全和完整质量门禁。

## Notes

- `[P]` 只表示文件和前置依赖允许并行，不表示可跳过本阶段测试先行顺序。
- 每个任务或逻辑组完成后应提交一次小范围 commit。
- staging 当前返回 `503 service_unconfigured`；T096-T098 只建立只读门禁，不授权命令测试。
- 任何任务发现需要修改 OpenAPI、订单 wallet action、funding plan、transfer 或 Claim 时必须停止并回到规格流程。

## Phase 9: Convergence

- [X] T101 **CRITICAL** 修正 `lib/ui/features/positions/providers/position_providers.dart` 与 `lib/ui/features/funding/providers/deposit_providers.dart` 的命令幂等键生命周期，使相同 intent 的并发提交、超时重试和结果不明确重试复用同一 key、intent 变化才生成新 key，并在对应 Provider 测试中断言最多创建一个经济资源 per FR-010, SC-002, Constitution III/IV (contradicts)
- [X] T102 **CRITICAL** 扩展 `test/acceptance/session_account_flow_test.dart`，通过 controlled adapter → generated client → service → repository → Riverpod 验证会话创建、恢复、无效或过期凭证拒绝、登出清理、旧 generation 丢弃及账户数据隔离 per US1/AC1-US1/AC3, T021, Constitution III (partial)
- [X] T103 **CRITICAL** 重写 `test/acceptance/order_position_flow_test.dart` 并扩展 `test/ui/features/positions/providers/position_providers_test.dart`，验证预览、幂等下单、回读、取消、`pending_signature` capability、仓位 TP/SL/杠杆/平仓、失败保留和最小失效的真实边界调用，替换字符串范围断言 per US3/AC1-US3/AC3, FR-008-FR-012, T052-T054, Constitution III (partial)
- [X] T104 重写 `test/acceptance/funding_flow_test.dart` 并扩展 Deposit/Withdrawal Provider 测试，通过完整边界验证 catalog、入金创建与回读、提现报价/授权/创建与回读、幂等、失败、状态不明确、session 隔离、`funding_transfer_not_supported` 以及排除 operation 零调用 per US4/AC1-US4/AC3, FR-013-FR-015, T068-T070 (partial)
- [X] T105 用“需求或验收场景 → 具体测试文件与测试名称”的静态可执行清单重写 `test/acceptance/requirement_traceability_test.dart`，只统计实际运行的至少 50 个代表性场景，并在证据真实通过后更正 `specs/004-trading-domain-foundation/quickstart.md` 的验证记录 per SC-001-SC-005, T093, T099-T100 (partial)
- [X] T106 重写 `test/acceptance/application_state_performance_test.dart`，使用 controlled adapter 驱动 generated client → service → repository → Riverpod 的完整查询链，采集至少 100 次样本并断言进入可消费终态的 p95 不超过 1 秒 per plan: performance target, T092 (partial)
- [X] T107 扩展 `test/app/providers/realtime_coordinator_test.dart` 及相关 Provider 测试，覆盖快照基线、刷新期间缓冲合并、缓冲溢出、断连重订阅、resync、终态不回退、旧 session generation 丢弃和 1,000 条事件按序且不重复应用 per FR-017, FR-018, SC-004, T083 (partial)
- [X] T108 扩展 `scripts/check-staging-readiness.mjs` 与 `.test.mjs`，在公开读取通过后显式评估受控身份、隔离钱包、命令额度、reset/teardown、资源回读、幂等和 SSE 证明；默认 fail closed，但在全部门禁满足时能够报告 command-ready，且输出始终脱敏 per plan: staging gate, T096-T098 (partial)
