# 验证指南：RWA 交易能力底座

## 前置条件

- Flutter 3.47、Dart 3.13、Node.js 22 和可用 Docker daemon。
- 默认验证不需要外网、Privy token、钱包、生产 secret 或真实资产。
- 数据与状态语义见 [data-model.md](data-model.md)；应用边界见 [contracts/](contracts/)。

## 基线验证

```bash
npm ci --ignore-scripts
flutter pub get
npm run quality:check
```

预期：OpenAPI、生成客户端漂移、格式化、静态分析及现有测试全部通过；默认测试不访问 staging。

## Controlled 验收

实现后，先运行按领域组织的确定性套件：

```bash
flutter test test/data test/domain test/app/providers test/ui
```

预期场景：

1. 有效/失效会话、登出、generation 切换和旧响应隔离。
2. 市场空数据/分页/详情/收藏，组合账户和现货/合约分离，金融字符串无损 round-trip。
3. 订单预览、过期/价格更新、无需签名订单的幂等提交、取消、回读，以及仓位 TP/SL、杠杆和平仓；
   `pending_signature` 返回不可重试的 `order_signature_not_supported`，不提交 wallet action。
4. Deposit 和 withdrawal quote/command 的成功、pending、失败、ambiguous 和 manual review 路径；
   `requiresTransfer=true` 返回不可重试的 `funding_transfer_not_supported`，并断言没有 funding plan、
   transfer 或 claim 的 domain/Provider/命令调用。
5. SSE 重复、乱序、断连、Last-Event-ID、缓冲溢出和 resync；旧事件不回退终态。
6. 401/403/409/422/429/503、timeout 和 mapping failure 均转为稳定、脱敏、可恢复的 domain failure。

每个金融命令必须断言同一 intent 的 retry 复用 Idempotency-Key 且最多产生一个资源；测试中的任何意外
外网请求必须立即失败。至少 50 个代表性场景全部通过后，SC-001 至 SC-005 才有验收证据。

## Staging 只读探测

当前只允许执行无副作用的公开 GET：

```bash
curl --fail-with-body --connect-timeout 5 --max-time 15 \
  https://rwa-api-staging.dxd.ink/v1/auth/config
curl --fail-with-body --connect-timeout 5 --max-time 15 \
  https://rwa-api-staging.dxd.ink/v1/system/app-version
curl --fail-with-body --connect-timeout 5 --max-time 15 \
  'https://rwa-api-staging.dxd.ink/v1/system/disclosures?locale=zh-CN'
```

2026-09-04 实测三个请求均返回 HTTP 503 `service_unconfigured`，所以 staging command suite 当前被阻断。

## Staging 恢复后的环境验证

只有 [validation-environments.md](contracts/validation-environments.md) 的全部 preflight 门禁通过后，才可
配置专用测试身份并运行独立 staging suite。预期顺序为会话、只读市场/组合、预览、无需签名的单笔幂等
命令回读、入金/提现状态、SSE/快照恢复和测试数据复位。

staging suite 不加入默认 `quality:check`。任一门禁失败时应报告 `blocked` 并停止命令验证；不得自动切换
生产账户、生产钱包或真实资产。

## 验证记录

- 2026-09-04：Phase 9 收敛后的 controlled 验收及 `npm run quality:check` 通过；OpenAPI 规则、lint、
  generator 漂移检查、Dart 格式与静态分析均通过，Flutter 共 118 个测试通过。
- 可执行追踪矩阵包含 63 条唯一测试链接，逐项指向实际测试文件和测试名称，并覆盖 US1-US5 的 15 个
  验收场景、FR-001-FR-023 与 SC-001-SC-005；性能门禁以 100 次完整 controlled 请求链测量 p95。
- `requirement_traceability_test.dart` 为 421 行的纯声明式审计矩阵；已完成超过 400 行的职责评审。矩阵不含
  业务逻辑，保持单文件可使需求覆盖缺口由一个集合断言发现，拆分会降低全局可审计性，因此保留内聚结构。
- staging preflight 已提供独立 `npm run staging:preflight` 命令，不属于默认质量门禁；本地受控响应同时验证
  HTTP 503、授权 401 或任一隔离证明缺失会阻断命令模式，只有全部显式门禁满足才报告 command-ready。
- 本次未修改 `openapi/main.yaml` 或 `packages/rwa_api_client/`，也未加入 order wallet action、funding
  plan、transfer 或 Claim 应用入口。
