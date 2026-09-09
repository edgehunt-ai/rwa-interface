<!--
同步影响报告
- 版本变更：1.1.0 -> 1.2.0
- 修改原则：
  - 模板原则 1 -> I. 规范优先与可追溯性
  - 模板原则 2 -> II. 分层架构与依赖方向
  - 模板原则 3 -> III. 正确性、测试与回归保护
  - 模板原则 4 -> IV. 安全、隐私与金融数据完整性
  - 模板原则 5 -> V. 明确、无障碍且可恢复的用户体验
- 新增原则：
  - VI. 模块化、组件复用与渲染隔离
- 新增章节：
  - 技术与产品约束
  - 开发流程与质量门禁
- 初始约束覆盖语义化主题、可复制内容、长文本和组件复用检查。
- 扩展原则 II，加入默认的 Riverpod 请求边界和明确的例外策略。
- 扩展原则 IV，要求所有用户可见的金额、Token 数量和相关金融数值统一通过项目共享格式化 API
  展示，并保护 Token decimals 与十进制精度。
- 删除章节：无；模板占位内容已替换。
- 后续 TODO：无。
- 修订理由：禁止页面和组件各自格式化金融数值，避免展示精度、Token decimals、尾零及极小非零
  金额的处理在不同界面产生偏差。
- 兼容性/迁移：新增展示必须直接使用共享格式化 API；已有或后续发现的手写金额格式化必须迁移到
  共享 formatter，并以精度边界测试保护。
-->
# RWA Interface 项目宪章

## 核心原则

### I. 规范优先与可追溯性

每个非平凡功能或行为变更 MUST 以可验证的规格开始，规格应定义用户目标、流程、边界情况、范围
和可度量的验收标准。计划、任务、测试和实现 MUST 可追溯到已批准的需求。需求变更 MUST 在完成前
同步更新受影响的产物。纯机械且不改变行为的变更 MAY 使用精简流程。

理由：RWA 产品涉及资产、金额、权限和可能不可逆的操作；团队必须在选择实现方案前先就正确行为
达成一致定义。

### II. 分层架构与依赖方向

应用 MUST 分离 presentation、业务逻辑和数据访问。UI 代码 MUST 只负责呈现状态、收集输入和表达
用户意图。业务规则 MUST NOT 依赖 widget、页面生命周期或具体的传输/存储库。外部 API model MUST
在数据边界完成映射，不得直接作为 domain model 使用。依赖 MUST 指向业务核心。例外 MUST 在功能
计划中记录范围、理由和隔离方式。

理由：稳定的边界可以限制 UI、API 和业务规则变更的影响范围，并使核心行为能够独立测试。

### III. 正确性、测试与回归保护

行为 MUST 根据风险获得相称的自动化验证：业务逻辑使用单元测试，重要 UI 状态和交互使用 widget
测试，关键身份或金融流程使用集成测试。缺陷修复 MUST 包含回归测试。适用测试 MUST 覆盖成功、失败、
空数据、边界和异步竞态。金融计算 MUST 定义精度和舍入规则，MUST NOT 使用未经评审的二进制浮点
运算。完成前格式化、分析和相关测试 MUST 通过。

理由：看起来正确的金融界面并不能证明其行为或算术结果正确。

### IV. 安全、隐私与金融数据完整性

Secret MUST NOT 出现在源码、日志、分析数据、崩溃信息或普通本地存储中。诊断信息 MUST 脱敏身份、
账户和交易数据。外部数据 MUST 经过校验。金额 MUST 保留币种、单位、精度和舍入语义，不得隐式转换。
所有用户可见的金额、余额、价格、数量、费用、盈亏和 Token 数量 MUST 使用项目批准的共享格式化 API
之一生成展示文本；Widget、页面和 feature 代码 MUST NOT 自行解析、截断、舍入或拼接这些金融数值。
Token 展示 MUST 使用契约或 domain model 提供的 decimals；缺少 decimals 时 MUST 保留原始十进制 scale，
极小非零值 MUST NOT 显示为零，且任何精度缩减 MUST 有明确、已测试的舍入或近似语义。
UI MUST 区分待处理、已确认和失败的操作，MUST NOT 推断交易最终成功。认证、授权和签名失败 MUST
以 fail closed 方式处理。安全例外 MUST 记录威胁、缓解措施、剩余风险和批准信息。

