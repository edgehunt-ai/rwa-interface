# 功能规格：优化 API 客户端与状态管理

**功能分支**：`main`  
**创建日期**：2026-09-03  
**状态**：已确认  
**输入**：基于现有 OpenAPI 客户端优化请求边界，并用 Riverpod 统一依赖装配和应用状态；保留已落地生成方案，不重复建设。

> 文档统一使用中文；`FR-*`、`SC-*`、`P*` 及 OpenAPI、Dio、Riverpod、SSE 等技术标识保持不变。

## 用户场景与测试

### 用户故事 1：安全消费生成请求（P1）

功能开发者通过应用自有边界调用 generated API 并获得可预测结果，无需重复处理认证、响应解释或传输细节。

**独立测试**：不依赖 UI/state，验证 public、authenticated、page、financial command、empty response 和 declared error。

1. public 操作不要求也不附加凭据。
2. authenticated 操作在请求时取得当前凭据，调用方和诊断均不可见凭据。
3. 并发 401 只协调一次恢复，每个可重放请求最多重试一次。
4. 金融命令由调用方提供唯一幂等键，边界原样传递。
5. 无 body 的成功响应不得尝试解码 payload。

### 用户故事 2：统一处理失败（P2）

业务获得有界、可理解的 failure，而不是 raw transport exception，从而决定 retry、reauthenticate、resync 或显示安全提示。

**独立测试**：注入声明错误、timeout、断网、cancel 和 malformed payload，验证安全分类及 request ID。

1. 声明错误保留 status、code、retry、user action 和可用 request ID。
2. timeout/connection/cancel/decode 可区分，且不暴露 token、stack 或敏感 payload。
3. 恢复失败或重试后仍 401 时只触发一次 session-expired，且不再重试。

### 用户故事 3：可靠接收实时事件（P3）

功能开发者可订阅 realtime channel 并按序接收 typed event，用于价格、订单、仓位、余额和资金状态更新。

**独立测试**：输入任意分片、多事件、heartbeat、断线、malformed 和 resync，验证交付、恢复、取消。

1. 完整或跨 chunk frame 均按序恰好交付一次。
2. heartbeat/comment 维持连接但不暴露为产品事件。
3. 重连使用最后成功 event ID，已确认事件不重复。
4. replay 不可用时明确要求重载权威快照。
5. 取消后连接和计划恢复均停止，不再交付。

### 用户故事 4：管理请求型状态（P4）

功能开发者观察 immutable loading/data/empty/refreshing/failure 并触发显式 command，页面只负责渲染和用户意图。

**独立测试**：用 fake override 驱动 query、refresh、参数变化、command、cancel、realtime，无需 Widget。

1. query 明确表达初载、数据、空结果和可恢复失败。
2. refresh 期间保留已有数据并表达 refreshing。
3. 参数快速变化时旧请求不得覆盖新状态。
4. 重要命令提交中阻止重复执行，retry 是显式动作。
5. override 生效，state 层不得自行创建网络客户端。
6. realtime 只更新/invalidate 最小相关状态。

### 用户故事 5：在契约变化下验证优化（P5）

维护者依赖 generated 边界周围的行为检查，防止 regeneration 或 contract change 静默破坏认证、精度、错误、204、分页或 realtime。

**独立测试**：clean checkout 运行统一质量命令；真实行为测试执行，未变化生成零 diff，stale output 明确失败。

1. 相同输入重复生成无 tracked diff。
2. contract 修改但未生成时失败并提示生成命令。
3. placeholder tests 不作为边界验证证据。
4. artifact 保留 runtime source/metadata，排除不维护的 placeholder tests/docs。
5. Release 展示 artifact size，但不按大小判定成败。
6. clean checkout 可直接 build/analyze/test，无未记录手工准备。

### 边界情况

- token 缺失/为空/并发过期，或恢复后仍无效；重试可能重复命令或消费 one-shot body。
- success 无 body/使用其他状态/内容畸形；error body 缺失或与 header request ID 冲突。
- nullable、absent、unknown enum、空分页、金融高精度 String。
- SSE 任意 chunk/newline、comment、blank data、重复 ID、unknown variant、resync；恢复中 cancel/teardown。
- dispose、快速换参数、logout 后旧结果返回，以及 realtime 与 snapshot refresh 竞态。
- 生成误删 serializer/operation/metadata，或 export 常驻全部未使用模型。
- production URL 缺失/无效/误用 staging；普通请求和 SSE timeout 不同；symlink escape；generator upgrade 改变高风险 construct。

## 功能需求

