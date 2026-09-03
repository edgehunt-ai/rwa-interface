# 应用 API 边界契约

- Presentation/Riverpod 仅依赖 repository/use case；service 实现是唯一直接依赖 generated API 的
  应用代码。
- Public 请求无 token；authenticated 请求运行时取 token。
- GET 可在 refresh 后重放一次；mutation 仅在调用者提供 Idempotency-Key 且 body 可重放时一次。
- 204/空 body 是成功；金额 wire 字段保持 String。
- Service 不向外返回 Response 或 DioException；失败统一为 ApiFailure；repository 返回 domain。
- Production URL 必须显式有效；普通请求和 SSE timeout 分离；日志不得含 token/raw body/stack。
- 代表接口：MarketsService.listStocks、OrdersService.createOrder、SessionService.deleteSession、
  RealtimeService.subscribe。
