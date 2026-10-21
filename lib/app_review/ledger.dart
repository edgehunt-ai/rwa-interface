part of 'repositories.dart';

const _reviewAddress = '0x0000000000000000000000000000000000000001';
const _reviewUsdc = '0xaf88d065e77c8cc2239327c5edb3a432268e5831';
String _number(num value) => value.abs() < 0.000000005
    ? '0'
    : value.toStringAsFixed(8).replaceFirst(RegExp(r'\.?0+$'), '');
double _value(DecimalValue? value) =>
    value == null ? 0 : double.parse(value.value);
DecimalValue _money(num value) => _usd(_number(value));

/// One session's simulated ledger. Only quote delegates perform network reads;
/// financial mutations in this store never invoke wallets or transport code.
final class AppReviewStore {
  AppReviewStore({this.onChanged}) {
    devices['app-review-device'] = RegisteredDevice(
      deviceId: 'app-review-device',
      platform: 'ios',
      appVersion: '0.7.9',
      pushProvider: 'apns',
      pushTokenRegistered: false,
      lastSeenAt: _now,
      createdAt: _now,
    );
    orders.addAll(_initialOpenOrders());
    for (final seed in AppReviewPortfolioRepository.positions) {
      positions[seed.positionId] = seed;
      seedMarksPending.add(seed.positionId);
    }
    for (final position in positions.values.toList()) {
      final protections = <Hip3PositionProtectionOrder>[];
      for (final order in orders.values.where(
        (o) => o.positionId == position.positionId,
      )) {
        final conditional = order.conditional!;
        protections.add(
          Hip3PositionProtectionOrder(
            orderId: order.orderId,
            protection: Hip3ProtectionParameters(
              role: conditional.role,
              triggerPrice: conditional.triggerPrice,
            ),
          ),
        );
      }
      positions[position.positionId] = _copyPosition(
        position,
        protections: protections,
      );
    }
  }
  final void Function()? onChanged;
  UserPreferences settings = const UserPreferences(
    language: 'en',
    pushEnabled: true,
    notifyOrderFilled: true,
    notifyOrderFailed: true,
    notifyLiquidationWarning: true,
  );
  final positions = <String, Position>{};
  final seedMarksPending = <String>{};
  final orders = <String, TradingOrder>{};
  final previews = <String, OrderPreview>{};
  final withdrawalQuotes = <String, WithdrawalQuote>{};
  final orderMargins = <String, double>{};
  final products = <String, MarketProduct>{};
  final productIds = <String, String>{};
  DateTime? marksUpdatedAt;
  Future<void>? marksRequest;
  final contexts = <String, Hip3OpeningContext>{};
  final deposits = <String, Deposit>{};
  final depositRoutes = <String, DepositInstruction>{};
  final depositBalances = <String, double>{};
  final withdrawals = <String, Withdrawal>{};
  final selfWithdrawals = <String, SelfCustodialWithdrawalSummary>{};
  final preparedWithdrawals = <String, PreparedSelfCustodialWithdrawal>{};
  final hip3Withdrawals = <String, Hip3Withdrawal>{};
  final hip3Quotes = <String, Hip3WithdrawalPreview>{};
  final fundingPlans = <String, FundingPlan>{};
  final fundingTransfers = <String, FundingTransfer>{};
  final sessions = <String, FundingSessionSummary>{};
  final fundingOrders = <String, OrderIntent>{};
  final destinations = <String, String>{};
  final tradeIntents = <String, TradeIntent>{};
  final actions = <String, Hip3ActionSummary>{};
  final results = <String, Object>{};
  final activities = <ActivityRecord>[];
  final openingLeverages = <String, int>{};
  final openingModes = <String, TradingMarginMode>{};
  final devices = <String, RegisteredDevice>{};
  AccountDeletion? deletion;
  double cash = 4375;
  double perpsCash = 2400;
  double realizedPnl = 0;
  bool unifiedAccount = true;
  bool active = true;
  int sequence = 0;
  String id(String prefix) => 'review-$prefix-${++sequence}';
  void changed() {
    if (active) onChanged?.call();
  }

  void requireActive() {
    if (!active) {
      throw StateError('Review session ended. Please sign in again.');
    }
  }

  // Draft quotes and plans do not change account balances or lists. Avoid
  // rebuilding account providers while the transfer UI is applying a quote.
  // Executed financial operations retain the default notification.
  T once<T extends Object>(
    String key,
    T Function() command, {
    bool notify = true,
  }) {
    requireActive();
    final existing = results[key];
    if (existing != null) return existing as T;
    final previousCash = cash,
        previousPerpsCash = perpsCash,
        previousPnl = realizedPnl;
    final rollback = <void Function()>[];
    void snapshot<K, V>(Map<K, V> map) {
      final previous = Map<K, V>.of(map);
      rollback.add(() {
        map
          ..clear()
          ..addAll(previous);
      });
    }

    snapshot(orderMargins);
    snapshot(positions);
    snapshot(orders);
    snapshot(actions);
    snapshot(deposits);
    snapshot(depositRoutes);
    snapshot(depositBalances);
    snapshot(withdrawals);
    snapshot(selfWithdrawals);
    snapshot(preparedWithdrawals);
    snapshot(hip3Withdrawals);
    snapshot(fundingPlans);
    snapshot(fundingTransfers);
    snapshot(sessions);
    snapshot(fundingOrders);
    snapshot(openingLeverages);
    snapshot(openingModes);
    snapshot(destinations);
    final activityCount = activities.length;
    final previousSeeds = Set<String>.of(seedMarksPending);
    try {
      final result = command();
      results[key] = result;
      if (notify) changed();
      return result;
    } on Object {
      cash = previousCash;
      perpsCash = previousPerpsCash;
      realizedPnl = previousPnl;
      for (final restore in rollback) {
        restore();
      }
      activities.length = activityCount;
      seedMarksPending
        ..clear()
        ..addAll(previousSeeds);
      rethrow;
    }
  }

