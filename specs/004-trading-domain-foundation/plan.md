# 实施计划：RWA 交易能力底座

**分支**：`feat/004-trading-domain-foundation` | **日期**：2026-09-04 | **规格**：[spec.md](spec.md)

## 摘要

在最终设计稿到位前，补齐账户、市场、组合、无需钱包签名的订单、仓位、钱包、入金、提现、活动和
实时同步的非 UI
能力。实现沿用现有生成客户端、数据边界和 Riverpod 组合方式，将 wire DTO/transport failure
转换为稳定 domain model、repository port 和应用状态。默认验收使用契约驱动的受控 adapter/fake；
staging 仅在隔离和可用性门禁全部通过后运行独立环境套件。

## 技术上下文

**语言/版本**：Dart 3.13.0、Flutter 3.47.0、Node.js 22

**主要依赖**：flutter_riverpod 3.4.2、Dio 5.11.0、go_router 18.0.0、生成的
`rwa_api_client` 1.0.0、built_value；不新增状态、HTTP、decimal 或 mock 依赖

**存储**：本功能不新增持久化存储；会话和查询状态保存在内存，事件断点仅在当前进程生命周期内维护；
离线缓存和敏感凭证持久化不在范围

**测试**：flutter_test/package:test、Dio `HttpClientAdapter` 场景替身、手写 repository/service
fake、Riverpod `ProviderContainer` override；默认套件禁止外网，staging 套件独立运行

**目标平台**：Flutter Android、iOS、Web、macOS、Windows、Linux；本功能不实现最终页面

**项目类型**：跨平台 Flutter 客户端 + 仓库内生成 Dart API package + Node 契约工具

**性能目标**：普通查询在受控测试中 95% 于 1 秒内进入可消费终态；1,000 条 SSE 事件按序处理且
不重复应用；20 个并发 401 只触发一次凭证刷新；取消后不再提交状态

**约束**：`openapi/main.yaml` 是 wire contract 唯一事实来源且本功能不修改它；生成文件不得手改；
金融值无损保存为十进制字符串；命令重试必须复用幂等键；最终 UI、Privy SDK 集成、真实资产操作、
资金准备/划转/Claim、订单 wallet action 和离线能力不在范围

**规模/范围**：覆盖 Auth、Account、Markets、Charts、Portfolio、Positions、Orders、Wallets、Funding
中的入金/提现、Activity 和 System 实时事件的范围内 operation；明确不实现 funding plan、transfer、
Claim 和 order wallet action。复用现有市场、订单代表性切片和 SSE 基础，新增不少于 50 个代表性场景

## 宪章检查

*GATE：Phase 0 前检查，Phase 1 后复核。*

- **规格与追踪：通过。** 设计产物映射 US1-US5、FR-001-FR-023、SC-001-SC-005；最终 UI 明确排除。
- **分层：通过。** 保持 Widget/screen → Riverpod → repository/use case → service → generated client；
  DTO、Response、DioException 不离开 data boundary。
- **正确性：通过。** 数据模型定义金融精度与状态机；单元/provider/契约驱动场景覆盖成功、失败、
  空数据、分页、并发、重复、乱序和重同步。
- **安全与隐私：通过。** 默认测试零外网；不保存 token，不记录原始 payload；staging 写操作受隔离门禁
  阻断，真实资产操作不在范围。
- **UX 状态：通过。** 虽不实现 UI，但应用状态契约完整表达 loading、empty、data、refreshing、
  submitting、pending、failure 和 recovery action。
- **模块与渲染：通过。** 按领域拆 repository/provider，状态订阅以参数和会话 generation 隔离；
  不引入全局万能状态。
- **依赖与规模：通过。** 使用现有依赖和测试替身；手写文件按职责拆分，generated 文件继续豁免。

Phase 1 复核：`data-model.md` 和三份内部契约维持上述边界；`quickstart.md` 将默认确定性验证与
staging 环境验证分离。无宪章例外或未解决澄清。

## 项目结构

### 文档

```text
specs/004-trading-domain-foundation/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── domain-ports.md
│   ├── riverpod-state.md
│   └── validation-environments.md
└── tasks.md                 # 后续由 $speckit-tasks 生成
```

### 源码

```text
lib/
├── app/providers/           # 环境、会话、service/repository 组合根
├── data/
│   ├── api/                 # 现有 Dio、鉴权、failure、SSE
│   ├── services/            # 按 API tag 的窄 generated-client adapter
│   └── repositories/        # DTO → domain、命令和分页实现
├── domain/
│   ├── models/              # 账户、市场、组合、订单、资金、活动
│   ├── repositories/        # presentation 可依赖的 ports
│   └── use_cases/           # 仅放跨 repository 的交易/资金编排
└── ui/features/*/providers/ # 查询、命令、会话和实时状态；不新增最终 views

test/
├── app/providers/
├── data/{services,repositories}/
├── domain/
├── helpers/                 # no-network adapter、场景 fixture、provider harness
└── ui/features/*/providers/

integration_test/            # 仅在 staging 门禁满足后加入独立环境套件
```

**结构决策**：沿用当前单应用分层。每个 API tag 由窄 service 隔离生成客户端，每个业务领域由
repository 映射为 domain；跨域编排只在确有多个 repository 参与时进入 use case。Provider 是 UI
唯一应用入口，本计划不创建最终页面或把原型结构固化进业务层。

## 实施阶段

### A. 会话与账户

完成 session、profile/settings、device、wallet 的 domain/service/repository/provider；保留
`PrivyAccessTokenProvider` 抽象，本阶段使用测试 token owner，不引入最终 Privy SDK。登出递增 session
generation 并清除所有用户域状态。

### B. 市场与组合

扩展现有 markets slice，覆盖产品详情、统计、订单簿、收藏、K 线、交易时段和参考价；新增 portfolio、
accounts、holdings。分页保留 cursor，金融值保持字符串，现货和合约使用判别联合而非可随意组合的字段。

### C. 订单与仓位

建立预览 → 提交 → 回读/事件更新流程；同一交易意图持有稳定幂等键。支持取消、平仓、TP/SL 和杠杆
更新；`pending_signature` 映射为 `order_signature_not_supported` capability state；`ambiguous`、
`manual_review` 始终视为未终结状态，不推断成功。

### D. 钱包、入金与提现

实现 wallet、deposit、withdrawal quote/command 和 activity。状态机只允许契约声明的迁移，资金记录
保留 asset、chain、account、amount、fee、request/resource ID 和 recovery。需要后续划转的入金映射为
`funding_transfer_not_supported` capability state。资金准备、transfer 和 claim 不建立 domain 能力。

### E. 实时协调

复用现有 SSE parser/reconnect/dedupe，将事件按实体路由到最小 Provider。快照刷新期间有界缓存后续事件；
重复 ID 丢弃，断点过期或未知状态触发权威快照重同步，旧 session 事件不得提交。

### F. 验收环境

默认套件使用契约驱动 adapter/fake，经过真实 generated client、service、repository 和 Provider，不建立
第二套业务实现。staging preflight 独立运行；只有公开启动接口可用、受控身份和隔离钱包已确认、幂等与
数据复位验证通过后，才允许执行 staging 命令套件。当前 staging 返回 `service_unconfigured`，故实施
起点使用确定性替身。

## 复杂度跟踪

无宪章违规。
