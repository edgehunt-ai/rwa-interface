# Riverpod 应用状态契约

## 组合与生命周期

- 应用组合根提供 environment、token owner、generated client、services、repositories 和 realtime。
- 所有依赖必须可 override；测试默认使用 no-network adapter 或手写 fake。
- public query 不依赖 session generation；账户、收藏、组合、订单、仓位、钱包、资金、活动和用户 SSE
  必须包含 generation。
- 登出、会话拒绝或身份切换递增 generation，并 invalidate 所有用户域 Provider。

## QueryState<T>

- `loading`：无可用数据的首次加载。
- `data`：已确认数据，可带 `isRefreshing` 和 `asOf`。
- `empty`：成功且无项目，不等同于 failure。
- `failure`：稳定 `DomainFailure`；刷新失败可保留旧 data 并附带非破坏性 failure。
- `data` 可附带 `UnsupportedCapability`；该状态不可重试，只向 presentation 暴露
  `wait_for_feature`，且不自动执行后续命令。
- 旧参数、旧 generation 或已 dispose 请求完成时不得提交状态。

## CommandState<I, R>

- `idle` → `submitting(intent, idempotencyKey)` → `accepted(resource)` 或 `failure`。
- accepted resource 若为 pending/ambiguous/manualReview，状态保持可跟踪，不转为 success toast 语义。
- submitting 期间相同 intent 的重复触发合并或拒绝；显式 retry 复用原 key。
- intent 发生任何经济字段变化时生成新 key，并要求重新预览/授权（如适用）。
- 成功只 invalidate 与返回资源相关的最小查询；不得全局刷新所有市场状态。

## 领域状态 owner

- 会话：当前 session/account 与 generation；登出拥有清理职责。
- 市场：按完整 query 参数 family；公共排行与用户收藏分开。
- 组合：summary/accounts/holdings 独立，可由 balance/position event 精确更新或 resync。
- 订单/仓位：列表和详情分开；event 按 ID 更新实体，终态不被较旧事件回退。
- 资金：deposit/withdrawal 各自拥有命令和详情状态；deposit 可附带
  `funding_transfer_not_supported`，不创建 transfer/claim Provider。
- 活动：分页列表只追加未重复 ID；实时活动按排序规则插入。
- realtime：按 channels + generation family；最后一个消费者释放后取消连接。

## 快照与事件协调

1. query 取得 snapshot 和基线时间/版本。
2. 刷新期间将基线之后的相关事件写入有界缓冲并按 event ID 去重。
3. snapshot 成功后替换基线，再按顺序重放仍更新的事件。
4. 缓冲溢出、断点过期、未知状态或 resyncRequired 时停止增量合并并刷新相关 snapshot。
5. generation 变化立即清空缓冲和 last event ID。

## Presentation 保证

- 状态只暴露 domain model、稳定 failure code/userAction 和可执行操作，不暴露后端文案或异常。
- 最终 UI 可独立决定布局和文案；业务状态不得依赖页面生命周期、组件层级或原型导航。
- 每个 Provider 的测试至少覆盖 loading/data/empty/failure、refresh、race/dispose 和 session isolation；
  command 额外覆盖重复触发、retry key、pending/ambiguous/manualReview。