  double get margin => positions.values
      .where((p) => p.kind == MarketProductKind.perp)
      .fold(0, (sum, p) => sum + _value(p.margin));
  double get unrealizedPnl =>
      positions.values.fold(0, (sum, p) => sum + _value(p.unrealizedPnl));
  double get stocksValue => positions.values
      .where((p) => p.kind == MarketProductKind.bstock)
      .fold(0, (sum, p) => sum + _value(p.valueUsd));
  double get perpsEquity =>
      perpsCash +
      margin +
      positions.values
          .where((p) => p.kind == MarketProductKind.perp)
          .fold(0.0, (sum, p) => sum + _value(p.unrealizedPnl));
  double get spotCash =>
      cash + depositBalances.values.fold(0.0, (a, b) => a + b);
  double get availableSpotCash => availableCash + spotCash - cash;
  double get total => spotCash + stocksValue + perpsEquity;

  List<PortfolioAsset> get cashAssets => [
    PortfolioAsset(
      assetId: 'review-usdc',
      network: 'arbitrum',
      symbol: 'USDC',
      decimals: 6,
      balance: _token(_number(cash), 'USDC'),
      valueUsd: _money(cash),
      availableQuantity: _token(_number(availableCash), 'USDC'),
      availabilityStatus: 'complete',
      withdrawable: true,
      walletId: 'review-wallet',
      contractAddress: _reviewUsdc,
      freshness: 'fresh',
    ),
    for (final entry in depositRoutes.entries)
      PortfolioAsset(
        assetId: entry.key,
        network: entry.value.chain.toLowerCase(),
        symbol: entry.value.token,
        decimals: entry.value.tokenDecimals,
        balance: _token(
          _number(depositBalances[entry.key] ?? 0),
          entry.value.token,
        ),
        valueUsd: _money(depositBalances[entry.key] ?? 0),
        availableQuantity: _token(
          _number(depositBalances[entry.key] ?? 0),
          entry.value.token,
        ),
        availabilityStatus: 'complete',
        withdrawable: true,
        walletId: reviewWalletId(entry.value.chain),
        contractAddress: entry.value.tokenContract,
        freshness: 'fresh',
      ),
  ];

  // Local identities exist only inside the simulated ledger and never reach
  // live transaction execution or a wallet signer.
  final _stockContracts = <String, String>{};
  List<PortfolioAsset> get stockAssets => [
    for (final position in positions.values)
      if (position.kind == MarketProductKind.bstock)
        PortfolioAsset(
          assetId: position.positionId,
          productId: position.productId,
          walletId: 'review-bstocks-wallet',
          network: 'bsc',
          symbol: position.symbol,
          decimals: 8,
          contractAddress: _stockContracts.putIfAbsent(
            position.symbol,
            () =>
                '0x${(_stockContracts.length + 1).toRadixString(16).padLeft(40, '0')}',
          ),
          withdrawable: true,
          balance: position.quantity,
          valueUsd: position.valueUsd,
          holdingReturnAmountUsd: position.unrealizedPnl,
          holdingReturnPercent: position.unrealizedPnlPercent,
          availableQuantity: _token(
            _number(availableQuantity(position)),
            position.symbol,
          ),
          availabilityStatus: 'complete',
          bstocksAvailabilityStatus: 'complete',
          bstocksAvailableQuantity: _token(
            _number(availableQuantity(position)),
            position.symbol,
          ),
          freshness: 'fresh',
        ),
  ];

  List<PortfolioAsset> get withdrawableAssets => [
    ...cashAssets,
    ...stockAssets,
  ];

  void withdrawAsset(PortfolioAsset asset, double amount) {
    final available = asset.withdrawalAvailableBalance;
    if (!amount.isFinite ||
        amount <= 0 ||
        available == null ||
        amount > _value(available)) {
      throw StateError('Insufficient simulated available balance');
    }
    final position = positions[asset.assetId];
    if (position == null) {
      spendCashAsset(asset.assetId, amount);
      return;
    }
    final remainder = _value(position.quantity) - amount;
    if (remainder < 0.00000001) {
      positions.remove(position.positionId);
    } else {
      final ratio = remainder / _value(position.quantity);
      positions[position.positionId] = _copyPosition(
        position,
        quantity: remainder,
        value: _value(position.valueUsd) * ratio,
        pnl: _value(position.unrealizedPnl) * ratio,
      );
    }
  }

  String reviewWalletId(String chain) => switch (chain.toLowerCase()) {
    'arbitrum' => 'review-wallet',
    'bsc' => 'review-bstocks-wallet',
    final network => 'review-wallet-$network',
  };

  void spendCashAsset(String assetId, double amount) {
    if (assetId == 'review-usdc') {
      spend(amount);
      return;
    }
    final available = depositBalances[assetId];
    if (available == null ||
        !amount.isFinite ||
        amount < 0 ||
        amount > available) {
      throw StateError('Insufficient simulated available balance');
    }
    depositBalances[assetId] = available - amount;
  }

