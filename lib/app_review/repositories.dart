import '../domain/models/activity_record.dart';
import '../domain/models/account_deletion.dart';
import '../domain/models/decimal_value.dart';
import '../domain/models/deposit.dart';
import '../domain/models/deposit_observation.dart';
import '../domain/models/domain_page.dart';
import '../domain/models/funding_catalog.dart';
import '../domain/models/funding_transfer.dart';
import '../domain/models/hip3_action_summary.dart';
import '../domain/models/position_leverage_context.dart';
import '../domain/models/position_operation.dart';
import '../domain/models/market_product.dart';
import '../domain/models/order.dart';
import '../domain/models/order_intent.dart';
import '../domain/models/order_preview.dart';
import '../domain/models/portfolio.dart';
import '../domain/models/position.dart';
import '../domain/models/registered_device.dart';
import '../domain/models/resource_result.dart';
import '../domain/models/trade_intent.dart';
import '../domain/models/trading_account.dart';
import '../domain/models/user_account.dart';
import '../domain/models/wallet.dart';
import '../domain/models/withdrawal.dart';
import '../domain/repositories/account_repository.dart';
import '../domain/repositories/activity_repository.dart';
import '../domain/repositories/funding_repository.dart';
import '../domain/repositories/hip3_order_execution_repository.dart';
import '../domain/repositories/markets_repository.dart';
import '../domain/repositories/orders_repository.dart';
import '../domain/repositories/portfolio_repository.dart';
import '../domain/repositories/positions_repository.dart';
import '../domain/repositories/realtime_repository.dart';
import '../domain/repositories/trade_intent_repository.dart';
import '../domain/repositories/wallets_repository.dart';

/// Shared, process-local state for the App Store review experience.
/// No method in this file performs network, wallet, payment, or chain I/O.
final class AppReviewStore {
  AppReviewStore()
    : settings = const UserPreferences(
        language: 'en',
        pushEnabled: true,
        notifyOrderFilled: true,
        notifyOrderFailed: true,
        notifyLiquidationWarning: true,
      );

  UserPreferences settings;
  final orders = <String, TradingOrder>{};
  final deposits = <String, Deposit>{};
  final withdrawals = <String, Withdrawal>{};
  final fundingPlans = <String, FundingPlan>{};
  final fundingTransfers = <String, FundingTransfer>{};
  final tradeIntents = <String, TradeIntent>{};
  int sequence = 0;

  String id(String prefix) => 'review-$prefix-${++sequence}';
}

DecimalValue _usd(String value) =>
    DecimalValue(value, asset: 'USD', unit: 'fiat');
DecimalValue _token(String value, String asset) =>
    DecimalValue(value, asset: asset, unit: 'token');
DateTime get _now => DateTime.now().toUtc();

final class AppReviewAccountRepository implements AccountRepository {
  AppReviewAccountRepository(this.store);
  final AppReviewStore store;

  @override
  Future<UserAccount> getAccount() async => UserAccount(
    userId: 'app-review-user',
    privyDid: 'did:privy:app-review',
    displayName: 'App Review',
    createdAt: DateTime.utc(2026, 1, 15),
    settings: store.settings,
  );

  @override
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch) async {
    final current = store.settings;
    store.settings = UserPreferences(
      language: patch.language ?? current.language,
      pushEnabled: patch.pushEnabled ?? current.pushEnabled,
      notifyOrderFilled: patch.notifyOrderFilled ?? current.notifyOrderFilled,
      notifyOrderFailed: patch.notifyOrderFailed ?? current.notifyOrderFailed,
      notifyLiquidationWarning:
          patch.notifyLiquidationWarning ?? current.notifyLiquidationWarning,
    );
    return store.settings;
  }

  @override
  Future<DomainPage<RegisteredDevice>> listDevices({String? cursor}) async =>
      DomainPage(
        items: [
          RegisteredDevice(
            deviceId: 'app-review-device',
            platform: 'ios',
            appVersion: '1.0.0',
            pushProvider: 'apns',
            pushTokenRegistered: true,
            lastSeenAt: _now,
            createdAt: DateTime.utc(2026, 1, 15),
          ),
        ],
      );

  @override
  Future<RegisteredDevice> registerDevice(
    DeviceRegistration registration,
  ) async => RegisteredDevice(
    deviceId: registration.deviceId,
    platform: registration.platform,
    appVersion: registration.appVersion,
    pushProvider: registration.pushProvider,
    pushTokenRegistered: true,
    lastSeenAt: _now,
    createdAt: _now,
  );

  @override
  Future<void> deleteDevice(String deviceId) async {}

  @override
  Future<AccountDeletion> requestAccountDeletion({
    required String idempotencyKey,
  }) async => _reviewDeletion();

  @override
  Future<AccountDeletion> getAccountDeletion() async => _reviewDeletion();

  AccountDeletion _reviewDeletion() => AccountDeletion(
    requestId: store.id('account-deletion'),
    state: AccountDeletionState.requested,
    blockers: const [],
    requestedAt: _now,
    updatedAt: _now,
  );
}

