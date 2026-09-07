# 验收环境契约

## 模式选择

一次测试运行必须显式选择且只选择一种模式：

- `controlled`：默认。使用契约驱动的 Dio adapter/service fake，禁止外网和真实资产后果。
- `staging-readonly`：只运行公开/已授权 GET preflight，不执行经济命令。
- `staging-command`：仅在全部门禁通过后运行隔离账户上的命令场景。

不得在请求失败后从 staging 自动回退 controlled；这会混淆验收证据并掩盖环境故障。

## Controlled 模式

- Fixture 必须符合 `openapi/main.yaml`，经过 generated serializer、service、repository 和 Provider 链路。
- 场景覆盖成功、空数据、分页、401/403、409、422、429、503、timeout、重复命令、乱序事件和 resync。
- `NoNetworkAdapter` 必须使任何未声明外网请求立即失败。
- 每个范围内金融命令断言 method/path/body、Idempotency-Key、resource/request ID 和后续回读状态；
  订单 wallet action、funding plan、transfer 和 claim 必须保持零调用，并验证对应 capability state
  不触发 retry。
- Fixture 仅表达 transport 场景，不复制订单或资金业务规则为第二套服务端实现。

## Staging preflight

进入 `staging-command` 前必须全部满足：

1. `/v1/auth/config`、`/v1/system/app-version`、`/v1/system/disclosures` 连续成功并可按契约解析。
2. 有专用 Privy 测试身份，可建立/恢复会话并读取 `/v1/me`。
3. 后端负责人书面确认测试租户、钱包、网络和资产与生产隔离且无真实价值。
4. 测试额度、允许命令、并发限制和 teardown/reset 程序已明确。
5. 订单预览、相同幂等键回读、资源 GET 与 SSE 可用。
6. 日志只记录时间、环境、operation、HTTP status、request/resource ID，不记录 token/signature/raw body。

任一项失败时，结果为 `blocked`，只允许运行 `staging-readonly`，不得执行命令或改用生产资产。

## 当前判定（2026-09-04）

- staging 域名、TLS、API gateway 与认证拦截可达。
- 三个公开启动接口均返回 HTTP 503、code `service_unconfigured`。
- 无 token 访问受保护市场接口返回契约化 HTTP 401 `access_token_required`。
- 仓库未提供 staging 测试身份、隔离钱包或数据复位配置。

因此当前选择 `controlled`；`staging-command` 被门禁阻断。

## 通过标准

- 默认 `quality:check` 只运行确定性、零外网的 controlled 套件。
- staging 套件独立触发，环境不可用不伪装为代码通过，也不阻断默认 CI。
- SC-001 至 SC-005 的证据必须来自 controlled 套件；staging 证据作为环境兼容性补充。
- staging 恢复后，同一业务场景必须复用相同 domain 断言，不维护两套预期语义。