- **FR-001**：复用现有 generated client 和确定性流程，不建立第二套客户端或契约真相源。
- **FR-002**：应用请求行为位于 generated 文件外，重生成不得覆盖。
- **FR-003**：支持 public/auth，并在请求时取凭据，不在 generated source 保存 secret。
- **FR-004**：并发 401 恢复 single-flight；每请求最多 retry 一次，无有效 token 时 fail closed。
- **FR-005**：无法证明安全 replay 时不得自动重试重要命令。
- **FR-006**：金融命令幂等键由调用方提供且原样传递。
- **FR-007**：所有声明的有/无 body success status 均可安全表示。
- **FR-008**：声明错误映射为应用 failure，保留 status/code/retry/userAction/details/requestId。
- **FR-009**：timeout/connect/cancel/decode/auth/unknown 可区分，诊断不暴露凭据、stack、金融 payload。
- **FR-010**：generated DTO 不越过 data 边界；repository 映射为 domain model。
- **FR-011**：Decimal 保持无损 String，timestamp 保持 UTC 语义。
- **FR-012**：cursor page 保留 items 和 continuation。
- **FR-013**：realtime 消费连续流，不当作单响应。
- **FR-014**：SSE 支持跨 chunk、多 frame、LF/CRLF、id/event、多行 data、comment、空行终止。
- **FR-015**：有效 realtime payload 经 generated model 验证并按序恰好交付一次。
- **FR-016**：订阅支持 cancel、Last-Event-ID 和 bounded reconnect。
- **FR-017**：unknown/malformed realtime 返回有界 failure/compatibility，不终止无关状态。
- **FR-018**：replay window 过期作为独立 resync signal。
- **FR-019**：保留 contract validation、generator pin、deterministic regeneration、stale detection。
- **FR-020**：测试覆盖 public/auth/并发恢复/金融命令/page/204/error/malformed/金融 String/realtime lifecycle。
- **FR-021**：质量门禁执行应用行为测试，placeholder tests 不算验证。
- **FR-022**：文档说明 ownership、生成/验证、SSE 和禁止手改 generated。
- **FR-023**：Riverpod 是本范围统一 DI/state 机制。
- **FR-024**：网络由 generated client/data service 执行；Riverpod 不构造请求或解析 wire。
- **FR-025**：Provider 只暴露 domain value/failure，不暴露 DTO/Response/DioException。
- **FR-026**：读状态区分 initial/data/empty/refreshing/failure，刷新适当保留数据。
- **FR-027**：command 有 idle/submitting/success/failure、防重复、同 intent retry 复用原 key。
- **FR-028**：参数状态由全部输入键控；stale/cancelled 结果不得覆盖新状态。
- **FR-029**：无人观察时释放 subscription/pending work；session state 有明确 invalidation。
- **FR-030**：realtime 只更新最小 state owner，并协调 in-flight snapshot refresh。
- **FR-031**：auth loss 清理用户态但保留 public；新用户不见旧用户数据。
- **FR-032**：state owner 支持 override，测试零真实网络。
- **FR-033**：Provider 仅为 composition/lifecycle；规则和转换在 repository/use case。
- **FR-034**：缓存、离线、完整业务 repository/交易规则/生产 UI 不在范围，代表性示例除外。
- **FR-035**：省略 placeholder API/model tests 及逐 API/model docs。
- **FR-036**：精简不得删除 operation/model/serializer/package metadata/generation metadata/warning。
- **FR-037**：用窄领域 service 暴露 operation，不把完整 client 注入 presentation/state。
- **FR-038**：wrapper 必须承担 failure/domain/auth/realtime 等职责，避免无价值透传。
- **FR-039**：composition/export 不刻意常驻未使用 operation/model。
- **FR-040**：能满足能力时复用 generated runtime dependency；重复依赖需记录缺口。
- **FR-041**：应用边界能解决时不定制 template；例外记录升级维护成本。
- **FR-042**：可记录 artifact size，但无 threshold/budget/gate。
- **FR-043**：生成后 package compile-ready；secondary source 提交或由所有入口自动生成。
- **FR-044**：service URL 来自显式环境，production 不 fallback staging。
- **FR-045**：production URL 缺失/无效时安全失败；测试可 override。
- **FR-046**：普通请求显式 connect/send/receive timeout；realtime 适配长连接。
- **FR-047**：重要 inline response/composition 使用稳定表意名称。
- **FR-048**：error schema 不与语言核心 Error 冲突，wire payload 不变。
- **FR-049**：生成、secondary generation、compile、verify 依赖有评审过的版本约束，禁止 unconstrained。
- **FR-050**：package metadata 有明确 name/description/version/repository/runtime constraint，无 placeholder。
- **FR-051**：清理仅允许 canonical package/contract-cache，删除前拒绝 symlink escape 和其他路径。
- **FR-052**：fixture 覆盖 discriminator oneOf、composition、nullable/absent、多 success、204、金融 String、unknown enum、SSE。
- **FR-053**：generator/version 改动先过 fixture 并评审 diff。
- **FR-054**：一个非交互命令完成 prepare/compile/analyze/app tests，local/CI 共用。
- **FR-055**：CI cache 由 lockfile/固定版本键控，cache 不绕过验证。
- **FR-056**：项目文档替代 generated docs，解释环境、生成、验证、ownership、failure、state、realtime。
- **FR-057**：artifact 保留 generator version/config/source identity。
- **FR-058**：generated warning 与应用质量隔离，generated compile error 阻塞。
- **FR-059**：保留 host `diff -qr`；跨平台替换不在范围。
- **FR-060**：PR/main CI 使用共享命令，不重复维护质量步骤。
- **FR-061**：自动 Release 仅在同一 main SHA 完整验证后开始；手动 Release 做等价验证。
- **FR-062**：Release 验证含 rules/lint/validate/drift/prepare/compile/analyze/tests。
- **FR-063**：同 PR 旧质量运行应取消；进行中的 Release 不自动取消。
- **FR-066**：contract approval workflow 保留当前 head SHA 校验；契约变更由具备仓库写入级别权限的至少一名协作者批准即可。

