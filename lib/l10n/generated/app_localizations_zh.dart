// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get hip3ConfirmSetTp => '设置止盈';

  @override
  String get hip3ConfirmSetSl => '设置止损';

  @override
  String get hip3ConfirmCancelTp => '取消止盈';

  @override
  String get hip3ConfirmCancelSl => '取消止损';

  @override
  String get hip3ConfirmClose => '平仓';

  @override
  String get hip3ConfirmLeverageTitle => '调整杠杆';

  @override
  String get hip3ConfirmTitle => '确认 HIP3 操作';

  @override
  String get hip3ConfirmReview => '签名前请核对当前步骤。即使拒绝签名，此前已完成的步骤仍然生效。';

  @override
  String get hip3ConfirmDecline => '拒绝签名';

  @override
  String get hip3ConfirmSign => '确认并签名';

  @override
  String get hip3ConfirmLeverage => '杠杆';

  @override
  String get hip3ConfirmMargin => '保证金模式';

  @override
  String get hip3ConfirmScope => '要取消的保护单';

  @override
  String get hip3ConfirmCoverage => '保护范围';

  @override
  String get hip3ConfirmQuantity => '保护数量';

  @override
  String get hip3ConfirmTpTrigger => '止盈触发价';

  @override
  String get hip3ConfirmTpReference => '止盈参考价格';

  @override
  String get hip3ConfirmTpExecution => '止盈执行方式';

  @override
  String get hip3ConfirmTpLimit => '止盈限价';

  @override
  String get hip3ConfirmSlTrigger => '止损触发价';

  @override
  String get hip3ConfirmSlReference => '止损参考价格';

  @override
  String get hip3ConfirmSlExecution => '止损执行方式';

  @override
  String get hip3ConfirmSlLimit => '止损限价';

  @override
  String get hip3ConfirmDirection => '平仓委托方向';

  @override
  String get hip3ConfirmCloseQuantity => '平仓数量';

  @override
  String get hip3ConfirmRemaining => '剩余数量';

  @override
  String get hip3ConfirmEstimate => '预计成交价';

  @override
  String get hip3ConfirmFee => '预计手续费（USDC）';

  @override
  String get hip3ConfirmPnl => '预计已实现盈亏（USDC）';

  @override
  String get hip3ConfirmSlippage => '最大滑点（%）';

  @override
  String get hip3ConfirmEntire => '触发时的整个仓位';

  @override
  String get hip3ConfirmFixed => '固定数量';

  @override
  String get hip3ConfirmPercent => '仓位比例';

  @override
  String get hip3ConfirmBuyClose => '买入平空';

  @override
  String get hip3ConfirmSellClose => '卖出平多';

  @override
  String get hip3ConfirmMarket => '市价';

  @override
  String get hip3ConfirmLimit => '限价';

  @override
  String get hip3ConfirmMark => '标记价格';

  @override
  String get hip3ConfirmCross => '全仓保证金';

  @override
  String get hip3ConfirmIsolated => '逐仓保证金';

  @override
  String get hip3ConfirmBoth => '止盈和止损';

  @override
  String hip3ConfirmValidUntil(String time) {
    return '有效期至 $time（本地时间）';
  }

  @override
  String get hip3PendingTitle => '未完成的 HIP3 操作';

  @override
  String get hip3PendingRefresh => '刷新操作';

  @override
  String get hip3PendingLoading => '正在加载未完成的操作…';

  @override
  String get hip3PendingLoadError => '无法加载操作，请刷新重试。';

  @override
  String get hip3PendingEmpty => '本页没有未完成的持仓操作。';

  @override
  String get hip3PendingMore => '加载更多操作';

  @override
  String get hip3PendingContinue => '继续操作';

  @override
  String get hip3PendingCheck => '查询进度';

  @override
  String get hip3PendingBusy => '正在查询操作…';

  @override
  String get hip3PendingReview => '需要人工处理。请勿创建替代操作，请提供操作 ID 联系客服。';

  @override
  String get hip3PendingSignature => '等待你的签名';

  @override
  String get hip3PendingProcessing => '正在核对交易所结果';

  @override
  String get hip3PendingUnavailable => '此操作无法在这里继续。';

  @override
  String get hip3PendingError => '无法继续，请刷新后重试同一个操作。';

  @override
  String get hip3PendingStillActive => '操作尚未完成，请继续此操作，不要重复创建。';

  @override
  String get hip3PendingComplete => '操作已确认';

  @override
  String get hip3PendingSetTpsl => '设置或修改止盈止损';

  @override
  String get hip3PendingClearTpsl => '取消止盈止损';

  @override
  String get hip3PendingLeverage => '调整杠杆';

  @override
  String get hip3PendingClose => '平仓';

  @override
  String get hip3PendingEffects => '此前的步骤已生效。';

  @override
  String get appTitle => 'RWA 交易界面';

  @override
  String get homeTitle => '应用首页';

  @override
  String get openDetails => '打开详情';

  @override
  String get detailsTitle => '导航详情';

  @override
  String get pageNotFoundTitle => '页面不存在';

  @override
  String get pageNotFoundMessage => '此地址不对应应用中的页面。';

  @override
  String get returnHome => '返回首页';

  @override
  String get loadingLabel => '加载中';

  @override
  String get copyLabel => '复制';

  @override
  String get copySucceeded => '已复制';

  @override
  String get copyFailed => '复制失败';

  @override
  String get cancel => '取消';

  @override
  String get assetsTitle => '资产';

  @override
  String get homePortfolio => '投资组合';

  @override
  String get marketsTitle => '市场';

  @override
  String get deposit => '充值';

  @override
  String get withdraw => '提现';

  @override
  String get selectAsset => '选择资产';

  @override
  String get searchAssets => '搜索资产';

  @override
  String get availableToWithdraw => '可提现';

  @override
  String get withdrawUsdc => '提现 USDC';

  @override
  String get recipientAddress => '收款地址';

  @override
  String get enterWalletAddress => '输入钱包地址';

  @override
  String get amount => '金额';

  @override
  String get network => '网络';

  @override
  String get networkFee => '网络费用';

  @override
  String get reviewWithdrawal => '确认提现';

  @override
  String get preparingWithdrawal => '正在准备提现…';

  @override
  String get withdrawalDetails => '提现详情';

  @override
  String get recipientReceives => '收款方实际到账';

  @override
  String get totalDeducted => '总扣除金额';

  @override
  String get authorizationRequired => '需要授权';

  @override
  String get depositCrypto => '充值加密资产';

  @override
  String get allSupportedAssets => '全部支持的资产';

  @override
  String get loadingAssets => '正在加载资产';

  @override
  String get assetsUnavailable => '资产不可用';

  @override
  String get portfolioValue => '投资组合价值';

  @override
  String get allocation => '资产配置';

  @override
  String get cash => '现金';

  @override
  String get bstocks => 'bStocks';

  @override
  String get perps => '永续合约';

  @override
  String get cashBalances => '现金余额';

  @override
  String get buy => '买入';

  @override
  String get sell => '卖出';

  @override
  String get balance => '余额';

  @override
  String get orderValue => '订单金额';

  @override
  String get estimatedFee => '预估费用';

  @override
  String get orderType => '订单类型';

  @override
  String get market => '市价';

  @override
  String get limit => '限价';

  @override
  String get orderSubmitted => '订单已提交';

  @override
  String get availableMargin => '可用保证金';

  @override
  String get orderNotional => '订单名义价值';

  @override
  String get preparingOrder => '正在准备订单…';

  @override
  String get submitting => '正在提交…';

  @override
  String get checkingOrder => '正在检查订单…';

  @override
  String get tradeSuccessful => '交易成功';

  @override
  String get long => '做多';

  @override
  String get short => '做空';

  @override
  String get closePosition => '平仓';

  @override
  String get closeAmount => '数量';

  @override
  String get quantity => '数量';

  @override
  String get slippage => '滑点';

  @override
  String get validOrderValue => '请输入有效的订单金额。';

  @override
  String get validLimitPrice => '请输入有效的限价。';

  @override
  String get prepareOrderFailed => '无法准备订单，请重试。';

  @override
  String get prepareFundingFailed => '无法准备资金，请重试。';

  @override
  String get willReceive => '预计到账';

  @override
  String get slippageTolerance => '滑点容差';

  @override
  String get maximumSlippage => '最大滑点';

  @override
  String get editSlippage => '编辑滑点';

  @override
  String get priceChangedReview => '价格已变化，请确认更新后的预估值再提交。';

  @override
  String get viewHistory => '查看历史';

  @override
  String get chooseMarginLeverage => '请选择支持的保证金模式和杠杆后再请求签名。';

  @override
  String get settingsNotConfirmed => '设置尚未确认。请继续相同请求后再开仓。';

  @override
  String get enterOrderValue => '请输入订单金额。';

  @override
  String get enterValidOrderValues => '请输入有效的订单参数。';

  @override
  String get orderQuoteUnavailable => '报价不可用或已过期，请返回并重新请求报价。';

  @override
  String get walletConnectRequired => '请连接此订单要求的钱包。';

  @override
  String get signatureCancelled => '签名请求已取消。';

  @override
  String get retry => '重试';

  @override
  String get close => '关闭';

  @override
  String get checkOrderStatus => '检查订单状态';

  @override
  String get invalidSlippage => '请输入 0% 到 100% 之间的滑点。';

  @override
  String get liquidationPrice => '强平价格';

  @override
  String get marginRequired => '所需保证金';

  @override
  String get maximumQuantity => '最大数量';

  @override
  String get marginMode => '保证金模式';

  @override
  String get leverage => '杠杆';

  @override
  String get dragToSetLeverage => '拖动设置杠杆';

  @override
  String get add => '添加';

  @override
  String get remove => '移除';

  @override
  String get cross => '全仓';

  @override
  String get isolated => '逐仓';

  @override
  String marginModeLabel(Object mode) {
    return '$mode保证金模式';
  }

  @override
  String get addFundsFrom => '入金方式：';

  @override
  String get inAppTransfer => '应用内转账';

  @override
  String get externalDeposit => '外部充值';

  @override
  String get transfer => '转账';

  @override
  String get availableBalance => '可用余额';

  @override
  String get loadMore => '加载更多';

  @override
  String get refreshOrders => '刷新订单';

  @override
  String get openOrdersUnavailable => '未能加载未完成订单';

  @override
  String get noOpenOrders => '暂无未完成订单';

  @override
  String get liquidation => '强平';

  @override
  String get protectionSize => '保护数量';

  @override
  String get entirePositionDefault => '全部';

  @override
  String get fixedQuantity => '固定数量';

  @override
  String get portfolioTrend => '投资组合走势';

  @override
  String get loadingMarkets => '正在加载市场';

  @override
  String get marketsUnavailable => '市场不可用';

  @override
  String get noProductsYet => '暂无产品';

  @override
  String get favorites => '自选';

  @override
  String get popular => '热门';

  @override
  String get gainers => '涨幅榜';

  @override
  String get losers => '跌幅榜';

  @override
  String get volume => '成交量';

  @override
  String get editTpSl => '编辑止盈止损';

  @override
  String get takeProfit => '止盈';

  @override
  String get stopLoss => '止损';

  @override
  String get price => '价格';

  @override
  String get takeProfitStopLoss => '止盈/止损';

  @override
  String get takeProfitStopLossTitle => '止盈 & 止损';

  @override
  String get change => '变动';

  @override
  String get hip3OrderTpSl => '本单止盈止损';

  @override
  String get hip3PositionTpSl => '持仓止盈止损';

  @override
  String get hip3PositionProtectionScope =>
      '这里只管理持仓止盈止损。开仓时附带的本单止盈止损独立存在，请在订单中查看其激活状态和数量；这里为空不代表所有保护都不存在。';

  @override
  String get bstocksTpSlUnavailable => 'bStocks 订单暂不支持止盈/止损。';

  @override
  String get saveTpSl => '保存止盈/止损';

  @override
  String get tpSlPriceHint => '输入此持仓的触发价格。';

  @override
  String get tpSlSaveFailed => '无法保存止盈/止损。请检查价格后重试。';

  @override
  String get orderSubmissionFailed => '订单未提交成功，请重试。';

  @override
  String get marketPrice => '市价';

  @override
  String get estimatedPrice => '预估价格';

  @override
  String get submittingOrder => '正在提交订单…';

  @override
  String get submittingOrderDescription => '这可能需要一些时间。你可以在详情页查看进度。';

  @override
  String get closeViewLater => '关闭，稍后查看';

  @override
  String get back => '返回';

  @override
  String get limitPrice => '限价';

  @override
  String get dragToSet => '拖动设置';

  @override
  String get priceDeviation => '价格偏差';

  @override
  String get confirm => '确认';

  @override
  String get tradeUsStockReference => '美股参考价';

  @override
  String get tradePremium => '溢价';

  @override
  String get tradeSpread => '价差';

  @override
  String get tradeBestBidAsk => '最优买价 / 卖价';

  @override
  String get tradeAssetRights => '资产与权益';

  @override
  String get tradeAssetRightsDescription =>
      '提供对标的 NVIDIA 证券的经济敞口。你在 BSC 钱包中持有链上证券代币，并不直接拥有 NVIDIA 股票。';

  @override
  String get tradeIssuer => '发行方';

  @override
  String get tradeIssuerValue => 'BTECH Holdings Limited';

  @override
  String get tradeBacking => '资产支持';

  @override
  String get tradeBackingValue => '由标的股票 1:1 支持';

  @override
  String get tradeCorporateActions => '公司行为';

  @override
  String get tradeCorporateActionsValue => '通过乘数自动反映';

  @override
  String get tradeDividendTreatment => '股息处理';

  @override
  String get tradeDividendTreatmentValue => '净股息自动再投资';

  @override
  String get tradeVotingRights => '投票权';

  @override
  String get tradeVotingRightsValue => '不享有股东投票权';

  @override
  String get tradeAssetLocation => '资产位置';

  @override
  String get tradeAssetLocationValue => '存放于 BSC 钱包';

  @override
  String get tradeMarketHoursTitle => '美股交易时段';

  @override
  String get tradeMarketHoursDescription => '市场关闭表示不可交易时段，包括周末、美国节假日和每日结算窗口。';

  @override
  String get tradePreMarket => '盘前';

  @override
  String get tradeRegularMarket => '常规交易时段';

  @override
  String get tradeAfterHours => '盘后';

  @override
  String get tradeOvernight => '隔夜';

  @override
  String get tradeMarketClosed => '市场关闭';

  @override
  String get tradeMediumLiquidity => '中等流动性';

  @override
  String get tradeHighLiquidity => '高流动性';

  @override
  String get tradeLowLiquidity => '低流动性';

  @override
  String get tradeMarketOpensIn => '美股市场将在 04:30:11 后开盘';

  @override
  String get tradeMarketClosedSchedule => '周末、美国节假日';

  @override
  String get tradeReferencePrice => '美股参考价';

  @override
  String get tradeReferenceValue => 'US \$175.22';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLoading => '正在加载设置';

  @override
  String get settingsUnavailable => '设置不可用';

  @override
  String get settingsRetry => '下拉刷新后重试。';

  @override
  String get settingsActiveAccount => '当前账户';

  @override
  String get settingsPasskey => '通行密钥';

  @override
  String get settingsPasskeyNotSet => '未设置';

  @override
  String get settingsPasskeyNotSetUp => '未设置';

  @override
  String get settingsPasskeyEnabled => '已启用';

  @override
  String get settingsPasskeyDescription => '使用面容 ID、触控 ID 或设备安全验证，更快登录。';

  @override
  String get settingsPasskeySetupTitle => '设置通行密钥';

  @override
  String get settingsPasskeySetupDescription => '使用面容 ID、触控 ID 或设备安全验证，更快登录。';

  @override
  String get settingsPasskeyRemoveDescription => '此账户已启用通行密钥。';

  @override
  String get settingsPasskeyExistingMethods => '现有登录方式仍可继续使用。';

  @override
  String get settingsPasskeySetUpAction => '设置';

  @override
  String get settingsPasskeyRemoveAction => '移除通行密钥';

  @override
  String get settingsNotNow => '暂不设置';

  @override
  String get settingsPasskeySetupSucceeded => '通行密钥设置成功';

  @override
  String get settingsPasskeySetupFailed => '通行密钥设置失败，请重试。';

  @override
  String get settingsPasskeyRemoveSucceeded => '通行密钥已移除';

  @override
  String get settingsPasskeyRemoveFailed => '无法移除通行密钥，请重试。';

  @override
  String get settingsLanguage => '语言';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageSimplifiedChinese => '简体中文';

  @override
  String get settingsExportPrivateKey => '导出私钥';

  @override
  String get settingsPrivateKeyWarning => '切勿向任何人透露你的私钥。获得该信息的人可以控制你的钱包。';

  @override
  String get settingsCheckUpdates => '检查更新';

  @override
  String get settingsAppVersion => '应用版本';

  @override
  String get settingsUpToDate => '当前已是最新版本。';

  @override
  String get settingsUpdateCheckFailed => '无法检查更新。';

  @override
  String get settingsUpdateUnavailable => '此平台没有可用的更新来源。';

  @override
  String get settingsUpdateAvailable => '发现新版本';

  @override
  String settingsUpdateAvailableMessage(Object version) {
    return '版本 $version 已可更新。';
  }

  @override
  String get settingsUpdateNow => '立即更新';

  @override
  String get settingsCacheSize => '缓存大小';

  @override
  String get settingsClearCache => '清除';

  @override
  String get settingsTermsConditions => '条款与条件';

  @override
  String get settingsLogOut => '退出登录';

  @override
  String get settingsLogOutQuestion => '确定要退出登录吗？';

  @override
  String get settingsDeleteAccount => '删除账户';

  @override
  String get settingsDeleteAccountMessage =>
      '此操作将申请永久删除产品账户及依法允许删除的产品数据，但不会删除钱包、链上资产或区块链历史。';

  @override
  String get settingsDeleteAccountConfirm => '删除账户';

  @override
  String get settingsDeleteAccountAccepted => '账户删除申请已提交，你已退出登录。';

  @override
  String get settingsDeleteAccountRecentAuth => '为保障安全，请退出后重新登录，再申请删除账户。';

  @override
  String get settingsDeleteAccountBlocked =>
      '账户仍有未结订单、仓位、在途资金、可提现资产或待审核事项，请处理后重试。';

  @override
  String get settingsDeleteAccountFailed => '无法提交账户删除申请，请稍后重试。';

  @override
  String get activityTitle => '活动';

  @override
  String get activityAllProducts => '全部产品';

  @override
  String get activityType => '类型';

  @override
  String get activityStatus => '状态';

  @override
  String get activityFilterStatus => '筛选状态';

  @override
  String get activityAllStatuses => '全部状态';

  @override
  String get activityOrders => '订单';

  @override
  String get activityFunding => '资金费';

  @override
  String get activityApprovals => '授权';

  @override
  String get activityInProgress => '处理中';

  @override
  String get activityCompleted => '已完成';

  @override
  String get activityFailed => '失败';

  @override
  String get activityCancelled => '已取消';

  @override
  String get activityUnknown => '未知';

  @override
  String get activityLoading => '正在加载活动';

  @override
  String get activityUnavailable => '活动不可用';

  @override
  String get activityRetry => '下拉刷新后重试。';

  @override
  String get activityEmptyTitle => '暂无活动';

  @override
  String get activityEmptyMessage => '你的订单和入金事件会显示在这里。';

  @override
  String get activityCopyReference => '复制活动参考号';

  @override
  String get tradeBasis => '基差';

  @override
  String get tradePerpAssetRightsDescription =>
      '永续合约仅提供 NVIDIA 的价格敞口，不授予股票、链上证券代币或公司股东权益。';

  @override
  String get tradeProductType => '产品类型';

  @override
  String get tradePerpProductType => 'HIP-3 永续合约';

  @override
  String get tradeUnderlyingExposure => '标的敞口';

  @override
  String get tradePriceExposureOnly => '仅价格敞口';

  @override
  String get tradeShareOwnership => '股票所有权';

  @override
  String get tradeNoShareOwnership => '不拥有标的股票';

  @override
  String get tradeDividendRights => '股息权利';

  @override
  String get tradeNone => '无';

  @override
  String get tradePositionType => '持仓类型';

  @override
  String get tradePerpPositionType => 'HIP-3 永续合约持仓';

  @override
  String get navigationHome => '首页';

  @override
  String get navigationMarkets => '市场';

  @override
  String get navigationAssets => '资产';

  @override
  String get navigationActivity => '活动';

  @override
  String get requestFailed => '请求失败';

  @override
  String get noFavoritesYet => '暂无自选';

  @override
  String get favoritesEmptyDescription => '点击任一市场的星标，即可将其保存到这里。';

  @override
  String get exploreMarkets => '探索市场';

  @override
  String get searchMarkets => '搜索市场';

  @override
  String get searchTickerOrCompany => '搜索股票代码或公司名称';

  @override
  String get products => '产品';

  @override
  String get loadingProducts => '正在加载产品';

  @override
  String get pullToRefreshRetry => '下拉刷新后重试。';

  @override
  String get noMatchingProducts => '没有匹配的产品';

  @override
  String get tryAnotherSearchOrFilter => '请尝试其他搜索词或产品筛选条件。';

  @override
  String get usMarket => '美股市场';

  @override
  String get usMarketStatus => '美股市场状态';

  @override
  String get marketHours => '市场交易时段';

  @override
  String get stocks => '股票';

  @override
  String get browseAll => '查看全部';

  @override
  String get filterProducts => '筛选产品';

  @override
  String get allProducts => '全部产品';

  @override
  String get hip3Perps => 'HIP-3 永续合约';

  @override
  String openTradeDetails(Object symbol) {
    return '打开 $symbol 的交易详情';
  }

  @override
  String get clearSearch => '清除搜索';

  @override
  String get loadingRecentSearches => '正在加载最近搜索';

  @override
  String get recentSearches => '最近搜索';

  @override
  String get results => '搜索结果';

  @override
  String get noRecentSearches => '暂无最近搜索';

  @override
  String get browseAllStocks => '查看全部股票';

  @override
  String get allStocks => '全部股票';

  @override
  String get loadingStocks => '正在加载股票';

  @override
  String get stocksUnavailable => '股票不可用';

  @override
  String get marketCatalogUnavailable => '市场目录可用后请重试。';

  @override
  String get noMatchingMarkets => '没有匹配的市场';

  @override
  String get tryAnotherTickerOrCompany => '请尝试其他股票代码或公司名称。';

  @override
  String get noStocksFound => '未找到股票';

  @override
  String searchResultCount(num count) {
    return '$count 个结果';
  }

  @override
  String get history => '历史记录';

  @override
  String get closeDepositRoutes => '关闭充值路线';

  @override
  String get depositChooseRoute => '选择推荐的路线，或浏览全部支持的资产。';

  @override
  String get depositRoutesUnavailable => '充值路线不可用';

  @override
  String get noDepositRoutes => '没有可用的充值路线';

  @override
  String get tryAgainLater => '请稍后重试。';

  @override
  String depositOn(Object token, Object chain) {
    return '在 $chain 上充值 $token';
  }

  @override
  String bestFor(Object product) {
    return '最适合 $product';
  }

  @override
  String get allSupportedAssetsDescription => '选择其他可用的资产和网络';

  @override
  String get depositRouteRequired => '需要选择充值路线';

  @override
  String get depositRouteRequiredDescription => '请选择支持的路线以获取充值地址。';

  @override
  String get loadingDepositInstructions => '正在加载充值说明';

  @override
  String get depositInstructionsUnavailable => '充值说明不可用';

  @override
  String get returnToDepositRoutes => '请返回充值路线后重试。';

  @override
  String get depositAssets => '充值资产';

  @override
  String get depositReceived => '充值已到账';

  @override
  String get gotIt => '知道了';

  @override
  String get backToDepositRoutes => '返回充值路线';

  @override
  String get depositQrCode => '充值二维码';

  @override
  String get depositAddress => '充值地址';

  @override
  String get routeDetails => '路线详情';

  @override
  String sendTokenOnChainOnly(Object token, Object chain) {
    return '请仅在 $chain 上发送 $token。';
  }

  @override
  String get minimumDeposit => '最低充值金额';

  @override
  String get estimatedArrival => '预计到账时间';

  @override
  String get confirmationsRequired => '所需确认数';

  @override
  String get loadingSupportedAssets => '正在加载支持的资产';

  @override
  String get supportedAssetsUnavailable => '支持的资产不可用';

  @override
  String get noAdditionalDepositRoutes => '没有更多可用的充值路线';

  @override
  String withdrawToken(Object token) {
    return '提现 $token';
  }

  @override
  String get enterRecipientAddressAndAmount => '请输入收款地址和金额。';

  @override
  String get enterValidWalletAddress => '请输入有效的钱包地址。';

  @override
  String enterValidTokenAmount(Object token) {
    return '请输入有效的 $token 金额。';
  }

  @override
  String get prepareWithdrawalFailed => '无法准备此次提现，请重试。';

  @override
  String get paste => '粘贴';

  @override
  String get max => '最大';

  @override
  String availableToken(Object token) {
    return '可用 $token';
  }

  @override
  String availableTokenAmount(Object amount, Object token) {
    return '可用 $amount $token';
  }

  @override
  String get networkFeesMayChange => '确认前网络费用可能发生变化。';

  @override
  String get youAreSending => '你将发送';

  @override
  String get to => '收款方';

  @override
  String get finalNetworkFeeMayVary => '最终网络费用可能略有不同。';

  @override
  String get unableToLoadAssets => '无法加载资产';

  @override
  String get checkConnectionRetry => '请检查网络连接后重试。';

  @override
  String get noAssetsAvailable => '没有可用资产';

  @override
  String get noMatchingAssets => '没有匹配的资产';

  @override
  String get assetsWithBalanceAppearHere => '有可用余额的资产将显示在这里。';

  @override
  String get tryDifferentAssetOrNetwork => '请尝试其他资产名称或网络。';

  @override
  String get token => '代币';

  @override
  String get logIn => '登录';

  @override
  String get portfolioUnavailable => '无法加载你的投资组合';

  @override
  String get marketsLoadFailed => '无法加载市场';

  @override
  String get openSettings => '打开设置';

  @override
  String get readyWhenYouAre => '随时可以开始';

  @override
  String get loginToViewPortfolio => '登录后即可查看投资组合并开始交易。';

  @override
  String get loginToViewAssets => '登录后查看你的资产';

  @override
  String get portfolioBalancesAppearHere => '你的投资组合和余额将显示在这里。';

  @override
  String get noAssetsYet => '暂无资产';

  @override
  String get depositToBuildPortfolio => '充值支持的资产以开始构建投资组合。';

  @override
  String get viewPortfolioTrend => '查看投资组合走势';

  @override
  String get collapseAllocation => '收起资产配置';

  @override
  String get expandAllocation => '展开资产配置';

  @override
  String get allocationUnavailable => '资产配置不可用';

  @override
  String get noCashBalances => '暂无现金余额';

  @override
  String get cashBalancesUnavailable => '现金余额不可用';

  @override
  String get depositToAddCash => '充值支持的资产后，现金会显示在这里。';

  @override
  String get loadingCashBalances => '正在加载现金余额';

  @override
  String get loadingHoldings => '正在加载持仓';

  @override
  String get holdingsUnavailable => '持仓不可用';

  @override
  String get holdingReturn => '持仓收益';

  @override
  String noHoldings(Object title) {
    return '没有 $title 持仓';
  }

  @override
  String get buyBstockToSeeHere => '买入 bStock 后将在这里显示。';

  @override
  String get openPerpsPositionToSeeHere => '开立永续合约仓位后将在这里显示。';

  @override
  String get perpsEquity => '永续合约权益';

  @override
  String get enterConfirmationCode => '输入确认码';

  @override
  String get signUpOrLogIn => '注册或登录以开始探索';

  @override
  String emailCodeSent(Object email) {
    return '请检查发送至 $email 的 privy.io 邮件，然后输入下方验证码。';
  }

  @override
  String get didntGetEmail => '没有收到邮件？';

  @override
  String get resendCode => '重新发送验证码';

  @override
  String get codeResent => '验证码已重新发送';

  @override
  String get continueWithPrivy => '使用 Privy 继续';

  @override
  String get enterValidEmail => '请输入有效的邮箱地址。';

  @override
  String get otherSocials => '其他社交账号';

  @override
  String get wallet => '钱包';

  @override
  String get recent => '最近使用';

  @override
  String get loginOrSignUp => '登录或注册';

  @override
  String get termsAgreement => '使用本应用即表示你同意条款与条件。';

  @override
  String get invalidConfirmationCode => '验证码无效或已过期。';

  @override
  String get networkUnavailableRetry => '网络不可用，请检查连接后重试。';

  @override
  String get browserSignInUnavailable => '无法启动社交账号登录。请检查浏览器和网络后重试。';

  @override
  String get privyNotConfigured => '此构建尚未配置 Privy。';

  @override
  String get sessionExpiredLogin => '你的会话已过期，请重新登录。';

  @override
  String get backendSessionFailed => 'Privy 登录成功，但无法创建 RWA 会话，请稍后重试。';

  @override
  String get walletSyncFailed => '你已登录，但钱包无法同步，请稍后重试。';

  @override
  String get emailLoginUnavailable => '邮箱登录不可用。';

  @override
  String get privyPlatformUnsupported => 'Privy 登录仅支持 Android 和 iOS。';

  @override
  String get privyUnavailable => 'Privy 暂时不可用，请稍后重试。';

  @override
  String supportId(Object id) {
    return '支持编号：$id';
  }

  @override
  String changeSymbolLeverage(Object symbol) {
    return '调整 $symbol 杠杆';
  }

  @override
  String get accountChangedReopenPosition => '账户已切换，请关闭此面板后重新打开仓位。';

  @override
  String get tradingContextUnavailable => '交易上下文不可用。';

  @override
  String get tradingContextReload => '交易上下文不可用，请重新加载后再调整杠杆。';

  @override
  String get reload => '重新加载';

  @override
  String currentMaximumLeverage(Object current, Object maximum) {
    return '当前：$current · 最大：$maximum';
  }

  @override
  String get leverageSignatureNotice => '调整杠杆需要钱包签名，且会保留当前保证金模式。';

  @override
  String get leverageChangesUnavailable => '此账户或产品无法调整杠杆。';

  @override
  String get validLeverageRequired => '请输入不超过当前最大值的整数，或重新加载已过期的限制。';

  @override
  String get reloadLimits => '重新加载限制';

  @override
  String get waitingForConfirmation => '正在等待确认…';

  @override
  String get reviewAndSign => '审核并签名';

  @override
  String get leverageUpdated => '杠杆已更新，正在刷新仓位和交易上下文。';

  @override
  String get leveragePending => '杠杆尚未确认，请关闭此面板并在待处理操作中继续原操作。';

  @override
  String get leverageNotConfirmed => '杠杆未确认，请先检查待处理操作再重试。';

  @override
  String get direction => '方向';

  @override
  String get entryPrice => '开仓价';

  @override
  String get markPrice => '标记价格';

  @override
  String get unrealizedPnl => '未实现盈亏';

  @override
  String get returnOnEquity => '净值回报率';

  @override
  String get margin => '保证金';

  @override
  String get cumulativeFunding => '累计资金费';

  @override
  String get fundingExplanation => '资金费：负数为支付，正数为收取。';

  @override
  String get changeLeverage => '调整杠杆';

  @override
  String get openOrdersRefreshHint => '请刷新未完成订单后重试。';

  @override
  String get openOrdersEmptyDescription => '此产品的未完成订单将显示在这里。';

  @override
  String get cancelling => '正在取消…';

  @override
  String get cancellationPending => '取消操作仍在确认中，请刷新后再重试。';

  @override
  String get cancellationFailed => '取消操作未完成，请刷新后重试；可能仍需要签名。';

  @override
  String get parentCancelWarning =>
      '如果此订单附带止盈止损，取消母单也会取消该保护。请检查剩余仓位的保护单；系统不会自动创建替代保护。';

  @override
  String get conditionalOrder => '条件订单';

  @override
  String get protectionInactive => '保护已失效';

  @override
  String get protectionNotSubmitted => '保护尚未提交';

  @override
  String get protectionWaitingForParent => '保护正在等待母单成交，尚未生效';

  @override
  String get protectionAwaitingConfirmation => '保护激活等待确认';

  @override
  String get protectionActive => '保护已生效';

  @override
  String get protectionStatusUnknown => '保护状态未知，尚未确认生效';

  @override
  String attachedToOrder(Object id) {
    return '附加至订单：$id';
  }

  @override
  String get parentCancelledProtectionWarning =>
      '母单已取消：此保护已失效。请检查剩余仓位的保护单；系统不会自动创建替代保护。';

  @override
  String triggerPrice(Object price, Object reference) {
    return '触发价格：$price USDC · $reference';
  }

  @override
  String triggerStatus(Object status, Object execution) {
    return '触发状态：$status · $execution';
  }

  @override
  String get entirePositionProtection => '全仓位保护';

  @override
  String fixedQuantityValue(Object quantity) {
    return '固定数量：$quantity';
  }

  @override
  String filledTotal(Object filled, Object total) {
    return '已成交 / 总计：$filled / $total';
  }

  @override
  String orderPrice(Object price) {
    return '订单价格：$price';
  }

  @override
  String orderStatus(Object status) {
    return '状态：$status';
  }

  @override
  String get filled => '已成交';

  @override
  String percentFilled(Object percent) {
    return '已成交 $percent%';
  }

  @override
  String get closeOrderSubmitted => '平仓订单已提交，请检查订单成交情况。';

  @override
  String closeActionPending(Object id) {
    return '操作 $id 仍在确认中，请在待处理操作中继续，不要重复创建平仓操作。';
  }

  @override
  String get closeFailed => '平仓未完成，请检查待处理操作并刷新仓位后再修改请求。';

  @override
  String get closeRetry => '无法完成平仓，请刷新仓位后重试。';

  @override
  String closeSymbol(Object symbol) {
    return '平仓 $symbol';
  }

  @override
  String get unavailableProduct => '产品不可用';

  @override
  String get longToSell => '做多 → 卖出';

  @override
  String get shortToBuy => '做空 → 买入';

  @override
  String positionQuantity(Object quantity, Object symbol) {
    return '持仓数量：$quantity $symbol';
  }

  @override
  String get limitPriceUsdc => '限价（USDC）';

  @override
  String quantityOfPosition(Object symbol) {
    return '数量（$symbol）';
  }

  @override
  String percentOfCurrentPosition(Object percent) {
    return '当前仓位的 $percent%';
  }

  @override
  String get all => '全部';

  @override
  String entryMark(Object entry, Object mark) {
    return '开仓价：$entry · 标记价：$mark';
  }

  @override
  String liquidationValue(Object price) {
    return '强平价：$price';
  }

  @override
  String get closeReviewNotice => '仅减仓。签名前请核对服务端规范化后的数量、预估盈亏和费用。限价订单可能保持未完成状态。';

  @override
  String get preparing => '正在准备…';

  @override
  String get reviewClose => '审核平仓';

  @override
  String buySymbol(Object symbol) {
    return '买入 $symbol';
  }

  @override
  String buySymbolMarket(Object symbol) {
    return '买入 $symbol · 市价';
  }

  @override
  String get inAppTransferLowercase => '应用内转账';

  @override
  String get fundingNotReady => '资金尚未准备好，无法提交此订单。';

  @override
  String get transferStartFailed => '无法授权或启动此次转账，请重试。';

  @override
  String get preparingTradingFunds => '正在准备交易资金…';

  @override
  String get bridgeInProgress => '跨链处理中，预计需要 1–3 分钟。你可以在详情页查看进度。';

  @override
  String serverSelected(Object asset) {
    return '$asset（服务端选择）';
  }

  @override
  String get amountNeeded => '所需金额';

  @override
  String get transferAmount => '转账金额';

  @override
  String get availableToFund => '可用于入金';

  @override
  String get shortfall => '缺口';

  @override
  String get availableBalanceUnavailable => '不可用';

  @override
  String get serverSelectedFundingRoute => '使用服务端选择的资金路线';

  @override
  String get externalDepositDetail => '从其他平台或钱包向 BSC 充值 USDT';

  @override
  String get positionsUnavailable => '仓位不可用';

  @override
  String get positionRefreshHint => '请刷新仓位后重试。';

  @override
  String get noOpenPosition => '没有未平仓位';

  @override
  String get openPositionDescription => '此产品的仓位将显示在这里。';

  @override
  String get cancellationSubmitted => '取消请求已提交，请刷新以确认最终订单状态。';

  @override
  String get cancellationPendingRefreshOrder => '取消操作仍在确认中，请刷新此订单后重试。';

  @override
  String get cancellationCompleteFailed => '无法完成取消操作，请刷新订单后重试。';

  @override
  String get longPosition => '多头仓位';

  @override
  String get shortPosition => '空头仓位';

  @override
  String get position => '仓位';

  @override
  String get tokenPosition => '代币持仓';

  @override
  String get value => '价值';

  @override
  String get tokenAmount => '代币数量';

  @override
  String get marketHoursUnavailable => '市场交易时段不可用';

  @override
  String get marketHoursRefreshHint => '请刷新市场交易时段后重试。';

  @override
  String get noMarketSessionData => '没有可用的市场时段数据。';

  @override
  String get perpetual => '永续合约';

  @override
  String get lineChart => '折线图';

  @override
  String get candlestickChart => 'K 线图';

  @override
  String get usStockReferencePrice => '美股参考价格';

  @override
  String get loginToViewActivity => '登录后查看你的活动';

  @override
  String get accountActivityAppearHere => '你的订单和账户活动将显示在这里。';

  @override
  String get tokenType => '代币类型';

  @override
  String get tokenDetails => '代币详情';

  @override
  String get cashBalance => '现金余额';

  @override
  String setLeverageTo(Object value) {
    return '将杠杆设为 ${value}x';
  }

  @override
  String quantitySymbol(Object symbol) {
    return '数量（$symbol）';
  }

  @override
  String get takeProfitLimitPrice => '止盈限价（USDC）';

  @override
  String get stopLimitPrice => '止损限价（USDC）';

  @override
  String get protectionSizesUnavailable => '无法读取现有保护单数量。请关闭后刷新再编辑。';

  @override
  String get protectionUpdateFailed =>
      '保护更新未完成，取消操作可能已经成功。请重试同一编辑，或先检查待处理操作再修改。';

  @override
  String get protectionUpdateRetry => '无法完成保护更新，请刷新后重试。';

  @override
  String get protectionSizesDiffer => '现有保护单的数量不同。请为本次编辑选择所需数量。';

  @override
  String get fixedQuantityNotice => '固定数量不会随仓位变化自动调整。';

  @override
  String get entirePositionProtectionNotice => '全仓位保护会在触发时使用仓位数量。';

  @override
  String get protectionSignatureNotice =>
      '触发执行不需要新的签名。修改和取消需要签名。关闭某一保护会取消它；其他修改可能需要额外签名。';

  @override
  String get amountRequiredForPercentage => '请输入金额以获取当前最大数量后，再使用百分比滑块。';

  @override
  String get hip3ExecutionDetailsUnavailable => '执行详情不可用，请返回并重新获取报价。';

  @override
  String get environment => '环境';

  @override
  String get product => '产品';

  @override
  String get feeReserveRate => '费用预留费率';

  @override
  String get slippageLimit => '滑点限制';

  @override
  String get unavailable => '不可用';

  @override
  String get whyUnavailable => '不可用原因';

  @override
  String get crossMarginLiquidationUnavailable => '全仓强平价取决于完整账户状态，无法在此可靠估算。';

  @override
  String get noReliableLiquidationEstimate => '未返回可靠估算值。';

  @override
  String get quoteExpiresUtc => '报价过期时间（UTC）';

  @override
  String get protectionConfirmationMismatch => '保护确认缺失或与订单不符，请返回并重新获取报价。';

  @override
  String fixedQuantityThisOrder(Object quantity) {
    return '固定数量：$quantity（仅此订单）';
  }

  @override
  String get marketPriceBound => '市价保护边界';

  @override
  String openingProtectionLeg(
    Object type,
    Object trigger,
    Object priceType,
    Object price,
  ) {
    return '$type · 标记价格触发 $trigger USDC · $priceType $price USDC';
  }

  @override
  String get openingOrderSignatureNotice => '本开仓订单已签名。触发无需再次签名；之后的修改和取消需要签名。';

  @override
  String get openingProtectionParentWarning =>
      '等待母单不代表保护已生效。取消部分成交的母单也会取消其保护；请检查剩余仓位。系统不会自动创建替代保护。';

  @override
  String get priceLimitEstimateNotice => '限价约束成交价格，但不保证成交；费用和保证金均为预估值。';

  @override
  String get takeProfitTriggerUsdc => '止盈触发价（USDC）';

  @override
  String get takeProfitLimitOptional => '止盈限价（可选）';

  @override
  String get stopLossTriggerUsdc => '止损触发价（USDC）';

  @override
  String get stopLossLimitOptional => '止损限价（可选）';

  @override
  String get leaveBlankForMarketExecution => '留空则按市价执行。';

  @override
  String get openingProtectionQuantityNotice =>
      '固定数量等于本订单数量，而非整个仓位。请随开仓订单一起签名；触发无需再次签名。';

  @override
  String get openingProtectionPendingNotice =>
      '已提交的保护尚未生效。取消部分成交的母单也会取消其保护；请检查剩余仓位。系统不会自动创建替代保护。';

  @override
  String get favoriteUpdateFailed => '无法更新自选。';

  @override
  String get favoriteAdded => '已加入自选。';

  @override
  String get favoriteRemoved => '已从自选中移除。';

  @override
  String buySucceeded(Object symbol) {
    return '$symbol 买入成功！';
  }

  @override
  String buyFailed(Object symbol) {
    return '$symbol 买入失败！';
  }

  @override
  String overnightAt(Object time) {
    return '隔夜 $time';
  }

  @override
  String get hip3Perp => 'HIP-3 永续合约';

  @override
  String get addFavorite => '加入自选';

  @override
  String get removeFavorite => '移除自选';

  @override
  String usStockPrice(Object price) {
    return '美股 $price';
  }

  @override
  String usPrice(Object price) {
    return '美股 $price';
  }

  @override
  String get priceChartUnavailable => '价格图表不可用';

  @override
  String priceChartLatestClose(Object price) {
    return '价格图表最新收盘价 $price';
  }

  @override
  String get tradeWeekend => '周末';

  @override
  String get tradeHoliday => '节假日';

  @override
  String get trade24hHigh => '24 小时最高价';

  @override
  String get trade24hLow => '24 小时最低价';

  @override
  String get trade24hTurnover => '24 小时成交额';

  @override
  String get trade24hVolume => '24 小时成交量';

  @override
  String get openTab => '未完成';

  @override
  String get details => '详情';

  @override
  String get status => '状态';

  @override
  String positionProtectionActionPending(Object id) {
    return '操作 $id 仍在确认中。请在待处理操作中继续，然后重新打开此编辑器。部分修改可能已经生效。';
  }

  @override
  String get orderStatusInActivity => '你可以在活动页面查看订单状态。';

  @override
  String get orderProcessingInDetails => '订单正在处理中，请在详情中跟踪其状态。';

  @override
  String get hip3InvalidOrderWithProtection =>
      '请输入有效的订单参数，以及至少一个正数保护触发价。每个保护限价都需要对应的触发价。';

  @override
  String get hip3InvalidOrderInputs => '请输入正数数量或订单金额，以及有效的限价。';

  @override
  String get hip3OrderNeedsReview => '此订单需要审核，请勿提交替代订单。';

  @override
  String get hip3OrderConfirming => '正在确认此订单。请重试以检查同一订单，请勿提交替代订单。';

  @override
  String get hip3SigningRequestExpired => '此签名请求已过期，请重新准备订单。';

  @override
  String get hip3OrderStillPreparing => '订单仍在准备中，请重试。';

  @override
  String get hip3SigningWalletUnavailable => '签名钱包不可用，请重新连接后重试。';

  @override
  String get hip3SigningRequestInvalid => '签名请求无效，请重新准备订单。';

  @override
  String reviewOrder(Object side, Object symbol) {
    return '核对$side $symbol';
  }

  @override
  String marginValue(Object value) {
    return '保证金：$value USDC';
  }
}
