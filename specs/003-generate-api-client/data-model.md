# 数据模型与状态模型

## ApiEnvironment

字段：`baseUrl`、普通请求 connect/send/receive timeout、environment。Production URL 必填、有效，
不得隐式回退 staging；测试允许显式 HTTP override。

## ApiFailure

sealed 类型：Server、Authentication、Network、Timeout、Cancelled、Decoding、Compatibility、
Unknown。安全字段：requestId?、retryable、userAction?；Server 另含 status/code/details。禁止 token、
raw body、stack trace 和未脱敏金融数据。

## DomainPage<T>

`items: List<T>`、`nextCursor: String?`；允许空页，cursor 原样保留。

## RealtimeFrame / RealtimeEnvelope

Frame 字段：id?、event?、dataLines、retry?；状态 collecting → complete/ignored/malformed。Envelope
含 eventId、eventName、typed RealtimeEvent；成功交付后才推进 lastSuccessfulEventId。

## RealtimeSubscriptionState

`idle → connecting → connected ↔ reconnecting`；可转 cancelled/failed/resyncRequired。字段包含
channels、lastSuccessfulEventId、attempt、nextDelay、failure?。

## QueryState<T>

initialLoading、data、empty、refreshingWithData、failure；身份由完整参数 + SessionGeneration 构成，
旧 generation 不得提交结果。

## CommandState<T>

`idle → submitting → success/failure`，failure 可显式 retry；含 intentId、idempotencyKey、result?、
failure?。同 intent 复用 key，新 intent 新 key，submitting 拒绝重复。

## SessionGeneration

单调递增。logout/换用户时递增并 invalidate 用户 Provider；公共 Provider 不依赖它。

## 关系

```text
Environment → Dio → Generated Client → Service → Repository → Query/Command State
SSE bytes → Frame → Envelope → relevant Provider update/invalidate
SessionGeneration → all user-scoped state

## 快照与事件协调

`QueryState` 刷新时保留当前可用数据，并记录 refresh 起始的最后 event ID。刷新期间到达的
事件进入有界 pending 队列：按 event ID 去重，超过容量或发现序列断点时转为
`resyncRequired`。权威 snapshot 成功后建立新基线，只重放基线之后的 pending 事件；snapshot
失败则保留旧数据和可恢复 failure，不提交过期结果。

## 本地化边界

`ApiFailure` 不保存翻译后的 UI 文案，只保存稳定 `code`、`userAction`、安全 details 和
request ID。presentation/l10n 层负责按 locale 选择文案；后端 message 不能替代客户端稳定
错误码。
```
