// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'serializers.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$serializers = (Serializers().toBuilder()
      ..add($OrderPreviewCommon.serializer)
      ..add($Page.serializer)
      ..add($RealtimeEventBase.serializer)
      ..add(AccountBalance.serializer)
      ..add(AccountKind.serializer)
      ..add(ActivityCategory.serializer)
      ..add(ActivityPage.serializer)
      ..add(ActivityRecord.serializer)
      ..add(ActivityRecordExplorer.serializer)
      ..add(ActivityRecordReference.serializer)
      ..add(ActivityRecordReferenceTypeEnum.serializer)
      ..add(ActivityStatus.serializer)
      ..add(ActivityType.serializer)
      ..add(ApiError.serializer)
      ..add(AppVersionInfo.serializer)
      ..add(AssetInfo.serializer)
      ..add(BstockCreateOrderRequest.serializer)
      ..add(BstockCreateOrderRequestKindEnum.serializer)
      ..add(BstockCreateOrderRequestSideEnum.serializer)
      ..add(BstockFundingPlan.serializer)
      ..add(BstockFundingPlanAssetEnum.serializer)
      ..add(BstockFundingPlanNetworkEnum.serializer)
      ..add(BstockFundingPlanRailEnum.serializer)
      ..add(BstockFundingPlanStatusEnum.serializer)
      ..add(BstockFundingRail.serializer)
      ..add(BstockFundingRailNetworkEnum.serializer)
      ..add(BstockFundingRailRailEnum.serializer)
      ..add(BstockFundingRailSettlementAssetEnum.serializer)
      ..add(BstockOrderPreview.serializer)
      ..add(BstockOrderPreviewKindEnum.serializer)
      ..add(BstockOrderPreviewNetworkEnum.serializer)
      ..add(BstockOrderPreviewRequest.serializer)
      ..add(BstockOrderPreviewRequestKindEnum.serializer)
      ..add(BstockOrderPreviewRequestSideEnum.serializer)
      ..add(BstockOrderPreviewSettlementAssetEnum.serializer)
      ..add(CandlePoint.serializer)
      ..add(CandleSeries.serializer)
      ..add(Chain.serializer)
      ..add(ChartRange.serializer)
      ..add(Claim.serializer)
      ..add(ClosePositionRequest.serializer)
      ..add(CreateDepositIntentRequest.serializer)
      ..add(CreateDepositIntentRequestChainEnum.serializer)
      ..add(CreateDepositIntentRequestTokenEnum.serializer)
      ..add(CreateOrderRequest.serializer)
      ..add(CreateWithdrawalRequest.serializer)
      ..add(CreateWithdrawalRequestAssetEnum.serializer)
      ..add(Deposit.serializer)
      ..add(DepositAddress.serializer)
      ..add(DepositAddressTokenEnum.serializer)
      ..add(DepositMode.serializer)
      ..add(DepositPage.serializer)
      ..add(DepositStatus.serializer)
      ..add(DepositTokenEnum.serializer)
      ..add(Device.serializer)
      ..add(DeviceInfo.serializer)
      ..add(DevicePage.serializer)
      ..add(DevicePushProviderEnum.serializer)
      ..add(DeviceRegisterRequest.serializer)
      ..add(DeviceRegisterRequestPushProviderEnum.serializer)
      ..add(Disclosures.serializer)
      ..add(DisclosuresAlwaysOn.serializer)
      ..add(DisclosuresSessionsInner.serializer)
      ..add(FundingCatalog.serializer)
      ..add(FundingPlan.serializer)
      ..add(FundingPlanRequest.serializer)
      ..add(FundingPlanRequestAssetEnum.serializer)
      ..add(FundingRail.serializer)
      ..add(Hip3Challenge.serializer)
      ..add(Hip3ChallengeCompleteRequest.serializer)
      ..add(Hip3ChallengeNetworkEnum.serializer)
      ..add(Hip3ChallengeRequest.serializer)
      ..add(Hip3ChallengeSettlementAssetEnum.serializer)
      ..add(Hip3ChallengeStatusEnum.serializer)
      ..add(HoldingGroup.serializer)
      ..add(HoldingPage.serializer)
      ..add(KeyValue.serializer)
      ..add(KeyValueToneEnum.serializer)
      ..add(ListAccounts200Response.serializer)
      ..add(ListAppVersions200Response.serializer)
      ..add(MarginMode.serializer)
      ..add(MarketProductGroup.serializer)
      ..add(MarketSessionInfo.serializer)
      ..add(MarketStats.serializer)
      ..add(Order.serializer)
      ..add(OrderBook.serializer)
      ..add(OrderBookLevel.serializer)
      ..add(OrderPage.serializer)
      ..add(OrderPreview.serializer)
      ..add(OrderPreviewRequest.serializer)
      ..add(OrderSide.serializer)
      ..add(OrderStatus.serializer)
      ..add(OrderType.serializer)
      ..add(PerpCreateOrderRequest.serializer)
      ..add(PerpCreateOrderRequestKindEnum.serializer)
      ..add(PerpCreateOrderRequestSideEnum.serializer)
      ..add(PerpFundingPlan.serializer)
      ..add(PerpFundingPlanAssetEnum.serializer)
      ..add(PerpFundingPlanNetworkEnum.serializer)
      ..add(PerpFundingPlanRailEnum.serializer)
      ..add(PerpFundingPlanStatusEnum.serializer)
      ..add(PerpFundingRail.serializer)
      ..add(PerpFundingRailNetworkEnum.serializer)
      ..add(PerpFundingRailRailEnum.serializer)
      ..add(PerpFundingRailSettlementAssetEnum.serializer)
      ..add(PerpOrderPreview.serializer)
      ..add(PerpOrderPreviewKindEnum.serializer)
      ..add(PerpOrderPreviewNetworkEnum.serializer)
      ..add(PerpOrderPreviewRequest.serializer)
      ..add(PerpOrderPreviewRequestKindEnum.serializer)
      ..add(PerpOrderPreviewRequestSideEnum.serializer)
      ..add(PerpOrderPreviewSettlementAssetEnum.serializer)
      ..add(PortfolioSummary.serializer)
      ..add(Position.serializer)
      ..add(PositionPage.serializer)
      ..add(PositionSideEnum.serializer)
      ..add(PrivyClientConfig.serializer)
      ..add(PrivyClientConfigEmbeddedWallet.serializer)
      ..add(PrivyClientConfigEmbeddedWalletCreateOnLoginEnum.serializer)
      ..add(PrivyClientConfigLoginMethodsEnum.serializer)
      ..add(ProductDetail.serializer)
      ..add(ProductDetailTradingHoursEnum.serializer)
      ..add(ProductKind.serializer)
      ..add(ProductListing.serializer)
      ..add(ProductListingProductTypeEnum.serializer)
      ..add(ProductPage.serializer)
      ..add(ProductRef.serializer)
      ..add(ProductType.serializer)
      ..add(Quote.serializer)
      ..add(RealtimeActivityEvent.serializer)
      ..add(RealtimeActivityEventEventEnum.serializer)
      ..add(RealtimeBalanceEvent.serializer)
      ..add(RealtimeBalanceEventEventEnum.serializer)
      ..add(RealtimeCandleEvent.serializer)
      ..add(RealtimeCandleEventEventEnum.serializer)
      ..add(RealtimeCandleUpdate.serializer)
      ..add(RealtimeCandleUpdateIntervalEnum.serializer)
      ..add(RealtimeClaimEvent.serializer)
      ..add(RealtimeClaimEventEventEnum.serializer)
      ..add(RealtimeDepositEvent.serializer)
      ..add(RealtimeDepositEventEventEnum.serializer)
      ..add(RealtimeEvent.serializer)
      ..add(RealtimeOrderEvent.serializer)
      ..add(RealtimeOrderEventEventEnum.serializer)
      ..add(RealtimePositionEvent.serializer)
      ..add(RealtimePositionEventEventEnum.serializer)
      ..add(RealtimePriceEvent.serializer)
      ..add(RealtimePriceEventEventEnum.serializer)
      ..add(RealtimePriceUpdate.serializer)
      ..add(RealtimeResyncRequiredEvent.serializer)
      ..add(RealtimeResyncRequiredEventAllOfData.serializer)
      ..add(RealtimeResyncRequiredEventAllOfDataReasonEnum.serializer)
      ..add(RealtimeResyncRequiredEventEventEnum.serializer)
      ..add(RealtimeSessionEvent.serializer)
      ..add(RealtimeSessionEventEventEnum.serializer)
      ..add(RealtimeTransferEvent.serializer)
      ..add(RealtimeTransferEventEventEnum.serializer)
      ..add(RealtimeWithdrawalEvent.serializer)
      ..add(RealtimeWithdrawalEventEventEnum.serializer)
      ..add(ReferencePrice.serializer)
      ..add(ReplaceFavoritesRequest.serializer)
      ..add(Session.serializer)
      ..add(SessionKind.serializer)
      ..add(SessionRequest.serializer)
      ..add(SessionResponse.serializer)
      ..add(SessionSegment.serializer)
      ..add(Stock.serializer)
      ..add(StockGroup.serializer)
      ..add(StockPage.serializer)
      ..add(TokenBalance.serializer)
      ..add(TpSlSpec.serializer)
      ..add(TpSlUpdateRequest.serializer)
      ..add(Transfer.serializer)
      ..add(TransferClaimRequest.serializer)
      ..add(TransferRequest.serializer)
      ..add(TransferStatus.serializer)
      ..add(UpdatePositionLeverageRequest.serializer)
      ..add(User.serializer)
      ..add(UserSettings.serializer)
      ..add(UserSettingsLanguageEnum.serializer)
      ..add(UserSettingsUpdate.serializer)
      ..add(UserSettingsUpdateLanguageEnum.serializer)
      ..add(Wallet.serializer)
      ..add(WalletActionCompleteRequest.serializer)
      ..add(WalletAuthorization.serializer)
      ..add(WalletAuthorizationPurposeEnum.serializer)
      ..add(WalletAuthorizationRequest.serializer)
      ..add(WalletAuthorizationRequestPurposeEnum.serializer)
      ..add(WalletAuthorizationStatusEnum.serializer)
      ..add(WalletPage.serializer)
      ..add(WalletStatus.serializer)
      ..add(Withdrawal.serializer)
      ..add(WithdrawalAssetEnum.serializer)
      ..add(WithdrawalPage.serializer)
      ..add(WithdrawalQuote.serializer)
      ..add(WithdrawalQuoteAssetEnum.serializer)
      ..add(WithdrawalQuoteRequest.serializer)
      ..add(WithdrawalQuoteRequestAssetEnum.serializer)
      ..add(WithdrawalStatus.serializer)
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AccountBalance)]),
          () => ListBuilder<AccountBalance>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ActivityRecord)]),
          () => ListBuilder<ActivityRecord>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(AppVersionInfo)]),
          () => ListBuilder<AppVersionInfo>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CandlePoint)]),
          () => ListBuilder<CandlePoint>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(CandlePoint)]),
          () => ListBuilder<CandlePoint>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SessionSegment)]),
          () => ListBuilder<SessionSegment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Chain)]),
          () => ListBuilder<Chain>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Deposit)]),
          () => ListBuilder<Deposit>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Device)]),
          () => ListBuilder<Device>())
      ..addBuilderFactory(
          const FullType(
              BuiltList, const [const FullType(DisclosuresSessionsInner)]),
          () => ListBuilder<DisclosuresSessionsInner>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(KeyValue)]),
          () => ListBuilder<KeyValue>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(FundingRail)]),
          () => ListBuilder<FundingRail>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(HoldingGroup)]),
          () => ListBuilder<HoldingGroup>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(KeyValue)]),
          () => ListBuilder<KeyValue>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(KeyValue)]),
          () => ListBuilder<KeyValue>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(KeyValue)]),
          () => ListBuilder<KeyValue>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(KeyValue)]),
          () => ListBuilder<KeyValue>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(KeyValue)]),
          () => ListBuilder<KeyValue>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(KeyValue)]),
          () => ListBuilder<KeyValue>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Order)]),
          () => ListBuilder<Order>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(OrderBookLevel)]),
          () => ListBuilder<OrderBookLevel>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(OrderBookLevel)]),
          () => ListBuilder<OrderBookLevel>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Position)]),
          () => ListBuilder<Position>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Position)]),
          () => ListBuilder<Position>())
      ..addBuilderFactory(
          const FullType(BuiltList,
              const [const FullType(PrivyClientConfigLoginMethodsEnum)]),
          () => ListBuilder<PrivyClientConfigLoginMethodsEnum>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ProductListing)]),
          () => ListBuilder<ProductListing>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ProductListing)]),
          () => ListBuilder<ProductListing>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(ProductRef)]),
          () => ListBuilder<ProductRef>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(SessionSegment)]),
          () => ListBuilder<SessionSegment>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(StockGroup)]),
          () => ListBuilder<StockGroup>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(String)]),
          () => ListBuilder<String>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(TokenBalance)]),
          () => ListBuilder<TokenBalance>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Wallet)]),
          () => ListBuilder<Wallet>())
      ..addBuilderFactory(
          const FullType(BuiltList, const [const FullType(Withdrawal)]),
          () => ListBuilder<Withdrawal>())
      ..addBuilderFactory(
          const FullType(BuiltMap, const [
            const FullType(String),
            const FullType.nullable(JsonObject)
          ]),
          () => MapBuilder<String, JsonObject?>()))
    .build();

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
