// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hip3ConfirmSetTp => 'Set take profit';

  @override
  String get hip3ConfirmSetSl => 'Set stop loss';

  @override
  String get hip3ConfirmCancelTp => 'Cancel take profit';

  @override
  String get hip3ConfirmCancelSl => 'Cancel stop loss';

  @override
  String get hip3ConfirmClose => 'Close position';

  @override
  String get hip3ConfirmLeverageTitle => 'Adjust leverage';

  @override
  String get hip3ConfirmTitle => 'Confirm HIP3 action';

  @override
  String get hip3ConfirmReview =>
      'Review this step before signing. Earlier completed steps remain effective if you decline.';

  @override
  String get hip3ConfirmDecline => 'Decline signature';

  @override
  String get hip3ConfirmSign => 'Confirm and sign';

  @override
  String get hip3ConfirmLeverage => 'Leverage';

  @override
  String get hip3ConfirmMargin => 'Margin mode';

  @override
  String get hip3ConfirmScope => 'Protection to cancel';

  @override
  String get hip3ConfirmCoverage => 'Protection coverage';

  @override
  String get hip3ConfirmQuantity => 'Protected quantity';

  @override
  String get hip3ConfirmTpTrigger => 'Take-profit trigger price';

  @override
  String get hip3ConfirmTpReference => 'Take-profit price reference';

  @override
  String get hip3ConfirmTpExecution => 'Take-profit execution';

  @override
  String get hip3ConfirmTpLimit => 'Take-profit limit price';

  @override
  String get hip3ConfirmSlTrigger => 'Stop-loss trigger price';

  @override
  String get hip3ConfirmSlReference => 'Stop-loss price reference';

  @override
  String get hip3ConfirmSlExecution => 'Stop-loss execution';

  @override
  String get hip3ConfirmSlLimit => 'Stop-loss limit price';

  @override
  String get hip3ConfirmDirection => 'Closing order direction';

  @override
  String get hip3ConfirmCloseQuantity => 'Close quantity';

  @override
  String get hip3ConfirmRemaining => 'Remaining quantity';

  @override
  String get hip3ConfirmEstimate => 'Estimated execution price';

  @override
  String get hip3ConfirmFee => 'Estimated fee (USDC)';

  @override
  String get hip3ConfirmPnl => 'Estimated realized PnL (USDC)';

  @override
  String get hip3ConfirmSlippage => 'Maximum slippage (%)';

  @override
  String get hip3ConfirmEntire => 'Entire position at trigger time';

  @override
  String get hip3ConfirmFixed => 'Fixed quantity';

  @override
  String get hip3ConfirmPercent => 'Percentage of position';

  @override
  String get hip3ConfirmBuyClose => 'Buy to close short position';

  @override
  String get hip3ConfirmSellClose => 'Sell to close long position';

  @override
  String get hip3ConfirmMarket => 'Market';

  @override
  String get hip3ConfirmLimit => 'Limit';

  @override
  String get hip3ConfirmMark => 'Mark price';

  @override
  String get hip3ConfirmCross => 'Cross';

  @override
  String get hip3ConfirmIsolated => 'Isolated';

  @override
  String get hip3ConfirmBoth => 'Take profit and stop loss';

  @override
  String hip3ConfirmValidUntil(String time) {
    return 'Valid until $time (local time)';
  }

  @override
  String get hip3PendingTitle => 'Unfinished HIP3 actions';

  @override
  String get hip3PendingRefresh => 'Refresh actions';

  @override
  String get hip3PendingLoading => 'Loading unfinished actions…';

  @override
  String get hip3PendingLoadError =>
      'Could not load actions. Refresh to try again.';

  @override
  String get hip3PendingEmpty => 'No unfinished position actions on this page.';

  @override
  String get hip3PendingMore => 'Load more actions';

  @override
  String get hip3PendingContinue => 'Continue action';

  @override
  String get hip3PendingCheck => 'Check progress';

  @override
  String get hip3PendingBusy => 'Checking action…';

  @override
  String get hip3PendingReview =>
      'Needs manual review. Do not create a replacement action. Contact support with the action ID.';

  @override
  String get hip3PendingSignature => 'Waiting for your signature';

  @override
  String get hip3PendingProcessing => 'Checking the exchange result';

  @override
  String get hip3PendingUnavailable => 'This action cannot be resumed here.';

  @override
  String get hip3PendingError =>
      'Could not continue. Refresh and retry the same action.';

  @override
  String get hip3PendingStillActive =>
      'The action is still unfinished. Continue this action instead of creating another.';

  @override
  String get hip3PendingComplete => 'Action confirmed';

  @override
  String get hip3PendingSetTpsl => 'Set or update TP/SL';

  @override
  String get hip3PendingClearTpsl => 'Cancel TP/SL';

  @override
  String get hip3PendingLeverage => 'Adjust leverage';

  @override
  String get hip3PendingClose => 'Close position';

  @override
  String get hip3PendingEffects => 'Earlier steps have already taken effect.';

  @override
  String get appTitle => 'RWA Interface';

  @override
  String get homeTitle => 'Application foundation';

  @override
  String get openDetails => 'Open details';

  @override
  String get detailsTitle => 'Navigation details';

  @override
  String get pageNotFoundTitle => 'Page not found';

  @override
  String get pageNotFoundMessage =>
      'This address does not match an application page.';

  @override
  String get returnHome => 'Return home';

  @override
  String get loadingLabel => 'Loading';

  @override
  String get copyLabel => 'Copy';

  @override
  String get copySucceeded => 'Copied';

  @override
  String get copyFailed => 'Could not copy';

  @override
  String get cancel => 'Cancel';

  @override
  String get assetsTitle => 'Assets';

  @override
  String get homePortfolio => 'Portfolio';

  @override
  String get marketsTitle => 'Markets';

  @override
  String get deposit => 'Deposit';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get selectAsset => 'Select asset';

  @override
  String get searchAssets => 'Search assets';

  @override
  String get availableToWithdraw => 'Available to withdraw';

  @override
  String get withdrawUsdc => 'Withdraw USDC';

  @override
  String get recipientAddress => 'Recipient address';

  @override
  String get enterWalletAddress => 'Enter wallet address';

  @override
  String get amount => 'Amount';

  @override
  String get network => 'Network';

  @override
  String get networkFee => 'Network fee';

  @override
  String get reviewWithdrawal => 'Review withdrawal';

  @override
  String get preparingWithdrawal => 'Preparing withdrawal…';

  @override
  String get withdrawalDetails => 'Withdrawal details';

  @override
  String get recipientReceives => 'Recipient receives';

  @override
  String get totalDeducted => 'Total deducted';

  @override
  String get authorizationRequired => 'Authorization required';

  @override
  String get depositCrypto => 'Deposit crypto';

  @override
  String get allSupportedAssets => 'All supported assets';

  @override
  String get loadingAssets => 'Loading assets';

  @override
  String get assetsUnavailable => 'Assets unavailable';

  @override
  String get portfolioValue => 'Portfolio value';

  @override
  String get allocation => 'Allocation';

  @override
  String get cash => 'Cash';

  @override
  String get bstocks => 'bStocks';

  @override
  String get perps => 'Perps';

  @override
  String get cashBalances => 'Cash balances';

  @override
  String get portfolioTrend => 'Portfolio trend';

  @override
  String get loadingMarkets => 'Loading markets';

  @override
  String get marketsUnavailable => 'Markets unavailable';

  @override
  String get hip3ChartLoading => 'Loading price history…';

  @override
  String get hip3ChartInspect => 'Touch or drag the chart to inspect a candle.';

  @override
  String get hip3ChartVolume => 'Volume';

  @override
  String hip3ChartUnits(String symbol) {
    return 'OHLC in USDC · Volume in $symbol';
  }

  @override
  String get hip3ChartHistoryLoad => 'Load earlier candles';

  @override
  String get hip3ChartHistoryLoading => 'Loading earlier candles…';

  @override
  String get hip3ChartHistoryRetry => 'Retry earlier candles';

  @override
  String get hip3ChartHistoryError =>
      'Earlier candles could not load. Your chart is unchanged.';

  @override
  String get hip3ChartHistoryEmpty =>
      'No candles in that earlier window. You can continue further back.';

  @override
  String get hip3ChartHistoryEnd => 'Reached the available history limit.';

  @override
  String get hip3ChartError => 'Could not load price history.';

  @override
  String get hip3ChartEmpty => 'No trades in this period.';

  @override
  String get hip3ChartRetry => 'Refresh chart';

  @override
  String get hip3ChartStale =>
      'Price history may be out of date. Refresh to update.';

  @override
  String get hip3ChartLine => 'Line chart';

  @override
  String get hip3ChartCandles => 'Candlestick chart';

  @override
  String get hip3ChartReferenceUnavailable =>
      'Reference price history is not available.';

  @override
  String get noProductsYet => 'No products yet';

  @override
  String get favorites => 'Favorites';

  @override
  String get popular => 'Popular';

  @override
  String get gainers => 'Gainers';

  @override
  String get losers => 'Losers';

  @override
  String get volume => 'Volume';

  @override
  String get editTpSl => 'Edit TP/SL';

  @override
  String get takeProfit => 'Take profit';

  @override
  String get stopLoss => 'Stop loss';

  @override
  String get price => 'Price';

  @override
  String get hip3OrderDetailTitle => 'HIP3 order details';

  @override
  String get hip3OrderHistoryTitle => 'HIP3 order records';

  @override
  String get hip3OrderHistoryEmpty => 'No HIP3 orders were returned.';

  @override
  String get hip3OrderLoadMore => 'Load more orders';

  @override
  String get hip3OrderLoading => 'Loading order details';

  @override
  String get hip3OrderLoadError =>
      'Could not load order records. Retry to fetch the latest data.';

  @override
  String get hip3OrderRetry => 'Retry';

  @override
  String get hip3OrderRefresh => 'Refresh orders';

  @override
  String get hip3OrderNotHip3 =>
      'HIP3 order details are unavailable for this order.';

  @override
  String get hip3OrderUnavailable => 'Unavailable';

  @override
  String get hip3OrderUnitUnavailable => 'unit unavailable';

  @override
  String get hip3OrderSummary => 'Order totals';

  @override
  String get hip3OrderDirection => 'Order direction';

  @override
  String hip3OrderSide(String side) {
    String _temp0 = intl.Intl.selectLogic(side, {
      'buy': 'Buy',
      'sell': 'Sell',
      'long': 'Long',
      'short': 'Short',
      'other': 'Unavailable',
    });
    return '$_temp0';
  }

  @override
  String get hip3OrderFilledQuantity => 'Total filled quantity';

  @override
  String get hip3OrderAveragePrice => 'Average fill price';

  @override
  String get hip3OrderTotalFee => 'Total fee';

  @override
  String get hip3OrderRealizedPnl => 'Order realized PnL';

  @override
  String get hip3OrderSummaryNote =>
      'Totals are reported by the order API, not calculated from the records below.';

  @override
  String get hip3OrderFillsTitle => 'Individual fills';

  @override
  String hip3OrderFillsCoverage(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'This response contains $count fill records',
      one: 'This response contains 1 fill record',
    );
    return '$_temp0 for this order. Earlier or missing records cannot be requested separately; completeness is not confirmed.';
  }

  @override
  String get hip3OrderReturnedRange => 'Returned execution times';

  @override
  String get hip3OrderObservedAt => 'Provider observation time';

  @override
  String get hip3OrderFillMissingFields =>
      'The API does not provide direction or realized PnL for individual fills. Order direction and order PnL are shown separately above.';

  @override
  String get hip3OrderFillsOmitted =>
      'Fill details were not provided by the API. This does not mean the order has no executions.';

  @override
  String get hip3OrderFillsEmpty =>
      'No individual fills were returned. This does not prove that no executions occurred.';

  @override
  String hip3OrderFillNumber(int index) {
    return 'Fill $index';
  }

  @override
  String get hip3OrderFillTime => 'Execution time';

  @override
  String get hip3OrderFillDirection => 'Fill direction';

  @override
  String get hip3OrderFillQuantity => 'Fill quantity';

  @override
  String get hip3OrderFillFee => 'Fill fee';

  @override
  String get hip3OrderFillPnl => 'Fill realized PnL';

  @override
  String get hip3OrderFillId => 'Fill ID';

  @override
  String get hip3OrderProviderTradeId => 'Provider trade ID';

  @override
  String get hip3OrderProviderHash => 'Provider transaction hash';

  @override
  String get add => 'Add';

  @override
  String get takeProfitStopLoss => 'Take profit/stop loss';

  @override
  String get hip3OrderTpSl => 'Order TP/SL';

  @override
  String get hip3PositionTpSl => 'Position TP/SL';

  @override
  String get hip3PositionProtectionScope =>
      'This editor manages position TP/SL only. Opening-order TP/SL is separate; check its activation and quantity in Orders. Empty fields here do not mean all protection is absent.';

  @override
  String get bstocksTpSlUnavailable =>
      'TP/SL is not available for bStocks orders.';

  @override
  String get saveTpSl => 'Save TP/SL';

  @override
  String get tpSlPriceHint => 'Enter trigger prices for this position.';

  @override
  String get tpSlSaveFailed =>
      'Could not save TP/SL. Check the prices and try again.';

  @override
  String get orderSubmissionFailed => 'Order was not submitted. Try again.';

  @override
  String get marketPrice => 'Market price';

  @override
  String get estimatedPrice => 'Estimated price';

  @override
  String get submittingOrder => 'Submitting Order…';

  @override
  String get submittingOrderDescription =>
      'This may take a few moments. You can track the progress on the Details page.';

  @override
  String get closeViewLater => 'Close & View Later';

  @override
  String get back => 'Back';

  @override
  String get limitPrice => 'Limit Price';

  @override
  String get market => 'Market';

  @override
  String get dragToSet => 'Drag to set';

  @override
  String get priceDeviation => 'Price deviation';

  @override
  String get confirm => 'Confirm';

  @override
  String get tradeUsStockReference => 'US Stock Reference';

  @override
  String get tradePremium => 'Premium';

  @override
  String get tradeSpread => 'Spread';

  @override
  String get tradeBestBidAsk => 'Best Bid / Ask';

  @override
  String get tradeAssetRights => 'Asset & Rights';

  @override
  String get tradeAssetRightsDescription =>
      'Provides economic exposure to underlying NVIDIA securities. You hold on-chain security tokens within your BSC wallet, not direct ownership of NVIDIA shares.';

  @override
  String get tradeIssuer => 'Issuer';

  @override
  String get tradeIssuerValue => 'BTECH Holdings Limited';

  @override
  String get tradeBacking => 'Backing';

  @override
  String get tradeBackingValue => '1:1 Backed by Underlying Shares';

  @override
  String get tradeCorporateActions => 'Corporate Actions';

  @override
  String get tradeCorporateActionsValue =>
      'Automatically Reflected via Multiplier';

  @override
  String get tradeDividendTreatment => 'Dividend Treatment';

  @override
  String get tradeDividendTreatmentValue =>
      'Net Dividends Automatically Reinvested';

  @override
  String get tradeVotingRights => 'Voting Rights';

  @override
  String get tradeVotingRightsValue => 'No Shareholder Voting Rights';

  @override
  String get tradeAssetLocation => 'Asset Location';

  @override
  String get tradeAssetLocationValue => 'Held in BSC Wallet';

  @override
  String get tradeMarketHoursTitle => 'US Market Trading Hours';

  @override
  String get tradeMarketHoursDescription =>
      'Market closed indicates no-trading periods, including weekends, US holidays, and daily settlement windows.';

  @override
  String get tradePreMarket => 'Pre-Market';

  @override
  String get tradeRegularMarket => 'Regular Market';

  @override
  String get tradeAfterHours => 'After-Hours';

  @override
  String get tradeOvernight => 'Overnight';

  @override
  String get tradeMarketClosed => 'Market Closed';

  @override
  String get tradeMediumLiquidity => 'Medium Liquidity';

  @override
  String get tradeHighLiquidity => 'High Liquidity';

  @override
  String get tradeLowLiquidity => 'Low Liquidity';

  @override
  String get tradeMarketOpensIn => 'US market opens in 04:30:11';

  @override
  String get tradeMarketClosedSchedule => 'Weekends, US holidays';

  @override
  String get tradeReferencePrice => 'US Stock Reference';

  @override
  String get tradeReferenceValue => 'US \$175.22';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLoading => 'Loading settings';

  @override
  String get settingsUnavailable => 'Settings unavailable';

  @override
  String get settingsRetry => 'Pull to refresh and try again.';

  @override
  String get settingsActiveAccount => 'Active Account';

  @override
  String get settingsPasskey => 'Passkey';

  @override
  String get settingsPasskeyNotSet => 'Not set';

  @override
  String get settingsPasskeyNotSetUp => 'Not set up';

  @override
  String get settingsPasskeyEnabled => 'Enabled';

  @override
  String get settingsPasskeyDescription =>
      'Use Face ID, Touch ID, or your device security to sign in faster.';

  @override
  String get settingsPasskeySetupTitle => 'Set Up Passkey';

  @override
  String get settingsPasskeySetupDescription =>
      'Sign in faster using Face ID, Touch ID, or your device security.';

  @override
  String get settingsPasskeyRemoveDescription =>
      'Passkey is enabled for this account.';

  @override
  String get settingsPasskeyExistingMethods =>
      'Your existing login methods will still work.';

  @override
  String get settingsPasskeySetUpAction => 'Set Up';

  @override
  String get settingsPasskeyRemoveAction => 'Remove Passkey';

  @override
  String get settingsNotNow => 'Not Now';

  @override
  String get settingsPasskeySetupSucceeded => 'Passkey set up successfully';

  @override
  String get settingsPasskeySetupFailed =>
      'Passkey setup failed. Please try again.';

  @override
  String get settingsPasskeyRemoveSucceeded => 'Passkey removed';

  @override
  String get settingsPasskeyRemoveFailed =>
      'Could not remove passkey. Please try again.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSimplifiedChinese => 'Simplified Chinese';

  @override
  String get settingsExportPrivateKey => 'Export Private Key';

  @override
  String get settingsPrivateKeyWarning =>
      'Never share your private key with anyone. Anyone with this information can control your wallet.';

  @override
  String get settingsCheckUpdates => 'Check for Updates';

  @override
  String get settingsAppVersion => 'App Version';

  @override
  String get settingsUpToDate => 'You\'re on the latest version.';

  @override
  String get settingsUpdateCheckFailed => 'Could not check for updates.';

  @override
  String get settingsUpdateUnavailable =>
      'No update source is available for this platform.';

  @override
  String get settingsUpdateAvailable => 'Update Available';

  @override
  String settingsUpdateAvailableMessage(Object version) {
    return 'Version $version is available.';
  }

  @override
  String get settingsUpdateNow => 'Update now';

  @override
  String get settingsCacheSize => 'Cache Size';

  @override
  String get settingsClearCache => 'Clear';

  @override
  String get settingsTermsConditions => 'Terms & Conditions';

  @override
  String get settingsLogOut => 'Log Out';

  @override
  String get settingsLogOutQuestion => 'Are you sure you want to log out?';

  @override
  String get settingsDeleteAccount => 'Delete Account';

  @override
  String get settingsDeleteAccountMessage =>
      'Account deletion is not available from this version of the app.';

  @override
  String get activityTitle => 'Activity';

  @override
  String get activityAllProducts => 'All product';

  @override
  String get activityType => 'Type';

  @override
  String get activityStatus => 'Status';

  @override
  String get activityFilterStatus => 'Filter status';

  @override
  String get activityAllStatuses => 'All statuses';

  @override
  String get activityOrders => 'Orders';

  @override
  String get activityFunding => 'Funding';

  @override
  String get activityApprovals => 'Approvals';

  @override
  String get activityInProgress => 'In Progress';

  @override
  String get activityCompleted => 'Completed';

  @override
  String get activityFailed => 'Failed';

  @override
  String get activityCancelled => 'Cancelled';

  @override
  String get activityUnknown => 'Unknown';

  @override
  String get activityLoading => 'Loading activity';

  @override
  String get activityUnavailable => 'Activity unavailable';

  @override
  String get activityRetry => 'Pull to refresh and try again.';

  @override
  String get activityEmptyTitle => 'No activity yet';

  @override
  String get activityEmptyMessage =>
      'Your orders and funding events will appear here.';

  @override
  String get activityCopyReference => 'Copy activity reference';

  @override
  String get tradeBasis => 'Basis';

  @override
  String get tradePerpAssetRightsDescription =>
      'Perpetual contracts provide price exposure to NVIDIA only; they do not grant stocks, on-chain security tokens, or corporate shareholder rights.';

  @override
  String get tradeProductType => 'Product Type';

  @override
  String get tradePerpProductType => 'HIP-3 Perpetual Contract';

  @override
  String get tradeUnderlyingExposure => 'Underlying Exposure';

  @override
  String get tradePriceExposureOnly => 'Price Exposure Only';

  @override
  String get tradeShareOwnership => 'Share Ownership';

  @override
  String get tradeNoShareOwnership => 'No Ownership of Underlying Shares';

  @override
  String get tradeDividendRights => 'Dividend Rights';

  @override
  String get tradeNone => 'None';

  @override
  String get tradePositionType => 'Position Type';

  @override
  String get tradePerpPositionType => 'HIP-3 Perpetual Position';

  @override
  String get portfolioPartialData =>
      'Some assets could not be read or valued. Shown amounts are a subtotal.';

  @override
  String get portfolioStaleData =>
      'Showing an older snapshot. Balances and positions may have changed.';

  @override
  String get portfolioUnverifiedData =>
      'Data completeness is not confirmed. Refresh before relying on these amounts.';

  @override
  String get portfolioLoadMore => 'Load more holdings';

  @override
  String get portfolioRefresh => 'Refresh assets';

  @override
  String get portfolioHoldingsUnconfirmed =>
      'Holdings could not be fully confirmed';

  @override
  String get portfolioMoreHoldings =>
      'More holdings are available on the next page.';

  @override
  String get portfolioAllocationUnavailable =>
      'Asset allocation is not available yet.';

  @override
  String get portfolioUnifiedCollateral =>
      'Unified-account collateral is shared by spot and perpetuals and must not be counted twice. Position value is not additional equity.';

  @override
  String get portfolioHistoryUnavailable =>
      'Portfolio history is not available yet. No estimated trend is shown.';

  @override
  String get portfolioLedgerNotice =>
      'These are internal ledger balances, not additional on-chain assets. They are not added to portfolio value.';
}
