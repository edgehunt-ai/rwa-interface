# Domain Repository 契约

## 通用边界

- Presentation 和 Riverpod 只依赖本文件定义的 domain port；不得接触 generated DTO、Dio、Response
  或 transport exception。
- 每个读取返回 domain value 或 `DomainPage<T>`；失败统一为 `DomainFailure`。
- 每个金融命令接收显式 intent 与 idempotency key，返回可回读的 domain resource。
- 同一 intent 的 retry 必须复用 key；相同 key 对应不同 intent 必须返回 conflict。
- 金融值保持十进制字符串及 asset/unit；repository 不做展示舍入。

## Ports

### SessionRepository

- 读取公开认证配置。
- 使用外部身份凭证建立/恢复产品会话。
- 结束会话；成功或认证已失效都触发本地用户域清理。

### AccountRepository

- 读取账户资料、设置和设备分页。
- 部分更新设置；登记或删除设备。
- 不返回身份凭证或完整 push token。

### MarketsRepository

- 查询股票/产品分页、产品详情、统计、订单簿、K 线、市场时段和参考价。
- 收藏查询依赖会话；替换、添加、删除收藏后只失效相关查询。

### PortfolioRepository

- 读取组合汇总、交易账户和按股票分组持仓。
- snapshot 是实时事件协调的权威基线。

### OrdersRepository

- 预览现货/合约 intent；验证预览有效期和价格更新标志。
- 查询订单分页/详情；用 idempotency key 创建不需要钱包签名的订单；取消订单。
- `pending_signature` 返回 `order_signature_not_supported` capability state，不调用
  `completeOrderWalletAction`。

### PositionsRepository

- 查询仓位分页/详情；更新/清除 TP/SL；关闭仓位；更新合约杠杆。
- 现货调用不得携带合约专属字段；方向规则不满足时在命令发出前失败。

### WalletsRepository

- 读取/同步钱包；仅为范围内的提现资源创建授权。
- authorization 只有 authorized 且未过期时可被对应命令消费。

### FundingRepository

- 查询/创建/读取 deposit。
- 创建 withdrawal quote；查询/创建/读取 withdrawal。
- 每个创建命令均使用独立、稳定的 idempotency key。
- `Deposit.requiresTransfer=true` 返回 `funding_transfer_not_supported` capability state。

### ActivityRepository

- 按 category、type、status 和 cursor 查询当前用户活动。
- Activity 不作为订单或资金终态的唯一依据。

### RealtimeRepository

- 按 channels 和 session generation 提供 typed event stream。
- 支持 Last-Event-ID、取消、有限退避、去重和 resyncRequired。
- 不积累无界事件历史，不在取消后交付事件。

## 映射失败规则

- 必需字段缺失、未知判别类型、无效 Decimal 或非法状态组合转换为非重试的 mapping failure，并携带
  request ID；不得用默认值伪造资源。
- 未知未来 enum 若不影响安全读取，可进入 explicit unknown 状态并要求刷新；金融命令和终态判断必须
  fail closed。
- HTTP 204 是无 body 成功；401/403 不自动转为 empty；429/503 保留 retryable 与 userAction。

## Capability state 契约

- `UnsupportedCapability` 包含稳定 `code`、`userAction=wait_for_feature`、`retryable=false` 和关联资源 ID。
- capability state 与资源一起返回，不进入 `DomainFailure`，不触发 retry、invalidate 或后续命令。
- 当前只允许 `order_signature_not_supported` 和 `funding_transfer_not_supported`。

## 明确排除

- 不调用 `completeOrderWalletAction`，不构造或猜测 `step_id`。
- 不建立 funding plan、transfer 或 claim 的 domain model、repository、Provider、命令或业务测试。
- 本功能不修改 `openapi/main.yaml` 或 `packages/rwa_api_client`。
