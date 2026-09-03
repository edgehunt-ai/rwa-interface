# Phase 0 研究

## 保留生成栈

**决定**：沿用 OpenAPI Generator 7.24.0 `dart-dio`、Dio、built_value、one_of 和 committed package。
**理由**：已覆盖普通 HTTP；更换会制造大规模 contract diff。
**备选**：Retrofit（第二套转换）、自定义模板（升级成本）、手写（规模不可持续）。

## 生成包可直接编译

**决定**：generation 后执行 build_runner，提交 `*.g.dart` 并纳入 drift comparison。
**理由**：当前 clean checkout 含 0 个 `.g.dart`，依赖隐式 CI 准备；源码数不等于安装包大小。
**备选**：所有入口临时生成（慢且易漏）；换 serializer（变化大且仍可能二次生成）。

## 精简产物

**决定**：禁用 api/model tests 和 docs，保留 runtime、README、metadata、serializers。
**理由**：当前各 142 个 test/doc 主要是未维护占位；真实测试属于应用边界。
**备选**：补齐 generated tests（再生成会覆盖）。

## 分层与 Riverpod

**决定**：service 隐藏 generated API，repository 映射 domain；Provider 做 DI，AsyncNotifier 管
query，Notifier 管 command，stream Provider 消费 SSE；默认 auto-dispose。
**理由**：隔离复杂度、便于 override，并限制状态生命周期与 rebuild。
**备选**：Widget/Provider 直调 API（错误和 mapping 散落）；全局 AppState（范围过大）。

## SSE

**决定**：Dio response stream + 增量 parser + generated serializer，实现 cancel、bounded backoff、
Last-Event-ID、resync-required。
**理由**：generated `Future<Response<RealtimeEvent>>` 不能表达持续 frame。
**备选**：直接使用生成方法（功能错误）；新增 SSE package（协议可自持且增加依赖）；轮询。

## 失败与重试

**决定**：sealed ApiFailure；401 single-flight，每请求最多一次；GET 可重放，mutation 仅在有
Idempotency-Key 且 body 可重放时重试。
**理由**：避免 transport 泄漏、refresh storm 和金融命令重复。
**备选**：暴露 DioException；全部重试；完全不重试。

## 配置、命名与生成安全

**决定**：生产 Base URL 必填；普通/SSE timeout 分离；inline schema 具名，Error 改 ApiError；
锁依赖和 metadata；删除 allowlist + symlink 检查；generator construct fixture。
**理由**：避免误连 staging、隐藏 timeout、脆弱类型名和误删/升级回归。
**备选**：依赖 generator 默认值或自定义模板。

## CI/Release

**决定**：共享验证命令；PR 可取消；Release 等同 SHA 完整 CI，手动自验；非门禁 size 报告和安全 cache。
**理由**：当前 Release 未准备 generated package且未继承完整 contract gate。
**备选**：多 workflow 复制步骤或保留并行 Release。

## 明确不做

保留当前 head SHA 校验，但契约变更改为至少一名具备仓库写入级别权限的协作者批准；不改
`diff -qr`、action `@v*`；不设体积门禁；不做全部页面、离线和缓存策略。

## 分析后补充决策

### 多语言

**决定**：本功能不新增 l10n 资源；failure 只携带稳定 code/action，后续本地化层按 locale
映射文案。
**理由**：请求边界和状态管理不应把中文或英文 UI 文案固化在 data 层；同时满足宪章对
用户可见文本可本地化的要求。

### Release 同 SHA

**决定**：自动发布按 `GITHUB_SHA` 查找并等待同一 commit 的完整 CI 成功结果；手动路径运行
同一 `release:verify`。
**理由**：只依赖 job 拓扑不能证明主分支 CI 已验证同一个提交。

### 快照与实时事件

**决定**：snapshot 是权威基线；refresh 期间有限缓存后续 event，按 event ID 去重并在成功后
重放；缓存溢出或断点不连续时发出 resync。
**理由**：避免实时事件覆盖快照或因 refresh 竞态丢失更新，同时不积累无限历史。

### 平台与依赖

**决定**：平台最低版本在发布配置中显式记录；所有构建依赖使用有界范围并由 lockfile 固定。
**理由**：消除“当前稳定版”和未定义浏览器范围造成的可重复性歧义。
