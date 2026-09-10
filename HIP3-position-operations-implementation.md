# HIP3 持仓操作与条件单接入

日期：2026-09-10。分支：`feat/hip3-position-order-ui`。基线：`d8910a5`。

本批代码已实现，真实测试网验收未运行。提交及合并状态以 Git 历史为准。

## 要求与证据

| 要求 | 实现 | 验证 |
|---|---|---|
| 平仓绑定当前仓位 | 专用 Hip3ClosePositionSheet 传完整 Position；repository 刷新并核对 ID/product/version/side/quantity，取得 close preview 后核对产品、方向、数量上限和限价边界，再走原 action 执行器 | 长短方向、市价/限价、非 NVDA、部分/全部、超量、错产品、仓位变化、预览重试复用测试 |
| 关闭保护腿明确撤销 | 编辑器按原有腿与开关计算 take_profit/stop_loss/both；repository 明确 clear，成功后才设置保留腿 | 一腿关闭、两腿关闭、待确认不能继续 set |
| 全仓/固定数量 | 默认 entire_position，显式输入 quantity；重新打开时读取保护订单，保留原数量及限价执行信息；不同腿尺寸不一致时要求明确选择，不静默统一 | 精确小数数量、越界拒绝、默认全仓、重开固定数量与 UI payload 测试 |
| 签名及部分成功语义 | 复用原执行器；clear/set 分别使用稳定键。触发不需再次签名，编辑/取消仍需签名；未确定状态给恢复提示，不显示全成功 | 原执行器、绑定、签名仅一次、未知广播结果恢复等回归测试；待确认表单不重复提交 |
| 挂单过滤分页 | symbol+kind+status_group=open 在服务端过滤；已知 product_id 时一并传递；每页保持订阅，去重并检查游标，刷新不保留不可观察的旧页副本 | transport 查询参数及第二页保持相同筛选、页面保留前页测试 |
| 条件单与方向 | mapOrder 保存 conditional，显示 TP/SL、触发价/参考、状态、固定或全仓模式、日期、Filled/Total 和进度；显式映射四种 side | wire→domain 映射及 Long/Short/触发价/进度 widget 测试 |

## 范围

- 只修改前端领域/数据/provider/持仓与挂单 UI；现有后端及 OpenAPI 已能表达需求，未改它们。
- `trade_screen.dart` 只新增必要 imports；未改行情/K 线主体。
- 未改资产总览、开仓表单或通用签名执行器。原工作目录已有改动未触碰。
- 清理了新 worktree 运行 Flutter 时自动产生的 Podfile/xcconfig 改动，不包含 iOS 构建变更。
- 逐笔 fills 明细展示、持仓完整风险字段/杠杆 UI、行情实时推送仍属原清单其他待办；本批只承诺条件单成交数量/进度。

## 验证结果

- 110 项定向测试通过（最终一轮）。
- `dart analyze lib test tool/hip3_position_preview_test.dart`：No issues found。
- `git diff --check`：通过。
- Flutter widget 渲染两种表单，确认手机宽度下可滚动、布局无异常；本地测试字体仍有部分按钮使用占位字形，这不是原生 iOS 字体验收，未以此声明原生视觉全部验证。
- 未使用测试账号、未发送真实交易、未完整编译 iOS。

临时 SDK 启动需要设置其现有预编译引擎版本（SDK 的 git 元信息不完整）：

```sh
FLUTTER_PREBUILT_ENGINE_VERSION=a804b261645ef8c13eb3d5c44a5c2fb0340c5539 /private/tmp/hip3-flutter-sdk/bin/flutter test --no-pub test/data/services/hip3_position_intents_test.dart test/data/services/hip3_order_list_service_test.dart test/data/services/hip3_position_action_executor_test.dart test/data/services/hip3_position_action_service_test.dart test/data/services/hip3_action_binding_test.dart test/data/repositories/hip3_position_operations_test.dart test/data/repositories/positions_repository_test.dart test/data/repositories/hip3_order_execution_repository_impl_test.dart test/ui/features/positions test/ui/features/orders/views/hip3_position_operation_widgets_test.dart test/ui/features/orders/views/trade_screen_test.dart test/ui/features/orders/providers/order_providers_test.dart test/ui/features/orders/views/bstocks_order_panel_test.dart
```

合并前应按此独立 worktree 的 diff 检查。后续行情分支也可能修改 trade_screen.dart / trade_screen_details.dart，合并时保留本批 imports、平仓入口及 HIP3 Open 分支，不能用整文件覆盖。