  PortfolioPerpsAllocationBreakdown get perpsBreakdown {
    final perps = positions.values
        .where((p) => p.kind == MarketProductKind.perp)
        .toList();
    final cross = perps
        .where((p) => p.marginMode != PositionMarginMode.isolated)
        .toList();
    final crossUsed = cross.fold(0.0, (sum, p) => sum + _value(p.margin));
    final isolatedUsed = perps
        .where((p) => p.marginMode == PositionMarginMode.isolated)
        .fold(0.0, (sum, p) => sum + _value(p.margin));
    final openOrderMargin = reserved(MarketProductKind.perp);
    // Simulated USDC principal is cash plus committed position collateral.
    // Unrealized PnL affects equity, but is not another USDC token balance.
    // Match the allocation contract: subtract isolated and opening-order
    // collateral, while retaining used cross margin inside the pool.
    final pool = (perpsCash + margin - isolatedUsed - openOrderMargin).clamp(
      0.0,
      double.infinity,
    );
    PortfolioAllocationAmount amount(double value) => PortfolioAllocationAmount(
      valueUsd: _money(value),
      percent: DecimalValue(
        _number(total == 0 ? 0 : value / total * 100),
        unit: 'percent',
      ),
    );
    double? closestDistance;
    var completeRisk = true;
    for (final position in cross) {
      final mark = _value(position.markPrice);
      final liquidation = _value(position.liquidationPrice);
      if (mark <= 0 || liquidation <= 0 || position.side == PositionSide.none) {
        completeRisk = false;
        continue;
      }
      final distance =
          (position.side == PositionSide.short
              ? liquidation - mark
              : mark - liquidation) /
          mark *
          100;
      if (closestDistance == null || distance < closestDistance) {
        closestDistance = distance;
      }
    }
    return PortfolioPerpsAllocationBreakdown(
      crossMargin: amount(crossUsed),
      crossMarginPool: amount(pool),
      crossMarginPoolQuantity: _token(_number(pool), 'USDC'),
      isolatedMargin: amount(isolatedUsed),
      openOrderMargin: amount(openOrderMargin),
      estimatedWithdrawable: amount(availablePerps),
      crossLiquidationRisk: PortfolioCrossLiquidationRisk(
        level: !completeRisk
            ? PortfolioLiquidationRiskLevel.unavailable
            : closestDistance == null || closestDistance >= 10
            ? PortfolioLiquidationRiskLevel.safe
            : closestDistance >= 5
            ? PortfolioLiquidationRiskLevel.liquidationRisk
            : PortfolioLiquidationRiskLevel.highLiquidationRisk,
        closestDistancePercent: completeRisk && closestDistance != null
            ? DecimalValue(_number(closestDistance), unit: 'percent')
            : null,
        crossPositionCount: cross.length,
      ),
    );
  }

  double reserved(MarketProductKind kind) => orders.values
      .where(
        (o) =>
            !o.isTerminal &&
            o.kind == kind &&
            o.conditional == null &&
            o.positionId == null &&
            (kind == MarketProductKind.perp || o.side == TradingSide.buy),
      )
      .fold(
        0,
        (sum, o) =>
            sum +
            (kind == MarketProductKind.perp
                ? (orderMargins[o.orderId] ??
                      _value(o.orderValue) /
                          (openingLeverages[o.productId] ?? 3))
                : _value(o.orderValue)),
      );
  double get availableCash =>
      (cash - reserved(MarketProductKind.bstock)).clamp(0, double.infinity);
  double get availablePerps =>
      (perpsCash - reserved(MarketProductKind.perp)).clamp(0, double.infinity);
  Position position(String id) =>
      positions[id] ?? (throw StateError('Position is no longer open'));
  double availableQuantity(Position p) =>
      (_value(p.quantity) -
              orders.values
                  .where(
                    (o) =>
                        !o.isTerminal &&
                        o.kind == p.kind &&
                        o.symbol == p.symbol &&
                        o.side == TradingSide.sell,
                  )
                  .fold(
                    0.0,
                    (sum, o) =>
                        sum + _value(o.quantity) - _value(o.filledQuantity),
                  ))
          .clamp(0, double.infinity);
  List<TradingAccount> get accounts => [
    for (final network in cashAssets.map((a) => a.network).toSet())
      TradingAccount(
        kind: TradingAccountKind.app,
        label: 'Review Portfolio',
        address: _reviewAddress,
        chain: network,
        walletId: reviewWalletId(network),
        totalValueUsd: _money(
          cashAssets
              .where((a) => a.network == network)
              .fold(0.0, (sum, a) => sum + _value(a.valueUsd)),
        ),
        availableUsd: _money(
          cashAssets
              .where((a) => a.network == network)
              .fold(0.0, (sum, a) => sum + _value(a.availableQuantity)),
        ),
        marginUsedUsd: _money(0),
        balances: [
          for (final asset in cashAssets.where((a) => a.network == network))
            TokenBalance(
              symbol: asset.symbol,
              balance: asset.balance,
              valueUsd: asset.valueUsd,
              decimals: asset.decimals,
              chain: network,
            ),
        ],
      ),
    TradingAccount(
      kind: TradingAccountKind.bstocks,
      label: 'bStocks',
      address: _reviewAddress,
      walletId: 'review-bstocks-wallet',
      chain: 'BSC',
      totalValueUsd: _money(stocksValue),
      availableUsd: _money(0),
      balances: [
        for (final asset in stockAssets)
          TokenBalance(
            symbol: asset.symbol,
            balance: asset.balance,
            valueUsd: asset.valueUsd,
            decimals: asset.decimals,
            chain: asset.network,
          ),
      ],
    ),
    TradingAccount(
      kind: TradingAccountKind.hip3,
      label: 'HIP3 Perps',
      address: _reviewAddress,
      chain: 'Hyperliquid',
      totalValueUsd: _money(perpsEquity),
      availableUsd: _money(availablePerps),
      marginUsedUsd: _money(margin),
      balances: [
        TokenBalance(
          symbol: 'USDC',
          balance: _token(_number(perpsCash), 'USDC'),
          valueUsd: _money(perpsCash),
          decimals: 6,
          chain: 'Hyperliquid',
        ),
      ],
    ),
  ];
  void record(
    String id,
    String type,
    double amount, {
    ActivityCategory category = ActivityCategory.cash,
    String? symbol,
  }) {
    activities.add(
      ActivityRecord(
        id: id,
        category: category,
        type: type,
        status: ActivityState.success,
        title: type,
        amount: _money(amount),
        context: 'App Review simulation',
        symbol: symbol,
        createdAt: _now,
      ),
    );
  }

