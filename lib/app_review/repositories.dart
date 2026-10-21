import '../domain/repositories/bstocks_order_execution_repository.dart';
import '../domain/repositories/hip3_account_abstraction_repository.dart';
import '../domain/repositories/hip3_opening_repository.dart';
import '../domain/repositories/hip3_withdrawal_repository.dart';
import '../domain/models/hip3_step_confirmation.dart';
import '../domain/models/hip3_opening_protection.dart';
import '../domain/models/hip3_account_abstraction.dart';
import '../domain/models/hip3_opening_context.dart';
import '../domain/models/hip3_withdrawal_preview.dart';
import '../domain/models/hip3_withdrawal.dart';
import '../domain/models/portfolio_asset.dart';

import 'dart:async';

import '../domain/models/activity_record.dart';
import '../domain/models/account_deletion.dart';
import '../domain/models/decimal_value.dart';
import '../domain/models/deposit.dart';
import '../domain/models/deposit_observation.dart';
import '../domain/models/funding_session.dart';
import '../domain/models/self_custodial_withdrawal.dart';
import '../domain/models/funding_catalog_summary.dart';
import '../domain/models/domain_page.dart';
import '../domain/models/funding_catalog.dart';
import '../domain/models/funding_transfer.dart';
import '../domain/models/hip3_action_summary.dart';
import '../domain/models/hip3_protection.dart';
import '../domain/models/position_leverage_context.dart';
import '../domain/models/position_operation.dart';
import '../domain/models/market_product.dart';
import '../domain/models/order.dart';
import '../domain/models/order_intent.dart';
import '../domain/models/order_preview.dart';
import '../domain/models/portfolio.dart';
import '../domain/models/portfolio_history.dart';
import '../domain/models/portfolio_allocation.dart';
import '../domain/models/position.dart';
import '../domain/models/position_close_preview.dart';
import '../domain/models/registered_device.dart';
import '../domain/models/realtime_replay_page.dart';
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

part 'ledger.dart';
part 'financial_repositories.dart';

DecimalValue _usd(String value) =>
    DecimalValue(value, asset: 'USD', unit: 'fiat');
DecimalValue _token(String value, String asset) =>
    DecimalValue(value, asset: asset, unit: 'token');
DateTime get _now => DateTime.now().toUtc();

