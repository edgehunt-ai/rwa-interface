# 验证指南

## 前置条件

Flutter 3.47/Dart 3.13、Node 22、Docker；不需要真实后端、Privy token 或生产 secret。

## 生成与完整验证

```bash
npm ci --ignore-scripts
npm run client:generate
npm run client:check
npm run quality:check
```

修改 `openapi/main.yaml` 后，也可以用一个命令完成正式生成、`build_runner` 和完整验证：

```bash
npm run client:regenerate
```

预期：生成包 compile-ready，无 TODO tests/逐类型 docs，二次生成无 diff；统一命令完成 contract、
fixture、client compile/analyze、format/analyze 和全部 Flutter/API/Riverpod/SSE tests，零外网。

## 关键场景

1. 对 root、无关目录、外部目录、symlink 运行生成目标测试：删除前拒绝。
2. 跑 public、authenticated、20 并发 401、idempotent mutation、page、204、ApiError、malformed
   fixture：单次 refresh、最多一次安全 retry、统一失败、金额 String 不变。
3. 跑 1,000 条任意分片 SSE、heartbeat、多行、重连、resync、cancel：按序恰好一次，cancel 后
   零交付/重连。
4. ProviderContainer override 跑 query/refresh/empty/failure/race/dispose/command/logout/realtime：
   旧结果不覆盖、命令 key 正确、用户隔离、无关监听零更新。
5. 模拟完整 CI/Release：自动 Release 仅同 SHA 成功后执行，手动自验，产物含
   非门禁 size report；审批保留当前 SHA 和权限校验，`diff -qr`、action `@v*` 无其他功能变化。

## 2026-09-03 验证记录

- `npm run quality:check`：完整通过。
- `npm run client:generate`：通过；生成 132 个 `*.g.dart` model/serializer part，placeholder
  `test/`、`doc/` 均为零。
- `npm run client:check`：通过；固定契约、配置、post-process 与 secondary generation 后
  `diff -qr` 零差异。
- Node policy/fixture tests：23 项通过；root、无关目录、external 和 symlink escape 均在删除前拒绝。
- API/Riverpod/SSE tests：使用 fake/override，覆盖 20 并发 401、20 并发 command、1,000 SSE
  frame、Last-Event-ID、dedupe、cancel、resync、金融 String、204、failure 脱敏与 session 清理。
- 手写 Dart 扫描：最长 91 行，全部低于 400 行；未发现未说明 TODO、`print`/`debugPrint`、
  hard-coded secret 或把 raw token/payload 写入 diagnostics 的实现。
- `.github/workflows/contract-approvals.yml`：契约变更由任一具备仓库写入级别权限的协作者批准当前
  head SHA 即可；旧 SHA、最新状态非批准或无足够权限不得通过。继续保留 `diff -qr` 和 Action
  `@v*`。Release size 仅写 summary，不包含 checksum、production URL 阻断、阈值或失败条件。
- `dart analyze --fatal-infos`：零问题；`flutter test`：全部通过。
