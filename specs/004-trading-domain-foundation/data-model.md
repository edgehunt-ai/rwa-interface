# 数据模型：RWA 交易能力底座

本文定义应用 domain 边界。字段名称表达业务语义，不复制 generated DTO；所有外部值在 data repository
完成校验和映射。

## 通用值对象

### DecimalValue

- `value`：规范十进制字符串，允许负号但不允许指数、NaN、Infinity 或隐式舍入。
- 可选语义：`asset`、`unit`、`scale`。不同 asset/unit 的值不可直接合并。
- data boundary 必须保持 wire value 的文本精度；展示格式化属于后续 UI。

### ResourceRef

- `resourceId`：服务端资源 ID。
- `requestId`：请求关联 ID，可用于失败排查。
- `createdAt`、`updatedAt`：RFC 3339 UTC；缺失的非必需时间保持空值，不用本地时间猜测。

### DomainPage<T>

- `items`：本页有效实体。
- `nextCursor`：下一页游标；空值表示结束。
- `hasMore`：服务端声明的连续性；翻页时必须保持原查询条件和 session generation。

### DomainFailure

- `kind`：unauthorized、forbidden、validation、conflict、rateLimited、unavailable、network、unknown。
- `code`、`requestId`、`retryable`、`userAction`、安全的结构化 details。
- 不含 token、raw body、stack trace、generated exception 或敏感金融 payload。

### UnsupportedCapability

- `code`：稳定值；本阶段包含 `order_signature_not_supported` 和
  `funding_transfer_not_supported`。
- `userAction`：固定为 `wait_for_feature`；`retryable` 固定为 false。
- `resourceId`：触发该能力状态的订单或入金 ID；可选安全 details 用于未来界面解释上下文。
- 它是成功读取资源后得到的 capability state，不是 transport/domain failure，也不触发自动重试。

## 身份与账户

### ProductSession

- `sessionId`、`createdAt`、`expiresAt`、`generation`、`accountCreated`。
- 关联一个 `UserAccount`；generation 在登出或身份切换时递增。
- 过期、登出或凭证拒绝后不可授权受保护请求。

### UserAccount

- `userId`、`privyDid`、`displayName`、`avatarUri`、`createdAt`、`settings`。
- `settings` 包含 language、push 总开关及成交/失败/强平通知偏好。
- Privy 身份资料不从产品 API 重复构造；敏感凭证不属于实体字段。

### RegisteredDevice

- `deviceId`、`platform`、`appVersion`、`pushProvider`、`pushTokenRegistered`、时间字段。
- 服务端只回显是否登记，不回显 push token。

### Wallet

- `walletId`、`address`、`chain`、`status`、`createdAt`。
- status：active、verificationRequired、disabled。
- 只有 active wallet 可参与新授权；address 作为可复制完整值保存。

### WalletAuthorization

- `authorizationId`、`walletId`、`purpose`、`resourceId`、`asset`、`amount`、`status`、有效期。
- 本阶段只使用 withdrawal purpose；order、transfer、claim purpose 均属于后续功能。
- status：pending → authorized → consumed；pending/authorized 可转 expired 或 failed。
- 授权绑定确切资源和金额，不得跨命令复用。

## 市场与组合

### MarketProduct

- `symbol`、`name`、`kind`、`network`、`settlementAsset`、`tradable`、行情和更新时间。
- kind 为 bstock 时锁定 BSC/USDC 与现货语义；kind 为 perp 时锁定 Arbitrum/USDC 与合约语义。
- 可关联统计、订单簿、K 线、参考价、市场时段和用户收藏状态。

### MarketSnapshot

- `price`、24h 变化、成交量、订单簿档位、`asOf`、`isStale`、market session。
- stale 数据可保留，但不得被标记为实时价格；订单预览仍以服务端结果为准。

### Portfolio

- `totalValueUsd`、`availableToTradeUsd`、`todayPnl`、`marginInUseUsd`、`stocksValueUsd`、`updatedAt`。
- 包含多个 `TradingAccount` 与按股票分组的 `HoldingGroup`。

### TradingAccount

- `kind`：app、bstocks、hip3；`label`、`address`、`chain`、总值、可用值、占用保证金和 token balances。
- bstock 持仓与 perp 仓位不可因 symbol 相同而合并为同一 position。

### Position