final class AppReviewPortfolioRepository implements PortfolioRepository {
  static final positions = <Position>[
    Position(
      positionId: 'review-position-nvda',
      productId: 'bstock-nvda',
      symbol: 'NVDA',
      kind: MarketProductKind.bstock,
      side: PositionSide.long,
      quantity: _token('12.5', 'NVDA'),
      valueUsd: _usd('15625.00'),
      entryPrice: _usd('1180.00'),
      markPrice: _usd('1250.00'),
      unrealizedPnl: _usd('875.00'),
      updatedAt: _now,
    ),
    Position(
      positionId: 'review-position-tsla',
      productId: 'bstock-tsla',
      symbol: 'TSLA',
      kind: MarketProductKind.bstock,
      side: PositionSide.long,
      quantity: _token('20', 'TSLA'),
      valueUsd: _usd('5000.00'),
      entryPrice: _usd('238.00'),
      markPrice: _usd('250.00'),
      unrealizedPnl: _usd('240.00'),
      updatedAt: _now,
    ),
  ];

  static List<TradingAccount> get accounts => [
    TradingAccount(
      kind: TradingAccountKind.app,
      label: 'Review Portfolio',
      address: '0x0000000000000000000000000000000000000001',
      chain: 'Arbitrum',
      totalValueUsd: _usd('25000.00'),
      availableUsd: _usd('4375.00'),
      marginUsedUsd: _usd('0.00'),
      balances: [
        TokenBalance(
          symbol: 'USDC',
          balance: _token('4375.00', 'USDC'),
          valueUsd: _usd('4375.00'),
          decimals: 6,
          chain: 'Arbitrum',
        ),
      ],
    ),
  ];

  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: _usd('25000.00'),
    availableToTradeUsd: _usd('4375.00'),
    todayPnl: _usd('324.80'),
    todayPnlPercent: DecimalValue('1.32', unit: 'percent'),
    marginInUseUsd: _usd('0.00'),
    stocksValueUsd: _usd('20625.00'),
    updatedAt: _now,
    accounts: accounts,
    holdings: _holdings,
  );

  static List<HoldingGroup> get _holdings => positions
      .map(
        (position) => HoldingGroup(
          symbol: position.symbol,
          totalValueUsd: position.valueUsd,
          positions: [position],
        ),
      )
      .toList(growable: false);

  @override
  Future<List<TradingAccount>> listAccounts() async => accounts;

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      DomainPage(items: _holdings);
}

final class AppReviewWalletsRepository implements WalletsRepository {
  AppReviewWalletsRepository(this.store);
  final AppReviewStore store;

  Wallet get _wallet => Wallet(
    walletId: 'review-wallet',
    address: '0x0000000000000000000000000000000000000001',
    chain: 'ethereum',
    status: WalletState.active,
    createdAt: DateTime.utc(2026, 1, 15),
  );

  @override
  Future<DomainPage<Wallet>> listWallets({String? cursor}) async =>
      DomainPage(items: [_wallet]);

  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async => _wallet;

  WalletAuthorization _authorization(String walletId) => WalletAuthorization(
    authorizationId: store.id('authorization'),
    walletId: walletId,
    status: WalletAuthorizationState.authorized,
    expiresAt: _now.add(const Duration(minutes: 10)),
  );

