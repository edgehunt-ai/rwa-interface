# 原生 Flutter CI 性能报告

性能测试仅运行 Android / iOS 的 **profile** 模式，不构建或运行 Web。
默认 CI 使用固定 Android 35 / x86_64 / Pixel 6 模拟器，在 PR 和 main push 时执行。
模拟器用于观察代码变更带来的趋势；真机性能结论应在固定真机上复测。

## 查看结果

打开 GitHub Actions 的 **Native Performance** 运行：

1. Summary 展示各场景 P50/P95、帧耗时、慢帧比例及退化提示。
2. 下载 `native-performance` artifact 并解压，打开 `report.html`。
3. 选择场景和指标查看 P95 基线对比、样本分布、历史趋势。报告离线可用，无需部署服务。

附件还包含 `raw.json`（逐次操作耗时、逐帧数据和设备信息）、`report.json`（汇总与对比）、
`summary.md` 和 `history.json`。HTML 是报告文件格式，与 Flutter Web 平台无关。
无完整原生数据或交互断言失败时，测量步骤失败，不生成有效性能报告。

## 覆盖的操作

共 22 个场景，执行真实页面和 Riverpod 业务流程：

| 场景 | 测量起止点 |
|---|---|
| 首页加载 | 挂载首页 → 资产总额和行情数据展示 |
| 行情加载 | 挂载行情页 → 股票入口和 60 项行情数据就绪 |
| 行情滚动 | 在真实行情列表执行 4 次、每次 300ms 的滚动手势 |
| 详情加载 | 点击股票入口 → 价格和 240 根 K 线展示 |
| 市价/限价 × 买入/卖出：面板打开 | 点击买卖按钮 → 输入面板动画完成 |
| 市价/限价 × 买入/卖出：报价更新 | 输入金额/数量 → 防抖后的报价展示 |
| 市价/限价 × 买入/卖出：确认预览 | 点击订单预览 → 确认按钮可用 |
| 市价/限价 × 买入/卖出：提交结果 | 点击确认 → 订单结果展示，并校验订单方向和类型 |
| 限价买入/卖出：撤单 | 点击详情页订单卡片撤单 → 该订单从列表移除 |

测试在 repository 边界注入固定数据，保留真实 provider/notifier 和 UI。
不调用真实 API，不签名或发送真实订单，因此数据衡量客户端交互和渲染，
不包含服务端、钱包或链上延迟。输入通过测试文本通道送入真实输入控件，不测原生键盘动画。
界面语言固定为英文。市价结果固定为成交，限价结果固定为挂单。
页面加载从已运行的测试进程进入页面开始，不是 App 冷启动。
当前不包含 HIP-3 永续下单、登录、内存、安装包体积或启动性能。

## 本地执行

需要 Flutter、Node.js，以及已连接的 Android 设备/模拟器，或 macOS 上的 iOS 真机。
iOS 真机需完成项目正常的 Xcode 签名配置；iOS 模拟器不支持这里要求的 profile 测量。
Android 构建需要可写的 Flutter SDK 插件目录；Nix 的只读 `/nix/store` SDK
可能被 Gradle 拒绝，请使用可写的 SDK 安装。CI 使用标准 Flutter SDK。

```bash
flutter pub get
npm run perf:test
flutter devices
npm run perf:run -- --device emulator-5554
npm run perf:report
```

把设备 ID 换成真机 ID 即可。脚本会拒绝 Web 和桌面设备；未指定 ID 时要求恰好一个移动设备。
结果在 `build/performance/report.html`。`perf:test` 是流程/报告逻辑验证，不产生性能结论；
其中 Widget 测试使用宽视口容纳 Flutter 的 Ahem 测试字体，实际移动视口由原生设备测量。

可用环境变量固定采样和设备池标识：

```bash
PERF_SAMPLES=20 PERF_WARMUPS=3 PERF_RUNNER_LABEL=lab-pixel6 npm run perf:run -- --device DEVICE_ID
npm run perf:report -- --baseline-dir /path/to/unpacked-main-artifact
```

默认每场景 10 次采样，先执行 2 次预热并排除预热数据；最少 5 次采样、1 次预热。
每次重新创建固定仓库和页面，避免上一次订单或持仓污染下一次结果。
测试计时包含自动化手势、等待数据就绪和必要动画时间，适合比较同一套测试，
不是单个函数的执行时间。默认 10 次采样的 nearest-rank P95 等于最大值，
评估细微退化时建议提高采样数并重复真机实验。

## 指标与基线

- 操作耗时：从触发动作到对应可用状态的 wall-clock 毫秒，统计 P50/P95/max。
- UI / 光栅帧：Flutter 引擎 `FrameTiming` 的 build/raster 耗时，按操作窗口的 buildStart 时间归属。
- 慢帧：UI 或光栅耗时超过 `1000 / refreshRate` 毫秒；同一帧只计一次。
- `total_ms` 保留帧总跨度，供原始数据分析，不作为 UI/光栅慢帧的判定依据。

CI 自动下载最近成功的 main push 报告作基线，沿 artifact 保留最近 30 次兼容报告。
首次运行或设备、Flutter SDK、runner、视口、刷新率、采样配置、fixture/场景版本不一致时，
显示“未比较”，不把不同环境的数值当成退化。过期或不存在的 artifact 不提供基线。
本地默认 runner 按主机 OS/架构区分；多台同型号设备应自行设置不同 `PERF_RUNNER_LABEL`。

退化提示条件：操作 P95 增加超过 `max(20%, 20ms)`；UI/光栅 P95 增加超过
`max(20%, 3ms)`；慢帧比例增加超过 5 个百分点。
默认只提示；workflow_dispatch 可选 `fail_on_regression`，本地可用
`npm run perf:report -- --fail-on-regression`。门禁失败时仍保存报告供查看。
共享 CI 主机有噪声，严格门禁更适合固定真机/专用 runner。

## 增加场景

在 `test/performance/performance_scenarios.dart` 中，用 `recorder.measure` 包裹真实交互，
以数据/控件实际可用作为终点，增加业务断言，并在 `scripts/performance-report.mjs`
的 `scenarioIds` 添加同名 ID。固定输入数据放在 `performance_fixture.dart`，
保持 repository 边界替换，禁止接入线上交易。
更新 Widget smoke 的场景数量；改变数据规模、等待方式、场景定义时同时提升
`performanceSuiteVersion` 和报告器支持版本，让旧数据不再作为兼容基线。

原生入口为 `integration_test/performance_test.dart`，host driver 为
`test_driver/performance_driver.dart`，无需修改生产 `main.dart`。