Map<String, TradingOrder> _initialOpenOrders() {
  final createdAt = _now.subtract(const Duration(hours: 2));
  return {
    'review-open-bstock-nvda': TradingOrder(
      orderId: 'review-open-bstock-nvda',
      productId: 'bstock-nvda',
      symbol: 'NVDA',
      kind: MarketProductKind.bstock,
      side: TradingSide.buy,
      type: TradingOrderType.limit,
      status: TradingOrderStatus.open,
      quantity: _token('2', 'NVDA'),
      filledQuantity: _token('0', 'NVDA'),
      limitPrice: _usd('1215.00'),
      orderValue: _usd('2430.00'),
      createdAt: createdAt,
      updatedAt: createdAt,
    ),
    'review-open-bstock-tsla': TradingOrder(
      orderId: 'review-open-bstock-tsla',
      productId: 'bstock-tsla',
      symbol: 'TSLA',
      kind: MarketProductKind.bstock,
      side: TradingSide.sell,
      type: TradingOrderType.limit,
      status: TradingOrderStatus.partiallyFilled,
      quantity: _token('8', 'TSLA'),
      filledQuantity: _token('3', 'TSLA'),
      limitPrice: _usd('265.00'),
      orderValue: _usd('2120.00'),
      createdAt: createdAt.subtract(const Duration(minutes: 20)),
      updatedAt: createdAt,
    ),
    'review-open-hip3-nvda-tp': TradingOrder(
      orderId: 'review-open-hip3-nvda-tp',
      productId: 'xyz:NVDA',
      positionId: 'review-position-xyz-nvda',
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      side: TradingSide.short,
      type: TradingOrderType.market,
      status: TradingOrderStatus.open,
      quantity: _token('6', 'NVDA'),
      filledQuantity: _token('0', 'NVDA'),
      orderValue: _usd('8340.00'),
      conditional: ConditionalOrder(
        role: 'takeProfit',
        triggerPrice: _usd('1390.00'),
        triggerStatus: 'untriggered',
        executionType: 'market',
        sizeMode: 'entirePosition',
        quantity: '6',
        triggerReference: 'mark',
        activationStatus: 'active',
        parentOrderId: 'review-position-xyz-nvda',
      ),
      createdAt: createdAt.subtract(const Duration(minutes: 40)),
      updatedAt: createdAt,
    ),
    'review-open-hip3-tsla-sl': TradingOrder(
      orderId: 'review-open-hip3-tsla-sl',
      productId: 'xyz:TSLA',
      positionId: 'review-position-xyz-tsla',
      symbol: 'TSLA',
      kind: MarketProductKind.perp,
      side: TradingSide.long,
      type: TradingOrderType.market,
      status: TradingOrderStatus.open,
      quantity: _token('15', 'TSLA'),
      filledQuantity: _token('0', 'TSLA'),
      orderValue: _usd('4095.00'),
      conditional: ConditionalOrder(
        role: 'stopLoss',
        triggerPrice: _usd('273.00'),
        triggerStatus: 'untriggered',
        executionType: 'market',
        sizeMode: 'entirePosition',
        quantity: '15',
        triggerReference: 'mark',
        activationStatus: 'active',
        parentOrderId: 'review-position-xyz-tsla',
      ),
      createdAt: createdAt.subtract(const Duration(minutes: 60)),
      updatedAt: createdAt,
    ),
  };
}

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
    store.changed();
    return store.settings;
  }

  @override
  Future<DomainPage<RegisteredDevice>> listDevices({String? cursor}) async =>
      DomainPage(items: store.devices.values.toList());

  @override
  Future<RegisteredDevice> registerDevice(
    DeviceRegistration registration,
  ) async {
    store.requireActive();
    final device = RegisteredDevice(
      deviceId: registration.deviceId,
      platform: registration.platform,
      appVersion: registration.appVersion,
      pushProvider: registration.pushProvider,
      pushTokenRegistered: true,
      lastSeenAt: _now,
      createdAt: _now,
    );
    store.devices[device.deviceId] = device;
    store.changed();
    return device;
  }

  @override
  Future<void> deleteDevice(String deviceId) async {
    store.requireActive();
    store.devices.remove(deviceId);
    store.changed();
  }

  @override
  Future<AccountDeletion> requestAccountDeletion({
    required String idempotencyKey,
  }) async => store.once(
    'account-deletion:$idempotencyKey',
    () => store.deletion ??= _reviewDeletion(),
  );

  @override
  Future<AccountDeletion> getAccountDeletion() async =>
      store.deletion ??
      (throw StateError('No account deletion has been requested'));

  AccountDeletion _reviewDeletion() => AccountDeletion(
    requestId: store.id('account-deletion'),
    state: AccountDeletionState.requested,
    blockers: const [],
    requestedAt: _now,
    updatedAt: _now,
  );
}