- 通用：`positionId`、`symbol`、`kind`、quantity/unit、value、entry/mark price、已实现和未实现盈亏。
- perp 扩展：side、leverage、marginMode、margin、liquidationPrice、fundingPaid。
- 风险设置：takeProfit、stopLoss、stopLimit；必须符合方向相对入场价的约束。

## 订单

### OrderIntent

- 通用：symbol、kind、side、type、amount 或 quantity、limitPrice、slippage、TP/SL。
- bstock side 仅 buy/sell；perp side 仅 long/short，并可带 leverage、marginMode、reduceOnly。
- market/limit 组合必须满足契约要求；金额与数量不可同时以冲突语义出现。

### OrderPreview

- `previewId`、原始 `intent`、market/estimated price、quantity/receive、order value、fees、impact、
  settlement account、margin/liquidation、`expiresAt`。
- 过期预览不可提交；若 price updated，状态必须要求调用方重新确认。

### Order

- `orderId`、client order ID、产品/方向/类型、quantity/filled quantity、价格、order value、fee、
  position ID、tx hash、failure reason 和时间字段。
- 本阶段处理 submitted → open → partiallyFilled → filled；`pendingSignature` 映射为关联订单 ID 的
  `order_signature_not_supported`。
- submitted/open/partiallyFilled 可转 cancelled 或 failed；任何非终态可进入 ambiguous/manualReview。
- filled、cancelled、failed 是终态；ambiguous/manualReview 必须通过回读或事件继续确认，不当作成功。

## 资金

### Deposit

- `depositId`、chain、token、amount、instructions、confirmations、creditedAccount、requiresTransfer、
  tx hash、activity ID 和时间字段。
- status：awaiting → confirming → credited；awaiting/confirming 可转 failed、ambiguous、manualReview。
- ambiguous/manualReview 需权威回读，不可推断到账。
- `requiresTransfer=true` 时附带 `funding_transfer_not_supported`，不生成资金计划或划转操作。

### WithdrawalQuote

- `quoteId`、asset、chain、amount、destination、转换/桥接路径、各类 fee、estimatedReceive、
  estimatedTime、sufficient、有效期（若契约提供）。
- insufficient 或已过期报价不可创建 Withdrawal。

### Withdrawal

- `withdrawalId`、asset、chain、amount、receivedAmount、fee、address/memo、status、failure、tx hash、
  activity ID 和时间字段。
- status：pendingSignature → processing → sent → completed；非终态可转 failed、ambiguous、manualReview。
- destination、quote 与 authorization 必须绑定同一意图。

### ActivityRecord

- `activityId`、category、type、status、title/summary、关联 resource、amount/asset、tx hash、createdAt。
- category：orders、funds、signatures；status：pending、success、failed、cancelled。
- 活动用于审计展示，不替代订单、仓位或资金资源的权威状态。

## 实时同步

### RealtimeEnvelope

- `eventId`、`emittedAt`、event kind、typed payload。
- kind：price、candle、order、position、deposit、withdrawal、balance、activity、session、resyncRequired。
- 现有 transport decoder 可继续忽略或解码 transfer/claim 事件，但本功能不为它们新增 domain model、
  repository、Provider 或业务测试，也不以它们更新范围内聚合。
- eventId 在单会话流内去重；旧 generation 的 envelope 必须丢弃。

### RealtimeSubscriptionState

- phase：disconnected、connecting、connected、backingOff、resyncRequired、closed。
- `lastEventId`、attempt、nextRetryAt、failure、generation。
- `resyncRequired` 触发相关 HTTP snapshot；成功建立新基线后才回到 connected。

## 聚合关系与一致性规则

- ProductSession 1:1 UserAccount，1:N Wallet/Device；登出使所有用户聚合失效。
- MarketProduct 1:N MarketSnapshot；Portfolio 1:N TradingAccount/HoldingGroup/Position。
- OrderPreview 由一个 OrderIntent 产生，并最多创建一个经济等价 Order。
- Order 可关联 Position 或 UnsupportedCapability；本阶段不处理 Order wallet action。
- WithdrawalQuote + WalletAuthorization 创建 Withdrawal；资金准备、Transfer 和 Claim 聚合不在范围。
- ActivityRecord 引用资源但不拥有资源状态；RealtimeEnvelope 更新对应聚合后仍以 snapshot 回读为权威。
- 所有金融命令使用稳定 idempotency key；相同 key + 不同 intent 必须视为冲突。
