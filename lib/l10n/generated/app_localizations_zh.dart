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
  String get loadingTradingRules => '正在加载交易规则…';

  @override
  String get retryTradingRules => '重试加载交易规则';

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
  String get add => '添加';

  @override
  String get takeProfitStopLoss => '止盈/止损';

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
  String get activityFunding => '入金';

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
}