final class AppReviewPortfolioRepository
    implements
        PortfolioRepository,
        PortfolioHistoryRepository,
        PortfolioAllocationRepository,
        PortfolioAssetsRepository {
  AppReviewPortfolioRepository([AppReviewStore? store, this.markets])
    : store = store ?? AppReviewStore();
  final AppReviewStore store;
  final MarketsRepository? markets;
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
      unrealizedPnlPercent: DecimalValue('5.93', unit: 'percent'),
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
      unrealizedPnlPercent: DecimalValue('5.04', unit: 'percent'),
      updatedAt: _now,
    ),
    Position(
      positionId: 'review-position-xyz-nvda',
      productId: 'xyz:NVDA',
      positionVersion: 'review-nvda-v1',
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      side: PositionSide.long,
      quantity: _token('6', 'NVDA'),
      valueUsd: _usd('2830.00'),
      entryPrice: _usd('1195.00'),
      markPrice: _usd('1250.00'),
      unrealizedPnl: _usd('330.00'),
      unrealizedPnlPercent: DecimalValue('9.17', unit: 'percent'),
      fundingPaid: _usd('-8.40'),
      leverage: DecimalValue('3', unit: 'multiple'),
      margin: _usd('2500.00'),
      marginMode: PositionMarginMode.cross,
      liquidationPrice: _usd('865.00'),
      takeProfitPrice: _usd('1390.00'),
      stopLossPrice: _usd('1120.00'),
      updatedAt: _now,
    ),
    Position(
      positionId: 'review-position-xyz-tsla',
      productId: 'xyz:TSLA',
      positionVersion: 'review-tsla-v1',
      symbol: 'TSLA',
      kind: MarketProductKind.perp,
      side: PositionSide.short,
      quantity: _token('15', 'TSLA'),
      valueUsd: _usd('1220.00'),
      entryPrice: _usd('258.00'),
      markPrice: _usd('250.00'),
      unrealizedPnl: _usd('120.00'),
      unrealizedPnlPercent: DecimalValue('10.91', unit: 'percent'),
      fundingPaid: _usd('3.10'),
      leverage: DecimalValue('3.4', unit: 'multiple'),
      margin: _usd('1100.00'),
      marginMode: PositionMarginMode.isolated,
      liquidationPrice: _usd('326.00'),
      takeProfitPrice: _usd('225.00'),
      stopLossPrice: _usd('273.00'),
      updatedAt: _now,
    ),
  ];

  List<TradingAccount> get accounts => store.accounts;

  @override
  Future<Portfolio> getSummary() async {
    await store.refreshMarkets(markets);
    return Portfolio(
      totalValueUsd: _money(store.total),
      availableToTradeUsd: _money(
        store.availableSpotCash + store.availablePerps,
      ),
      todayPnl: _money(store.realizedPnl + store.unrealizedPnl),
      todayPnlPercent: DecimalValue(
        _number((store.realizedPnl + store.unrealizedPnl) / 31000 * 100),
        unit: 'percent',
      ),
      marginInUseUsd: _money(store.margin),
      stocksValueUsd: _money(store.stocksValue),
      updatedAt: _now,
      accounts: accounts,
      holdings: _holdings,
    );
  }

  @override
  Future<PortfolioRailAllocation> getRailAllocation() async {
    await store.refreshMarkets(markets);
    final values = {
      'cash': store.spotCash,
      'bstock': store.stocksValue,
      'perp': store.perpsEquity,
    };
    PortfolioAccountAllocation allocation(
      double value, {
      PortfolioPerpsAllocationBreakdown? breakdown,
    }) => PortfolioAccountAllocation(
      valueUsd: _money(value),
      percent: DecimalValue(
        _number(store.total == 0 ? 0 : value / store.total * 100),
        unit: 'percent',
      ),
      perpsBreakdown: breakdown,
    );
    return PortfolioRailAllocation(
      items: [
        for (final entry in values.entries)
          PortfolioRailAllocationItem(
            rail: entry.key,
            valueUsd: _money(entry.value),
            percent:
                allocation(entry.value).percent ??
                DecimalValue('0', unit: 'percent'),
          ),
      ],
      valuedTotalUsd: _money(store.total),
      unvaluedAssetCount: 0,
      spot: allocation(store.spotCash + store.stocksValue),
      perps: allocation(store.perpsEquity, breakdown: store.perpsBreakdown),
    );
  }

  @override
  Future<List<PortfolioAsset>> listAssets({
    String? cursor,
    String? productId,
    String? account,
  }) async {
    await store.refreshMarkets(markets);
    return [
      if (productId == null && account != 'perps') ...store.cashAssets,
      if (account != 'perps')
        ...store.stockAssets.where(
          (asset) => productId == null || asset.productId == productId,
        ),
      if (account != 'spot' && productId == null)
        PortfolioAsset(
          assetId: 'review-hip3-usdc',
          network: 'hyperliquid',
          symbol: 'USDC',
          decimals: 6,
          balance: _token(_number(store.perpsEquity), 'USDC'),
          valueUsd: _money(store.perpsEquity),
          availableQuantity: _token(_number(store.availablePerps), 'USDC'),
          availabilityStatus: 'complete',
          freshness: 'fresh',
        ),
    ];
  }

  @override
  Future<PortfolioHistory> getHistory(PortfolioHistoryRange range) async {
    final step = switch (range) {
      PortfolioHistoryRange.oneDay => const Duration(hours: 3),
      PortfolioHistoryRange.oneWeek => const Duration(days: 1),
      PortfolioHistoryRange.oneMonth => const Duration(days: 4),
      PortfolioHistoryRange.oneYear => const Duration(days: 52),
    };
    const values = [
      '28640.00',
      '29120.00',
      '28980.00',
      '29750.00',
      '30110.00',
      '29940.00',
      '30520.00',
      '31000.00',
    ];
    final start = _now.subtract(step * (values.length - 1));
    return PortfolioHistory(
      range: range,
      calculatedAt: _now,
      points: List.generate(
        values.length,
        (index) => PortfolioHistoryPoint(
          timestamp: start.add(step * index),
          totalValueUsd: index == values.length - 1
              ? _money(store.total)
              : _usd(values[index]),
        ),
      ),
    );
  }

  List<HoldingGroup> get _holdings => store.positions.values
      .map(
        (position) => HoldingGroup(
          symbol: position.symbol,
          totalValueUsd: position.valueUsd,
          positions: [position],
        ),
      )
      .toList(growable: false);

  @override
  Future<List<TradingAccount>> listAccounts() async {
    await store.refreshMarkets(markets);
    return accounts;
  }

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async {
    await store.refreshMarkets(markets);
    return DomainPage(items: _holdings);
  }
}