  @override
  Future<WalletAuthorization> authorizeWithdrawal({
    required String walletId,
    required String quoteId,
    required String amount,
    required String idempotencyKey,
  }) async => _authorization(walletId);

  @override
  Future<WalletAuthorization> authorizeFundingTransfer({
    required String walletId,
    required String planId,
    required String asset,
    required String maximumAmount,
    required String idempotencyKey,
  }) async => _authorization(walletId);
}

final class AppReviewActivityRepository implements ActivityRepository {
  AppReviewActivityRepository(this.store);
  final AppReviewStore store;

  @override
  Future<DomainPage<ActivityRecord>> list({
    ActivityCategory? category,
    ActivityState? status,
    String? cursor,
  }) async {
    final records = <ActivityRecord>[
      ActivityRecord(
        id: 'review-activity-order',
        category: ActivityCategory.orders,
        type: 'order_filled',
        status: ActivityState.success,
        title: 'Bought NVDA',
        amount: _usd('2500.00'),
        context: 'App Review simulated order',
        createdAt: _now.subtract(const Duration(days: 1)),
      ),
      ActivityRecord(
        id: 'review-activity-deposit',
        category: ActivityCategory.funds,
        type: 'deposit_credited',
        status: ActivityState.success,
        title: 'USDC deposit',
        amount: _token('5000.00', 'USDC'),
        context: 'App Review simulated deposit',
        createdAt: _now.subtract(const Duration(days: 3)),
      ),
      for (final order in store.orders.values)
        ActivityRecord(
          id: 'activity-${order.orderId}',
          category: ActivityCategory.orders,
          type: 'order_filled',
          status: ActivityState.success,
          title: '${order.side.name} ${order.symbol}',
          amount: order.orderValue,
          context: 'App Review simulated order',
          reference: ActivityReference(type: 'order', id: order.orderId),
          createdAt: order.createdAt,
        ),
    ];
    return DomainPage(
      items: records
          .where((item) => category == null || item.category == category)
          .where((item) => status == null || item.status == status)
          .toList(growable: false),
    );
  }
}

final class AppReviewPositionsRepository implements PositionsRepository {
  @override
  Future<PositionLeverageContext> leverageContext(String productId) async =>
      PositionLeverageContext(
        productId: productId,
        maximum: DecimalValue('50'),
        current: DecimalValue('5'),
        marginMode: PositionMarginMode.cross,
        validUntil: _now.add(const Duration(hours: 1)),
        canChange: true,
      );

  @override
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({
    String? cursor,
  }) async => const DomainPage(items: []);

  @override
  Future<void> resumeHip3Action(String actionId) async {}

  @override
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  }) async => DomainPage(
    items: AppReviewPortfolioRepository.positions
        .where((item) => symbol == null || item.symbol == symbol)
        .where((item) => kind == null || item.kind == kind)
        .toList(growable: false),
  );

  @override
  Future<Position> get(String positionId) async => AppReviewPortfolioRepository
      .positions
      .firstWhere((item) => item.positionId == positionId);

  @override
  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
    ProtectionClearScope? clearScope,
    required String idempotencyKey,
  }) async => position;

  @override
  Future<Position> clearTpSl(
    String positionId, {
    ProtectionClearScope scope = ProtectionClearScope.both,
    required String idempotencyKey,
  }) => get(positionId);

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    required String idempotencyKey,
  }) async => position;

  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    required String idempotencyKey,
  }) async {
    final position = await get(positionId);
    return TradingOrder(
      orderId: 'review-close-$positionId',
      symbol: position.symbol,
      kind: position.kind,
      side: position.kind == MarketProductKind.bstock
          ? TradingSide.sell
          : TradingSide.short,
      type: TradingOrderType.market,
      status: TradingOrderStatus.filled,
      quantity: position.quantity,
      filledQuantity: position.quantity,
      orderValue: position.valueUsd,
      createdAt: _now,
      updatedAt: _now,
    );
  }
}

final class AppReviewOrdersRepository implements OrdersRepository {
  AppReviewOrdersRepository(
    this.store, {
    required this.previewDelegate,
    required this.marketsDelegate,
  });

