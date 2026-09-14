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
  String get buy => 'Buy';

  @override
  String get sell => 'Sell';

  @override
  String get balance => 'Balance';

  @override
  String get orderValue => 'Order Value';

  @override
  String get estimatedFee => 'Estimated Fee';

  @override
  String get orderType => 'Order Type';

  @override
  String get market => 'Market';

  @override
  String get limit => 'Limit';

  @override
  String get orderSubmitted => 'Order submitted';

  @override
  String get availableMargin => 'Available margin';

  @override
  String get orderNotional => 'Order notional';

  @override
  String get preparingOrder => 'Preparing order…';

  @override
  String get submitting => 'Submitting...';

  @override
  String get checkingOrder => 'Checking order...';

  @override
  String get tradeSuccessful => 'Trade Successful';

  @override
  String get long => 'Long';

  @override
  String get short => 'Short';

  @override
  String get closePosition => 'Close Position';

  @override
  String get closeAmount => 'Amount';

  @override
  String get quantity => 'Quantity';

  @override
  String get slippage => 'Slippage';

  @override
  String get validOrderValue => 'Enter a valid order value.';

  @override
  String get validLimitPrice => 'Enter a valid limit price.';

  @override
  String get prepareOrderFailed => 'Unable to prepare this order. Try again.';

  @override
  String get prepareFundingFailed =>
      'Unable to prepare funding for this order. Try again.';

  @override
  String get willReceive => 'Will receive';

  @override
  String get slippageTolerance => 'Slippage tolerance';

  @override
  String get maximumSlippage => 'Maximum slippage';

  @override
  String get editSlippage => 'Edit slippage';

  @override
  String get priceChangedReview =>
      'Price changed. Review the updated estimate before submitting.';

  @override
  String get viewHistory => 'View History';

  @override
  String get chooseMarginLeverage =>
      'Choose a supported margin mode and leverage before requesting a signature.';

  @override
  String get settingsNotConfirmed =>
      'Settings are not confirmed. Resume the same request before opening an order.';

  @override
  String get enterOrderValue => 'Enter an order value.';

  @override
  String get enterValidOrderValues => 'Enter valid order values.';

  @override
  String get orderQuoteUnavailable =>
      'This quote is unavailable or expired. Go back and request a new quote.';

  @override
  String get walletConnectRequired =>
      'Connect the wallet requested for this order.';

  @override
  String get signatureCancelled => 'Signature request was cancelled.';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get checkOrderStatus => 'Check order status';

  @override
  String get invalidSlippage => 'Enter a slippage percentage from 0% to 100%.';

  @override
  String get liquidationPrice => 'Liquidation Price';

  @override
  String get marginRequired => 'Margin Required';

  @override
  String get maximumQuantity => 'Maximum quantity';

  @override
  String get marginMode => 'Margin mode';

  @override
  String get leverage => 'Leverage';

  @override
  String get dragToSetLeverage => 'Drag to set leverage';

  @override
  String get add => 'Add';

  @override
  String get remove => 'Remove';

  @override
  String get cross => 'Cross';

  @override
  String get isolated => 'Isolated';

  @override
  String marginModeLabel(Object mode) {
    return '$mode margin mode';
  }

  @override
  String get addFundsFrom => 'Add funds from:';

  @override
  String get inAppTransfer => 'In-App Transfer';

  @override
  String get externalDeposit => 'External Deposit';

  @override
  String get transfer => 'Transfer';

  @override
  String get availableBalance => 'Available balance';

  @override
  String get loadMore => 'Load more';

  @override
  String get refreshOrders => 'Refresh orders';

  @override
  String get openOrdersUnavailable => 'Open orders unavailable';

  @override
  String get noOpenOrders => 'No open orders';

  @override
  String get liquidation => 'Liquidation';

  @override
  String get protectionSize => 'Protection size';

  @override
  String get entirePositionDefault => 'All';

  @override
  String get fixedQuantity => 'Fixed quantity';

  @override
  String get portfolioTrend => 'Portfolio trend';

  @override
  String get loadingMarkets => 'Loading markets';

  @override
  String get marketsUnavailable => 'Markets unavailable';

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
  String get takeProfitStopLoss => 'Take profit/stop loss';

  @override
  String get takeProfitStopLossTitle => 'Take Profit & stop loss';

  @override
  String get change => 'Change';

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
      'This requests permanent deletion of your product account and eligible product data. It does not delete your wallet, blockchain assets, or blockchain history.';

  @override
  String get settingsDeleteAccountConfirm => 'Delete Account';

  @override
  String get settingsDeleteAccountAccepted =>
      'Account deletion requested. You have been signed out.';

  @override
  String get settingsDeleteAccountRecentAuth =>
      'For your security, sign out, sign in again, and retry account deletion.';

  @override
  String get settingsDeleteAccountBlocked =>
      'Account deletion is blocked by open orders, positions, funds in transit, remaining assets, or a required review. Resolve them and try again.';

  @override
  String get settingsDeleteAccountFailed =>
      'Unable to request account deletion. Try again later.';

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
  String get navigationHome => 'Home';

  @override
  String get navigationMarkets => 'Markets';

  @override
  String get navigationAssets => 'Assets';

  @override
  String get navigationActivity => 'Activity';

  @override
  String get requestFailed => 'Request failed';

  @override
  String get noFavoritesYet => 'No favorites yet';

  @override
  String get favoritesEmptyDescription =>
      'Tap the star on any market to save it here.';

  @override
  String get exploreMarkets => 'Explore markets';

  @override
  String get searchMarkets => 'Search markets';

  @override
  String get searchTickerOrCompany => 'Search ticker or company';

  @override
  String get products => 'Products';

  @override
  String get loadingProducts => 'Loading products';

  @override
  String get pullToRefreshRetry => 'Pull to refresh and try again.';

  @override
  String get noMatchingProducts => 'No matching products';

  @override
  String get tryAnotherSearchOrFilter =>
      'Try another search or product filter.';

  @override
  String get usMarket => 'US Market';

  @override
  String get usMarketStatus => 'US market status';

  @override
  String get marketHours => 'Market hours';

  @override
  String get stocks => 'Stocks';

  @override
  String get browseAll => 'Browse all';

  @override
  String get filterProducts => 'Filter products';

  @override
  String get allProducts => 'All products';

  @override
  String get hip3Perps => 'HIP-3 Perps';

  @override
  String openTradeDetails(Object symbol) {
    return 'Open $symbol trade details';
  }

  @override
  String get clearSearch => 'Clear search';

  @override
  String get loadingRecentSearches => 'Loading recent searches';

  @override
  String get recentSearches => 'Recent searches';

  @override
  String get results => 'Results';

  @override
  String get noRecentSearches => 'No recent searches';

  @override
  String get browseAllStocks => 'Browse all stocks';

  @override
  String get allStocks => 'All stocks';

  @override
  String get loadingStocks => 'Loading stocks';

  @override
  String get stocksUnavailable => 'Stocks unavailable';

  @override
  String get marketCatalogUnavailable =>
      'Try again when the market catalog is available.';

  @override
  String get noMatchingMarkets => 'No matching markets';

  @override
  String get tryAnotherTickerOrCompany => 'Try another ticker or company name.';

  @override
  String get noStocksFound => 'No stocks found';

  @override
  String searchResultCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count results',
      one: '1 result',
    );
    return '$_temp0';
  }

  @override
  String get history => 'History';

  @override
  String get closeDepositRoutes => 'Close deposit routes';

  @override
  String get depositChooseRoute =>
      'Choose a recommended route, or browse all supported assets.';

  @override
  String get depositRoutesUnavailable => 'Deposit routes unavailable';

  @override
  String get noDepositRoutes => 'No deposit routes available';

  @override
  String get tryAgainLater => 'Try again later.';

  @override
  String depositOn(Object token, Object chain) {
    return 'Deposit $token on $chain';
  }

  @override
  String bestFor(Object product) {
    return 'Best for $product';
  }

  @override
  String get allSupportedAssetsDescription =>
      'Choose another available asset and network';

  @override
  String get depositRouteRequired => 'Deposit route required';

  @override
  String get depositRouteRequiredDescription =>
      'Choose a supported route to receive an address.';

  @override
  String get loadingDepositInstructions => 'Loading deposit instructions';

  @override
  String get depositInstructionsUnavailable =>
      'Deposit instructions unavailable';

  @override
  String get returnToDepositRoutes => 'Return to deposit routes and try again.';

  @override
  String get depositAssets => 'Deposit assets';

  @override
  String get depositReceived => 'Deposit received';

  @override
  String get gotIt => 'Got it';

  @override
  String get backToDepositRoutes => 'Back to deposit routes';

  @override
  String get depositQrCode => 'Deposit QR code';

  @override
  String get depositAddress => 'Deposit address';

  @override
  String get routeDetails => 'Route details';

  @override
  String sendTokenOnChainOnly(Object token, Object chain) {
    return 'Send $token on $chain only.';
  }

  @override
  String get minimumDeposit => 'Minimum deposit';

  @override
  String get estimatedArrival => 'Estimated arrival';

  @override
  String get confirmationsRequired => 'Confirmations required';

  @override
  String get loadingSupportedAssets => 'Loading supported assets';

  @override
  String get supportedAssetsUnavailable => 'Supported assets unavailable';

  @override
  String get noAdditionalDepositRoutes =>
      'No additional deposit routes available';

  @override
  String withdrawToken(Object token) {
    return 'Withdraw $token';
  }

  @override
  String get enterRecipientAddressAndAmount =>
      'Enter a recipient address and amount.';

  @override
  String get enterValidWalletAddress => 'Enter a valid wallet address.';

  @override
  String enterValidTokenAmount(Object token) {
    return 'Enter a valid $token amount.';
  }

  @override
  String get prepareWithdrawalFailed =>
      'Unable to prepare this withdrawal. Try again.';

  @override
  String get paste => 'Paste';

  @override
  String get max => 'Max';

  @override
  String availableToken(Object token) {
    return 'Available $token';
  }

  @override
  String availableTokenAmount(Object amount, Object token) {
    return 'Available $amount $token';
  }

  @override
  String get networkFeesMayChange =>
      'Network fees may change before confirmation.';

  @override
  String get youAreSending => 'You are sending';

  @override
  String get to => 'To';

  @override
  String get finalNetworkFeeMayVary =>
      'The final network fee may vary slightly.';

  @override
  String get unableToLoadAssets => 'Unable to load assets';

  @override
  String get checkConnectionRetry => 'Check your connection and try again.';

  @override
  String get noAssetsAvailable => 'No assets available';

  @override
  String get noMatchingAssets => 'No matching assets';

  @override
  String get assetsWithBalanceAppearHere =>
      'Assets with an available balance will appear here.';

  @override
  String get tryDifferentAssetOrNetwork =>
      'Try a different asset name or network.';

  @override
  String get token => 'Token';

  @override
  String get logIn => 'Log in';

  @override
  String get portfolioUnavailable => 'We couldn\'t load your portfolio';

  @override
  String get marketsLoadFailed => 'We couldn\'t load the markets';

  @override
  String get openSettings => 'Open settings';

  @override
  String get readyWhenYouAre => 'Ready when you are';

  @override
  String get loginToViewPortfolio =>
      'Log in to view your portfolio and start trading.';

  @override
  String get loginToViewAssets => 'Log in to view your assets';

  @override
  String get portfolioBalancesAppearHere =>
      'Your portfolio and balances will appear here.';

  @override
  String get noAssetsYet => 'No assets yet';

  @override
  String get depositToBuildPortfolio =>
      'Deposit a supported asset to start building your portfolio.';

  @override
  String get viewPortfolioTrend => 'View portfolio trend';

  @override
  String get collapseAllocation => 'Collapse allocation';

  @override
  String get expandAllocation => 'Expand allocation';

  @override
  String get allocationUnavailable => 'Allocation unavailable';

  @override
  String get noCashBalances => 'No cash balances';

  @override
  String get cashBalancesUnavailable => 'Cash balances unavailable';

  @override
  String get depositToAddCash => 'Deposit a supported asset to add cash here.';

  @override
  String get loadingCashBalances => 'Loading cash balances';

  @override
  String get loadingHoldings => 'Loading holdings';

  @override
  String get holdingsUnavailable => 'Holdings unavailable';

  @override
  String get holdingReturn => 'Holding return';

  @override
  String noHoldings(Object title) {
    return 'No $title holdings';
  }

  @override
  String get buyBstockToSeeHere => 'Buy a bStock to see it here.';

  @override
  String get openPerpsPositionToSeeHere =>
      'Open a Perps position to see it here.';

  @override
  String get perpsEquity => 'Perps equity';

  @override
  String get enterConfirmationCode => 'Enter confirmation code';

  @override
  String get signUpOrLogIn => 'Sign up or log in to start exploring';

  @override
  String emailCodeSent(Object email) {
    return 'Please check $email for an email from privy.io and enter your code below.';
  }

  @override
  String get didntGetEmail => 'Didn\'t get an email?';

  @override
  String get resendCode => 'Resend code';

  @override
  String get codeResent => 'Code resent';

  @override
  String get continueWithPrivy => 'Continue with Privy';

  @override
  String get enterValidEmail => 'Enter a valid email address.';

  @override
  String get otherSocials => 'Other Socials';

  @override
  String get wallet => 'Wallet';

  @override
  String get recent => 'Recent';

  @override
  String get loginOrSignUp => 'Log in or sign up';

  @override
  String get termsAgreement =>
      'By using this app, you agree to the Terms & Conditions.';

  @override
  String get invalidConfirmationCode => 'That code is invalid or expired.';

  @override
  String get networkUnavailableRetry =>
      'Network unavailable. Check your connection and try again.';

  @override
  String get browserSignInUnavailable =>
      'Unable to start social sign-in. Check that your browser and network are working, then try again.';

  @override
  String get privyNotConfigured => 'Privy is not configured for this build.';

  @override
  String get sessionExpiredLogin =>
      'Your session expired. Please sign in again.';

  @override
  String get backendSessionFailed =>
      'Privy sign-in succeeded, but we could not create your RWA session. Try again later.';

  @override
  String get walletSyncFailed =>
      'You are signed in, but your wallet could not be synchronized. Try again later.';

  @override
  String get emailLoginUnavailable => 'Email sign-in is not available.';

  @override
  String get privyPlatformUnsupported =>
      'Privy sign-in is available on Android and iOS.';

  @override
  String get privyUnavailable =>
      'Privy is temporarily unavailable. Please try again.';

  @override
  String supportId(Object id) {
    return 'Support ID: $id';
  }

  @override
  String changeSymbolLeverage(Object symbol) {
    return 'Change $symbol leverage';
  }

  @override
  String get accountChangedReopenPosition =>
      'Account changed. Close this panel and reopen the position.';

  @override
  String get tradingContextUnavailable => 'Trading context unavailable.';

  @override
  String get tradingContextReload =>
      'Trading context unavailable. Reload before changing leverage.';

  @override
  String get reload => 'Reload';

  @override
  String currentMaximumLeverage(Object current, Object maximum) {
    return 'Current: $current · Maximum: $maximum';
  }

  @override
  String get leverageSignatureNotice =>
      'Changing leverage requires your wallet signature and keeps the current margin mode.';

  @override
  String get leverageChangesUnavailable =>
      'Leverage changes are unavailable for this account or product.';

  @override
  String get validLeverageRequired =>
      'Enter a whole number within the current maximum, or reload expired limits.';

  @override
  String get reloadLimits => 'Reload limits';

  @override
  String get waitingForConfirmation => 'Waiting for confirmation…';

  @override
  String get reviewAndSign => 'Review and sign';

  @override
  String get leverageUpdated =>
      'Leverage updated. Refreshing position and trading context.';

  @override
  String get leveragePending =>
      'Leverage is not yet confirmed. Close this panel and resume the existing action in Pending actions.';

  @override
  String get leverageNotConfirmed =>
      'Leverage was not confirmed. Check pending actions before trying again.';

  @override
  String get direction => 'Direction';

  @override
  String get entryPrice => 'Entry price';

  @override
  String get markPrice => 'Mark price';

  @override
  String get unrealizedPnl => 'Unrealized PnL';

  @override
  String get returnOnEquity => 'Return on equity';

  @override
  String get margin => 'Margin';

  @override
  String get cumulativeFunding => 'Cumulative funding';

  @override
  String get fundingExplanation =>
      'Funding: negative = paid; positive = received.';

  @override
  String get changeLeverage => 'Change leverage';

  @override
  String get openOrdersRefreshHint => 'Try again to refresh open orders.';

  @override
  String get openOrdersEmptyDescription =>
      'Open orders for this product will appear here.';

  @override
  String get cancelling => 'Cancelling…';

  @override
  String get cancellationPending =>
      'Cancellation is still being confirmed. Refresh before retrying.';

  @override
  String get cancellationFailed =>
      'Cancellation was not completed. Refresh and retry; signing may still be required.';

  @override
  String get parentCancelWarning =>
      'If this order has attached TP/SL, cancelling the parent also cancels that protection. Check protection for any remaining position; replacement protection is not created automatically.';

  @override
  String get conditionalOrder => 'Conditional order';

  @override
  String get protectionInactive => 'Protection is no longer active';

  @override
  String get protectionNotSubmitted => 'Protection not submitted';

  @override
  String get protectionWaitingForParent =>
      'Protection waiting for parent fill — not active';

  @override
  String get protectionAwaitingConfirmation =>
      'Protection activation awaiting confirmation';

  @override
  String get protectionActive => 'Protection active';

  @override
  String get protectionStatusUnknown =>
      'Protection status unknown — not confirmed active';

  @override
  String attachedToOrder(Object id) {
    return 'Attached to order: $id';
  }

  @override
  String get parentCancelledProtectionWarning =>
      'Parent cancelled: this protection is inactive. Check protection for any remaining position; no replacement is created automatically.';

  @override
  String triggerPrice(Object price, Object reference) {
    return 'Trigger price: $price USDC · $reference';
  }

  @override
  String triggerStatus(Object status, Object execution) {
    return 'Trigger status: $status · $execution';
  }

  @override
  String get entirePositionProtection => 'Entire position protection';

  @override
  String fixedQuantityValue(Object quantity) {
    return 'Fixed quantity: $quantity';
  }

  @override
  String filledTotal(Object filled, Object total) {
    return 'Filled / Total: $filled / $total';
  }

  @override
  String orderPrice(Object price) {
    return 'Order price: $price';
  }

  @override
  String orderStatus(Object status) {
    return 'Status: $status';
  }

  @override
  String get filled => 'Filled';

  @override
  String percentFilled(Object percent) {
    return '$percent% filled';
  }

  @override
  String get closeOrderSubmitted =>
      'Close order submitted. Check the order for fills.';

  @override
  String closeActionPending(Object id) {
    return 'Action $id is still being confirmed. Resume it from pending actions; do not create another close.';
  }

  @override
  String get closeFailed =>
      'Close was not completed. Check pending actions and refresh the position before changing this request.';

  @override
  String get closeRetry =>
      'Close could not be completed. Refresh the position and retry.';

  @override
  String closeSymbol(Object symbol) {
    return 'Close $symbol';
  }

  @override
  String get unavailableProduct => 'Unavailable product';

  @override
  String get longToSell => 'Long → Sell';

  @override
  String get shortToBuy => 'Short → Buy';

  @override
  String positionQuantity(Object quantity, Object symbol) {
    return 'Position quantity: $quantity $symbol';
  }

  @override
  String get limitPriceUsdc => 'Limit price (USDC)';

  @override
  String quantityOfPosition(Object symbol) {
    return 'Quantity ($symbol)';
  }

  @override
  String percentOfCurrentPosition(Object percent) {
    return '$percent% of current position';
  }

  @override
  String get all => 'All';

  @override
  String entryMark(Object entry, Object mark) {
    return 'Entry: $entry · Mark: $mark';
  }

  @override
  String liquidationValue(Object price) {
    return 'Liquidation: $price';
  }

  @override
  String get closeReviewNotice =>
      'Reduce-only. Review the server-normalized quantity, estimated PnL and fees before signing. A limit order may remain open.';

  @override
  String get preparing => 'Preparing…';

  @override
  String get reviewClose => 'Review close';

  @override
  String buySymbol(Object symbol) {
    return 'Buy $symbol';
  }

  @override
  String buySymbolMarket(Object symbol) {
    return 'Buy $symbol · Market';
  }

  @override
  String get inAppTransferLowercase => 'In-app transfer';

  @override
  String get fundingNotReady => 'Funding is not ready to submit this order.';

  @override
  String get transferStartFailed =>
      'Unable to authorize or start this transfer. Try again.';

  @override
  String get preparingTradingFunds => 'Preparing trading funds…';

  @override
  String get bridgeInProgress =>
      'Bridge in progress. Estimated time: 1–3 min. You can track the progress on the Details page.';

  @override
  String serverSelected(Object asset) {
    return '$asset (server selected)';
  }

  @override
  String get amountNeeded => 'Amount needed';

  @override
  String get transferAmount => 'Transfer amount';

  @override
  String get availableToFund => 'Available to fund';

  @override
  String get shortfall => 'Shortfall';

  @override
  String get availableBalanceUnavailable => 'Unavailable';

  @override
  String get serverSelectedFundingRoute =>
      'Use the server-selected funding route';

  @override
  String get externalDepositDetail =>
      'Deposit USDT on BSC from another platform or wallet';

  @override
  String get positionsUnavailable => 'Positions unavailable';

  @override
  String get positionRefreshHint => 'Try again to refresh your position.';

  @override
  String get noOpenPosition => 'No open position';

  @override
  String get openPositionDescription =>
      'Your position for this product will appear here.';

  @override
  String get cancellationSubmitted =>
      'Cancellation submitted. Refresh to confirm the final order status.';

  @override
  String get cancellationPendingRefreshOrder =>
      'Cancellation is still being confirmed. Refresh this order before retrying.';

  @override
  String get cancellationCompleteFailed =>
      'Unable to complete cancellation. Refresh the order and retry.';

  @override
  String get longPosition => 'Long position';

  @override
  String get shortPosition => 'Short position';

  @override
  String get position => 'Position';

  @override
  String get tokenPosition => 'Token position';

  @override
  String get value => 'Value';

  @override
  String get tokenAmount => 'Token amount';

  @override
  String get marketHoursUnavailable => 'Market hours unavailable';

  @override
  String get marketHoursRefreshHint => 'Try again to refresh market hours.';

  @override
  String get noMarketSessionData => 'No market session data is available.';

  @override
  String get perpetual => 'Perpetual';

  @override
  String get lineChart => 'Line chart';

  @override
  String get candlestickChart => 'Candlestick chart';

  @override
  String get usStockReferencePrice => 'US stock reference price';

  @override
  String get loginToViewActivity => 'Log in to view your activity';

  @override
  String get accountActivityAppearHere =>
      'Your orders and account activity will appear here.';

  @override
  String get tokenType => 'Token type';

  @override
  String get tokenDetails => 'Token details';

  @override
  String get cashBalance => 'Cash balance';

  @override
  String setLeverageTo(Object value) {
    return 'Set leverage to ${value}x';
  }

  @override
  String quantitySymbol(Object symbol) {
    return 'Quantity ($symbol)';
  }

  @override
  String get takeProfitLimitPrice => 'Take profit limit price (USDC)';

  @override
  String get stopLimitPrice => 'Stop limit price (USDC)';

  @override
  String get protectionSizesUnavailable =>
      'Could not read existing protection sizes. Close and refresh before editing.';

  @override
  String get protectionUpdateFailed =>
      'Protection update was not completed. A cancellation may already have succeeded. Retry the same edit or check pending actions before changing it.';

  @override
  String get protectionUpdateRetry =>
      'Protection update could not be completed. Refresh before retrying.';

  @override
  String get protectionSizesDiffer =>
      'Existing protection legs have different sizes. Select the desired size for this edit.';

  @override
  String get fixedQuantityNotice =>
      'Fixed quantity will not adjust automatically when the position changes.';

  @override
  String get entirePositionProtectionNotice =>
      'Entire position protection uses the position size at trigger time.';

  @override
  String get protectionSignatureNotice =>
      'Trigger execution needs no new signature. Changes and cancellations require signing. Switching a leg off cancels it; other edits may require additional signatures.';

  @override
  String get amountRequiredForPercentage =>
      'Enter an amount to get a current maximum quantity before using the percentage slider.';

  @override
  String get hip3ExecutionDetailsUnavailable =>
      'Execution details are unavailable. Go back and request a new quote.';

  @override
  String get environment => 'Environment';

  @override
  String get product => 'Product';

  @override
  String get feeReserveRate => 'Fee reserve rate';

  @override
  String get slippageLimit => 'Slippage limit';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get whyUnavailable => 'Why unavailable';

  @override
  String get crossMarginLiquidationUnavailable =>
      'Cross-margin liquidation depends on the full account and cannot be estimated reliably here.';

  @override
  String get noReliableLiquidationEstimate =>
      'No reliable estimate was returned.';

  @override
  String get quoteExpiresUtc => 'Quote expires (UTC)';

  @override
  String get protectionConfirmationMismatch =>
      'Protection confirmation is missing or differs from your order. Go back and request a new quote.';

  @override
  String fixedQuantityThisOrder(Object quantity) {
    return 'Fixed quantity: $quantity (this order only)';
  }

  @override
  String get marketPriceBound => 'Market price bound';

  @override
  String openingProtectionLeg(
    Object type,
    Object trigger,
    Object priceType,
    Object price,
  ) {
    return '$type · Mark trigger $trigger USDC · $priceType $price USDC';
  }

  @override
  String get openingOrderSignatureNotice =>
      'Signed with this opening order. Triggering needs no new signature; later changes and cancellations require signing.';

  @override
  String get openingProtectionParentWarning =>
      'Waiting for the parent is not active protection. Cancelling a partially filled parent cancels its protection; check the remaining position. No automatic replacement.';

  @override
  String get priceLimitEstimateNotice =>
      'The price limit bounds execution; it does not guarantee a fill. Fees and margin are estimates.';

  @override
  String get takeProfitTriggerUsdc => 'Take profit trigger (USDC)';

  @override
  String get takeProfitLimitOptional => 'Take profit limit (optional)';

  @override
  String get stopLossTriggerUsdc => 'Stop loss trigger (USDC)';

  @override
  String get stopLossLimitOptional => 'Stop loss limit (optional)';

  @override
  String get leaveBlankForMarketExecution =>
      'Leave blank for market execution.';

  @override
  String get openingProtectionQuantityNotice =>
      'Fixed quantity equals this order, not your entire position. Sign with the opening order; triggering needs no new signature.';

  @override
  String get openingProtectionPendingNotice =>
      'Submitted protection is not yet active. If you cancel a partially filled parent order, its protection is cancelled too. Check the remaining position; protection is not replaced automatically.';

  @override
  String get favoriteUpdateFailed => 'Unable to update favorites.';

  @override
  String get favoriteAdded => 'Added to favorites.';

  @override
  String get favoriteRemoved => 'Removed from favorites.';

  @override
  String buySucceeded(Object symbol) {
    return '$symbol Buy Successful!';
  }

  @override
  String buyFailed(Object symbol) {
    return '$symbol Buy Failed!';
  }

  @override
  String overnightAt(Object time) {
    return 'Overnight $time';
  }

  @override
  String get hip3Perp => 'HIP-3 Perp';

  @override
  String get addFavorite => 'Add favorite';

  @override
  String get removeFavorite => 'Remove favorite';

  @override
  String usStockPrice(Object price) {
    return 'US Stock $price';
  }

  @override
  String usPrice(Object price) {
    return 'US $price';
  }

  @override
  String get priceChartUnavailable => 'Price chart unavailable';

  @override
  String priceChartLatestClose(Object price) {
    return 'Price chart latest close $price';
  }

  @override
  String get tradeWeekend => 'Weekend';

  @override
  String get tradeHoliday => 'Holiday';

  @override
  String get trade24hHigh => '24h High';

  @override
  String get trade24hLow => '24h Low';

  @override
  String get trade24hTurnover => '24h Turnover';

  @override
  String get trade24hVolume => '24h Volume';

  @override
  String get openTab => 'Open';

  @override
  String get details => 'Details';

  @override
  String get status => 'Status';

  @override
  String positionProtectionActionPending(Object id) {
    return 'Action $id is still being confirmed. Resume pending actions, then reopen this editor. Changes may be partially applied.';
  }

  @override
  String get orderStatusInActivity =>
      'You can check the order status on the activities page.';

  @override
  String get orderProcessingInDetails =>
      'Your order is being processed. Track its status in Details.';

  @override
  String get hip3InvalidOrderWithProtection =>
      'Enter valid order values and at least one positive protection trigger. Each protection limit needs its trigger.';

  @override
  String get hip3InvalidOrderInputs =>
      'Enter a positive quantity or order value and a valid limit price.';

  @override
  String get hip3OrderNeedsReview =>
      'This order needs review. Do not place a replacement order.';

  @override
  String get hip3OrderConfirming =>
      'Confirming this order. Retry to check the same order; do not place a replacement.';

  @override
  String get hip3SigningRequestExpired =>
      'This signing request expired. Prepare the order again.';

  @override
  String get hip3OrderStillPreparing =>
      'The order is still being prepared. Try again.';

  @override
  String get hip3SigningWalletUnavailable =>
      'The signing wallet is unavailable. Reconnect and try again.';

  @override
  String get hip3SigningRequestInvalid =>
      'The signing request is invalid. Prepare the order again.';

  @override
  String reviewOrder(Object side, Object symbol) {
    return 'Review $side $symbol';
  }

  @override
  String marginValue(Object value) {
    return 'Margin: $value USDC';
  }
}