final class AppReviewWalletsRepository implements WalletsRepository {
  AppReviewWalletsRepository(this.store, {required this.readDelegate});
  final AppReviewStore store;
  final WalletsRepository readDelegate;

  Wallet get _wallet => Wallet(
    walletId: 'review-wallet',
    address: _reviewAddress,
    chain: 'arbitrum',
    status: WalletState.active,
    createdAt: DateTime.utc(2026, 1, 15),
  );

  // Simulated portfolio assets reference this ledger wallet. The live deposit
  // directory resolves the real wallet independently after syncWallet below.
  @override
  Future<DomainPage<Wallet>> listWallets({String? cursor}) async => DomainPage(
    items: [
      _wallet,
      for (final chain in {...store.cashAssets.map((a) => a.normalizedNetwork)})
        if (chain != 'arbitrum')
          Wallet(
            walletId: store.reviewWalletId(chain),
            address: _reviewAddress,
            chain: chain,
            status: WalletState.active,
            createdAt: _wallet.createdAt,
          ),
    ],
  );

  // Wallet provisioning/registration does not move funds. Keep real identity
  // in sync so the live deposit directory can resolve the verified wallet.
  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async =>
      readDelegate.syncWallet(idempotencyKey: idempotencyKey);

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
    String? type,
    String? productOrAsset,
    String? cursor,
  }) async {
    final records = <ActivityRecord>[
      ...store.activities.reversed,
      ActivityRecord(
        id: 'review-activity-order',
        category: ActivityCategory.orders,
        type: 'market',
        status: ActivityState.success,
        title: 'Bought NVDA',
        amount: _usd('2500.00'),
        context: 'App Review simulated order',
        symbol: 'NVDA',
        kind: MarketProductKind.bstock.name,
        createdAt: _now.subtract(const Duration(days: 1)),
      ),
      ActivityRecord(
        id: 'review-activity-deposit',
        category: ActivityCategory.cash,
        type: 'deposit',
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
          type: order.conditional == null ? order.type.name : 'tpsl',
          status: order.status == TradingOrderStatus.cancelled
              ? ActivityState.cancelled
              : !order.isTerminal
              ? ActivityState.pending
              : ActivityState.success,
          title: '${order.side.name} ${order.symbol}',
          amount: order.orderValue,
          context: 'App Review simulated order',
          reference: ActivityReference(type: 'order', id: order.orderId),
          symbol: order.symbol,
          kind: order.kind.name,
          createdAt: order.createdAt,
        ),
    ];
    return DomainPage(
      items: records
          .where((item) => category == null || item.category == category)
          .where((item) => status == null || item.status == status)
          .where((item) => type == null || item.type == type)
          .where(
            (item) =>
                productOrAsset == null ||
                item.symbol == productOrAsset ||
                item.asset == productOrAsset,
          )
          .toList(growable: false),
    );
  }
}

