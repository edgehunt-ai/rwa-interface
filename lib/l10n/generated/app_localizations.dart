import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @hip3ConfirmSetTp.
  ///
  /// In en, this message translates to:
  /// **'Set take profit'**
  String get hip3ConfirmSetTp;

  /// No description provided for @hip3ConfirmSetSl.
  ///
  /// In en, this message translates to:
  /// **'Set stop loss'**
  String get hip3ConfirmSetSl;

  /// No description provided for @hip3ConfirmCancelTp.
  ///
  /// In en, this message translates to:
  /// **'Cancel take profit'**
  String get hip3ConfirmCancelTp;

  /// No description provided for @hip3ConfirmCancelSl.
  ///
  /// In en, this message translates to:
  /// **'Cancel stop loss'**
  String get hip3ConfirmCancelSl;

  /// No description provided for @hip3ConfirmClose.
  ///
  /// In en, this message translates to:
  /// **'Close position'**
  String get hip3ConfirmClose;

  /// No description provided for @hip3ConfirmLeverageTitle.
  ///
  /// In en, this message translates to:
  /// **'Adjust leverage'**
  String get hip3ConfirmLeverageTitle;

  /// No description provided for @hip3ConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm HIP3 action'**
  String get hip3ConfirmTitle;

  /// No description provided for @hip3ConfirmReview.
  ///
  /// In en, this message translates to:
  /// **'Review this step before signing. Earlier completed steps remain effective if you decline.'**
  String get hip3ConfirmReview;

  /// No description provided for @hip3ConfirmDecline.
  ///
  /// In en, this message translates to:
  /// **'Decline signature'**
  String get hip3ConfirmDecline;

  /// No description provided for @hip3ConfirmSign.
  ///
  /// In en, this message translates to:
  /// **'Confirm and sign'**
  String get hip3ConfirmSign;

  /// No description provided for @hip3ConfirmLeverage.
  ///
  /// In en, this message translates to:
  /// **'Leverage'**
  String get hip3ConfirmLeverage;

  /// No description provided for @hip3ConfirmMargin.
  ///
  /// In en, this message translates to:
  /// **'Margin mode'**
  String get hip3ConfirmMargin;

  /// No description provided for @hip3ConfirmScope.
  ///
  /// In en, this message translates to:
  /// **'Protection to cancel'**
  String get hip3ConfirmScope;

  /// No description provided for @hip3ConfirmCoverage.
  ///
  /// In en, this message translates to:
  /// **'Protection coverage'**
  String get hip3ConfirmCoverage;

  /// No description provided for @hip3ConfirmQuantity.
  ///
  /// In en, this message translates to:
  /// **'Protected quantity'**
  String get hip3ConfirmQuantity;

  /// No description provided for @hip3ConfirmTpTrigger.
  ///
  /// In en, this message translates to:
  /// **'Take-profit trigger price'**
  String get hip3ConfirmTpTrigger;

  /// No description provided for @hip3ConfirmTpReference.
  ///
  /// In en, this message translates to:
  /// **'Take-profit price reference'**
  String get hip3ConfirmTpReference;

  /// No description provided for @hip3ConfirmTpExecution.
  ///
  /// In en, this message translates to:
  /// **'Take-profit execution'**
  String get hip3ConfirmTpExecution;

  /// No description provided for @hip3ConfirmTpLimit.
  ///
  /// In en, this message translates to:
  /// **'Take-profit limit price'**
  String get hip3ConfirmTpLimit;

  /// No description provided for @hip3ConfirmSlTrigger.
  ///
  /// In en, this message translates to:
  /// **'Stop-loss trigger price'**
  String get hip3ConfirmSlTrigger;

  /// No description provided for @hip3ConfirmSlReference.
  ///
  /// In en, this message translates to:
  /// **'Stop-loss price reference'**
  String get hip3ConfirmSlReference;

  /// No description provided for @hip3ConfirmSlExecution.
  ///
  /// In en, this message translates to:
  /// **'Stop-loss execution'**
  String get hip3ConfirmSlExecution;

  /// No description provided for @hip3ConfirmSlLimit.
  ///
  /// In en, this message translates to:
  /// **'Stop-loss limit price'**
  String get hip3ConfirmSlLimit;

  /// No description provided for @hip3ConfirmDirection.
  ///
  /// In en, this message translates to:
  /// **'Closing order direction'**
  String get hip3ConfirmDirection;

  /// No description provided for @hip3ConfirmCloseQuantity.
  ///
  /// In en, this message translates to:
  /// **'Close quantity'**
  String get hip3ConfirmCloseQuantity;

  /// No description provided for @hip3ConfirmRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining quantity'**
  String get hip3ConfirmRemaining;

  /// No description provided for @hip3ConfirmEstimate.
  ///
  /// In en, this message translates to:
  /// **'Estimated execution price'**
  String get hip3ConfirmEstimate;

  /// No description provided for @hip3ConfirmFee.
  ///
  /// In en, this message translates to:
  /// **'Estimated fee (USDC)'**
  String get hip3ConfirmFee;

  /// No description provided for @hip3ConfirmPnl.
  ///
  /// In en, this message translates to:
  /// **'Estimated realized PnL (USDC)'**
  String get hip3ConfirmPnl;

  /// No description provided for @hip3ConfirmSlippage.
  ///
  /// In en, this message translates to:
  /// **'Maximum slippage (%)'**
  String get hip3ConfirmSlippage;

  /// No description provided for @hip3ConfirmEntire.
  ///
  /// In en, this message translates to:
  /// **'Entire position at trigger time'**
  String get hip3ConfirmEntire;

  /// No description provided for @hip3ConfirmFixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed quantity'**
  String get hip3ConfirmFixed;

  /// No description provided for @hip3ConfirmPercent.
  ///
  /// In en, this message translates to:
  /// **'Percentage of position'**
  String get hip3ConfirmPercent;

  /// No description provided for @hip3ConfirmBuyClose.
  ///
  /// In en, this message translates to:
  /// **'Buy to close short position'**
  String get hip3ConfirmBuyClose;

  /// No description provided for @hip3ConfirmSellClose.
  ///
  /// In en, this message translates to:
  /// **'Sell to close long position'**
  String get hip3ConfirmSellClose;

  /// No description provided for @hip3ConfirmMarket.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get hip3ConfirmMarket;

  /// No description provided for @hip3ConfirmLimit.
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get hip3ConfirmLimit;

  /// No description provided for @hip3ConfirmMark.
  ///
  /// In en, this message translates to:
  /// **'Mark price'**
  String get hip3ConfirmMark;

  /// No description provided for @hip3ConfirmCross.
  ///
  /// In en, this message translates to:
  /// **'Cross'**
  String get hip3ConfirmCross;

  /// No description provided for @hip3ConfirmIsolated.
  ///
  /// In en, this message translates to:
  /// **'Isolated'**
  String get hip3ConfirmIsolated;

  /// No description provided for @hip3ConfirmBoth.
  ///
  /// In en, this message translates to:
  /// **'Take profit and stop loss'**
  String get hip3ConfirmBoth;

  /// No description provided for @hip3ConfirmValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {time} (local time)'**
  String hip3ConfirmValidUntil(String time);

  /// No description provided for @hip3PendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Unfinished HIP3 actions'**
  String get hip3PendingTitle;

  /// No description provided for @hip3PendingRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh actions'**
  String get hip3PendingRefresh;

  /// No description provided for @hip3PendingLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading unfinished actions…'**
  String get hip3PendingLoading;

  /// No description provided for @hip3PendingLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load actions. Refresh to try again.'**
  String get hip3PendingLoadError;

  /// No description provided for @hip3PendingEmpty.
  ///
  /// In en, this message translates to:
  /// **'No unfinished position actions on this page.'**
  String get hip3PendingEmpty;

  /// No description provided for @hip3PendingMore.
  ///
  /// In en, this message translates to:
  /// **'Load more actions'**
  String get hip3PendingMore;

  /// No description provided for @hip3PendingContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue action'**
  String get hip3PendingContinue;

  /// No description provided for @hip3PendingCheck.
  ///
  /// In en, this message translates to:
  /// **'Check progress'**
  String get hip3PendingCheck;

  /// No description provided for @hip3PendingBusy.
  ///
  /// In en, this message translates to:
  /// **'Checking action…'**
  String get hip3PendingBusy;

  /// No description provided for @hip3PendingReview.
  ///
  /// In en, this message translates to:
  /// **'Needs manual review. Do not create a replacement action. Contact support with the action ID.'**
  String get hip3PendingReview;

  /// No description provided for @hip3PendingSignature.
  ///
  /// In en, this message translates to:
  /// **'Waiting for your signature'**
  String get hip3PendingSignature;

  /// No description provided for @hip3PendingProcessing.
  ///
  /// In en, this message translates to:
  /// **'Checking the exchange result'**
  String get hip3PendingProcessing;

  /// No description provided for @hip3PendingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be resumed here.'**
  String get hip3PendingUnavailable;

  /// No description provided for @hip3PendingError.
  ///
  /// In en, this message translates to:
  /// **'Could not continue. Refresh and retry the same action.'**
  String get hip3PendingError;

  /// No description provided for @hip3PendingStillActive.
  ///
  /// In en, this message translates to:
  /// **'The action is still unfinished. Continue this action instead of creating another.'**
  String get hip3PendingStillActive;

  /// No description provided for @hip3PendingComplete.
  ///
  /// In en, this message translates to:
  /// **'Action confirmed'**
  String get hip3PendingComplete;

  /// No description provided for @hip3PendingSetTpsl.
  ///
  /// In en, this message translates to:
  /// **'Set or update TP/SL'**
  String get hip3PendingSetTpsl;

  /// No description provided for @hip3PendingClearTpsl.
  ///
  /// In en, this message translates to:
  /// **'Cancel TP/SL'**
  String get hip3PendingClearTpsl;

  /// No description provided for @hip3PendingLeverage.
  ///
  /// In en, this message translates to:
  /// **'Adjust leverage'**
  String get hip3PendingLeverage;

  /// No description provided for @hip3PendingClose.
  ///
  /// In en, this message translates to:
  /// **'Close position'**
  String get hip3PendingClose;

  /// No description provided for @hip3PendingEffects.
  ///
  /// In en, this message translates to:
  /// **'Earlier steps have already taken effect.'**
  String get hip3PendingEffects;

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'RWA Interface'**
  String get appTitle;

  /// Foundation home screen title
  ///
  /// In en, this message translates to:
  /// **'Application foundation'**
  String get homeTitle;

  /// Button opening the route demonstration
  ///
  /// In en, this message translates to:
  /// **'Open details'**
  String get openDetails;

  /// Route demonstration screen title
  ///
  /// In en, this message translates to:
  /// **'Navigation details'**
  String get detailsTitle;

  /// Unknown route title
  ///
  /// In en, this message translates to:
  /// **'Page not found'**
  String get pageNotFoundTitle;

  /// Unknown route explanation
  ///
  /// In en, this message translates to:
  /// **'This address does not match an application page.'**
  String get pageNotFoundMessage;

  /// Action returning to the root route
  ///
  /// In en, this message translates to:
  /// **'Return home'**
  String get returnHome;

  /// Accessible loading label
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loadingLabel;

  /// Copy action label
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copyLabel;

  /// Successful copy feedback
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copySucceeded;

  /// Failed copy feedback
  ///
  /// In en, this message translates to:
  /// **'Could not copy'**
  String get copyFailed;

  /// Generic cancellation action
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @assetsTitle.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get assetsTitle;

  /// No description provided for @homePortfolio.
  ///
  /// In en, this message translates to:
  /// **'Portfolio'**
  String get homePortfolio;

  /// No description provided for @marketsTitle.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get marketsTitle;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @selectAsset.
  ///
  /// In en, this message translates to:
  /// **'Select asset'**
  String get selectAsset;

  /// No description provided for @searchAssets.
  ///
  /// In en, this message translates to:
  /// **'Search assets'**
  String get searchAssets;

  /// No description provided for @availableToWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Available to withdraw'**
  String get availableToWithdraw;

  /// No description provided for @withdrawUsdc.
  ///
  /// In en, this message translates to:
  /// **'Withdraw USDC'**
  String get withdrawUsdc;

  /// No description provided for @recipientAddress.
  ///
  /// In en, this message translates to:
  /// **'Recipient address'**
  String get recipientAddress;

  /// No description provided for @enterWalletAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter wallet address'**
  String get enterWalletAddress;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @networkFee.
  ///
  /// In en, this message translates to:
  /// **'Network fee'**
  String get networkFee;

  /// No description provided for @reviewWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Review withdrawal'**
  String get reviewWithdrawal;

  /// No description provided for @preparingWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Preparing withdrawal…'**
  String get preparingWithdrawal;

  /// No description provided for @withdrawalDetails.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal details'**
  String get withdrawalDetails;

  /// No description provided for @recipientReceives.
  ///
  /// In en, this message translates to:
  /// **'Recipient receives'**
  String get recipientReceives;

  /// No description provided for @totalDeducted.
  ///
  /// In en, this message translates to:
  /// **'Total deducted'**
  String get totalDeducted;

  /// No description provided for @authorizationRequired.
  ///
  /// In en, this message translates to:
  /// **'Authorization required'**
  String get authorizationRequired;

  /// No description provided for @depositCrypto.
  ///
  /// In en, this message translates to:
  /// **'Deposit crypto'**
  String get depositCrypto;

  /// No description provided for @allSupportedAssets.
  ///
  /// In en, this message translates to:
  /// **'All supported assets'**
  String get allSupportedAssets;

  /// No description provided for @loadingAssets.
  ///
  /// In en, this message translates to:
  /// **'Loading assets'**
  String get loadingAssets;

  /// No description provided for @assetsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Assets unavailable'**
  String get assetsUnavailable;

  /// No description provided for @portfolioValue.
  ///
  /// In en, this message translates to:
  /// **'Portfolio value'**
  String get portfolioValue;

  /// No description provided for @allocation.
  ///
  /// In en, this message translates to:
  /// **'Allocation'**
  String get allocation;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @bstocks.
  ///
  /// In en, this message translates to:
  /// **'bStocks'**
  String get bstocks;

  /// No description provided for @perps.
  ///
  /// In en, this message translates to:
  /// **'Perps'**
  String get perps;

  /// No description provided for @cashBalances.
  ///
  /// In en, this message translates to:
  /// **'Cash balances'**
  String get cashBalances;

  /// No description provided for @portfolioTrend.
  ///
  /// In en, this message translates to:
  /// **'Portfolio trend'**
  String get portfolioTrend;

  /// No description provided for @loadingMarkets.
  ///
  /// In en, this message translates to:
  /// **'Loading markets'**
  String get loadingMarkets;

  /// No description provided for @marketsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Markets unavailable'**
  String get marketsUnavailable;

  /// No description provided for @hip3ChartLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading price history…'**
  String get hip3ChartLoading;

  /// No description provided for @hip3ChartError.
  ///
  /// In en, this message translates to:
  /// **'Could not load price history.'**
  String get hip3ChartError;

  /// No description provided for @hip3ChartEmpty.
  ///
  /// In en, this message translates to:
  /// **'No trades in this period.'**
  String get hip3ChartEmpty;

  /// No description provided for @hip3ChartRetry.
  ///
  /// In en, this message translates to:
  /// **'Refresh chart'**
  String get hip3ChartRetry;

  /// No description provided for @hip3ChartStale.
  ///
  /// In en, this message translates to:
  /// **'Price history may be out of date. Refresh to update.'**
  String get hip3ChartStale;

  /// No description provided for @hip3ChartLine.
  ///
  /// In en, this message translates to:
  /// **'Line chart'**
  String get hip3ChartLine;

  /// No description provided for @hip3ChartCandles.
  ///
  /// In en, this message translates to:
  /// **'Candlestick chart'**
  String get hip3ChartCandles;

  /// No description provided for @hip3ChartReferenceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Reference price history is not available.'**
  String get hip3ChartReferenceUnavailable;

  /// No description provided for @noProductsYet.
  ///
  /// In en, this message translates to:
  /// **'No products yet'**
  String get noProductsYet;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @gainers.
  ///
  /// In en, this message translates to:
  /// **'Gainers'**
  String get gainers;

  /// No description provided for @losers.
  ///
  /// In en, this message translates to:
  /// **'Losers'**
  String get losers;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @editTpSl.
  ///
  /// In en, this message translates to:
  /// **'Edit TP/SL'**
  String get editTpSl;

  /// No description provided for @takeProfit.
  ///
  /// In en, this message translates to:
  /// **'Take profit'**
  String get takeProfit;

  /// No description provided for @stopLoss.
  ///
  /// In en, this message translates to:
  /// **'Stop loss'**
  String get stopLoss;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @takeProfitStopLoss.
  ///
  /// In en, this message translates to:
  /// **'Take profit/stop loss'**
  String get takeProfitStopLoss;

  /// No description provided for @bstocksTpSlUnavailable.
  ///
  /// In en, this message translates to:
  /// **'TP/SL is not available for bStocks orders.'**
  String get bstocksTpSlUnavailable;

  /// No description provided for @saveTpSl.
  ///
  /// In en, this message translates to:
  /// **'Save TP/SL'**
  String get saveTpSl;

  /// No description provided for @tpSlPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Enter trigger prices for this position.'**
  String get tpSlPriceHint;

  /// No description provided for @tpSlSaveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not save TP/SL. Check the prices and try again.'**
  String get tpSlSaveFailed;

  /// No description provided for @orderSubmissionFailed.
  ///
  /// In en, this message translates to:
  /// **'Order was not submitted. Try again.'**
  String get orderSubmissionFailed;

  /// No description provided for @marketPrice.
  ///
  /// In en, this message translates to:
  /// **'Market price'**
  String get marketPrice;

  /// No description provided for @estimatedPrice.
  ///
  /// In en, this message translates to:
  /// **'Estimated price'**
  String get estimatedPrice;

  /// No description provided for @submittingOrder.
  ///
  /// In en, this message translates to:
  /// **'Submitting Order…'**
  String get submittingOrder;

  /// No description provided for @submittingOrderDescription.
  ///
  /// In en, this message translates to:
  /// **'This may take a few moments. You can track the progress on the Details page.'**
  String get submittingOrderDescription;

  /// No description provided for @closeViewLater.
  ///
  /// In en, this message translates to:
  /// **'Close & View Later'**
  String get closeViewLater;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @limitPrice.
  ///
  /// In en, this message translates to:
  /// **'Limit Price'**
  String get limitPrice;

  /// No description provided for @market.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get market;

  /// No description provided for @dragToSet.
  ///
  /// In en, this message translates to:
  /// **'Drag to set'**
  String get dragToSet;

  /// No description provided for @priceDeviation.
  ///
  /// In en, this message translates to:
  /// **'Price deviation'**
  String get priceDeviation;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @tradeUsStockReference.
  ///
  /// In en, this message translates to:
  /// **'US Stock Reference'**
  String get tradeUsStockReference;

  /// No description provided for @tradePremium.
  ///
  /// In en, this message translates to:
  /// **'Premium'**
  String get tradePremium;

  /// No description provided for @tradeSpread.
  ///
  /// In en, this message translates to:
  /// **'Spread'**
  String get tradeSpread;

  /// No description provided for @tradeBestBidAsk.
  ///
  /// In en, this message translates to:
  /// **'Best Bid / Ask'**
  String get tradeBestBidAsk;

  /// No description provided for @tradeAssetRights.
  ///
  /// In en, this message translates to:
  /// **'Asset & Rights'**
  String get tradeAssetRights;

  /// No description provided for @tradeAssetRightsDescription.
  ///
  /// In en, this message translates to:
  /// **'Provides economic exposure to underlying NVIDIA securities. You hold on-chain security tokens within your BSC wallet, not direct ownership of NVIDIA shares.'**
  String get tradeAssetRightsDescription;

  /// No description provided for @tradeIssuer.
  ///
  /// In en, this message translates to:
  /// **'Issuer'**
  String get tradeIssuer;

  /// No description provided for @tradeIssuerValue.
  ///
  /// In en, this message translates to:
  /// **'BTECH Holdings Limited'**
  String get tradeIssuerValue;

  /// No description provided for @tradeBacking.
  ///
  /// In en, this message translates to:
  /// **'Backing'**
  String get tradeBacking;

  /// No description provided for @tradeBackingValue.
  ///
  /// In en, this message translates to:
  /// **'1:1 Backed by Underlying Shares'**
  String get tradeBackingValue;

  /// No description provided for @tradeCorporateActions.
  ///
  /// In en, this message translates to:
  /// **'Corporate Actions'**
  String get tradeCorporateActions;

  /// No description provided for @tradeCorporateActionsValue.
  ///
  /// In en, this message translates to:
  /// **'Automatically Reflected via Multiplier'**
  String get tradeCorporateActionsValue;

  /// No description provided for @tradeDividendTreatment.
  ///
  /// In en, this message translates to:
  /// **'Dividend Treatment'**
  String get tradeDividendTreatment;

  /// No description provided for @tradeDividendTreatmentValue.
  ///
  /// In en, this message translates to:
  /// **'Net Dividends Automatically Reinvested'**
  String get tradeDividendTreatmentValue;

  /// No description provided for @tradeVotingRights.
  ///
  /// In en, this message translates to:
  /// **'Voting Rights'**
  String get tradeVotingRights;

  /// No description provided for @tradeVotingRightsValue.
  ///
  /// In en, this message translates to:
  /// **'No Shareholder Voting Rights'**
  String get tradeVotingRightsValue;

  /// No description provided for @tradeAssetLocation.
  ///
  /// In en, this message translates to:
  /// **'Asset Location'**
  String get tradeAssetLocation;

  /// No description provided for @tradeAssetLocationValue.
  ///
  /// In en, this message translates to:
  /// **'Held in BSC Wallet'**
  String get tradeAssetLocationValue;

  /// No description provided for @tradeMarketHoursTitle.
  ///
  /// In en, this message translates to:
  /// **'US Market Trading Hours'**
  String get tradeMarketHoursTitle;

  /// No description provided for @tradeMarketHoursDescription.
  ///
  /// In en, this message translates to:
  /// **'Market closed indicates no-trading periods, including weekends, US holidays, and daily settlement windows.'**
  String get tradeMarketHoursDescription;

  /// No description provided for @tradePreMarket.
  ///
  /// In en, this message translates to:
  /// **'Pre-Market'**
  String get tradePreMarket;

  /// No description provided for @tradeRegularMarket.
  ///
  /// In en, this message translates to:
  /// **'Regular Market'**
  String get tradeRegularMarket;

  /// No description provided for @tradeAfterHours.
  ///
  /// In en, this message translates to:
  /// **'After-Hours'**
  String get tradeAfterHours;

  /// No description provided for @tradeOvernight.
  ///
  /// In en, this message translates to:
  /// **'Overnight'**
  String get tradeOvernight;

  /// No description provided for @tradeMarketClosed.
  ///
  /// In en, this message translates to:
  /// **'Market Closed'**
  String get tradeMarketClosed;

  /// No description provided for @tradeMediumLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Medium Liquidity'**
  String get tradeMediumLiquidity;

  /// No description provided for @tradeHighLiquidity.
  ///
  /// In en, this message translates to:
  /// **'High Liquidity'**
  String get tradeHighLiquidity;

  /// No description provided for @tradeLowLiquidity.
  ///
  /// In en, this message translates to:
  /// **'Low Liquidity'**
  String get tradeLowLiquidity;

  /// No description provided for @tradeMarketOpensIn.
  ///
  /// In en, this message translates to:
  /// **'US market opens in 04:30:11'**
  String get tradeMarketOpensIn;

  /// No description provided for @tradeMarketClosedSchedule.
  ///
  /// In en, this message translates to:
  /// **'Weekends, US holidays'**
  String get tradeMarketClosedSchedule;

  /// No description provided for @tradeReferencePrice.
  ///
  /// In en, this message translates to:
  /// **'US Stock Reference'**
  String get tradeReferencePrice;

  /// No description provided for @tradeReferenceValue.
  ///
  /// In en, this message translates to:
  /// **'US \$175.22'**
  String get tradeReferenceValue;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading settings'**
  String get settingsLoading;

  /// No description provided for @settingsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Settings unavailable'**
  String get settingsUnavailable;

  /// No description provided for @settingsRetry.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh and try again.'**
  String get settingsRetry;

  /// No description provided for @settingsActiveAccount.
  ///
  /// In en, this message translates to:
  /// **'Active Account'**
  String get settingsActiveAccount;

  /// No description provided for @settingsPasskey.
  ///
  /// In en, this message translates to:
  /// **'Passkey'**
  String get settingsPasskey;

  /// No description provided for @settingsPasskeyNotSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get settingsPasskeyNotSet;

  /// No description provided for @settingsPasskeyNotSetUp.
  ///
  /// In en, this message translates to:
  /// **'Not set up'**
  String get settingsPasskeyNotSetUp;

  /// No description provided for @settingsPasskeyEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get settingsPasskeyEnabled;

  /// No description provided for @settingsPasskeyDescription.
  ///
  /// In en, this message translates to:
  /// **'Use Face ID, Touch ID, or your device security to sign in faster.'**
  String get settingsPasskeyDescription;

  /// No description provided for @settingsPasskeySetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Up Passkey'**
  String get settingsPasskeySetupTitle;

  /// No description provided for @settingsPasskeySetupDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign in faster using Face ID, Touch ID, or your device security.'**
  String get settingsPasskeySetupDescription;

  /// No description provided for @settingsPasskeyRemoveDescription.
  ///
  /// In en, this message translates to:
  /// **'Passkey is enabled for this account.'**
  String get settingsPasskeyRemoveDescription;

  /// No description provided for @settingsPasskeyExistingMethods.
  ///
  /// In en, this message translates to:
  /// **'Your existing login methods will still work.'**
  String get settingsPasskeyExistingMethods;

  /// No description provided for @settingsPasskeySetUpAction.
  ///
  /// In en, this message translates to:
  /// **'Set Up'**
  String get settingsPasskeySetUpAction;

  /// No description provided for @settingsPasskeyRemoveAction.
  ///
  /// In en, this message translates to:
  /// **'Remove Passkey'**
  String get settingsPasskeyRemoveAction;

  /// No description provided for @settingsNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not Now'**
  String get settingsNotNow;

  /// No description provided for @settingsPasskeySetupSucceeded.
  ///
  /// In en, this message translates to:
  /// **'Passkey set up successfully'**
  String get settingsPasskeySetupSucceeded;

  /// No description provided for @settingsPasskeySetupFailed.
  ///
  /// In en, this message translates to:
  /// **'Passkey setup failed. Please try again.'**
  String get settingsPasskeySetupFailed;

  /// No description provided for @settingsPasskeyRemoveSucceeded.
  ///
  /// In en, this message translates to:
  /// **'Passkey removed'**
  String get settingsPasskeyRemoveSucceeded;

  /// No description provided for @settingsPasskeyRemoveFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not remove passkey. Please try again.'**
  String get settingsPasskeyRemoveFailed;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSimplifiedChinese.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get languageSimplifiedChinese;

  /// No description provided for @settingsExportPrivateKey.
  ///
  /// In en, this message translates to:
  /// **'Export Private Key'**
  String get settingsExportPrivateKey;

  /// No description provided for @settingsPrivateKeyWarning.
  ///
  /// In en, this message translates to:
  /// **'Never share your private key with anyone. Anyone with this information can control your wallet.'**
  String get settingsPrivateKeyWarning;

  /// No description provided for @settingsCheckUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for Updates'**
  String get settingsCheckUpdates;

  /// No description provided for @settingsAppVersion.
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get settingsAppVersion;

  /// No description provided for @settingsUpToDate.
  ///
  /// In en, this message translates to:
  /// **'You\'\'re on the latest version.'**
  String get settingsUpToDate;

  /// No description provided for @settingsUpdateCheckFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not check for updates.'**
  String get settingsUpdateCheckFailed;

  /// No description provided for @settingsUpdateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No update source is available for this platform.'**
  String get settingsUpdateUnavailable;

  /// No description provided for @settingsUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get settingsUpdateAvailable;

  /// No description provided for @settingsUpdateAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Version {version} is available.'**
  String settingsUpdateAvailableMessage(Object version);

  /// No description provided for @settingsUpdateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get settingsUpdateNow;

  /// No description provided for @settingsCacheSize.
  ///
  /// In en, this message translates to:
  /// **'Cache Size'**
  String get settingsCacheSize;

  /// No description provided for @settingsClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get settingsClearCache;

  /// No description provided for @settingsTermsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get settingsTermsConditions;

  /// No description provided for @settingsLogOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get settingsLogOut;

  /// No description provided for @settingsLogOutQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get settingsLogOutQuestion;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountMessage.
  ///
  /// In en, this message translates to:
  /// **'Account deletion is not available from this version of the app.'**
  String get settingsDeleteAccountMessage;

  /// No description provided for @activityTitle.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activityTitle;

  /// No description provided for @activityAllProducts.
  ///
  /// In en, this message translates to:
  /// **'All product'**
  String get activityAllProducts;

  /// No description provided for @activityType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get activityType;

  /// No description provided for @activityStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get activityStatus;

  /// No description provided for @activityFilterStatus.
  ///
  /// In en, this message translates to:
  /// **'Filter status'**
  String get activityFilterStatus;

  /// No description provided for @activityAllStatuses.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get activityAllStatuses;

  /// No description provided for @activityOrders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get activityOrders;

  /// No description provided for @activityFunding.
  ///
  /// In en, this message translates to:
  /// **'Funding'**
  String get activityFunding;

  /// No description provided for @activityApprovals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get activityApprovals;

  /// No description provided for @activityInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get activityInProgress;

  /// No description provided for @activityCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get activityCompleted;

  /// No description provided for @activityFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get activityFailed;

  /// No description provided for @activityCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get activityCancelled;

  /// No description provided for @activityUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get activityUnknown;

  /// No description provided for @activityLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading activity'**
  String get activityLoading;

  /// No description provided for @activityUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Activity unavailable'**
  String get activityUnavailable;

  /// No description provided for @activityRetry.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh and try again.'**
  String get activityRetry;

  /// No description provided for @activityEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get activityEmptyTitle;

  /// No description provided for @activityEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Your orders and funding events will appear here.'**
  String get activityEmptyMessage;

  /// No description provided for @activityCopyReference.
  ///
  /// In en, this message translates to:
  /// **'Copy activity reference'**
  String get activityCopyReference;

  /// No description provided for @tradeBasis.
  ///
  /// In en, this message translates to:
  /// **'Basis'**
  String get tradeBasis;

  /// No description provided for @tradePerpAssetRightsDescription.
  ///
  /// In en, this message translates to:
  /// **'Perpetual contracts provide price exposure to NVIDIA only; they do not grant stocks, on-chain security tokens, or corporate shareholder rights.'**
  String get tradePerpAssetRightsDescription;

  /// No description provided for @tradeProductType.
  ///
  /// In en, this message translates to:
  /// **'Product Type'**
  String get tradeProductType;

  /// No description provided for @tradePerpProductType.
  ///
  /// In en, this message translates to:
  /// **'HIP-3 Perpetual Contract'**
  String get tradePerpProductType;

  /// No description provided for @tradeUnderlyingExposure.
  ///
  /// In en, this message translates to:
  /// **'Underlying Exposure'**
  String get tradeUnderlyingExposure;

  /// No description provided for @tradePriceExposureOnly.
  ///
  /// In en, this message translates to:
  /// **'Price Exposure Only'**
  String get tradePriceExposureOnly;

  /// No description provided for @tradeShareOwnership.
  ///
  /// In en, this message translates to:
  /// **'Share Ownership'**
  String get tradeShareOwnership;

  /// No description provided for @tradeNoShareOwnership.
  ///
  /// In en, this message translates to:
  /// **'No Ownership of Underlying Shares'**
  String get tradeNoShareOwnership;

  /// No description provided for @tradeDividendRights.
  ///
  /// In en, this message translates to:
  /// **'Dividend Rights'**
  String get tradeDividendRights;

  /// No description provided for @tradeNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get tradeNone;

  /// No description provided for @tradePositionType.
  ///
  /// In en, this message translates to:
  /// **'Position Type'**
  String get tradePositionType;

  /// No description provided for @tradePerpPositionType.
  ///
  /// In en, this message translates to:
  /// **'HIP-3 Perpetual Position'**
  String get tradePerpPositionType;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
