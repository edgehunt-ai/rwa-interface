# Riverpod 状态契约

- 应用级 Provider：environment、Dio、generated client；惰性共享。
- 会话级：用户、token、SSE；logout 全量失效。
- 页面/参数级 query：family + auto-dispose，参数必须完整。
- 命令级：独立 Notifier，不与 query loading 混用。
- AsyncNotifier 调 repository，暴露 domain/ApiFailure；刷新保留旧数据；旧参数、旧 session、已
  dispose 请求不得提交。
- Submitting 时拒绝重复；同 intent retry 复用 key；成功按资源关系最小 invalidate。
- Stream Provider 只消费 typed SSE，不积累历史；Widget 用 family/select 最小监听。
- snapshot refresh 是权威基线；刷新期间只缓存有界的后续事件，按 event ID 去重，成功后重放
  基线之后的事件，溢出或断点不连续时转 resync_required。
- ProviderContainer 测状态序列、race、dispose、logout、最小通知，依赖全部可 override 且零外网。

## 多语言边界

Provider 暴露 `ApiFailure.code`/`userAction`，不暴露硬编码中文或英文文案；UI l10n 层按
locale 映射可本地化文案。