final class AppReviewPositionsRepository implements PositionsRepository {
  AppReviewPositionsRepository([AppReviewStore? store, this.markets])
    : store = store ?? AppReviewStore();
  final AppReviewStore store;
  final MarketsRepository? markets;
  @override
  Future<int> sizeDecimals(String productId) async => 4;

  @override
  Future<PositionClosePreview> previewClose(
    Position position, {
    required String quantity,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    required String idempotencyKey,
  }) async {
    // Use the latest real market observation for the simulated close.
    await store.refreshMarkets(markets);
    position = store.position(position.positionId);
    requireWithinPosition(quantity, position.quantity.value);
    final mark =
        position.markPrice ??
        position.entryPrice ??
        (throw StateError('Market price unavailable. Please refresh.'));
    final entry = position.entryPrice ?? mark;
    final price = type == TradingOrderType.limit
        ? DecimalValue(limitPrice ?? '')
        : mark;
    requirePositiveDecimal(price.value);
    final size = double.parse(quantity);
    final notional = size * double.parse(price.value);
    final fee =
        notional *
        _value(
          store.contexts[position.productId]?.takerFeeRate ??
              DecimalValue('0.00045'),
        );
    final pnl =
        size *
            (double.parse(price.value) - double.parse(entry.value)) *
            (position.side == PositionSide.short ? -1 : 1) -
        fee;
    return PositionClosePreview(
      previewId: 'review-close-preview-$idempotencyKey',
      positionId: position.positionId,
      productId: position.productId!,
      positionVersion: position.positionVersion ?? 'review',
      environment: store.contexts[position.productId]?.environment ?? 'mainnet',
      side: position.side == PositionSide.long
          ? PositionSide.short
          : PositionSide.long,
      type: type,
      quantity: DecimalValue(quantity),
      notional: DecimalValue(notional.toStringAsFixed(8)),
      entryPrice: entry,
      markPrice: mark,
      estimatedPrice: price,
      estimatedFee: DecimalValue(fee.toStringAsFixed(8)),
      estimatedRealizedPnl: DecimalValue(pnl.toStringAsFixed(8)),
      limitPrice: type == TradingOrderType.limit ? price : null,
      liquidationPrice: position.liquidationPrice,
      expiresAt: _now.add(const Duration(minutes: 1)),
      observedAt: _now,
    );
  }

  @override
  Future<Hip3ActionSummary> hip3Action(String actionId) async =>
      store.actions[actionId] ??
      (throw StateError('Simulated action not found'));

  @override
  Future<Hip3ActionSummary> manageTpSl(
    Position position, {
    required List<Hip3ProtectionChange> changes,
    required String idempotencyKey,
    bool confirmBeforeSigning = true,
  }) async => store.once(
    'protection:$idempotencyKey',
    () => store.changeProtection(position.positionId, changes),
  );

  @override
  Future<PositionLeverageContext> leverageContext(String productId) async {
    final position = store.positions.values
        .where((p) => p.productId == productId)
        .firstOrNull;
    return PositionLeverageContext(
      productId: productId,
      maximum: DecimalValue('50'),
      current: position?.leverage ?? DecimalValue('3'),
      marginMode: position?.marginMode ?? PositionMarginMode.cross,
      validUntil: _now.add(const Duration(hours: 1)),
      canChange: true,
    );
  }

  @override
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({
    String? cursor,
  }) async => const DomainPage(items: []);
  @override
  Future<void> resumeHip3Action(String actionId) async {
    await hip3Action(actionId);
  }