  void spend(double amount, {bool perps = false}) {
    if (!amount.isFinite || amount < 0) {
      throw const FormatException('Invalid amount');
    }
    if (amount > (perps ? availablePerps : availableCash) + 0.00000001) {
      throw StateError('Insufficient simulated available balance');
    }
    if (perps) {
      perpsCash -= amount;
    } else {
      cash -= amount;
    }
  }

  Deposit simulateDeposit(
    String amount,
    String key, {
    DepositInstruction? instruction,
  }) => once('deposit:$key', () {
    requirePositiveDecimal(amount);
    final chain = instruction?.chain.toLowerCase() ?? 'arbitrum';
    final token = instruction?.token.toUpperCase() ?? 'USDC';
    if (!{'arbitrum', 'bsc', 'base', 'ethereum'}.contains(chain) ||
        !{'USDC', 'USDT'}.contains(token)) {
      throw StateError('Unsupported simulated deposit route');
    }
    if (chain == 'arbitrum' && token == 'USDC') {
      cash += double.parse(amount);
    } else {
      final assetId = 'review-$chain-${token.toLowerCase()}';
      depositRoutes[assetId] = instruction!;
      depositBalances[assetId] =
          (depositBalances[assetId] ?? 0) + double.parse(amount);
    }
    final deposit = Deposit(
      depositId: id('deposit'),
      chain: chain,
      token: token,
      amount: _token(amount, token),
      status: DepositState.credited,
      instructions: DepositInstructions(
        address: instruction?.address ?? _reviewAddress,
      ),
      confirmations: 1,
      confirmationsRequired: 1,
      createdAt: _now,
    );
    deposits[deposit.depositId] = deposit;
    activities.add(
      ActivityRecord(
        id: deposit.depositId,
        category: ActivityCategory.cash,
        type: 'deposit',
        status: ActivityState.success,
        title: '$token deposit',
        createdAt: _now,
        amount: deposit.amount,
        chain: chain,
        asset: token,
        context: 'App Review simulation',
        reference: ActivityReference(type: 'deposit', id: deposit.depositId),
      ),
    );
    return deposit;
  });
  Future<void> refreshMarkets(MarketsRepository? markets) async {
    if (markets == null || !active) return;
    if (marksRequest != null) return marksRequest;
    if (marksUpdatedAt != null &&
        _now.difference(marksUpdatedAt!) < const Duration(seconds: 15)) {
      return;
    }
    final request = Future.wait(
      positions.values.toList().map((p) async {
        try {
          final product = await markets.getProduct(
            MarketProductRef(symbol: p.symbol, kind: p.kind),
          );
          if (!active) return;
          products['${p.kind.name}:${p.symbol}'] = product;
          String? canonicalId = product.productId;
          if (canonicalId == null && p.kind == MarketProductKind.bstock) {
            try {
              canonicalId = (await markets.getSnapshot(
                MarketProductRef(symbol: product.symbol, kind: p.kind),
              )).productId;
            } on Object {
              /* Retain the known identity when the book is unavailable. */
            }
          }
          if (canonicalId != null) {
            productIds['${p.kind.name}:${p.symbol}'] = canonicalId;
          }

          final current = positions[p.positionId];
          if (current == null ||
              (product.productId != null &&
                  current.productId != product.productId)) {
            return;
          }
          final price = _value(product.price);
          if (price <= 0) return;
          // Seed entry levels follow the first live mark so old demonstration
          // prices do not create already-liquidated positions on first login.
          final firstMark = seedMarksPending.remove(p.positionId);
          final entry = firstMark && _value(current.markPrice) > 0
              ? _value(current.entryPrice) * price / _value(current.markPrice)
              : _value(current.entryPrice);
          double? initialMargin;
          if (firstMark && current.kind == MarketProductKind.perp) {
            initialMargin =
                _value(current.quantity) * price / _value(current.leverage);
            perpsCash += _value(current.margin) - initialMargin;
          }
          final pnl =
              _value(current.quantity) *
              (price - entry) *
              (current.side == PositionSide.short ? -1 : 1);
          if (canonicalId != null &&
              current.kind == MarketProductKind.bstock &&
              canonicalId != current.productId) {
            for (final order
                in orders.values
                    .where(
                      (o) =>
                          o.kind == current.kind &&
                          o.productId == current.productId,
                    )
                    .toList()) {
              orders[order.orderId] = _copyOrder(
                order,
                status: order.status,
                productId: canonicalId,
              );
            }
          }
          final ratio = _value(current.markPrice) == 0
              ? 1.0
              : price / _value(current.markPrice);
          final protections = firstMark
              ? current.protectionOrders
                    .map(
                      (o) => Hip3PositionProtectionOrder(
                        orderId: o.orderId,
                        protection: Hip3ProtectionParameters(
                          role: o.protection.role,
                          triggerPrice: _money(
                            _value(o.protection.triggerPrice) * ratio,
                          ),
                          limitPrice: o.protection.limitPrice == null
                              ? null
                              : _money(_value(o.protection.limitPrice) * ratio),
                          quantity: o.protection.quantity,
                          percent: o.protection.percent,
                          triggerReference: o.protection.triggerReference,
                        ),
                      ),
                    )
                    .toList()
              : current.protectionOrders;
          if (firstMark) {
            for (final protection in protections) {
              final order = orders[protection.orderId];
              if (order == null || order.isTerminal) continue;
              final terms = protection.protection;
              orders[order.orderId] = _copyOrder(
                order,
                status: order.status,
                conditional: ConditionalOrder(
                  role: terms.role,
                  triggerPrice: terms.triggerPrice,
                  executionType: terms.executionType,
                  sizeMode: terms.sizeMode,
                  quantity: (order.quantity ?? current.quantity).value,
                  triggerReference: terms.triggerReference,
                  triggerStatus: 'untriggered',
                  activationStatus: 'active',
                  parentOrderId: current.positionId,
                ),
              );
            }
          }
          positions[p.positionId] = _copyPosition(
            current,
            productId: canonicalId,
            mark: price,
            entry: entry,
            margin: initialMargin,
            protections: protections,
            liquidation: firstMark && current.liquidationPrice != null
                ? _value(current.liquidationPrice) * ratio
                : null,
            pnl: pnl,
            value: current.kind == MarketProductKind.perp
                ? (initialMargin ?? _value(current.margin)) + pnl
                : _value(current.quantity) * price,
          );
        } on Object {
          // Keep the last observed valuation if market refresh is unavailable.
          // Explicit trade quotes still surface the concrete read failure.
        }
      }),
    );
    marksRequest = request;
    try {
      await request;
      marksUpdatedAt = _now;
    } finally {
      marksRequest = null;
    }
  }