理由：金融数据泄露或损坏可能造成难以甚至无法挽回的损失。

### V. 明确、无障碍且可恢复的用户体验

页面 MUST 处理适用的 loading、empty、success、partial-data 和 failure 状态。重要操作 MUST 说明影响
并要求确认。错误 MUST 在不暴露内部细节的情况下说明恢复方式，可恢复失败 MUST 保留有效输入。支持的
页面和文字缩放 MUST 保证内容和操作可访问且不溢出。核心流程 MUST 提供语义标签、合理焦点、足够对比度
和不依赖颜色的状态提示。与用户相关的引用文本 MUST 可复制。动态文本 MUST 有明确的长内容策略，保留
重要含义。

理由：清晰、无障碍且可恢复的交互可以减少困惑和代价高昂的错误。

### VI. 模块化、组件复用与渲染隔离

代码 MUST 遵循单一职责和明确的变更边界。页面 MUST 组合流程，不得拥有可独立测试的业务逻辑。创建
组件前 MUST 检查现有 feature、shared 和 design-system 组件；语义匹配时应复用、组合或合理扩展。
跨领域提升组件层级必须有已验证的复用；禁止强行复用和配置过度的万能组件。重复模式第二次出现时
MUST 评估，并在第三次出现前提取或记录不提取的理由。频繁变化的状态 MUST 由合理范围内最小的消费者
观察；静态区域 MUST NOT 订阅无关状态。渲染优化 MUST 针对已测量的瓶颈。拆分 MUST 保持内聚的所有权。

理由：有意设计的边界可以改善导航、复用、测试和 Flutter 重建行为，同时避免用任意拆文件或推测性抽象
取代架构设计。

## 技术与产品约束

- OpenAPI 是 HTTP 契约的唯一事实来源。客户端代码 MUST NOT 假设未声明的字段、状态或保证。契约变更
  MUST 触发规格、model mapping、兼容行为和契约测试的评审。
- 应用 API 请求通常 MUST 通过 Riverpod provider/notifier 及其注入的 repository 或 use case 依赖流转。
  Widget、页面和普通业务类 MUST NOT 构造 Dio client 或直接调用生成的 API operation。启动代码、非
  Flutter isolate、传输基础设施和 focused test MAY 直接调用底层，但例外 MUST 明确、范围狭窄且有测试覆盖。
- 共享 UI MUST 分为 design-system primitive、跨 feature shared composition 和 feature-local component。
  提升到更广层级必须有经过验证的消费者和兼容语义；禁止把通用 `common/widgets` 作为杂物目录。
- 品牌色、语义色、文字样式和全局组件样式 MUST 来自 Flutter theme 或集中式语义 design token。
  Feature 和页面代码 MUST NOT 声明未经批准的 `Color(...)`、十六进制颜色或 `Colors.*` 值。透明色、
  诊断信息、第三方适配边界和 design-system 实现 MAY 例外。Token MUST 按用途命名，例如 surface、
  muted text 或 warning status，而不是按具体颜色命名。亮色、暗色和交互状态 MUST 保持语义一致。
- 间距、尺寸和局部布局值 MAY 保持局部定义。只有在它们代表既定设计尺度、确实跨屏复用或需要全局协同
  调整时，才 MUST 提升为共享 token。
- 与用户相关的标识符和诊断引用 MUST 使用项目统一的可复制文本模式或提供明确的复制操作。简短标题、
  按钮标签、导航标签和没有合理复制用途的普通说明文字无需复制。