  @override
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  }) async {
    await store.refreshMarkets(markets);
    return DomainPage(
      items: store.positions.values
          .where(
            (p) =>
                (symbol == null || p.symbol == symbol) &&
                (kind == null || p.kind == kind),
          )
          .toList(),
    );
  }

  @override
  Future<Position> get(String positionId) async {
    await store.refreshMarkets(markets);
    return store.position(positionId);
  }

  @override
  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
    ProtectionClearScope? clearScope,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    final current = store.position(position.positionId);
    final changes = <Hip3ProtectionChange>[
      for (final order in current.protectionOrders)
        if ((takeProfit != null && order.protection.role == 'takeProfit') ||
            (stopLoss != null && order.protection.role == 'stopLoss') ||
            clearScope == ProtectionClearScope.both ||
            (clearScope == ProtectionClearScope.takeProfit &&
                order.protection.role == 'takeProfit') ||
            (clearScope == ProtectionClearScope.stopLoss &&
                order.protection.role == 'stopLoss'))
          Hip3ProtectionChange.cancel(order.orderId),
      if (takeProfit != null)
        Hip3ProtectionChange.create(
          Hip3ProtectionParameters(
            role: 'takeProfit',
            triggerPrice: _usd(takeProfit),
            limitPrice: takeLimit == null ? null : _usd(takeLimit),
            quantity: quantity == null
                ? null
                : _token(quantity, current.symbol),
          ),
        ),
      if (stopLoss != null)
        Hip3ProtectionChange.create(
          Hip3ProtectionParameters(
            role: 'stopLoss',
            triggerPrice: _usd(stopLoss),
            limitPrice: stopLimit == null ? null : _usd(stopLimit),
            quantity: quantity == null
                ? null
                : _token(quantity, current.symbol),
          ),
        ),
    ];
    await manageTpSl(current, changes: changes, idempotencyKey: idempotencyKey);
    return store.position(position.positionId);
  }

  @override
  Future<Position> clearTpSl(
    String positionId, {
    ProtectionClearScope scope = ProtectionClearScope.both,
    required String idempotencyKey,
  }) => updateTpSl(
    store.position(positionId),
    clearScope: scope,
    idempotencyKey: idempotencyKey,
  );
  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    PositionMarginMode? marginMode,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async => store.once(
    'leverage:$idempotencyKey',
    () => store.changeLeverage(position.positionId, leverage, marginMode),
  );
  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    PositionClosePreview? preview,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async => store.once('close:$idempotencyKey', () {
    final position = store.position(positionId);
    final size =
        quantity ??
        (percent == null
            ? position.quantity.value
            : percentageQuantity(position.quantity.value, percent));
    requireWithinPosition(size, position.quantity.value);
    if (preview != null &&
        (preview.isExpired ||
            preview.positionId != positionId ||
            preview.quantity.value != size ||
            preview.type != type)) {
      throw StateError('Close quote changed. Please refresh.');
    }
    return store.closePosition(
      position,
      double.parse(size),
      type: type,
      limitPrice: limitPrice,
      executionPrice: preview == null ? null : _value(preview.estimatedPrice),
      fee: preview == null ? null : _value(preview.estimatedFee),
    );
  });
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

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    OrderPreview? preview;
    Object? quoteError;
    try {
      preview = await previewDelegate.preview(
        intent,
        idempotencyKey: idempotencyKey,
      );
    } on Object catch (error) {
      quoteError = error;
    }

    final needsProduct =
        intent.kind == MarketProductKind.bstock ||
        preview == null ||
        preview.marketPrice == null ||
        preview.estimatedPrice == null ||
        preview.estimatedQuantity == null;
    if (!needsProduct) {
      final result = _completePreview(
        preview,
        preview.estimatedPrice ?? preview.marketPrice!,
      );
      store.previews[result.previewId] = result;
      return result;
    }

    try {
      final productRef = MarketProductRef(
        symbol: intent.symbol,
        kind: intent.kind,
      );
      final product = await marketsDelegate.getProduct(productRef);
      store.products['${intent.kind.name}:${intent.symbol}'] = product;
      if (product.productId == null &&
          intent.kind == MarketProductKind.bstock) {
        try {
          final snapshot = await marketsDelegate.getSnapshot(productRef);
          if (snapshot.productId != null) {
            store.productIds['${intent.kind.name}:${intent.symbol}'] =
                snapshot.productId!;
          }
        } on Object {
          /* An existing holding can still supply its known identity. */
        }
      }
      final result = _completePreview(
        preview ?? _fallbackPreview(intent, product.price),
        preview?.estimatedPrice ?? product.price,
      );
      store.previews[result.previewId] = result;
      return result;
    } on Object {
      if (preview == null) {
        throw quoteError ?? StateError('Market quote unavailable');
      }
      final result = _completePreview(
        preview,
        preview.estimatedPrice ??
            preview.marketPrice ??
            (throw quoteError ?? StateError('Market quote unavailable')),
      );
      store.previews[result.previewId] = result;
      return result;
    }
  }

  @override
  Future<OrderPreview> previewContinuation(
    String orderId,
    OrderIntent intent, {
    required String idempotencyKey,
  }) => preview(intent, idempotencyKey: idempotencyKey);

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
    final perps = intent.kind == MarketProductKind.perp;
    final productId =
        preview.hip3Execution?.productId ??
        store.products['${intent.kind.name}:${intent.symbol}']?.productId ??
        store.positions.values
            .where((p) => p.kind == intent.kind && p.symbol == intent.symbol)
            .firstOrNull
            ?.productId;
    final leverage =
        intent.leverage ??
        DecimalValue('${store.openingLeverages[productId] ?? 3}');
    final executionQuantity = quantity ?? _token('0', intent.symbol);
    final requiredMargin = perps
        ? _token(_number(_value(orderValue) / _value(leverage)), 'USDC')
        : null;
    final protection = intent.openingProtection;
    final execution = !perps || productId == null
        ? null
        : Hip3PreviewExecution(
            contextId: preview.hip3Execution?.contextId ?? 'review-$productId',
            productId: productId,
            environment:
                preview.hip3Execution?.environment ??
                store.contexts[productId]?.environment ??
                'mainnet',
            quantity: executionQuantity,
            type: intent.type,
            timeInForce: intent.type == TradingOrderType.limit ? 'Gtc' : 'Ioc',
            limitPrice: intent.limitPrice ?? price,
            leverage: leverage,
            marginMode:
                intent.marginMode ??
                store.openingModes[productId] ??
                TradingMarginMode.cross,
            reduceOnly: intent.reduceOnly,
            notional: orderValue,
            marginRequired: requiredMargin!,
            availableMargin: _token(_number(store.availablePerps), 'USDC'),
            estimatedFee: preview.fee ?? _money(_value(orderValue) * 0.00045),
            slippagePercent: intent.slippage ?? DecimalValue('0.5'),
            liquidationPrice: preview.hip3Execution?.liquidationPrice,
            liquidationPriceUnavailableReason:
                preview.hip3Execution?.liquidationPriceUnavailableReason,
            openingProtection: protection == null
                ? null
                : Hip3OpeningProtectionConfirmation(
                    quantity: executionQuantity,
                    legs: [
                      if (protection.takeProfit != null)
                        Hip3ConfirmedProtectionLeg(
                          takeProfit: true,
                          market: protection.takeProfit!.limitPrice == null,
                          triggerPrice: protection.takeProfit!.triggerPrice,
                          executionPrice:
                              protection.takeProfit!.limitPrice ?? price,
                        ),
                      if (protection.stopLoss != null)
                        Hip3ConfirmedProtectionLeg(
                          takeProfit: false,
                          market: protection.stopLoss!.limitPrice == null,
                          triggerPrice: protection.stopLoss!.triggerPrice,
                          executionPrice:
                              protection.stopLoss!.limitPrice ?? price,
                        ),
                    ],
                  ),
          );
    return OrderPreview(
      previewId: preview.previewId,
      intent: intent,
      orderValue: orderValue,
      marketPrice: preview.marketPrice ?? price,
      estimatedPrice: preview.estimatedPrice ?? price,
      estimatedQuantity: quantity,
      estimatedReceive: calculatedReceive ?? preview.estimatedReceive,
      fee: preview.fee,
      marginRequired: requiredMargin ?? preview.marginRequired,
      liquidationPrice: preview.liquidationPrice,
      settlementAsset: preview.settlementAsset,
      priceUpdated: preview.priceUpdated,
      expiresAt: preview.expiresAt ?? _now.add(const Duration(minutes: 1)),
      hip3Execution: execution,
      feeRate: preview.feeRate,
      feeNote: preview.feeNote,
      settlementChain: preview.settlementChain,
      details: preview.details,
      executionReady: true,
      approvalRequired: false,
    );
  }

  OrderPreview _fallbackPreview(OrderIntent intent, DecimalValue price) {
    final quantity =
        intent.quantity ??
        _token(_number(_value(intent.amount) / _value(price)), intent.symbol);
    final value = intent.amount ?? _money(_value(quantity) * _value(price));
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
    final existing = store.results['order:$idempotencyKey'];
    if (existing != null) return existing as ResourceResult<TradingOrder>;
    final quote = previewId == null
        ? await preview(intent, idempotencyKey: 'quote-$idempotencyKey')
        : store.previews[previewId];
    if (quote == null || quote.intent.fingerprint != intent.fingerprint) {
      throw StateError(
        'Order quote does not match the request. Please refresh.',
      );
    }
    if (quote.isExpired) {
      throw StateError('Order quote expired. Please refresh.');
    }
    return store.once(
      'order:$idempotencyKey',
      () => ResourceResult(resource: store.createOrder(intent, quote)),
    );
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
        .where(
          (order) => statusGroup == 'open'
              ? !order.isTerminal
              : (statusGroup != 'history' && statusGroup != 'closed') ||
                    order.isTerminal,
        )
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
  }) async {
    return ResourceResult(
      resource: store.once(
        'cancel:$idempotencyKey',
        () => store.cancelOrder(orderId),
      ),
    );
  }
}