  TradingOrder createOrder(OrderIntent intent, OrderPreview quote) {
    final product = products['${intent.kind.name}:${intent.symbol}'];
    final productId =
        quote.hip3Execution?.productId ??
        product?.productId ??
        productIds['${intent.kind.name}:${intent.symbol}'] ??
        positions.values
            .where((p) => p.symbol == intent.symbol && p.kind == intent.kind)
            .firstOrNull
            ?.productId ??
        // bStocks metadata and its optional order book may both omit an ID.
        // This identity belongs only to the session-local simulated ledger;
        // it is never sent to a live execution endpoint.
        (intent.kind == MarketProductKind.bstock
            ? productIds.putIfAbsent(
                '${intent.kind.name}:${intent.symbol}',
                () => 'review:bstock:${intent.symbol.toUpperCase()}',
              )
            : null);
    if (productId == null) {
      throw StateError('Market product identity unavailable. Please refresh.');
    }
    final price = _value(
      intent.limitPrice ?? quote.estimatedPrice ?? quote.marketPrice,
    );
    final quantity = _value(
      intent.quantity ??
          quote.estimatedQuantity ??
          (intent.amount == null
              ? null
              : _token(_number(_value(intent.amount) / price), intent.symbol)),
    );
    if (price <= 0 || quantity <= 0 || !quantity.isFinite) {
      throw const FormatException('Order quantity and price must be positive');
    }
    final current = positions.values
        .where((p) => p.productId == productId)
        .firstOrNull;
    final closing =
        current != null &&
        (intent.side == TradingSide.sell ||
            (intent.kind == MarketProductKind.perp &&
                (intent.side == TradingSide.long) !=
                    (current.side == PositionSide.long)));
    if (intent.reduceOnly &&
        (!closing || quantity > _value(current.quantity))) {
      throw StateError('Reduce-only order exceeds the open position');
    }
    if (intent.side == TradingSide.sell &&
        (current == null ||
            quantity > availableQuantity(current) + 0.00000001)) {
      throw StateError('Insufficient simulated available shares');
    }
    final leverage = _value(
      intent.leverage ?? DecimalValue('${openingLeverages[productId] ?? 3}'),
    );
    if (leverage < 1 || leverage > 50) {
      throw const FormatException('Leverage must be between 1 and 50');
    }
    final fee = intent.type == TradingOrderType.limit ? 0.0 : _value(quote.fee);
    final notional = quantity * price;
    if (!closing) {
      final required = intent.kind == MarketProductKind.perp
          ? notional / leverage
          : notional;
      if (required + fee >
          (intent.kind == MarketProductKind.perp
              ? availablePerps
              : availableCash)) {
        throw StateError('Insufficient simulated available balance');
      }
    }
    if (intent.type == TradingOrderType.market && closing) {
      final closeSize = quantity.clamp(0.0, _value(current.quantity));
      final close = closePosition(
        current,
        closeSize,
        executionPrice: price,
        fee: fee * closeSize / quantity,
      );
      if (quantity <= closeSize) return close;
      // Opposite orders close the old side before opening the remaining size.
      return createOrder(
        OrderIntent(
          symbol: intent.symbol,
          kind: intent.kind,
          side: intent.side,
          type: intent.type,
          quantity: _token(_number(quantity - closeSize), intent.symbol),
          leverage: intent.leverage,
          marginMode: intent.marginMode,
        ),
        OrderPreview(
          previewId: quote.previewId,
          intent: quote.intent,
          orderValue: quote.orderValue,
          estimatedPrice: quote.estimatedPrice,
          marketPrice: quote.marketPrice,
          hip3Execution: quote.hip3Execution,
          fee: _money(fee * (quantity - closeSize) / quantity),
        ),
      );
    }
    final filled = intent.type == TradingOrderType.market;
    final order = TradingOrder(
      orderId: id('order'),
      productId: productId,
      positionId: closing ? current.positionId : null,
      symbol: intent.symbol,
      kind: intent.kind,
      side: intent.side,
      type: intent.type,
      status: filled ? TradingOrderStatus.filled : TradingOrderStatus.open,
      quantity: _token(_number(quantity), intent.symbol),
      filledQuantity: _token(filled ? _number(quantity) : '0', intent.symbol),
      limitPrice: intent.limitPrice,
      averageFillPrice: filled ? _money(price) : null,
      orderValue: _money(notional),
      fee: _money(fee),
      createdAt: _now,
      updatedAt: _now,
    );
    if (filled) {
      final perps = intent.kind == MarketProductKind.perp;
      final cost = perps ? notional / leverage : notional;
      spend(cost + fee, perps: perps);
      final totalQuantity = quantity + _value(current?.quantity);
      final entry =
          (quantity * price +
              _value(current?.quantity) * _value(current?.entryPrice)) /
          totalQuantity;
      final pnl =
          totalQuantity *
          (price - entry) *
          (intent.side == TradingSide.short ? -1 : 1);
      final newMargin = perps ? cost + _value(current?.margin) : 0.0;
      final position = Position(
        positionId: current?.positionId ?? id('position'),
        productId: productId,
        positionVersion: id('version'),
        symbol: intent.symbol,
        kind: intent.kind,
        side: intent.side == TradingSide.short
            ? PositionSide.short
            : PositionSide.long,
        quantity: _token(_number(totalQuantity), intent.symbol),
        valueUsd: _money(perps ? newMargin + pnl : totalQuantity * price),
        entryPrice: _money(entry),
        markPrice: _money(price),
        unrealizedPnl: _money(pnl),
        leverage: perps ? DecimalValue(_number(leverage)) : null,
        margin: perps ? _money(newMargin) : null,
        unrealizedPnlPercent: DecimalValue(
          _number(
            (perps ? newMargin : totalQuantity * entry) == 0
                ? 0
                : pnl / (perps ? newMargin : totalQuantity * entry) * 100,
          ),
          unit: 'percent',
        ),
        liquidationPrice: perps
            ? quote.liquidationPrice ??
                  quote.hip3Execution?.liquidationPrice ??
                  _money(
                    price *
                        (intent.side == TradingSide.short
                            ? 1 + 1 / leverage
                            : 1 - 1 / leverage),
                  )
            : null,
        marginMode: intent.marginMode == TradingMarginMode.isolated
            ? PositionMarginMode.isolated
            : PositionMarginMode.cross,
        protectionOrders: current?.protectionOrders ?? const [],
        updatedAt: _now,
      );
      positions[position.positionId] = position;
      seedMarksPending.remove(position.positionId);
      realizedPnl -= fee;
      final protection = intent.openingProtection;
      final legacy = intent.tpSl;
      final changes = <Hip3ProtectionChange>[
        if (protection?.takeProfit != null)
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: 'takeProfit',
              triggerPrice: protection!.takeProfit!.triggerPrice,
              limitPrice: protection.takeProfit!.limitPrice,
            ),
          ),
        if (protection?.stopLoss != null)
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: 'stopLoss',
              triggerPrice: protection!.stopLoss!.triggerPrice,
              limitPrice: protection.stopLoss!.limitPrice,
            ),
          ),
        if (legacy?.takeProfit != null)
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: 'takeProfit',
              triggerPrice: legacy!.takeProfit!,
            ),
          ),
        if (legacy?.stopLoss != null)
          Hip3ProtectionChange.create(
            Hip3ProtectionParameters(
              role: 'stopLoss',
              triggerPrice: legacy!.stopLoss!,
              limitPrice: legacy.stopLimit,
            ),
          ),
      ];
      if (changes.isNotEmpty) changeProtection(position.positionId, changes);
    }
    if (!filled && intent.kind == MarketProductKind.perp && !closing) {
      orderMargins[order.orderId] = notional / leverage;
    }
    orders[order.orderId] = order;
    return order;
  }

  TradingOrder closePosition(
    Position p,
    double quantity, {
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    double? executionPrice,
    double? fee,
  }) {
    final current = position(p.positionId);
    requireWithinPosition(_number(quantity), current.quantity.value);
    final available = current.kind == MarketProductKind.bstock
        ? availableQuantity(current)
        : (_value(current.quantity) -
              orders.values
                  .where(
                    (o) =>
                        !o.isTerminal &&
                        o.positionId == current.positionId &&
                        o.conditional == null,
                  )
                  .fold(
                    0.0,
                    (sum, o) =>
                        sum + _value(o.quantity) - _value(o.filledQuantity),
                  ));
    if (quantity > available + 0.00000001) {
      throw StateError('Position quantity is reserved by another open order');
    }
    final price =
        executionPrice ??
        (limitPrice == null
            ? _value(current.markPrice ?? current.entryPrice)
            : double.parse(limitPrice));
    if (price <= 0) throw const FormatException('Price must be positive');
    final filled = type == TradingOrderType.market;
    final chargedFee = filled ? (fee ?? quantity * price * 0.00045) : 0.0;
    final order = TradingOrder(
      orderId: id('close'),
      productId: p.productId,
      positionId: p.positionId,
      symbol: p.symbol,
      kind: p.kind,
      side: p.kind == MarketProductKind.bstock
          ? TradingSide.sell
          : p.side == PositionSide.long
          ? TradingSide.short
          : TradingSide.long,
      type: type,
      status: filled ? TradingOrderStatus.filled : TradingOrderStatus.open,
      quantity: _token(_number(quantity), p.symbol),
      filledQuantity: _token(filled ? _number(quantity) : '0', p.symbol),
      averageFillPrice: filled ? _money(price) : null,
      limitPrice: limitPrice == null ? null : _money(price),
      orderValue: _money(quantity * price),
      fee: _money(chargedFee),
      createdAt: _now,
      updatedAt: _now,
    );
    if (filled) {
      final ratio = quantity / _value(current.quantity);
      final gross =
          quantity *
          (price - _value(current.entryPrice)) *
          (current.side == PositionSide.short ? -1 : 1);
      if (p.kind == MarketProductKind.perp) {
        perpsCash += _value(current.margin) * ratio + gross - chargedFee;
      } else {
        cash += quantity * price - chargedFee;
      }
      realizedPnl += gross - chargedFee;
      final remainder = _value(current.quantity) - quantity;
      if (remainder < 0.00000001) {
        for (final protection in current.protectionOrders) {
          cancelOrder(protection.orderId);
        }
        positions.remove(p.positionId);
      } else {
        positions[p.positionId] = _copyPosition(
          current,
          quantity: remainder,
          margin: _value(current.margin) * (1 - ratio),
          value: _value(current.valueUsd) * (1 - ratio),
          pnl: _value(current.unrealizedPnl) * (1 - ratio),
        );
      }
    }
    orders[order.orderId] = order;
    return order;
  }

  TradingOrder cancelOrder(String orderId) {
    final current =
        orders[orderId] ?? (throw StateError('Simulated order not found'));
    if (current.isTerminal) return current;
    final result = _copyOrder(current, status: TradingOrderStatus.cancelled);
    orders[orderId] = result;
    final position = positions[current.positionId];
    if (position != null && current.conditional != null) {
      positions[position.positionId] = _copyPosition(
        position,
        protections: position.protectionOrders
            .where((p) => p.orderId != orderId)
            .toList(),
      );
    }
    return result;
  }

  Position changeLeverage(
    String positionId,
    String value,
    PositionMarginMode? mode,
  ) {
    final p = position(positionId);
    final leverage = double.parse(value);
    if (leverage < 1 || leverage > 50 || !leverage.isFinite) {
      throw const FormatException('Leverage must be between 1 and 50');
    }
    final newMargin = _value(p.quantity) * _value(p.markPrice) / leverage;
    final difference = newMargin - _value(p.margin);
    if (difference > 0) {
      spend(difference, perps: true);
    } else {
      perpsCash -= difference;
    }
    final result = _copyPosition(
      p,
      leverage: leverage,
      margin: newMargin,
      value: newMargin + _value(p.unrealizedPnl),
      mode: mode,
    );
    positions[positionId] = result;
    record(
      id('activity'),
      'leverage',
      newMargin,
      category: ActivityCategory.orders,
      symbol: p.symbol,
    );
    return result;
  }

  Hip3ActionSummary changeProtection(
    String positionId,
    List<Hip3ProtectionChange> changes,
  ) {
    final p = position(positionId);
    final protections = p.protectionOrders.toList();
    // Validate the entire batch before applying any mutations.
    final changedIds = <String>{};
    for (final change in changes) {
      if (change.orderId != null && !changedIds.add(change.orderId!)) {
        throw StateError(
          'A protection order can only be changed once per request',
        );
      }
      if (change.operation != ProtectionChangeOperation.create &&
          !protections.any((o) => o.orderId == change.orderId)) {
        throw StateError('Protection order no longer exists');
      }
      final protection = change.protection;
      if (protection != null) {
        if (!{'takeProfit', 'stopLoss'}.contains(protection.role)) {
          throw const FormatException('Invalid protection role');
        }
        requirePositiveDecimal(protection.triggerPrice.value);
        if (protection.limitPrice != null) {
          requirePositiveDecimal(protection.limitPrice!.value);
        }
        if (protection.quantity != null) {
          requireWithinPosition(protection.quantity!.value, p.quantity.value);
        }
        if (protection.percent != null) {
          final percent = _value(protection.percent);
          if (percent <= 0 || percent > 100) {
            throw const FormatException(
              'Protection percentage must be between 0 and 100',
            );
          }
        }
      }
    }
    final results = <Hip3ProtectionOrderResult>[];
    for (var i = 0; i < changes.length; i++) {
      final change = changes[i];
      final previous = protections
          .where((o) => o.orderId == change.orderId)
          .firstOrNull;
      final protection = change.protection ?? previous!.protection;
      if (previous != null) {
        cancelOrder(previous.orderId);
        protections.remove(previous);
      }
      final orderId = change.operation == ProtectionChangeOperation.cancel
          ? previous!.orderId
          : id('protection');
      if (change.operation != ProtectionChangeOperation.cancel) {
        protections.add(
          Hip3PositionProtectionOrder(orderId: orderId, protection: protection),
        );
        final quantity =
            protection.quantity ??
            (protection.percent == null
                ? p.quantity
                : _token(
                    percentageQuantity(
                      p.quantity.value,
                      protection.percent!.value,
                    ),
                    p.symbol,
                  ));
        orders[orderId] = TradingOrder(
          orderId: orderId,
          positionId: p.positionId,
          productId: p.productId,
          symbol: p.symbol,
          kind: p.kind,
          side: p.side == PositionSide.long
              ? TradingSide.short
              : TradingSide.long,
          type: protection.limitPrice == null
              ? TradingOrderType.market
              : TradingOrderType.limit,
          status: TradingOrderStatus.open,
          quantity: quantity,
          filledQuantity: _token('0', p.symbol),
          limitPrice: protection.limitPrice,
          conditional: ConditionalOrder(
            role: protection.role,
            triggerPrice: protection.triggerPrice,
            executionType: protection.executionType,
            sizeMode: protection.sizeMode,
            quantity: quantity.value,
            triggerReference: protection.triggerReference,
            triggerStatus: 'untriggered',
            activationStatus: 'active',
            parentOrderId: p.positionId,
          ),
          createdAt: _now,
          updatedAt: _now,
        );
      }
      results.add(
        Hip3ProtectionOrderResult(
          stepId: id('step'),
          changeIndex: i,
          orderId: orderId,
          replacedOrderId: previous?.orderId,
          protection: protection,
          status: 'confirmed',
          isCancellation: change.operation == ProtectionChangeOperation.cancel,
        ),
      );
    }
    final action = Hip3ActionSummary(
      actionId: id('action'),
      productId: p.productId!,
      positionId: positionId,
      operation: 'manageTpsl',
      status: 'succeeded',
      effectsApplied: true,
      canResumePositionAction: false,
      protectionOrders: results,
    );
    actions[action.actionId] = action;
    positions[positionId] = _copyPosition(
      p,
      protections: protections,
      actionId: action.actionId,
    );
    record(
      action.actionId,
      'manageTpsl',
      0,
      category: ActivityCategory.orders,
      symbol: p.symbol,
    );
    return action;
  }
}