## 关键实体

- **Generated Client**：契约生成的 operation/wire model，只能重生成。
- **Application Request Boundary**：配置请求、凭据、安全结果和 generated operation 的应用入口。
- **Request Failure**：server/auth/network/timeout/cancel/decode/unknown 的稳定安全分类。
- **Realtime Subscription**：可取消、恢复、按序且携带最后 event ID 的序列。
- **Transport Model**：在 repository 边界映射为 domain entity 的 wire 表示。
- **State Owner**：生命周期感知、可 override，调用 repository/use case 并暴露 immutable state/command。
- **Query State**：特定参数的 loading/data/empty/refreshing/failure。
- **Command State**：重要操作的 idle/submitting/success/failure 及防重复。

## 成功标准

- **SC-001**：FR-020 十类行为均有真实断言并通过质量门禁。
- **SC-002**：20 个并发 401 只恢复一次，每请求最多 retry 一次。
- **SC-003**：public/auth/page/financial/empty/error fixture 结果 100% 正确。
- **SC-004**：高精度金融 String 做 100 次 round-trip，文本零变化。
- **SC-005**：至少 1,000 个任意分片 event 按序恰好交付一次。
- **SC-006**：cancel 后后续 delivery/reconnect 为零。
- **SC-007**：相同输入两次生成零 diff；stale fixture 每次被检测。
- **SC-008**：普通诊断泄漏 token/stack/金融 payload 为零。
- **SC-009**：消费 request/SSE 无需 import transport exception 或解析 raw body。
- **SC-010**：query test 覆盖 initial/data/empty/refresh/failure/retry/dispose/stale suppression。
- **SC-011**：100 次竞态中旧结果覆盖新参数为零。
- **SC-012**：20 次快速 command 只执行一次；显式 retry 复用原 key。
- **SC-013**：logout 清除全部用户态并保留 public；换用户不见旧数据。
- **SC-014**：realtime 只更新相关 scope；无关 observer 通知为零。
- **SC-015**：请求/state tests 使用 override，外网连接为零。
- **SC-016**：clean generation 后 TODO-only test 和排除 docs 为零。
- **SC-017**：精简后 contract/drift/generated compile/app tests 均通过。
- **SC-018**：presentation/state import generated/DTO/Response/DioException 为零。
- **SC-019**：每个 wrapper 至少一个经过测试的非透传职责。
- **SC-020**：Release 报告 size；size 增长造成失败为零。
- **SC-021**：clean checkout 按文档 build/analyze/test，无隐藏准备步骤。
- **SC-023**：timeout/SSE longevity/cancel/recovery 使用显式策略。
- **SC-024**：optimized public schema 中 status-code name 和 Error 冲突为零。
- **SC-025**：unconstrained build dependency 和 placeholder metadata 为零。
- **SC-026**：root/无关目录/external/symlink 均在删除前拒绝。
- **SC-027**：固定版本通过 FR-052；破坏任一预期时 fixture 失败。
- **SC-028**：一个命令在 clean 环境覆盖 prepare/compile/analyze/client/state tests。
- **SC-029**：artifact 暴露 version/source identity 且可复现。
- **SC-030**：同 SHA 全部门禁通过后才 package；任一失败阻止 publish。
- **SC-031**：format/analyze/prepare/test 各有一个 CI/Release 共用命令源。
- **SC-032**：PR 新 push 取代旧 run；活动 Release 不自动 cancel。
- **SC-034**：approval workflow 仅允许具备仓库写入级别权限的至少一名协作者批准当前 head SHA；旧 SHA、最新状态非批准或无足够权限均不得通过。

## 假设

- 已合并生成实现是基线，技术栈保持 OpenAPI Generator 7.24.0 + `dart-dio`。
- generated package 提交、固定版本、做 drift check；SSE 因 continuous semantics 由应用边界实现。
- Riverpod 包装 repository/use case/SSE，不替代 Dio；Widget 不直连，Provider 不暴露 transport model。
- placeholder tests/docs 由项目行为测试和中文文档替代；不承诺 binary size 减少且不设置 gate。
- secondary source 提交并由统一流程准备；URL/timeout 由应用配置；命名优化不改变 wire/server behavior。
- 保留 `diff -qr`、当前 SHA 校验和 `@v*`；契约审批改为至少一名具备仓库写入级别权限的协作者；跨平台 diff、Release 产物 checksum 和 production URL 门禁不在范围。