final class AppReviewTradeIntentRepository implements TradeIntentRepository {
  AppReviewTradeIntentRepository(this.store);
  final AppReviewStore store;

  @override
  Future<TradeIntent> create(
    TradeIntentCreateInput input, {
    required String idempotencyKey,
  }) async => store.once('trade-intent:$idempotencyKey', () {
    store.requireActive();
    final preview =
        store.previews[input.previewId] ??
        (throw StateError('Trade quote not found. Please refresh.'));
    if (preview.isExpired) {
      throw StateError('Trade quote expired. Please refresh.');
    }
    final order = store.createOrder(preview.intent, preview);
    final id = store.id('trade-intent');
    final intent = TradeIntent(
      tradeIntentId: id,
      previewId: input.previewId,
      authorizationId: input.authorizationId,
      productId: order.productId!,
      status: 'order_created',
      nextAction: 'complete',
      executionPolicy: input.executionPolicy,
      orderId: order.orderId,
      createdAt: _now,
      updatedAt: _now,
      expiresAt: input.executionPolicy.executeBefore,
    );
    store.tradeIntents[id] = intent;
    return intent;
  });

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
      store.actions[actionId] ??
      (throw StateError('Simulated action not found'));

  @override
  Future<Hip3ActionSummary> cancelAction(
    String actionId, {
    required String idempotencyKey,
  }) => getAction(actionId);

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  }) async => ResourceResult(
    resource: store.once(
      'hip3-cancel:$idempotencyKey',
      () => store.cancelOrder(orderId),
    ),
  );
}

final class AppReviewRealtimeRepository implements RealtimeRepository {
  @override
  Stream<TypedRealtimeEvent> subscribe({required Set<String> channels}) =>
      const Stream.empty();

  @override
  Future<RealtimeReplayPage> replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
  }) async => const RealtimeReplayPage(
    items: [],
    nextCursor: '',
    hasMore: false,
    resyncRequired: false,
  );

  @override
  Stream<TypedRealtimeEvent> subscribeWithRecovery({
    required Set<String> channels,
    required Future<void> Function() refreshSnapshot,
  }) => const Stream.empty();
}