  final AppReviewStore store;
  final OrdersRepository previewDelegate;
  final MarketsRepository marketsDelegate;
  final Map<MarketProductRef, Future<MarketProduct>> _products = {};

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    OrderPreview? preview;
    try {
      preview = await previewDelegate.preview(
        intent,
        idempotencyKey: idempotencyKey,
      );
    } on Object {
      // Review mode can still proceed when the read-only quote is unavailable.
    }

    final needsProduct =
        intent.kind == MarketProductKind.bstock ||
        preview == null ||
        preview.marketPrice == null ||
        preview.estimatedPrice == null ||
        preview.estimatedQuantity == null;
    if (!needsProduct) return preview;

    try {
      final productRef = MarketProductRef(
        symbol: intent.symbol,
        kind: intent.kind,
      );
      final product = await _products.putIfAbsent(
        productRef,
        () => marketsDelegate.getProduct(productRef),
      );
      return _completePreview(
        preview ?? _fallbackPreview(intent),
        product.price,
      );
    } on Object {
      return preview ?? _fallbackPreview(intent);
    }
  }

  OrderPreview _completePreview(OrderPreview preview, DecimalValue price) {
    final intent = preview.intent;
    final calculatedQuantity = _divide(
      intent.amount,
      price,
      asset: intent.symbol,
      unit: 'token',
    );
    final quantity =
        calculatedQuantity ?? preview.estimatedQuantity ?? intent.quantity;
    final orderValue =
        intent.amount ??
        _multiply(intent.quantity, price, asset: 'USD', unit: 'fiat') ??
        preview.orderValue;
    final calculatedReceive = switch ((intent.kind, intent.side)) {
      (MarketProductKind.bstock, TradingSide.buy) => calculatedQuantity,
      (MarketProductKind.bstock, TradingSide.sell) => _multiply(
        intent.quantity,
        price,
        asset: preview.settlementAsset ?? 'USDC',
        unit: 'token',
      ),
      _ => null,
    };
    return OrderPreview(
      previewId: preview.previewId,
      intent: intent,
      orderValue: orderValue,
      marketPrice: preview.marketPrice ?? price,
      estimatedPrice: preview.estimatedPrice ?? price,
      estimatedQuantity: quantity,
      estimatedReceive: calculatedReceive ?? preview.estimatedReceive,
      fee: preview.fee,
      marginRequired: preview.marginRequired,
      liquidationPrice: preview.liquidationPrice,
      settlementAsset: preview.settlementAsset,
      priceUpdated: preview.priceUpdated,
      expiresAt: preview.expiresAt,
    );
  }

  OrderPreview _fallbackPreview(OrderIntent intent) {
    final price = intent.limitPrice ?? _usd('250.00');
    final quantity = intent.quantity ?? _token('1', intent.symbol);
    final value = intent.amount ?? _usd('250.00');
    return OrderPreview(
      previewId: store.id('preview'),
      intent: intent,
      orderValue: value,
      marketPrice: price,
      estimatedPrice: price,
      estimatedQuantity: quantity,
      fee: _usd('0.25'),
      settlementAsset: 'USDC',
      expiresAt: _now.add(const Duration(minutes: 5)),
    );
  }

  DecimalValue? _multiply(
    DecimalValue? left,
    DecimalValue right, {
    required String asset,
    required String unit,
  }) {
    if (left == null) return null;
    final value = double.parse(left.value) * double.parse(right.value);
    return DecimalValue(_calculatedValue(value), asset: asset, unit: unit);
  }

  DecimalValue? _divide(
    DecimalValue? numerator,
    DecimalValue denominator, {
    required String asset,
    required String unit,
  }) {
    if (numerator == null) return null;
    final divisor = double.parse(denominator.value);
    if (divisor == 0) return null;
    final value = double.parse(numerator.value) / divisor;
    return DecimalValue(_calculatedValue(value), asset: asset, unit: unit);
  }

  String _calculatedValue(double value) {
    final fixed = value.toStringAsFixed(8);
    return fixed.replaceFirst(RegExp(r'\.?0+$'), '');
  }

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async {
    final price = intent.limitPrice ?? _usd('250.00');
    final quantity = intent.quantity ?? _token('1', intent.symbol);
    final order = TradingOrder(
      orderId: store.id('order'),
      symbol: intent.symbol,
      kind: intent.kind,
      side: intent.side,
      type: intent.type,
      status: TradingOrderStatus.filled,
      quantity: quantity,
      filledQuantity: quantity,
      limitPrice: intent.limitPrice,
      averageFillPrice: price,
      orderValue: intent.amount ?? _usd('250.00'),
      fee: _usd('0.25'),
      createdAt: _now,
      updatedAt: _now,
    );
    store.orders[order.orderId] = order;
    return ResourceResult(resource: order);
  }

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async => DomainPage(
    items: store.orders.values
        .where((order) => kind == null || order.kind == kind)
        .where((order) => symbol == null || order.symbol == symbol)
        .where((order) => productId == null || order.productId == productId)
        .map((order) => ResourceResult(resource: order))
        .toList(growable: false),
  );

  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) async =>
      ResourceResult(resource: store.orders[orderId]!);

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) async => get(orderId);
}

