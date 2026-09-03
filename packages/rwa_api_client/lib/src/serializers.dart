//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:rwa_api_client/src/date_serializer.dart';
import 'package:rwa_api_client/src/model/date.dart';

import 'package:rwa_api_client/src/model/account_balance.dart';
import 'package:rwa_api_client/src/model/account_kind.dart';
import 'package:rwa_api_client/src/model/activity_category.dart';
import 'package:rwa_api_client/src/model/activity_record.dart';
import 'package:rwa_api_client/src/model/activity_record_explorer.dart';
import 'package:rwa_api_client/src/model/activity_record_reference.dart';
import 'package:rwa_api_client/src/model/activity_status.dart';
import 'package:rwa_api_client/src/model/activity_type.dart';
import 'package:rwa_api_client/src/model/app_version_info.dart';
import 'package:rwa_api_client/src/model/asset_info.dart';
import 'package:rwa_api_client/src/model/bstock_create_order_request.dart';
import 'package:rwa_api_client/src/model/bstock_funding_plan.dart';
import 'package:rwa_api_client/src/model/bstock_funding_rail.dart';
import 'package:rwa_api_client/src/model/bstock_order_preview.dart';
import 'package:rwa_api_client/src/model/bstock_order_preview_request.dart';
import 'package:rwa_api_client/src/model/candle_point.dart';
import 'package:rwa_api_client/src/model/candle_series.dart';
import 'package:rwa_api_client/src/model/chain.dart';
import 'package:rwa_api_client/src/model/chart_range.dart';
import 'package:rwa_api_client/src/model/claim.dart';
import 'package:rwa_api_client/src/model/close_position_request.dart';
import 'package:rwa_api_client/src/model/create_deposit_intent_request.dart';
import 'package:rwa_api_client/src/model/create_order_request.dart';
import 'package:rwa_api_client/src/model/create_withdrawal_request.dart';
import 'package:rwa_api_client/src/model/deposit.dart';
import 'package:rwa_api_client/src/model/deposit_address.dart';
import 'package:rwa_api_client/src/model/deposit_mode.dart';
import 'package:rwa_api_client/src/model/deposit_status.dart';
import 'package:rwa_api_client/src/model/device.dart';
import 'package:rwa_api_client/src/model/device_info.dart';
import 'package:rwa_api_client/src/model/device_register_request.dart';
import 'package:rwa_api_client/src/model/disclosures.dart';
import 'package:rwa_api_client/src/model/disclosures_always_on.dart';
import 'package:rwa_api_client/src/model/disclosures_sessions_inner.dart';
import 'package:rwa_api_client/src/model/error.dart';
import 'package:rwa_api_client/src/model/funding_catalog.dart';
import 'package:rwa_api_client/src/model/funding_plan.dart';
import 'package:rwa_api_client/src/model/funding_plan_request.dart';
import 'package:rwa_api_client/src/model/funding_rail.dart';
import 'package:rwa_api_client/src/model/hip3_challenge.dart';
import 'package:rwa_api_client/src/model/hip3_challenge_complete_request.dart';
import 'package:rwa_api_client/src/model/hip3_challenge_request.dart';
import 'package:rwa_api_client/src/model/holding_group.dart';
import 'package:rwa_api_client/src/model/key_value.dart';
import 'package:rwa_api_client/src/model/list_accounts200_response.dart';
import 'package:rwa_api_client/src/model/list_activity200_response.dart';
import 'package:rwa_api_client/src/model/list_app_versions200_response.dart';
import 'package:rwa_api_client/src/model/list_deposits200_response.dart';
import 'package:rwa_api_client/src/model/list_devices200_response.dart';
import 'package:rwa_api_client/src/model/list_holdings200_response.dart';
import 'package:rwa_api_client/src/model/list_orders200_response.dart';
import 'package:rwa_api_client/src/model/list_positions200_response.dart';
import 'package:rwa_api_client/src/model/list_products200_response.dart';
import 'package:rwa_api_client/src/model/list_stocks200_response.dart';
import 'package:rwa_api_client/src/model/list_wallets200_response.dart';
import 'package:rwa_api_client/src/model/list_withdrawals200_response.dart';
import 'package:rwa_api_client/src/model/margin_mode.dart';
import 'package:rwa_api_client/src/model/market_product_group.dart';
import 'package:rwa_api_client/src/model/market_session_info.dart';
import 'package:rwa_api_client/src/model/market_stats.dart';
import 'package:rwa_api_client/src/model/order.dart';
import 'package:rwa_api_client/src/model/order_book.dart';
import 'package:rwa_api_client/src/model/order_book_level.dart';
import 'package:rwa_api_client/src/model/order_preview.dart';
import 'package:rwa_api_client/src/model/order_preview_common.dart';
import 'package:rwa_api_client/src/model/order_preview_request.dart';
import 'package:rwa_api_client/src/model/order_side.dart';
import 'package:rwa_api_client/src/model/order_status.dart';
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:rwa_api_client/src/model/perp_create_order_request.dart';
import 'package:rwa_api_client/src/model/perp_funding_plan.dart';
import 'package:rwa_api_client/src/model/perp_funding_rail.dart';
import 'package:rwa_api_client/src/model/perp_order_preview.dart';
import 'package:rwa_api_client/src/model/perp_order_preview_request.dart';
import 'package:rwa_api_client/src/model/portfolio_summary.dart';
import 'package:rwa_api_client/src/model/position.dart';
import 'package:rwa_api_client/src/model/privy_client_config.dart';
import 'package:rwa_api_client/src/model/privy_client_config_embedded_wallet.dart';
import 'package:rwa_api_client/src/model/product_detail.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/product_listing.dart';
import 'package:rwa_api_client/src/model/product_ref.dart';
import 'package:rwa_api_client/src/model/product_type.dart';
import 'package:rwa_api_client/src/model/quote.dart';
import 'package:rwa_api_client/src/model/realtime_activity_event.dart';
import 'package:rwa_api_client/src/model/realtime_balance_event.dart';
import 'package:rwa_api_client/src/model/realtime_candle_event.dart';
import 'package:rwa_api_client/src/model/realtime_candle_update.dart';
import 'package:rwa_api_client/src/model/realtime_claim_event.dart';
import 'package:rwa_api_client/src/model/realtime_deposit_event.dart';
import 'package:rwa_api_client/src/model/realtime_event.dart';
import 'package:rwa_api_client/src/model/realtime_event_base.dart';
import 'package:rwa_api_client/src/model/realtime_order_event.dart';
import 'package:rwa_api_client/src/model/realtime_position_event.dart';
import 'package:rwa_api_client/src/model/realtime_price_event.dart';
import 'package:rwa_api_client/src/model/realtime_price_update.dart';
import 'package:rwa_api_client/src/model/realtime_resync_required_event.dart';
import 'package:rwa_api_client/src/model/realtime_resync_required_event_all_of_data.dart';
import 'package:rwa_api_client/src/model/realtime_session_event.dart';
import 'package:rwa_api_client/src/model/realtime_transfer_event.dart';
import 'package:rwa_api_client/src/model/realtime_withdrawal_event.dart';
import 'package:rwa_api_client/src/model/reference_price.dart';
import 'package:rwa_api_client/src/model/replace_favorites_request.dart';
import 'package:rwa_api_client/src/model/session.dart';
import 'package:rwa_api_client/src/model/session_kind.dart';
import 'package:rwa_api_client/src/model/session_request.dart';
import 'package:rwa_api_client/src/model/session_response.dart';
import 'package:rwa_api_client/src/model/session_segment.dart';
import 'package:rwa_api_client/src/model/stock.dart';
import 'package:rwa_api_client/src/model/stock_group.dart';
import 'package:rwa_api_client/src/model/token_balance.dart';
import 'package:rwa_api_client/src/model/tp_sl_spec.dart';
import 'package:rwa_api_client/src/model/tp_sl_update_request.dart';
import 'package:rwa_api_client/src/model/transfer.dart';
import 'package:rwa_api_client/src/model/transfer_claim_request.dart';
import 'package:rwa_api_client/src/model/transfer_request.dart';
import 'package:rwa_api_client/src/model/transfer_status.dart';
import 'package:rwa_api_client/src/model/update_position_leverage_request.dart';
import 'package:rwa_api_client/src/model/user.dart';
import 'package:rwa_api_client/src/model/user_settings.dart';
import 'package:rwa_api_client/src/model/user_settings_update.dart';
import 'package:rwa_api_client/src/model/wallet.dart';
import 'package:rwa_api_client/src/model/wallet_action_complete_request.dart';
import 'package:rwa_api_client/src/model/wallet_authorization.dart';
import 'package:rwa_api_client/src/model/wallet_authorization_request.dart';
import 'package:rwa_api_client/src/model/wallet_status.dart';
import 'package:rwa_api_client/src/model/withdrawal.dart';
import 'package:rwa_api_client/src/model/withdrawal_quote.dart';
import 'package:rwa_api_client/src/model/withdrawal_quote_request.dart';
import 'package:rwa_api_client/src/model/withdrawal_status.dart';

