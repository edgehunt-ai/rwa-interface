// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

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
  String get market => '市价';

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
  String get settingsDeleteAccountMessage => '当前版本暂不支持删除账户。';

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