final class AppReviewFundingRepository implements FundingRepository {
  AppReviewFundingRepository(this.store);
  final AppReviewStore store;

  @override
  Future<DepositDirectory> getDepositDirectory() async => DepositDirectory(
    walletAddress: '0x0000000000000000000000000000000000000001',
    instructions: [
      DepositInstruction(
        chain: 'Arbitrum',
        token: 'USDC',
        tokenContract: '0x0000000000000000000000000000000000000000',
        tokenDecimals: 6,
        address: '0x0000000000000000000000000000000000000001',
        qrPayload: 'app-review://deposit/arbitrum/usdc',
        minimumAmount: _token('1.00', 'USDC'),
        confirmationsRequired: 1,
        estimatedArrivalSeconds: 5,
        warning: 'App Review simulation. Do not send real assets.',
      ),
    ],
    updatedAt: _now,
  );

  @override
  Future<UnifiedFundingAccountSummary> getUnifiedFundingAccount() async =>
      UnifiedFundingAccountSummary(
        totalUsd: _usd('25000.00'),
        availableToFundUsd: _usd('4375.00'),
        reservedUsd: _usd('0.00'),
        inTransitUsd: _usd('0.00'),
        dataStatus: 'simulated',
        calculatedAt: _now,
      );

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async {
    final id = store.id('funding-plan');
    final plan = FundingPlan(
      planId: id,
      tradePreviewId: tradePreviewId,
      shortfall: _token('100.00', 'USDC'),
      status: FundingPlanState.ready,
      sourceWalletId: 'review-wallet',
      sourceAsset: 'USDC',
      sourceMaximum: _token('100.00', 'USDC'),
      legs: [
        FundingLeg(
          legId: '$id-leg-1',
          walletId: 'review-wallet',
          asset: 'USDC',
          maximumAmount: _token('100.00', 'USDC'),
          outputAmount: _token('100.00', 'USDC'),
          status: FundingLegState.actionReleased,
        ),
      ],
    );
    store.fundingPlans[id] = plan;
    return plan;
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async =>
      store.fundingPlans[id]!;

  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    final transfer = FundingTransfer(
      transferId: store.id('funding-transfer'),
      planId: planId,
      amount: _token('100.00', 'USDC'),
      status: FundingTransferState.completed,
    );
    store.fundingTransfers[transfer.transferId] = transfer;
    final plan = store.fundingPlans[planId];
    if (plan != null) {
      store.fundingPlans[planId] = FundingPlan(
        planId: plan.planId,
        tradePreviewId: plan.tradePreviewId,
        shortfall: plan.shortfall,
        status: FundingPlanState.alreadyFunded,
        sourceWalletId: plan.sourceWalletId,
        sourceAsset: plan.sourceAsset,
        sourceMaximum: plan.sourceMaximum,
        blocker: plan.blocker,
        legs: plan.legs
            .map(
              (leg) => FundingLeg(
                legId: leg.legId,
                walletId: leg.walletId,
                asset: leg.asset,
                maximumAmount: leg.maximumAmount,
                outputAmount: leg.outputAmount,
                status: leg.legId == legId
                    ? FundingLegState.completed
                    : leg.status,
                transferId: leg.legId == legId
                    ? transfer.transferId
                    : leg.transferId,
              ),
            )
            .toList(growable: false),
      );
    }
    return transfer;
  }

