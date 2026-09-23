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

  /// No description provided for @signAndConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign and confirm'**
  String get signAndConfirm;

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

  /// No description provided for @signatureDetails.
  ///
  /// In en, this message translates to:
  /// **'Signature Details'**
  String get signatureDetails;

  /// No description provided for @signAndWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Sign & Withdraw {symbol}'**
  String signAndWithdraw(Object symbol);

  /// No description provided for @signatureFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get signatureFrom;

  /// No description provided for @signatureTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get signatureTo;

  /// No description provided for @signatureValue.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get signatureValue;

  /// No description provided for @signatureData.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get signatureData;

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

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @receive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receive;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @orderValue.
  ///
  /// In en, this message translates to:
  /// **'Order Value'**
  String get orderValue;

  /// No description provided for @estimatedFee.
  ///
  /// In en, this message translates to:
  /// **'Estimated Fee'**
  String get estimatedFee;

  /// No description provided for @orderType.
  ///
  /// In en, this message translates to:
  /// **'Order Type'**
  String get orderType;

  /// No description provided for @market.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get market;

  /// No description provided for @limit.
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get limit;

  /// No description provided for @orderSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Order submitted'**
  String get orderSubmitted;

  /// No description provided for @availableMargin.
  ///
  /// In en, this message translates to:
  /// **'Available margin'**
  String get availableMargin;

  /// No description provided for @orderNotional.
  ///
  /// In en, this message translates to:
  /// **'Order notional'**
  String get orderNotional;

  /// No description provided for @preparingOrder.
  ///
  /// In en, this message translates to:
  /// **'Preparing order…'**
  String get preparingOrder;

  /// No description provided for @submitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting...'**
  String get submitting;

  /// No description provided for @checkingOrder.
  ///
  /// In en, this message translates to:
  /// **'Checking order...'**
  String get checkingOrder;

  /// No description provided for @tradeSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Trade Successful'**
  String get tradeSuccessful;

  /// No description provided for @long.
  ///
  /// In en, this message translates to:
  /// **'Long'**
  String get long;

  /// No description provided for @short.
  ///
  /// In en, this message translates to:
  /// **'Short'**
  String get short;

  /// No description provided for @closePosition.
  ///
  /// In en, this message translates to:
  /// **'Close Position'**
  String get closePosition;

  /// No description provided for @closeAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get closeAmount;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @slippage.
  ///
  /// In en, this message translates to:
  /// **'Slippage'**
  String get slippage;

  /// No description provided for @validOrderValue.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid order value.'**
  String get validOrderValue;

  /// No description provided for @validLimitPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid limit price.'**
  String get validLimitPrice;

  /// No description provided for @prepareOrderFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to prepare this order. Try again.'**
  String get prepareOrderFailed;

  /// No description provided for @prepareFundingFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to prepare funding for this order. Try again.'**
  String get prepareFundingFailed;

  /// No description provided for @willReceive.
  ///
  /// In en, this message translates to:
  /// **'Will receive'**
  String get willReceive;

  /// No description provided for @slippageTolerance.
  ///
  /// In en, this message translates to:
  /// **'Slippage tolerance'**
  String get slippageTolerance;

  /// No description provided for @maximumSlippage.
  ///
  /// In en, this message translates to:
  /// **'Maximum slippage'**
  String get maximumSlippage;

  /// No description provided for @editSlippage.
  ///
  /// In en, this message translates to:
  /// **'Edit slippage'**
  String get editSlippage;

  /// No description provided for @priceChangedReview.
  ///
  /// In en, this message translates to:
  /// **'Price changed. Review the updated estimate before submitting.'**
  String get priceChangedReview;

  /// No description provided for @viewHistory.
  ///
  /// In en, this message translates to:
  /// **'View History'**
  String get viewHistory;

  /// No description provided for @chooseMarginLeverage.
  ///
  /// In en, this message translates to:
  /// **'Choose a supported margin mode and leverage before requesting a signature.'**
  String get chooseMarginLeverage;

  /// No description provided for @settingsNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Settings are not confirmed. Resume the same request before opening an order.'**
  String get settingsNotConfirmed;

  /// No description provided for @enterOrderValue.
  ///
  /// In en, this message translates to:
  /// **'Enter an order value.'**
  String get enterOrderValue;

  /// No description provided for @minimumAmountPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Min {minimum}'**
  String minimumAmountPlaceholder(Object minimum);

  /// No description provided for @enterValidOrderValues.
  ///
  /// In en, this message translates to:
  /// **'Enter valid order values.'**
  String get enterValidOrderValues;

  /// No description provided for @orderQuoteUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This quote is unavailable or expired. Request a new quote before placing the order.'**
  String get orderQuoteUnavailable;

  /// No description provided for @hip3TradingContextUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Trading service is unavailable. Try again in a moment.'**
  String get hip3TradingContextUnavailable;

  /// No description provided for @hip3LeverageAboveMaximum.
  ///
  /// In en, this message translates to:
  /// **'Leverage exceeds the {maximum}x limit for this product.'**
  String hip3LeverageAboveMaximum(Object maximum);

  /// No description provided for @hip3MarginModeUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This product does not support the selected margin mode.'**
  String get hip3MarginModeUnsupported;

  /// No description provided for @hip3PlaceOrderUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Opening orders is unavailable for this product right now.'**
  String get hip3PlaceOrderUnsupported;

  /// No description provided for @hip3ClientSignedTradingUnavailable.
  ///
  /// In en, this message translates to:
  /// **'In-app signed trading is not open for this product yet.'**
  String get hip3ClientSignedTradingUnavailable;

  /// No description provided for @hip3OrderTypeUnsupported.
  ///
  /// In en, this message translates to:
  /// **'This product does not support the selected order type.'**
  String get hip3OrderTypeUnsupported;

  /// No description provided for @hip3NotionalBelowMinimum.
  ///
  /// In en, this message translates to:
  /// **'Order value is below the {minimum} USDC minimum.'**
  String hip3NotionalBelowMinimum(Object minimum);

  /// No description provided for @hip3NotionalAboveMaximum.
  ///
  /// In en, this message translates to:
  /// **'Order value is above the {maximum} USDC maximum.'**
  String hip3NotionalAboveMaximum(Object maximum);

  /// No description provided for @hip3InsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance.'**
  String get hip3InsufficientBalance;

  /// No description provided for @hip3MaximumLeverageHint.
  ///
  /// In en, this message translates to:
  /// **'Max {maximum}x'**
  String hip3MaximumLeverageHint(Object maximum);

  /// No description provided for @hip3OrderValueRangeHint.
  ///
  /// In en, this message translates to:
  /// **'Allowed {minimum}-{maximum} USDC'**
  String hip3OrderValueRangeHint(Object minimum, Object maximum);

  /// No description provided for @hip3OrderValueMinimumHint.
  ///
  /// In en, this message translates to:
  /// **'Allowed from {minimum} USDC'**
  String hip3OrderValueMinimumHint(Object minimum);

  /// No description provided for @walletConnectRequired.
  ///
  /// In en, this message translates to:
  /// **'Connect the wallet requested for this order.'**
  String get walletConnectRequired;

  /// No description provided for @signatureCancelled.
  ///
  /// In en, this message translates to:
  /// **'Signature request was cancelled.'**
  String get signatureCancelled;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @checkOrderStatus.
  ///
  /// In en, this message translates to:
  /// **'Check order status'**
  String get checkOrderStatus;

  /// No description provided for @invalidSlippage.
  ///
  /// In en, this message translates to:
  /// **'Enter a slippage percentage from 0% to 100%.'**
  String get invalidSlippage;

  /// No description provided for @liquidationPrice.
  ///
  /// In en, this message translates to:
  /// **'Liquidation Price'**
  String get liquidationPrice;

  /// No description provided for @marginRequired.
  ///
  /// In en, this message translates to:
  /// **'Margin Required'**
  String get marginRequired;

  /// No description provided for @maximumQuantity.
  ///
  /// In en, this message translates to:
  /// **'Maximum quantity'**
  String get maximumQuantity;

  /// No description provided for @marginMode.
  ///
  /// In en, this message translates to:
  /// **'Margin mode'**
  String get marginMode;

  /// No description provided for @chooseMarginMode.
  ///
  /// In en, this message translates to:
  /// **'Choose a margin mode:'**
  String get chooseMarginMode;

  /// No description provided for @crossMarginDescription.
  ///
  /// In en, this message translates to:
  /// **'Shares margin across positions'**
  String get crossMarginDescription;

  /// No description provided for @isolatedMarginDescription.
  ///
  /// In en, this message translates to:
  /// **'Uses margin for this position only'**
  String get isolatedMarginDescription;

  /// No description provided for @leverage.
  ///
  /// In en, this message translates to:
  /// **'Leverage'**
  String get leverage;

  /// No description provided for @dragToSetLeverage.
  ///
  /// In en, this message translates to:
  /// **'Drag to set leverage'**
  String get dragToSetLeverage;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @cross.
  ///
  /// In en, this message translates to:
  /// **'Cross'**
  String get cross;

  /// No description provided for @isolated.
  ///
  /// In en, this message translates to:
  /// **'Isolated'**
  String get isolated;

  /// No description provided for @marginModeLabel.
  ///
  /// In en, this message translates to:
  /// **'{mode} margin mode'**
  String marginModeLabel(Object mode);

  /// No description provided for @addFundsFrom.
  ///
  /// In en, this message translates to:
  /// **'Add funds from:'**
  String get addFundsFrom;

  /// No description provided for @inAppTransfer.
  ///
  /// In en, this message translates to:
  /// **'In-App Transfer'**
  String get inAppTransfer;

  /// No description provided for @externalDeposit.
  ///
  /// In en, this message translates to:
  /// **'External Deposit'**
  String get externalDeposit;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available balance'**
  String get availableBalance;

  /// No description provided for @loadMore.
  ///
  /// In en, this message translates to:
  /// **'Load more'**
  String get loadMore;

  /// No description provided for @refreshOrders.
  ///
  /// In en, this message translates to:
  /// **'Refresh orders'**
  String get refreshOrders;

  /// No description provided for @openOrdersUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Open orders unavailable'**
  String get openOrdersUnavailable;

  /// No description provided for @noOpenOrders.
  ///
  /// In en, this message translates to:
  /// **'No open orders'**
  String get noOpenOrders;

  /// No description provided for @liquidation.
  ///
  /// In en, this message translates to:
  /// **'Liquidation'**
  String get liquidation;

  /// No description provided for @protectionSize.
  ///
  /// In en, this message translates to:
  /// **'Protection size'**
  String get protectionSize;

  /// No description provided for @entirePositionDefault.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get entirePositionDefault;

  /// No description provided for @fixedQuantity.
  ///
  /// In en, this message translates to:
  /// **'Fixed quantity'**
  String get fixedQuantity;

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

  /// No description provided for @takeProfitStopLoss.
  ///
  /// In en, this message translates to:
  /// **'Take profit/stop loss'**
  String get takeProfitStopLoss;

  /// No description provided for @takeProfitStopLossTitle.
  ///
  /// In en, this message translates to:
  /// **'Take Profit & stop loss'**
  String get takeProfitStopLossTitle;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @hip3OrderTpSl.
  ///
  /// In en, this message translates to:
  /// **'Order TP/SL'**
  String get hip3OrderTpSl;

  /// No description provided for @hip3PositionTpSl.
  ///
  /// In en, this message translates to:
  /// **'Position TP/SL'**
  String get hip3PositionTpSl;

  /// No description provided for @hip3PositionProtectionScope.
  ///
  /// In en, this message translates to:
  /// **'This editor manages position TP/SL only. Opening-order TP/SL is separate; check its activation and quantity in Orders. Empty fields here do not mean all protection is absent.'**
  String get hip3PositionProtectionScope;

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

  /// No description provided for @tradeBstocksUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No bStocks market'**
  String get tradeBstocksUnavailable;

  /// No description provided for @tradePerpUnavailable.
  ///
  /// In en, this message translates to:
  /// **'No HIP-3 perpetual market'**
  String get tradePerpUnavailable;

  /// No description provided for @tradeProductUnavailableDescription.
  ///
  /// In en, this message translates to:
  /// **'{symbol} is not listed on this product yet. Switch back to the other tab to keep trading.'**
  String tradeProductUnavailableDescription(Object symbol);

  /// No description provided for @tradeMarketHoursDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Market closed indicates no-trading periods, including weekends, US holidays, and daily settlement windows.'**
  String get tradeMarketHoursDisclaimer;

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
  /// **'US market opens in {countdown}'**
  String tradeMarketOpensIn(Object countdown);

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
  /// **'Sign in on the web to export\nyour private key'**
  String get settingsPrivateKeyWarning;

  /// No description provided for @settingsPrivateKeyContinue.
  ///
  /// In en, this message translates to:
  /// **'Sign in on the web'**
  String get settingsPrivateKeyContinue;

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
  /// **'This requests permanent deletion of your product account and eligible product data. It does not delete your wallet, blockchain assets, or blockchain history.'**
  String get settingsDeleteAccountMessage;

  /// No description provided for @settingsDeleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get settingsDeleteAccountConfirm;

  /// No description provided for @settingsDeleteAccountAccepted.
  ///
  /// In en, this message translates to:
  /// **'Account deletion requested. You have been signed out.'**
  String get settingsDeleteAccountAccepted;

  /// No description provided for @settingsDeleteAccountRecentAuth.
  ///
  /// In en, this message translates to:
  /// **'For your security, sign out, sign in again, and retry account deletion.'**
  String get settingsDeleteAccountRecentAuth;

  /// No description provided for @settingsDeleteAccountBlocked.
  ///
  /// In en, this message translates to:
  /// **'Account deletion is blocked by open orders, positions, funds in transit, remaining assets, or a required review. Resolve them and try again.'**
  String get settingsDeleteAccountBlocked;

  /// No description provided for @settingsDeleteAccountFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to request account deletion. Try again later.'**
  String get settingsDeleteAccountFailed;

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

  /// No description provided for @navigationHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navigationHome;

  /// No description provided for @navigationMarkets.
  ///
  /// In en, this message translates to:
  /// **'Markets'**
  String get navigationMarkets;

  /// No description provided for @navigationAssets.
  ///
  /// In en, this message translates to:
  /// **'Assets'**
  String get navigationAssets;

  /// No description provided for @navigationActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get navigationActivity;

  /// No description provided for @requestFailed.
  ///
  /// In en, this message translates to:
  /// **'Request failed'**
  String get requestFailed;

  /// No description provided for @noFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get noFavoritesYet;

  /// No description provided for @favoritesEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap the star on any market to save it here.'**
  String get favoritesEmptyDescription;

  /// No description provided for @exploreMarkets.
  ///
  /// In en, this message translates to:
  /// **'Explore markets'**
  String get exploreMarkets;

  /// No description provided for @searchMarkets.
  ///
  /// In en, this message translates to:
  /// **'Search markets'**
  String get searchMarkets;

  /// No description provided for @searchTickerOrCompany.
  ///
  /// In en, this message translates to:
  /// **'Search ticker or company'**
  String get searchTickerOrCompany;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @loadingProducts.
  ///
  /// In en, this message translates to:
  /// **'Loading products'**
  String get loadingProducts;

  /// No description provided for @pullToRefreshRetry.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh and try again.'**
  String get pullToRefreshRetry;

  /// No description provided for @noMatchingProducts.
  ///
  /// In en, this message translates to:
  /// **'No matching products'**
  String get noMatchingProducts;

  /// No description provided for @tryAnotherSearchOrFilter.
  ///
  /// In en, this message translates to:
  /// **'Try another search or product filter.'**
  String get tryAnotherSearchOrFilter;

  /// No description provided for @usMarket.
  ///
  /// In en, this message translates to:
  /// **'US Market'**
  String get usMarket;

  /// No description provided for @usMarketStatus.
  ///
  /// In en, this message translates to:
  /// **'US market status'**
  String get usMarketStatus;

  /// No description provided for @marketHours.
  ///
  /// In en, this message translates to:
  /// **'Market hours'**
  String get marketHours;

  /// No description provided for @stocks.
  ///
  /// In en, this message translates to:
  /// **'Stocks'**
  String get stocks;

  /// No description provided for @browseAll.
  ///
  /// In en, this message translates to:
  /// **'Browse all'**
  String get browseAll;

  /// No description provided for @filterProducts.
  ///
  /// In en, this message translates to:
  /// **'Filter products'**
  String get filterProducts;

  /// No description provided for @allProducts.
  ///
  /// In en, this message translates to:
  /// **'All products'**
  String get allProducts;

  /// No description provided for @hip3Perps.
  ///
  /// In en, this message translates to:
  /// **'HIP-3 Perps'**
  String get hip3Perps;

  /// No description provided for @openTradeDetails.
  ///
  /// In en, this message translates to:
  /// **'Open {symbol} trade details'**
  String openTradeDetails(Object symbol);

  /// No description provided for @clearSearch.
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// No description provided for @loadingRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'Loading recent searches'**
  String get loadingRecentSearches;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent searches'**
  String get recentSearches;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @noRecentSearches.
  ///
  /// In en, this message translates to:
  /// **'No recent searches'**
  String get noRecentSearches;

  /// No description provided for @browseAllStocks.
  ///
  /// In en, this message translates to:
  /// **'Browse all stocks'**
  String get browseAllStocks;

  /// No description provided for @allStocks.
  ///
  /// In en, this message translates to:
  /// **'All stocks'**
  String get allStocks;

  /// No description provided for @loadingStocks.
  ///
  /// In en, this message translates to:
  /// **'Loading stocks'**
  String get loadingStocks;

  /// No description provided for @stocksUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Stocks unavailable'**
  String get stocksUnavailable;

  /// No description provided for @marketCatalogUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Try again when the market catalog is available.'**
  String get marketCatalogUnavailable;

  /// No description provided for @noMatchingMarkets.
  ///
  /// In en, this message translates to:
  /// **'No matching markets'**
  String get noMatchingMarkets;

  /// No description provided for @tryAnotherTickerOrCompany.
  ///
  /// In en, this message translates to:
  /// **'Try another ticker or company name.'**
  String get tryAnotherTickerOrCompany;

  /// No description provided for @noStocksFound.
  ///
  /// In en, this message translates to:
  /// **'No stocks found'**
  String get noStocksFound;

  /// No description provided for @searchResultCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 result} other{{count} results}}'**
  String searchResultCount(num count);

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @closeDepositRoutes.
  ///
  /// In en, this message translates to:
  /// **'Close deposit routes'**
  String get closeDepositRoutes;

  /// No description provided for @depositChooseRoute.
  ///
  /// In en, this message translates to:
  /// **'Choose a recommended route, or browse all supported assets.'**
  String get depositChooseRoute;

  /// No description provided for @depositRoutesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Deposit routes unavailable'**
  String get depositRoutesUnavailable;

  /// No description provided for @noDepositRoutes.
  ///
  /// In en, this message translates to:
  /// **'No deposit routes available'**
  String get noDepositRoutes;

  /// No description provided for @tryAgainLater.
  ///
  /// In en, this message translates to:
  /// **'Try again later.'**
  String get tryAgainLater;

  /// No description provided for @depositOn.
  ///
  /// In en, this message translates to:
  /// **'Deposit {token} on {chain}'**
  String depositOn(Object token, Object chain);

  /// No description provided for @bestFor.
  ///
  /// In en, this message translates to:
  /// **'Best for {product}'**
  String bestFor(Object product);

  /// No description provided for @allSupportedAssetsDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose another available asset and network'**
  String get allSupportedAssetsDescription;

  /// No description provided for @depositRouteRequired.
  ///
  /// In en, this message translates to:
  /// **'Deposit route required'**
  String get depositRouteRequired;

  /// No description provided for @depositRouteRequiredDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose a supported route to receive an address.'**
  String get depositRouteRequiredDescription;

  /// No description provided for @loadingDepositInstructions.
  ///
  /// In en, this message translates to:
  /// **'Loading deposit instructions'**
  String get loadingDepositInstructions;

  /// No description provided for @depositInstructionsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Deposit instructions unavailable'**
  String get depositInstructionsUnavailable;

  /// No description provided for @returnToDepositRoutes.
  ///
  /// In en, this message translates to:
  /// **'Return to deposit routes and try again.'**
  String get returnToDepositRoutes;

  /// No description provided for @depositAssets.
  ///
  /// In en, this message translates to:
  /// **'Deposit assets'**
  String get depositAssets;

  /// No description provided for @depositReceived.
  ///
  /// In en, this message translates to:
  /// **'Deposit received'**
  String get depositReceived;

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get gotIt;

  /// No description provided for @backToDepositRoutes.
  ///
  /// In en, this message translates to:
  /// **'Back to deposit routes'**
  String get backToDepositRoutes;

  /// No description provided for @depositQrCode.
  ///
  /// In en, this message translates to:
  /// **'Deposit QR code'**
  String get depositQrCode;

  /// No description provided for @depositAddress.
  ///
  /// In en, this message translates to:
  /// **'Deposit address'**
  String get depositAddress;

  /// No description provided for @routeDetails.
  ///
  /// In en, this message translates to:
  /// **'Route details'**
  String get routeDetails;

  /// No description provided for @sendTokenOnChainOnly.
  ///
  /// In en, this message translates to:
  /// **'Send {token} on {chain} only.'**
  String sendTokenOnChainOnly(Object token, Object chain);

  /// No description provided for @minimumDeposit.
  ///
  /// In en, this message translates to:
  /// **'Minimum deposit'**
  String get minimumDeposit;

  /// No description provided for @estimatedArrival.
  ///
  /// In en, this message translates to:
  /// **'Estimated arrival'**
  String get estimatedArrival;

  /// No description provided for @confirmationsRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirmations required'**
  String get confirmationsRequired;

  /// No description provided for @loadingSupportedAssets.
  ///
  /// In en, this message translates to:
  /// **'Loading supported assets'**
  String get loadingSupportedAssets;

  /// No description provided for @supportedAssetsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Supported assets unavailable'**
  String get supportedAssetsUnavailable;

  /// No description provided for @noAdditionalDepositRoutes.
  ///
  /// In en, this message translates to:
  /// **'No additional deposit routes available'**
  String get noAdditionalDepositRoutes;

  /// No description provided for @withdrawToken.
  ///
  /// In en, this message translates to:
  /// **'Withdraw {token}'**
  String withdrawToken(Object token);

  /// No description provided for @enterRecipientAddressAndAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a recipient address and amount.'**
  String get enterRecipientAddressAndAmount;

  /// No description provided for @enterValidWalletAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid wallet address.'**
  String get enterValidWalletAddress;

  /// No description provided for @enterValidTokenAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid {token} amount.'**
  String enterValidTokenAmount(Object token);

  /// No description provided for @prepareWithdrawalFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to prepare this withdrawal. Try again.'**
  String get prepareWithdrawalFailed;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @availableToken.
  ///
  /// In en, this message translates to:
  /// **'Available {token}'**
  String availableToken(Object token);

  /// No description provided for @availableTokenAmount.
  ///
  /// In en, this message translates to:
  /// **'Available {amount} {token}'**
  String availableTokenAmount(Object amount, Object token);

  /// No description provided for @confirmingWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Confirming withdrawal…'**
  String get confirmingWithdrawal;

  /// No description provided for @withdrawalSucceeded.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal successful'**
  String get withdrawalSucceeded;

  /// No description provided for @balanceRefreshFailed.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal submitted. Balance is still updating.'**
  String get balanceRefreshFailed;

  /// No description provided for @walletUpgradeTitle.
  ///
  /// In en, this message translates to:
  /// **'Upgrade this wallet?'**
  String get walletUpgradeTitle;

  /// No description provided for @walletUpgradeNotice.
  ///
  /// In en, this message translates to:
  /// **'To cover the network fee for you, this wallet is upgraded to a smart contract account (EIP-7702). The upgrade happens once, your wallet address does not change, and you keep full control of the wallet.'**
  String get walletUpgradeNotice;

  /// No description provided for @walletUpgradeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Upgrade and continue'**
  String get walletUpgradeConfirm;

  /// No description provided for @sponsoredGasUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Network fee not covered'**
  String get sponsoredGasUnavailableTitle;

  /// No description provided for @sponsoredGasUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'The platform cannot cover this network fee right now. Continue by paying about {fee} {asset} from this wallet.'**
  String sponsoredGasUnavailableMessage(Object fee, Object asset);

  /// No description provided for @sponsoredGasUnavailableConfirm.
  ///
  /// In en, this message translates to:
  /// **'Pay the fee myself'**
  String get sponsoredGasUnavailableConfirm;

  /// No description provided for @insufficientGasForWithdrawal.
  ///
  /// In en, this message translates to:
  /// **'Not enough {asset} to pay the network fee. Add {asset} to this wallet and try again.'**
  String insufficientGasForWithdrawal(Object asset);

  /// No description provided for @networkFeesMayChange.
  ///
  /// In en, this message translates to:
  /// **'Network fees may change before confirmation.'**
  String get networkFeesMayChange;

  /// No description provided for @youAreSending.
  ///
  /// In en, this message translates to:
  /// **'You are sending'**
  String get youAreSending;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @finalNetworkFeeMayVary.
  ///
  /// In en, this message translates to:
  /// **'The final network fee may vary slightly.'**
  String get finalNetworkFeeMayVary;

  /// No description provided for @unableToLoadAssets.
  ///
  /// In en, this message translates to:
  /// **'Unable to load assets'**
  String get unableToLoadAssets;

  /// No description provided for @checkConnectionRetry.
  ///
  /// In en, this message translates to:
  /// **'Check your connection and try again.'**
  String get checkConnectionRetry;

  /// No description provided for @noAssetsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No assets available'**
  String get noAssetsAvailable;

  /// No description provided for @noMatchingAssets.
  ///
  /// In en, this message translates to:
  /// **'No matching assets'**
  String get noMatchingAssets;

  /// No description provided for @assetsWithBalanceAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Assets with an available balance will appear here.'**
  String get assetsWithBalanceAppearHere;

  /// No description provided for @tryDifferentAssetOrNetwork.
  ///
  /// In en, this message translates to:
  /// **'Try a different asset name or network.'**
  String get tryDifferentAssetOrNetwork;

  /// No description provided for @token.
  ///
  /// In en, this message translates to:
  /// **'Token'**
  String get token;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get logIn;

  /// No description provided for @portfolioUnavailable.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'\'t load your portfolio'**
  String get portfolioUnavailable;

  /// No description provided for @marketsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'We couldn\'\'t load the markets'**
  String get marketsLoadFailed;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @readyWhenYouAre.
  ///
  /// In en, this message translates to:
  /// **'Ready when you are'**
  String get readyWhenYouAre;

  /// No description provided for @loginToViewPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Log in to view your portfolio and start trading.'**
  String get loginToViewPortfolio;

  /// No description provided for @loginToViewAssets.
  ///
  /// In en, this message translates to:
  /// **'Log in to view your assets'**
  String get loginToViewAssets;

  /// No description provided for @portfolioBalancesAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your portfolio and balances will appear here.'**
  String get portfolioBalancesAppearHere;

  /// No description provided for @noAssetsYet.
  ///
  /// In en, this message translates to:
  /// **'No assets yet'**
  String get noAssetsYet;

  /// No description provided for @depositToBuildPortfolio.
  ///
  /// In en, this message translates to:
  /// **'Deposit a supported asset to start building your portfolio.'**
  String get depositToBuildPortfolio;

  /// No description provided for @viewPortfolioTrend.
  ///
  /// In en, this message translates to:
  /// **'View portfolio trend'**
  String get viewPortfolioTrend;

  /// No description provided for @collapseAllocation.
  ///
  /// In en, this message translates to:
  /// **'Collapse allocation'**
  String get collapseAllocation;

  /// No description provided for @expandAllocation.
  ///
  /// In en, this message translates to:
  /// **'Expand allocation'**
  String get expandAllocation;

  /// No description provided for @allocationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Allocation unavailable'**
  String get allocationUnavailable;

  /// No description provided for @noCashBalances.
  ///
  /// In en, this message translates to:
  /// **'No cash balances'**
  String get noCashBalances;

  /// No description provided for @cashBalancesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Cash balances unavailable'**
  String get cashBalancesUnavailable;

  /// No description provided for @depositToAddCash.
  ///
  /// In en, this message translates to:
  /// **'Deposit a supported asset to add cash here.'**
  String get depositToAddCash;

  /// No description provided for @loadingCashBalances.
  ///
  /// In en, this message translates to:
  /// **'Loading cash balances'**
  String get loadingCashBalances;

  /// No description provided for @loadingHoldings.
  ///
  /// In en, this message translates to:
  /// **'Loading holdings'**
  String get loadingHoldings;

  /// No description provided for @holdingsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Holdings unavailable'**
  String get holdingsUnavailable;

  /// No description provided for @holdingReturn.
  ///
  /// In en, this message translates to:
  /// **'Holding return'**
  String get holdingReturn;

  /// No description provided for @noHoldings.
  ///
  /// In en, this message translates to:
  /// **'No {title} holdings'**
  String noHoldings(Object title);

  /// No description provided for @buyBstockToSeeHere.
  ///
  /// In en, this message translates to:
  /// **'Buy a bStock to see it here.'**
  String get buyBstockToSeeHere;

  /// No description provided for @openPerpsPositionToSeeHere.
  ///
  /// In en, this message translates to:
  /// **'Open a Perps position to see it here.'**
  String get openPerpsPositionToSeeHere;

  /// No description provided for @perpsEquity.
  ///
  /// In en, this message translates to:
  /// **'Perps equity'**
  String get perpsEquity;

  /// No description provided for @enterConfirmationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter confirmation code'**
  String get enterConfirmationCode;

  /// No description provided for @signUpOrLogIn.
  ///
  /// In en, this message translates to:
  /// **'Sign up or log in to start exploring'**
  String get signUpOrLogIn;

  /// No description provided for @emailCodeSent.
  ///
  /// In en, this message translates to:
  /// **'Please check {email} for an email from privy.io and enter your code below.'**
  String emailCodeSent(Object email);

  /// No description provided for @didntGetEmail.
  ///
  /// In en, this message translates to:
  /// **'Didn\'\'t get an email?'**
  String get didntGetEmail;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'Code resent'**
  String get codeResent;

  /// No description provided for @continueWithPrivy.
  ///
  /// In en, this message translates to:
  /// **'Continue with Privy'**
  String get continueWithPrivy;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get enterValidEmail;

  /// No description provided for @otherSocials.
  ///
  /// In en, this message translates to:
  /// **'Other Socials'**
  String get otherSocials;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @loginOrSignUp.
  ///
  /// In en, this message translates to:
  /// **'Log in or sign up'**
  String get loginOrSignUp;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'By using this app, you agree to the Terms & Conditions.'**
  String get termsAgreement;

  /// No description provided for @tpSlRiskAgreementPrefix.
  ///
  /// In en, this message translates to:
  /// **'I have read and agree to the '**
  String get tpSlRiskAgreementPrefix;

  /// No description provided for @tpSlRiskAgreementLink.
  ///
  /// In en, this message translates to:
  /// **'TP/SL risk disclosure'**
  String get tpSlRiskAgreementLink;

  /// No description provided for @tpSlRiskAgreementTitle.
  ///
  /// In en, this message translates to:
  /// **'TP/SL risk disclosure'**
  String get tpSlRiskAgreementTitle;

  /// No description provided for @tpSlRiskAgreementDetails.
  ///
  /// In en, this message translates to:
  /// **'Take Profit and Stop Loss orders may be set for your entire position or for the quantity associated with a specific order.\n\nPosition-based TP/SL may apply to your current position size and may change as your position changes. Order-based TP/SL applies only to the quantity associated with that order.\n\nIf multiple TP/SL orders are active at the same time, changes to your position size—such as adding, reducing, or partially closing a position—may cause the remaining TP/SL quantities to differ from your current position. As a result, a later order or newly added position quantity may be reduced when an existing TP/SL is triggered.\n\nTP/SL orders are intended to reduce a position and do not guarantee that your entire intended quantity will be closed. During rapid price movements or periods of low liquidity, an order may be partially filled, filled at a different price, or remain unfilled after being triggered.\n\nPlease review your active TP/SL orders after changing your position size and adjust or cancel them when necessary.'**
  String get tpSlRiskAgreementDetails;

  /// No description provided for @tpSlRiskAgreementConsent.
  ///
  /// In en, this message translates to:
  /// **'I understand and accept the TP/SL risks.'**
  String get tpSlRiskAgreementConsent;

  /// No description provided for @tpSlRiskAgreementAccept.
  ///
  /// In en, this message translates to:
  /// **'Agree and continue'**
  String get tpSlRiskAgreementAccept;

  /// No description provided for @tpSlRequired.
  ///
  /// In en, this message translates to:
  /// **'Set at least one take-profit or stop-loss price.'**
  String get tpSlRequired;

  /// No description provided for @tpSlInvalidPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid positive price.'**
  String get tpSlInvalidPrice;

  /// No description provided for @tpSlTakeProfitAboveReference.
  ///
  /// In en, this message translates to:
  /// **'Take-profit price must be above the reference price.'**
  String get tpSlTakeProfitAboveReference;

  /// No description provided for @tpSlTakeProfitBelowReference.
  ///
  /// In en, this message translates to:
  /// **'Take-profit price must be below the reference price.'**
  String get tpSlTakeProfitBelowReference;

  /// No description provided for @tpSlStopLossBelowReference.
  ///
  /// In en, this message translates to:
  /// **'Stop-loss price must be below the reference price.'**
  String get tpSlStopLossBelowReference;

  /// No description provided for @tpSlStopLossAboveReference.
  ///
  /// In en, this message translates to:
  /// **'Stop-loss price must be above the reference price.'**
  String get tpSlStopLossAboveReference;

  /// No description provided for @invalidConfirmationCode.
  ///
  /// In en, this message translates to:
  /// **'That code is invalid or expired.'**
  String get invalidConfirmationCode;

  /// No description provided for @networkUnavailableRetry.
  ///
  /// In en, this message translates to:
  /// **'Network unavailable. Check your connection and try again.'**
  String get networkUnavailableRetry;

  /// No description provided for @browserSignInUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unable to start social sign-in. Check that your browser and network are working, then try again.'**
  String get browserSignInUnavailable;

  /// No description provided for @privyNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Privy is not configured for this build.'**
  String get privyNotConfigured;

  /// No description provided for @sessionExpiredLogin.
  ///
  /// In en, this message translates to:
  /// **'Your session expired. Please sign in again.'**
  String get sessionExpiredLogin;

  /// No description provided for @backendSessionFailed.
  ///
  /// In en, this message translates to:
  /// **'Privy sign-in succeeded, but we could not create your RWA session. Try again later.'**
  String get backendSessionFailed;

  /// No description provided for @walletSyncFailed.
  ///
  /// In en, this message translates to:
  /// **'You are signed in, but your wallet could not be synchronized. Try again later.'**
  String get walletSyncFailed;

  /// No description provided for @emailLoginUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Email sign-in is not available.'**
  String get emailLoginUnavailable;

  /// No description provided for @privyPlatformUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Privy sign-in is available on Android and iOS.'**
  String get privyPlatformUnsupported;

  /// No description provided for @privyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Privy is temporarily unavailable. Please try again.'**
  String get privyUnavailable;

  /// No description provided for @supportId.
  ///
  /// In en, this message translates to:
  /// **'Support ID: {id}'**
  String supportId(Object id);

  /// No description provided for @changeSymbolLeverage.
  ///
  /// In en, this message translates to:
  /// **'Change {symbol} leverage'**
  String changeSymbolLeverage(Object symbol);

  /// No description provided for @accountChangedReopenPosition.
  ///
  /// In en, this message translates to:
  /// **'Account changed. Close this panel and reopen the position.'**
  String get accountChangedReopenPosition;

  /// No description provided for @tradingContextUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Trading context unavailable.'**
  String get tradingContextUnavailable;

  /// No description provided for @tradingContextReload.
  ///
  /// In en, this message translates to:
  /// **'Trading context unavailable. Reload before changing leverage.'**
  String get tradingContextReload;

  /// No description provided for @reload.
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reload;

  /// No description provided for @currentMaximumLeverage.
  ///
  /// In en, this message translates to:
  /// **'Current: {current} · Maximum: {maximum}'**
  String currentMaximumLeverage(Object current, Object maximum);

  /// No description provided for @leverageSignatureNotice.
  ///
  /// In en, this message translates to:
  /// **'Changing leverage requires your wallet signature and keeps the current margin mode.'**
  String get leverageSignatureNotice;

  /// No description provided for @leverageChangesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Leverage changes are unavailable for this account or product.'**
  String get leverageChangesUnavailable;

  /// No description provided for @validLeverageRequired.
  ///
  /// In en, this message translates to:
  /// **'Enter a whole number within the current maximum, or reload expired limits.'**
  String get validLeverageRequired;

  /// No description provided for @reloadLimits.
  ///
  /// In en, this message translates to:
  /// **'Reload limits'**
  String get reloadLimits;

  /// No description provided for @waitingForConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Waiting for confirmation…'**
  String get waitingForConfirmation;

  /// No description provided for @reviewAndSign.
  ///
  /// In en, this message translates to:
  /// **'Review and sign'**
  String get reviewAndSign;

  /// No description provided for @leverageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Leverage updated. Refreshing position and trading context.'**
  String get leverageUpdated;

  /// No description provided for @leveragePending.
  ///
  /// In en, this message translates to:
  /// **'Leverage is not yet confirmed. Close this panel and resume the existing action in Pending actions.'**
  String get leveragePending;

  /// No description provided for @leverageNotConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Leverage was not confirmed. Check pending actions before trying again.'**
  String get leverageNotConfirmed;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @entryPrice.
  ///
  /// In en, this message translates to:
  /// **'Entry'**
  String get entryPrice;

  /// No description provided for @markPrice.
  ///
  /// In en, this message translates to:
  /// **'Mark price'**
  String get markPrice;

  /// No description provided for @unrealizedPnl.
  ///
  /// In en, this message translates to:
  /// **'Unrealized PnL'**
  String get unrealizedPnl;

  /// No description provided for @returnOnEquity.
  ///
  /// In en, this message translates to:
  /// **'Return on equity'**
  String get returnOnEquity;

  /// No description provided for @margin.
  ///
  /// In en, this message translates to:
  /// **'Margin'**
  String get margin;

  /// No description provided for @cumulativeFunding.
  ///
  /// In en, this message translates to:
  /// **'Cumulative funding'**
  String get cumulativeFunding;

  /// No description provided for @fundingExplanation.
  ///
  /// In en, this message translates to:
  /// **'Funding: negative = paid; positive = received.'**
  String get fundingExplanation;

  /// No description provided for @changeLeverage.
  ///
  /// In en, this message translates to:
  /// **'Change leverage'**
  String get changeLeverage;

  /// No description provided for @openOrdersRefreshHint.
  ///
  /// In en, this message translates to:
  /// **'Try again to refresh open orders.'**
  String get openOrdersRefreshHint;

  /// No description provided for @openOrdersEmptyDescription.
  ///
  /// In en, this message translates to:
  /// **'Open orders for this product will appear here.'**
  String get openOrdersEmptyDescription;

  /// No description provided for @cancelling.
  ///
  /// In en, this message translates to:
  /// **'Cancelling…'**
  String get cancelling;

  /// No description provided for @cancellationPending.
  ///
  /// In en, this message translates to:
  /// **'Cancellation is still being confirmed. Refresh before retrying.'**
  String get cancellationPending;

  /// No description provided for @cancellationFailed.
  ///
  /// In en, this message translates to:
  /// **'Cancellation was not completed. Refresh and retry; signing may still be required.'**
  String get cancellationFailed;

  /// No description provided for @parentCancelWarning.
  ///
  /// In en, this message translates to:
  /// **'If this order has attached TP/SL, cancelling the parent also cancels that protection. Check protection for any remaining position; replacement protection is not created automatically.'**
  String get parentCancelWarning;

  /// No description provided for @conditionalOrder.
  ///
  /// In en, this message translates to:
  /// **'Conditional order'**
  String get conditionalOrder;

  /// No description provided for @protectionInactive.
  ///
  /// In en, this message translates to:
  /// **'Protection is no longer active'**
  String get protectionInactive;

  /// No description provided for @protectionNotSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Protection not submitted'**
  String get protectionNotSubmitted;

  /// No description provided for @protectionWaitingForParent.
  ///
  /// In en, this message translates to:
  /// **'Protection waiting for parent fill — not active'**
  String get protectionWaitingForParent;

  /// No description provided for @protectionAwaitingConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Protection activation awaiting confirmation'**
  String get protectionAwaitingConfirmation;

  /// No description provided for @protectionActive.
  ///
  /// In en, this message translates to:
  /// **'Protection active'**
  String get protectionActive;

  /// No description provided for @protectionStatusUnknown.
  ///
  /// In en, this message translates to:
  /// **'Protection status unknown — not confirmed active'**
  String get protectionStatusUnknown;

  /// No description provided for @attachedToOrder.
  ///
  /// In en, this message translates to:
  /// **'Attached to order: {id}'**
  String attachedToOrder(Object id);

  /// No description provided for @parentCancelledProtectionWarning.
  ///
  /// In en, this message translates to:
  /// **'Parent cancelled: this protection is inactive. Check protection for any remaining position; no replacement is created automatically.'**
  String get parentCancelledProtectionWarning;

  /// No description provided for @triggerPrice.
  ///
  /// In en, this message translates to:
  /// **'Trigger price: {price} USDC · {reference}'**
  String triggerPrice(Object price, Object reference);

  /// No description provided for @triggerStatus.
  ///
  /// In en, this message translates to:
  /// **'Trigger status: {status} · {execution}'**
  String triggerStatus(Object status, Object execution);

  /// No description provided for @entirePositionProtection.
  ///
  /// In en, this message translates to:
  /// **'Entire position protection'**
  String get entirePositionProtection;

  /// No description provided for @fixedQuantityValue.
  ///
  /// In en, this message translates to:
  /// **'Fixed quantity: {quantity}'**
  String fixedQuantityValue(Object quantity);

  /// No description provided for @filledTotal.
  ///
  /// In en, this message translates to:
  /// **'Filled / Total: {filled} / {total}'**
  String filledTotal(Object filled, Object total);

  /// No description provided for @orderPrice.
  ///
  /// In en, this message translates to:
  /// **'Order price: {price}'**
  String orderPrice(Object price);

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Status: {status}'**
  String orderStatus(Object status);

  /// No description provided for @filled.
  ///
  /// In en, this message translates to:
  /// **'Filled'**
  String get filled;

  /// No description provided for @percentFilled.
  ///
  /// In en, this message translates to:
  /// **'{percent}% filled'**
  String percentFilled(Object percent);

  /// No description provided for @closeOrderSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Close order submitted. Check the order for fills.'**
  String get closeOrderSubmitted;

  /// No description provided for @closeActionPending.
  ///
  /// In en, this message translates to:
  /// **'Action {id} is still being confirmed. Resume it from pending actions; do not create another close.'**
  String closeActionPending(Object id);

  /// No description provided for @closeFailed.
  ///
  /// In en, this message translates to:
  /// **'Close was not completed. Check pending actions and refresh the position before changing this request.'**
  String get closeFailed;

  /// No description provided for @closeRetry.
  ///
  /// In en, this message translates to:
  /// **'Close could not be completed. Refresh the position and retry.'**
  String get closeRetry;

  /// No description provided for @closeSymbol.
  ///
  /// In en, this message translates to:
  /// **'Close {symbol}'**
  String closeSymbol(Object symbol);

  /// No description provided for @unavailableProduct.
  ///
  /// In en, this message translates to:
  /// **'Unavailable product'**
  String get unavailableProduct;

  /// No description provided for @longToSell.
  ///
  /// In en, this message translates to:
  /// **'Long → Sell'**
  String get longToSell;

  /// No description provided for @shortToBuy.
  ///
  /// In en, this message translates to:
  /// **'Short → Buy'**
  String get shortToBuy;

  /// No description provided for @positionQuantity.
  ///
  /// In en, this message translates to:
  /// **'Position quantity: {quantity} {symbol}'**
  String positionQuantity(Object quantity, Object symbol);

  /// No description provided for @limitPriceUsdc.
  ///
  /// In en, this message translates to:
  /// **'Limit price (USDC)'**
  String get limitPriceUsdc;

  /// No description provided for @quantityOfPosition.
  ///
  /// In en, this message translates to:
  /// **'Quantity ({symbol})'**
  String quantityOfPosition(Object symbol);

  /// No description provided for @percentOfCurrentPosition.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of current position'**
  String percentOfCurrentPosition(Object percent);

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @entryMark.
  ///
  /// In en, this message translates to:
  /// **'Entry: {entry} · Mark: {mark}'**
  String entryMark(Object entry, Object mark);

  /// No description provided for @liquidationValue.
  ///
  /// In en, this message translates to:
  /// **'Liquidation: {price}'**
  String liquidationValue(Object price);

  /// No description provided for @closeReviewNotice.
  ///
  /// In en, this message translates to:
  /// **'Reduce-only. Review the server-normalized quantity, estimated PnL and fees before signing. A limit order may remain open.'**
  String get closeReviewNotice;

  /// No description provided for @preparing.
  ///
  /// In en, this message translates to:
  /// **'Preparing…'**
  String get preparing;

  /// No description provided for @reviewClose.
  ///
  /// In en, this message translates to:
  /// **'Review close'**
  String get reviewClose;

  /// No description provided for @buySymbol.
  ///
  /// In en, this message translates to:
  /// **'Buy {symbol}'**
  String buySymbol(Object symbol);

  /// No description provided for @buySymbolMarket.
  ///
  /// In en, this message translates to:
  /// **'Buy {symbol} · Market'**
  String buySymbolMarket(Object symbol);

  /// No description provided for @inAppTransferLowercase.
  ///
  /// In en, this message translates to:
  /// **'In-app transfer'**
  String get inAppTransferLowercase;

  /// No description provided for @fundingNotReady.
  ///
  /// In en, this message translates to:
  /// **'Funding is not ready to submit this order.'**
  String get fundingNotReady;

  /// No description provided for @transferStartFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to authorize or start this transfer. Try again.'**
  String get transferStartFailed;

  /// No description provided for @preparingTradingFunds.
  ///
  /// In en, this message translates to:
  /// **'Preparing trading funds…'**
  String get preparingTradingFunds;

  /// No description provided for @bridgeInProgress.
  ///
  /// In en, this message translates to:
  /// **'Bridge in progress. Estimated time: 1–3 min. You can track the progress on the Details page.'**
  String get bridgeInProgress;

  /// No description provided for @serverSelected.
  ///
  /// In en, this message translates to:
  /// **'{asset} (server selected)'**
  String serverSelected(Object asset);

  /// No description provided for @amountNeeded.
  ///
  /// In en, this message translates to:
  /// **'Amount needed'**
  String get amountNeeded;

  /// No description provided for @transferAmount.
  ///
  /// In en, this message translates to:
  /// **'Transfer amount'**
  String get transferAmount;

  /// No description provided for @availableToFund.
  ///
  /// In en, this message translates to:
  /// **'Available to fund'**
  String get availableToFund;

  /// No description provided for @shortfall.
  ///
  /// In en, this message translates to:
  /// **'Shortfall'**
  String get shortfall;

  /// No description provided for @availableBalanceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get availableBalanceUnavailable;

  /// No description provided for @serverSelectedFundingRoute.
  ///
  /// In en, this message translates to:
  /// **'Use the server-selected funding route'**
  String get serverSelectedFundingRoute;

  /// No description provided for @externalDepositDetail.
  ///
  /// In en, this message translates to:
  /// **'Deposit USDT on BSC from another platform or wallet'**
  String get externalDepositDetail;

  /// No description provided for @positionsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Positions unavailable'**
  String get positionsUnavailable;

  /// No description provided for @positionRefreshHint.
  ///
  /// In en, this message translates to:
  /// **'Try again to refresh your position.'**
  String get positionRefreshHint;

  /// No description provided for @noOpenPosition.
  ///
  /// In en, this message translates to:
  /// **'No open position'**
  String get noOpenPosition;

  /// No description provided for @openPositionDescription.
  ///
  /// In en, this message translates to:
  /// **'Your position for this product will appear here.'**
  String get openPositionDescription;

  /// No description provided for @cancellationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Cancellation submitted. Refresh to confirm the final order status.'**
  String get cancellationSubmitted;

  /// No description provided for @cancellationPendingRefreshOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancellation is still being confirmed. Refresh this order before retrying.'**
  String get cancellationPendingRefreshOrder;

  /// No description provided for @cancellationCompleteFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to complete cancellation. Refresh the order and retry.'**
  String get cancellationCompleteFailed;

  /// No description provided for @longPosition.
  ///
  /// In en, this message translates to:
  /// **'Long position'**
  String get longPosition;

  /// No description provided for @shortPosition.
  ///
  /// In en, this message translates to:
  /// **'Short position'**
  String get shortPosition;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @yourPositions.
  ///
  /// In en, this message translates to:
  /// **'Your positions'**
  String get yourPositions;

  /// No description provided for @positionWillBe.
  ///
  /// In en, this message translates to:
  /// **'Position will be'**
  String get positionWillBe;

  /// No description provided for @positionWillBeTooltipIntro.
  ///
  /// In en, this message translates to:
  /// **'Opposite orders reduce the current position first; any excess reverses the position.'**
  String get positionWillBeTooltipIntro;

  /// No description provided for @positionWillBeTooltipExampleOne.
  ///
  /// In en, this message translates to:
  /// **'Long {longValue} + Short {shortValue} → Long {resultValue}'**
  String positionWillBeTooltipExampleOne(
    Object longValue,
    Object resultValue,
    Object shortValue,
  );

  /// No description provided for @positionWillBeTooltipExampleTwo.
  ///
  /// In en, this message translates to:
  /// **'Long {longValue} + Short {shortValue} → Short {resultValue}'**
  String positionWillBeTooltipExampleTwo(
    Object longValue,
    Object resultValue,
    Object shortValue,
  );

  /// No description provided for @tokenPosition.
  ///
  /// In en, this message translates to:
  /// **'Token position'**
  String get tokenPosition;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @tokenAmount.
  ///
  /// In en, this message translates to:
  /// **'Token amount'**
  String get tokenAmount;

  /// No description provided for @marketHoursUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Market hours unavailable'**
  String get marketHoursUnavailable;

  /// No description provided for @marketHoursRefreshHint.
  ///
  /// In en, this message translates to:
  /// **'Try again to refresh market hours.'**
  String get marketHoursRefreshHint;

  /// No description provided for @noMarketSessionData.
  ///
  /// In en, this message translates to:
  /// **'No market session data is available.'**
  String get noMarketSessionData;

  /// No description provided for @perpetual.
  ///
  /// In en, this message translates to:
  /// **'Perpetual'**
  String get perpetual;

  /// No description provided for @lineChart.
  ///
  /// In en, this message translates to:
  /// **'Line chart'**
  String get lineChart;

  /// No description provided for @candlestickChart.
  ///
  /// In en, this message translates to:
  /// **'Candlestick chart'**
  String get candlestickChart;

  /// No description provided for @usStockReferencePrice.
  ///
  /// In en, this message translates to:
  /// **'US stock reference price'**
  String get usStockReferencePrice;

  /// No description provided for @loginToViewActivity.
  ///
  /// In en, this message translates to:
  /// **'Log in to view your activity'**
  String get loginToViewActivity;

  /// No description provided for @accountActivityAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your orders and account activity will appear here.'**
  String get accountActivityAppearHere;

  /// No description provided for @tokenType.
  ///
  /// In en, this message translates to:
  /// **'Token type'**
  String get tokenType;

  /// No description provided for @tokenDetails.
  ///
  /// In en, this message translates to:
  /// **'Token details'**
  String get tokenDetails;

  /// No description provided for @cashBalance.
  ///
  /// In en, this message translates to:
  /// **'Cash balance'**
  String get cashBalance;

  /// No description provided for @setLeverageTo.
  ///
  /// In en, this message translates to:
  /// **'Set leverage to {value}x'**
  String setLeverageTo(Object value);

  /// No description provided for @quantitySymbol.
  ///
  /// In en, this message translates to:
  /// **'Quantity ({symbol})'**
  String quantitySymbol(Object symbol);

  /// No description provided for @takeProfitLimitPrice.
  ///
  /// In en, this message translates to:
  /// **'Take profit limit price (USDC)'**
  String get takeProfitLimitPrice;

  /// No description provided for @stopLimitPrice.
  ///
  /// In en, this message translates to:
  /// **'Stop limit price (USDC)'**
  String get stopLimitPrice;

  /// No description provided for @protectionSizesUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Could not read existing protection sizes. Close and refresh before editing.'**
  String get protectionSizesUnavailable;

  /// No description provided for @protectionUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Protection update was not completed. A cancellation may already have succeeded. Retry the same edit or check pending actions before changing it.'**
  String get protectionUpdateFailed;

  /// No description provided for @protectionUpdateRetry.
  ///
  /// In en, this message translates to:
  /// **'Protection update could not be completed. Refresh before retrying.'**
  String get protectionUpdateRetry;

  /// No description provided for @protectionSizesDiffer.
  ///
  /// In en, this message translates to:
  /// **'Existing protection legs have different sizes. Select the desired size for this edit.'**
  String get protectionSizesDiffer;

  /// No description provided for @fixedQuantityNotice.
  ///
  /// In en, this message translates to:
  /// **'Fixed quantity will not adjust automatically when the position changes.'**
  String get fixedQuantityNotice;

  /// No description provided for @entirePositionProtectionNotice.
  ///
  /// In en, this message translates to:
  /// **'Entire position protection uses the position size at trigger time.'**
  String get entirePositionProtectionNotice;

  /// No description provided for @protectionSignatureNotice.
  ///
  /// In en, this message translates to:
  /// **'Trigger execution needs no new signature. Changes and cancellations require signing. Switching a leg off cancels it; other edits may require additional signatures.'**
  String get protectionSignatureNotice;

  /// No description provided for @amountRequiredForPercentage.
  ///
  /// In en, this message translates to:
  /// **'Enter an amount to get a current maximum quantity before using the percentage slider.'**
  String get amountRequiredForPercentage;

  /// No description provided for @hip3ExecutionDetailsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Execution details are unavailable. Request a new quote before placing the order.'**
  String get hip3ExecutionDetailsUnavailable;

  /// No description provided for @environment.
  ///
  /// In en, this message translates to:
  /// **'Environment'**
  String get environment;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @feeReserveRate.
  ///
  /// In en, this message translates to:
  /// **'Fee reserve rate'**
  String get feeReserveRate;

  /// No description provided for @slippageLimit.
  ///
  /// In en, this message translates to:
  /// **'Slippage limit'**
  String get slippageLimit;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @whyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Why unavailable'**
  String get whyUnavailable;

  /// No description provided for @crossMarginLiquidationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Cross-margin liquidation depends on the full account and cannot be estimated reliably here.'**
  String get crossMarginLiquidationUnavailable;

  /// No description provided for @noReliableLiquidationEstimate.
  ///
  /// In en, this message translates to:
  /// **'No reliable estimate was returned.'**
  String get noReliableLiquidationEstimate;

  /// No description provided for @quoteExpiresUtc.
  ///
  /// In en, this message translates to:
  /// **'Quote expires (UTC)'**
  String get quoteExpiresUtc;

  /// No description provided for @protectionConfirmationMismatch.
  ///
  /// In en, this message translates to:
  /// **'Protection confirmation is missing or differs from your order. Request a new quote before placing the order.'**
  String get protectionConfirmationMismatch;

  /// No description provided for @fixedQuantityThisOrder.
  ///
  /// In en, this message translates to:
  /// **'Fixed quantity: {quantity} (this order only)'**
  String fixedQuantityThisOrder(Object quantity);

  /// No description provided for @marketPriceBound.
  ///
  /// In en, this message translates to:
  /// **'Market price bound'**
  String get marketPriceBound;

  /// No description provided for @openingProtectionLeg.
  ///
  /// In en, this message translates to:
  /// **'{type} · Mark trigger {trigger} USDC · {priceType} {price} USDC'**
  String openingProtectionLeg(
    Object type,
    Object trigger,
    Object priceType,
    Object price,
  );

  /// No description provided for @openingOrderSignatureNotice.
  ///
  /// In en, this message translates to:
  /// **'Signed with this opening order. Triggering needs no new signature; later changes and cancellations require signing.'**
  String get openingOrderSignatureNotice;

  /// No description provided for @openingProtectionParentWarning.
  ///
  /// In en, this message translates to:
  /// **'Waiting for the parent is not active protection. Cancelling a partially filled parent cancels its protection; check the remaining position. No automatic replacement.'**
  String get openingProtectionParentWarning;

  /// No description provided for @priceLimitEstimateNotice.
  ///
  /// In en, this message translates to:
  /// **'The price limit bounds execution; it does not guarantee a fill. Fees and margin are estimates.'**
  String get priceLimitEstimateNotice;

  /// No description provided for @takeProfitTriggerUsdc.
  ///
  /// In en, this message translates to:
  /// **'Take profit trigger (USDC)'**
  String get takeProfitTriggerUsdc;

  /// No description provided for @takeProfitLimitOptional.
  ///
  /// In en, this message translates to:
  /// **'Take profit limit (optional)'**
  String get takeProfitLimitOptional;

  /// No description provided for @stopLossTriggerUsdc.
  ///
  /// In en, this message translates to:
  /// **'Stop loss trigger (USDC)'**
  String get stopLossTriggerUsdc;

  /// No description provided for @stopLossLimitOptional.
  ///
  /// In en, this message translates to:
  /// **'Stop loss limit (optional)'**
  String get stopLossLimitOptional;

  /// No description provided for @leaveBlankForMarketExecution.
  ///
  /// In en, this message translates to:
  /// **'Leave blank for market execution.'**
  String get leaveBlankForMarketExecution;

  /// No description provided for @openingProtectionQuantityNotice.
  ///
  /// In en, this message translates to:
  /// **'Fixed quantity equals this order, not your entire position. Sign with the opening order; triggering needs no new signature.'**
  String get openingProtectionQuantityNotice;

  /// No description provided for @openingProtectionPendingNotice.
  ///
  /// In en, this message translates to:
  /// **'Submitted protection is not yet active. If you cancel a partially filled parent order, its protection is cancelled too. Check the remaining position; protection is not replaced automatically.'**
  String get openingProtectionPendingNotice;

  /// No description provided for @favoriteUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to update favorites.'**
  String get favoriteUpdateFailed;

  /// No description provided for @favoriteAdded.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites.'**
  String get favoriteAdded;

  /// No description provided for @favoriteRemoved.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites.'**
  String get favoriteRemoved;

  /// No description provided for @buySucceeded.
  ///
  /// In en, this message translates to:
  /// **'{symbol} Buy Successful!'**
  String buySucceeded(Object symbol);

  /// No description provided for @buyFailed.
  ///
  /// In en, this message translates to:
  /// **'{symbol} Buy Failed!'**
  String buyFailed(Object symbol);

  /// No description provided for @overnightAt.
  ///
  /// In en, this message translates to:
  /// **'Overnight {time}'**
  String overnightAt(Object time);

  /// No description provided for @hip3Perp.
  ///
  /// In en, this message translates to:
  /// **'HIP-3 Perp'**
  String get hip3Perp;

  /// No description provided for @addFavorite.
  ///
  /// In en, this message translates to:
  /// **'Add favorite'**
  String get addFavorite;

  /// No description provided for @removeFavorite.
  ///
  /// In en, this message translates to:
  /// **'Remove favorite'**
  String get removeFavorite;

  /// No description provided for @usStockPrice.
  ///
  /// In en, this message translates to:
  /// **'US Stock {price}'**
  String usStockPrice(Object price);

  /// No description provided for @usPrice.
  ///
  /// In en, this message translates to:
  /// **'US {price}'**
  String usPrice(Object price);

  /// No description provided for @priceChartUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Price chart unavailable'**
  String get priceChartUnavailable;

  /// No description provided for @priceChartLatestClose.
  ///
  /// In en, this message translates to:
  /// **'Price chart latest close {price}'**
  String priceChartLatestClose(Object price);

  /// No description provided for @tradeWeekend.
  ///
  /// In en, this message translates to:
  /// **'Weekend'**
  String get tradeWeekend;

  /// No description provided for @tradeHoliday.
  ///
  /// In en, this message translates to:
  /// **'Holiday'**
  String get tradeHoliday;

  /// No description provided for @trade24hHigh.
  ///
  /// In en, this message translates to:
  /// **'24h High'**
  String get trade24hHigh;

  /// No description provided for @trade24hLow.
  ///
  /// In en, this message translates to:
  /// **'24h Low'**
  String get trade24hLow;

  /// No description provided for @trade24hTurnover.
  ///
  /// In en, this message translates to:
  /// **'24h Turnover'**
  String get trade24hTurnover;

  /// No description provided for @trade24hVolume.
  ///
  /// In en, this message translates to:
  /// **'24h Volume'**
  String get trade24hVolume;

  /// No description provided for @openTab.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openTab;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @positionProtectionActionPending.
  ///
  /// In en, this message translates to:
  /// **'Action {id} is still being confirmed. Resume pending actions, then reopen this editor. Changes may be partially applied.'**
  String positionProtectionActionPending(Object id);

  /// No description provided for @orderStatusInActivity.
  ///
  /// In en, this message translates to:
  /// **'You can check the order status on the activities page.'**
  String get orderStatusInActivity;

  /// No description provided for @orderProcessingInDetails.
  ///
  /// In en, this message translates to:
  /// **'Your order is being processed. Track its status in Details.'**
  String get orderProcessingInDetails;

  /// No description provided for @hip3InvalidOrderWithProtection.
  ///
  /// In en, this message translates to:
  /// **'Enter valid order values and at least one positive protection trigger. Each protection limit needs its trigger.'**
  String get hip3InvalidOrderWithProtection;

  /// No description provided for @hip3InvalidOrderInputs.
  ///
  /// In en, this message translates to:
  /// **'Enter a positive quantity or order value and a valid limit price.'**
  String get hip3InvalidOrderInputs;

  /// No description provided for @hip3OrderNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'This order needs review. Do not place a replacement order.'**
  String get hip3OrderNeedsReview;

  /// No description provided for @hip3OrderConfirming.
  ///
  /// In en, this message translates to:
  /// **'Confirming this order. Retry to check the same order; do not place a replacement.'**
  String get hip3OrderConfirming;

  /// No description provided for @hip3SigningRequestExpired.
  ///
  /// In en, this message translates to:
  /// **'This signing request expired. Prepare the order again.'**
  String get hip3SigningRequestExpired;

  /// No description provided for @hip3OrderStillPreparing.
  ///
  /// In en, this message translates to:
  /// **'The order is still being prepared. Try again.'**
  String get hip3OrderStillPreparing;

  /// No description provided for @hip3SigningWalletUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The signing wallet is unavailable. Reconnect and try again.'**
  String get hip3SigningWalletUnavailable;

  /// No description provided for @hip3SigningRequestInvalid.
  ///
  /// In en, this message translates to:
  /// **'The signing request is invalid. Prepare the order again.'**
  String get hip3SigningRequestInvalid;

  /// No description provided for @reviewOrder.
  ///
  /// In en, this message translates to:
  /// **'Review {side} {symbol}'**
  String reviewOrder(Object side, Object symbol);

  /// No description provided for @marginValue.
  ///
  /// In en, this message translates to:
  /// **'Balance: {value} USDC'**
  String marginValue(Object value);

  /// No description provided for @spotBalance.
  ///
  /// In en, this message translates to:
  /// **'Spot balance'**
  String get spotBalance;

  /// No description provided for @perpsBalance.
  ///
  /// In en, this message translates to:
  /// **'Perps balance'**
  String get perpsBalance;

  /// No description provided for @orderSizeLabel.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get orderSizeLabel;

  /// No description provided for @hip3MarginChip.
  ///
  /// In en, this message translates to:
  /// **'Margin {amount}'**
  String hip3MarginChip(String amount);

  /// No description provided for @hip3SignAndConfirm.
  ///
  /// In en, this message translates to:
  /// **'Sign & Confirm {direction}'**
  String hip3SignAndConfirm(String direction);
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