- 动态文本组件 MUST 使用代表性长内容、本地化扩展和增大文字缩放进行验证。地址和标识符 MAY 在展示时
  中间截断，但复制操作 MUST 返回完整值。错误详情 MUST 支持换行或展开，并在安全时支持复制；紧凑控件
  截断文本时 MUST 保留可识别的操作。
- 手写 Dart 文件超过 400 行或 widget 的 `build` 方法超过 80 行时 MUST 触发职责和拆分评审。生成文件
  免除此限制。超过阈值只有在评审记录拆分会降低内聚性、清晰度或可测试性时才允许。
- 状态订阅 MUST 尽可能靠近消费状态的 widget。适用时 MUST 使用 `const` 构造函数和不可变值。不能在
  未指出受影响的 rebuild、layout、paint 或 compositing 成本时，宣称 widget 提取、`const` 或
  `RepaintBoundary` 是性能修复。
- 性能工作 MUST 从可复现的场景和测量开始。当数据量或交互延迟具有实际影响时，功能规格 MUST 定义用户
  可感知的目标。
- 新依赖 MUST 有明确的负责人和用途。重复标准库或现有项目能力的依赖 MUST NOT 在没有书面理由时添加。
- 用户可见文本 MUST 可本地化，MUST NOT 散落为未管理的字面量。
- 金融数值展示 MUST 调用 `lib/ui/core/formatters/` 下项目批准的 formatter 方法。Token 十进制金额
  MUST 使用 `TokenAmountFormatter.format`；最小单位整数 MUST 使用
  `TokenAmountFormatter.formatAtomic`；完整精度和规范化展示 MUST 通过其 `exact` 或 `normalized`
  模式选择。Presentation 代码 MUST NOT 对金融值使用 `double`、`num`、`toStringAsFixed`、直接
  `NumberFormat` 或手写小数截断。新增法币、百分比或紧凑显示需求 MUST 先扩展共享 formatter 及其
  精度测试，再由页面使用，不得在 feature 内建立旁路实现。
- 运行时失败 MUST 转换为可理解的 domain failure state；MUST NOT 向用户展示原始 exception 或 stack trace。
- 首个生产客户端功能获批前，MUST 记录支持的平台、最低系统版本和浏览器覆盖范围。

## 开发流程与质量门禁

非平凡功能 MUST 遵循 `specify -> clarify (when needed) -> plan -> tasks -> analyze -> implement`。
实现前，规格 MUST 不存在未解决的关键澄清；计划 MUST 覆盖架构边界、数据流、错误、安全影响、渲染影响
和测试；任务 MUST 可独立验证并可追溯到需求。

完成前：

- 每个验收场景 MUST 完成验证。
- 格式化、静态分析和相关自动化测试 MUST 通过。
- OpenAPI 变更 MUST 经过兼容性评审。
- 新依赖和架构复杂度 MUST 有充分理由。
- MUST 不存在未记录的 TODO、临时代码、secret 和调试日志。
- 文档和生成的 Spec Kit 产物 MUST 描述最终行为。

代码评审 MUST 检查规格合规性、分层边界、测试覆盖、安全与隐私、数值精度、状态和错误处理、无障碍、
组件所有权及渲染范围。新组件评审 MUST 确认已检查现有组件、所有权层级正确，且既不重复现有能力，也不
创建配置过度的万能组件。任何必需门禁失败都会阻止完成。

## 治理

本宪章优先于非正式开发实践、功能计划和任务描述。修订 MUST 包含理由、受影响的原则或流程、兼容性影响
和必要的迁移计划。新规则生效前 MUST 经过项目维护者的明确评审。

宪章版本遵循语义化版本：删除或不兼容地重新定义原则或治理规则时递增 MAJOR；新增原则或重大扩展时递增
MINOR；非语义澄清时递增 PATCH。每份功能计划和代码评审 MUST 包含宪章合规检查。例外 MUST 在计划中
记录准确范围、风险、备选方案、到期或隔离策略以及批准的维护者；不能仅以进度压力作为理由。

**Version**: 1.2.0 | **Ratified**: 2026-09-02 | **Last Amended**: 2026-09-04
