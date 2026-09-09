# Phase 0 研究：RWA 交易能力底座

## 复用现有分层

**决定**：扩展现有 `Riverpod → repository → service → generated client`，每个 API tag 使用窄 service，
每个业务域使用 repository；只有跨多个 repository 的流程才建立 use case。

**理由**：仓库已有环境、鉴权、失败映射、市场 repository、订单命令和 SSE 基础，扩展它们可以保持 DTO
与 transport exception 在 data boundary 内，并允许 Provider 通过 override 独立测试。

**备选方案**：Provider 直接调用 generated API（边界泄漏）；单一全局 repository/app state（职责和失效
范围过大）；为每个 operation 建 use case（样板多且没有业务编排价值）。

## Domain model 与金融数值

**决定**：domain model 使用不可变值对象和判别联合表达 bstock/perp、命令意图与结果；金额、价格、数量、
费用、杠杆和盈亏保持规范十进制字符串，并显式携带 asset/unit/chain/account。

**理由**：OpenAPI 已将金融数值定义为 Decimal string，两条产品线的结算网络、资产结果和风险语义不同；
判别联合可防止无效字段组合，字符串 round-trip 可避免二进制浮点损失。

**备选方案**：全部映射为 `double`（精度不安全）；直接暴露 generated built_value（污染 domain）；引入
decimal package（当前仅需保存、比较服务端值，无新增依赖收益）。

## 查询、命令与会话状态

**决定**：查询使用参数化 auto-dispose async state，命令使用独立 notifier 并保存 intent + idempotency
key；所有用户域 key 包含 session generation。刷新保留已确认数据，登出或 generation 变化使旧请求失效。

**理由**：查询 loading 不应覆盖命令提交状态；generation 可阻止旧账户响应或事件污染新会话；稳定 key
保证超时后重试不产生第二个经济结果。

**备选方案**：页面级单一状态对象（竞态与 rebuild 范围过大）；每次重试生成新 key（破坏幂等）；全局
永久缓存（跨用户泄漏和陈旧数据风险）。

## 快照与实时事件

**决定**：HTTP 快照是权威基线；SSE 事件按 event ID 去重并按实体更新。快照刷新期间有界缓存基线之后的
事件，成功后重放；断点过期、缓存溢出、未知状态或 `resync_required` 触发完整快照。

**理由**：现有 SSE 基础已支持分片、重连、Last-Event-ID 和去重；该协调规则可以避免乱序事件覆盖新快照，
又不会积累无限历史。

**备选方案**：只用 SSE（无法可靠建立初始基线）；只轮询（延迟和负载更高）；事件无界保存（内存风险）。

## 验收环境选择

**决定**：当前以契约驱动的受控 `HttpClientAdapter`/fake 作为默认验收环境，复用真实 generated client、
service、repository 和 Provider 链路。staging 是独立的后续环境验证，不在测试运行中自动回退或混用。

**理由**：2026-09-04 对 `https://rwa-api-staging.dxd.ink` 的只读探测显示网关和鉴权可达，但
`/v1/auth/config`、`/v1/system/app-version`、`/v1/system/disclosures` 均返回
`503 service_unconfigured`；仓库也没有 staging 身份或隔离钱包配置。确定性替身可覆盖所有状态且不产生
真实资产后果。

**备选方案**：现在直接使用 staging（服务未配置，门禁失败）；建立独立全量 Mock server（形成第二套
业务实现且维护成本高）；运行时失败后自动回退 fake（会掩盖环境故障并混淆验收证据）。

## Staging 恢复门禁

**决定**：staging 命令验证必须同时满足：公开启动接口连续成功并可按契约解析；受控 Privy 测试身份可
建立会话；后端负责人确认测试租户、钱包、网络和资产与生产隔离；预览、幂等回读、SSE 和数据复位均可用。
任一失败只允许只读探测并明确报告阻断。

**理由**：域名可达不代表业务可用；真实金融命令必须在可证明无真实价值后果的环境中运行。

**备选方案**：只检查 HTTP 200（无法证明隔离和命令安全）；共享生产钱包（违反 FR-023）；将 staging
波动纳入默认 CI（产生非代码原因的阻断）。

## 延后不完整的契约流程

**决定**：本功能不修改 OpenAPI，也不实现 `pending_signature` 订单 wallet action、资金准备、transfer
或 Claim。`pending_signature` 和 `Deposit.requiresTransfer=true` 分别映射为稳定、非重试的 capability
state；不为 transfer/Claim 建立 domain model、repository、Provider 或业务测试。

**理由**：当前只有 `completeOrderWalletAction(order_id, step_id)`，但 Order/preview 没有可发现的
`step_id` 或动作资源；Claim 创建后也没有 GET/list，Activity 只能分页检索且没有保留期保证。这使
这些流程无法仅凭现有契约完整恢复。产品已明确本阶段延后订单签名和前端资金划转，因此没有必要为了
当前交付扩大 API 契约。

**备选方案**：现在修改 OpenAPI（超出本次范围）；从原型或后端文案猜 `step_id`（违反契约优先）；只
依赖 SSE/Activity 跟踪 Claim（断线后无法可靠恢复）。

## 测试策略与依赖

**决定**：继续使用 flutter_test/package:test、手写 fake、Provider override 和 Dio adapter；新增按场景
组织的 contract-backed fixtures，不引入 Mockito、状态代码生成或新 HTTP/decimal 依赖。staging 套件使用
显式开关单独运行。

**理由**：现有定向基线测试 32 项通过，已验证零外网、401 single-flight、幂等重放、SSE 和 Provider
隔离；当前工具足以表达新增领域场景，手写 fake 的失败模式更明确。

**备选方案**：新增 mocking 框架（收益不足）；只测 mapper（无法证明完整应用链路）；默认测试访问
staging（不确定且当前不可用）。

## 最终 UI 与认证 SDK

**决定**：本功能只输出 domain/repository/Riverpod 契约与最小测试入口，不实现最终 views，也不引入
Privy SDK；token owner 保持可替换接口，待设计与认证集成规格提供实现。

**理由**：最终设计稿尚未提供，而 Privy SDK 的平台配置、登录 UX 和生命周期属于独立用户功能；提前
绑定会固化未确认决策。

**备选方案**：按 HTML 原型实现临时页面（容易成为事实 UI）；在本功能中完成 Privy（扩大范围且缺少
产品验收条件）。
