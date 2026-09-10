# HIP3 行情列表与搜索接入

基线：rwa-interface main f943e66。仅前端改动，无 OpenAPI、后端、生成客户端或数据库变更。

## 已核对的接口能力

`GET /v1/markets/products`：

| 页面条件 | 参数 | 服务端行为 |
|---|---|---|
| 全部 / bStocks / HIP3 | product_type 缺省(all) / spot / contract | 分页前过滤，不依赖股票分组 |
| Popular | group=hot | 服务端热门排名 |
| Gainers / Losers | group=gainers / losers | 24h 涨跌幅降序 / 升序；不承诺仅正 / 负值 |
| Volume | group=volume | 24h USD 成交额降序 |
| 搜索 | q | 代码/名称搜索 |
| 分页 | cursor、limit | 原样使用 next_cursor；limit 默认20、范围1–100 |

契约已定义但当前后端未实现的能力：`favorites`（未登录401，已登录仍不可用）。前端传递真实请求并呈现失败，不能从第一页伪造自选列表。

未定义能力：独立排序字段/方向、行业筛选、资金费率/未平仓量排序。本次未新增这些控件。

服务端游标当前基于实时结果集偏移量，没有分页快照保证；客户端去重可消除重复展示，不能保证排名变化期间跨页绝不遗漏，用户可下拉刷新。

## 实现范围

- service → repository → provider → Markets/发现搜索传递全部已支持条件。
- Markets 的全部/HIP3 分类与发现搜索使用独立分页状态；搜索不再只显示2条。
- HIP3-only 合约直接保留；身份为 symbol + kind，同名 bStocks/HIP3 互不去重。
- “加载更多”禁重复点击；失败保留结果和游标；末页停止；缺失/重复/循环游标可重试，不无限请求。
- 分类、排行、搜索变化从第一页开始；刷新和账号变化隔离晚到响应。
- 现有首页、All stocks 页面、Markets 的 bStocks 分类数据和排序行为不变。同页股票摘要小卡只修复固定高度溢出。
- 不涉及开仓、签名执行器、父子单、订单对账、迁移。

## 验证

针对性覆盖接口参数穿透、非首屏 HIP3、HIP3-only、去重、重复加载、失败重试、末页、异常游标、快速切换、刷新、账号变化以及大字号横竖屏。无需完整 iOS 编译；未执行真实交易。

最终针对性及相关回归合计 63 项通过；`flutter analyze --no-pub` 和 `git diff --check` 通过。