TradingOrder _copyOrder(
  TradingOrder p, {
  required TradingOrderStatus status,
  String? productId,
  ConditionalOrder? conditional,
}) => TradingOrder(
  orderId: p.orderId,
  productId: productId ?? p.productId,
  positionId: p.positionId,
  clientOrderId: p.clientOrderId,
  conditional: conditional ?? p.conditional,
  symbol: p.symbol,
  kind: p.kind,
  side: p.side,
  type: p.type,
  status: status,
  quantity: p.quantity,
  filledQuantity: p.filledQuantity,
  limitPrice: p.limitPrice,
  averageFillPrice: p.averageFillPrice,
  orderValue: p.orderValue,
  fee: p.fee,
  createdAt: p.createdAt,
  updatedAt: _now,
);
Position _copyPosition(
  Position p, {
  double? quantity,
  double? value,
  double? margin,
  double? pnl,
  double? leverage,
  double? mark,
  double? entry,
  double? liquidation,
  PositionMarginMode? mode,
  List<Hip3PositionProtectionOrder>? protections,
  String? actionId,
  String? productId,
}) {
  final orders = protections ?? p.protectionOrders;
  DecimalValue? trigger(String role) => orders
      .where((o) => o.protection.role == role)
      .firstOrNull
      ?.protection
      .triggerPrice;
  final returnBasis = p.kind == MarketProductKind.perp
      ? (margin ?? _value(p.margin))
      : (quantity ?? _value(p.quantity)) * (entry ?? _value(p.entryPrice));
  return Position(
    positionId: p.positionId,
    productId: productId ?? p.productId,
    positionVersion: '${p.positionVersion ?? 'review'}-updated',
    hip3ActionId: actionId ?? p.hip3ActionId,
    symbol: p.symbol,
    kind: p.kind,
    side: p.side,
    quantity: quantity == null
        ? p.quantity
        : _token(_number(quantity), p.symbol),
    valueUsd: value == null ? p.valueUsd : _money(value),
    entryPrice: entry == null ? p.entryPrice : _money(entry),
    markPrice: mark == null ? p.markPrice : _money(mark),
    unrealizedPnl: pnl == null ? p.unrealizedPnl : _money(pnl),
    unrealizedPnlPercent: DecimalValue(
      _number(
        returnBasis == 0
            ? 0
            : (pnl ?? _value(p.unrealizedPnl)) / returnBasis * 100,
      ),
      unit: 'percent',
    ),
    fundingPaid: p.fundingPaid,
    realizedPnl: p.realizedPnl,
    leverage: leverage == null
        ? p.leverage
        : DecimalValue(_number(leverage), unit: 'multiple'),
    margin: margin == null ? p.margin : _money(margin),
    marginMode: mode ?? p.marginMode,
    liquidationPrice: liquidation == null
        ? p.liquidationPrice
        : _money(liquidation),
    protectionOrders: orders,
    protectionOrderIds: orders.map((o) => o.orderId).toList(),
    takeProfitPrice: trigger('takeProfit'),
    stopLossPrice: trigger('stopLoss'),
    stopLimitPrice: orders
        .where((o) => o.protection.role == 'stopLoss')
        .firstOrNull
        ?.protection
        .limitPrice,
    updatedAt: _now,
  );
}
