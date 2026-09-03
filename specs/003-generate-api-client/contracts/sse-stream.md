# SSE 流契约

## 输入与语法

`/v1/events` 使用 Bearer、可选 Last-Event-ID、`Accept: text/event-stream` 和 channels；响应按 byte
stream。接受 LF/CRLF、任意 chunk、多 frame；识别 id/event/data/retry，多行 data 用换行连接；
comment/heartbeat 忽略；空行结束 frame。

## 交付与恢复

data JSON 用 generated serializers 转 RealtimeEvent；完整成功后按 wire 顺序交付并更新 last ID。
非主动断开使用可测试、有上限指数退避；重连携带 last ID；resync_required 显式要求刷新快照；
cancel 终止 stream、timer 和后续交付。

## 错误

401 走共享认证策略；malformed/unknown incompatible 转 CompatibilityFailure；网络断开转
NetworkFailure 并按策略恢复；不泄漏 token 或 raw payload。