  @override
  Future<FundingTransfer> getFundingTransfer(String id) async =>
      store.fundingTransfers[id]!;

  @override
  Future<ResourceResult<Deposit>> getDeposit(String id) async =>
      ResourceResult(resource: store.deposits[id]!);

  @override
  Future<DomainPage<ResourceResult<Deposit>>> listDeposits({
    String? cursor,
  }) async => DomainPage(
    items: store.deposits.values
        .map((item) => ResourceResult(resource: item))
        .toList(growable: false),
  );

  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) async => WithdrawalQuote(
    quoteId: store.id('withdrawal-quote'),
    intent: intent,
    totalFee: _token('0.10', intent.amount.asset ?? 'USDC'),
    estimatedReceive: intent.amount,
    sufficient: true,
  );

  @override
  Future<Withdrawal> createWithdrawal(
    WithdrawalIntent intent, {
    required String quoteId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    final withdrawal = Withdrawal(
      withdrawalId: store.id('withdrawal'),
      chain: intent.chain,
      amount: intent.amount,
      receivedAmount: intent.amount,
      totalFee: _token('0.10', intent.amount.asset ?? 'USDC'),
      address: intent.address,
      status: WithdrawalState.completed,
      createdAt: _now,
    );
    store.withdrawals[withdrawal.withdrawalId] = withdrawal;
    return withdrawal;
  }

  @override
  Future<DomainPage<DepositObservation>> listDepositObservations({
    String? cursor,
  }) async => const DomainPage(items: <DepositObservation>[]);

  @override
  Future<Withdrawal> getWithdrawal(String id) async => store.withdrawals[id]!;

  @override
  Future<DomainPage<Withdrawal>> listWithdrawals({String? cursor}) async =>
      DomainPage(items: store.withdrawals.values.toList(growable: false));
}

final class AppReviewTradeIntentRepository implements TradeIntentRepository {
  AppReviewTradeIntentRepository(this.store);
  final AppReviewStore store;

  @override
  Future<TradeIntent> create(
    TradeIntentCreateInput input, {
    required String idempotencyKey,
  }) async {
    final id = store.id('trade-intent');
    final intent = TradeIntent(
      tradeIntentId: id,
      previewId: input.previewId,
      authorizationId: input.authorizationId,
      productId: 'app-review-product',
      status: 'order_created',
      nextAction: 'complete',
      executionPolicy: input.executionPolicy,
      orderId: store.id('order'),
      createdAt: _now,
      updatedAt: _now,
      expiresAt: input.executionPolicy.executeBefore,
    );
    store.tradeIntents[id] = intent;
    return intent;
  }

  @override
  Future<TradeIntent?> getCurrent() async =>
      store.tradeIntents.values.where((item) => !item.isTerminal).firstOrNull;

  @override
  Future<TradeIntent> get(String tradeIntentId) async =>
      store.tradeIntents[tradeIntentId]!;

  @override
  Future<TradeIntent> cancel(
    String tradeIntentId, {
    required String idempotencyKey,
  }) async => store.tradeIntents[tradeIntentId]!;
}

final class AppReviewHip3OrderExecutionRepository
    implements Hip3OrderExecutionRepository {
  AppReviewHip3OrderExecutionRepository(this.store);
  final AppReviewStore store;

  @override
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(
    String orderId,
  ) async => ResourceResult(resource: store.orders[orderId]!);

  @override
  Future<DomainPage<Hip3ActionSummary>> listActions({String? cursor}) async =>
      const DomainPage(items: []);

  @override
  Future<Hip3ActionSummary> getAction(String actionId) async =>
      throw StateError('No simulated HIP-3 action with id $actionId');

  @override
  Future<Hip3ActionSummary> cancelAction(
    String actionId, {
    required String idempotencyKey,
  }) => getAction(actionId);

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  }) async => ResourceResult(resource: store.orders[orderId]!);
}

final class AppReviewRealtimeRepository implements RealtimeRepository {
  @override
  Stream<TypedRealtimeEvent> subscribe({required Set<String> channels}) =>
      const Stream.empty();
}