part 'serializers.g.dart';

@SerializersFor([
  AccountBalance,
  AccountKind,
  ActivityCategory,
  ActivityRecord,
  ActivityRecordExplorer,
  ActivityRecordReference,
  ActivityStatus,
  ActivityType,
  AppVersionInfo,
  AssetInfo,
  BstockCreateOrderRequest,
  BstockFundingPlan,
  BstockFundingRail,
  BstockOrderPreview,
  BstockOrderPreviewRequest,
  CandlePoint,
  CandleSeries,
  Chain,
  ChartRange,
  Claim,
  ClosePositionRequest,
  CreateDepositIntentRequest,
  CreateOrderRequest,
  CreateWithdrawalRequest,
  Deposit,
  DepositAddress,
  DepositMode,
  DepositStatus,
  Device,
  DeviceInfo,
  DeviceRegisterRequest,
  Disclosures,
  DisclosuresAlwaysOn,
  DisclosuresSessionsInner,
  Error,
  FundingCatalog,
  FundingPlan,
  FundingPlanRequest,
  FundingRail,
  Hip3Challenge,
  Hip3ChallengeCompleteRequest,
  Hip3ChallengeRequest,
  HoldingGroup,
  KeyValue,
  ListAccounts200Response,
  ListActivity200Response,
  ListAppVersions200Response,
  ListDeposits200Response,
  ListDevices200Response,
  ListHoldings200Response,
  ListOrders200Response,
  ListPositions200Response,
  ListProducts200Response,
  ListStocks200Response,
  ListWallets200Response,
  ListWithdrawals200Response,
  MarginMode,
  MarketProductGroup,
  MarketSessionInfo,
  MarketStats,
  Order,
  OrderBook,
  OrderBookLevel,
  OrderPreview,
  OrderPreviewCommon,$OrderPreviewCommon,
  OrderPreviewRequest,
  OrderSide,
  OrderStatus,
  OrderType,
  Page,$Page,
  PerpCreateOrderRequest,
  PerpFundingPlan,
  PerpFundingRail,
  PerpOrderPreview,
  PerpOrderPreviewRequest,
  PortfolioSummary,
  Position,
  PrivyClientConfig,
  PrivyClientConfigEmbeddedWallet,
  ProductDetail,
  ProductKind,
  ProductListing,
  ProductRef,
  ProductType,
  Quote,
  RealtimeActivityEvent,
  RealtimeBalanceEvent,
  RealtimeCandleEvent,
  RealtimeCandleUpdate,
  RealtimeClaimEvent,
  RealtimeDepositEvent,
  RealtimeEvent,
  RealtimeEventBase,$RealtimeEventBase,
  RealtimeOrderEvent,
  RealtimePositionEvent,
  RealtimePriceEvent,
  RealtimePriceUpdate,
  RealtimeResyncRequiredEvent,
  RealtimeResyncRequiredEventAllOfData,
  RealtimeSessionEvent,
  RealtimeTransferEvent,
  RealtimeWithdrawalEvent,
  ReferencePrice,
  ReplaceFavoritesRequest,
  Session,
  SessionKind,
  SessionRequest,
  SessionResponse,
  SessionSegment,
  Stock,
  StockGroup,
  TokenBalance,
  TpSlSpec,
  TpSlUpdateRequest,
  Transfer,
  TransferClaimRequest,
  TransferRequest,
  TransferStatus,
  UpdatePositionLeverageRequest,
  User,
  UserSettings,
  UserSettingsUpdate,
  Wallet,
  WalletActionCompleteRequest,
  WalletAuthorization,
  WalletAuthorizationRequest,
  WalletStatus,
  Withdrawal,
  WithdrawalQuote,
  WithdrawalQuoteRequest,
  WithdrawalStatus,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(FundingRail)]),
        () => ListBuilder<FundingRail>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(CandlePoint)]),
        () => ListBuilder<CandlePoint>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Device)]),
        () => ListBuilder<Device>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Withdrawal)]),
        () => ListBuilder<Withdrawal>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(KeyValue)]),
        () => ListBuilder<KeyValue>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Chain)]),
        () => ListBuilder<Chain>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Position)]),
        () => ListBuilder<Position>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(HoldingGroup)]),
        () => ListBuilder<HoldingGroup>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Deposit)]),
        () => ListBuilder<Deposit>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ProductListing)]),
        () => ListBuilder<ProductListing>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(OrderBookLevel)]),
        () => ListBuilder<OrderBookLevel>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(StockGroup)]),
        () => ListBuilder<StockGroup>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Order)]),
        () => ListBuilder<Order>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(Wallet)]),
        () => ListBuilder<Wallet>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ActivityRecord)]),
        () => ListBuilder<ActivityRecord>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AppVersionInfo)]),
        () => ListBuilder<AppVersionInfo>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(ProductRef)]),
        () => ListBuilder<ProductRef>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(DisclosuresSessionsInner)]),
        () => ListBuilder<DisclosuresSessionsInner>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
        () => MapBuilder<String, JsonObject?>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(TokenBalance)]),
        () => ListBuilder<TokenBalance>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(SessionSegment)]),
        () => ListBuilder<SessionSegment>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(String)]),
        () => ListBuilder<String>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AccountBalance)]),
        () => ListBuilder<AccountBalance>(),
      )
      ..add(OrderPreviewCommon.serializer)
      ..add(Page.serializer)
      ..add(RealtimeEventBase.serializer)
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
