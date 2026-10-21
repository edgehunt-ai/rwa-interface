part of 'repositories.dart';

final class AppReviewFundingRepository implements FundingRepository {
  AppReviewFundingRepository(
    this.store, {
    this.readDelegate,
    this.quoteDelegate,
  });
  final AppReviewStore store;
  final FundingRepository? readDelegate;
  final OrdersRepository? quoteDelegate;

  // Keep actual deposit routes and addresses available for inspection. No
  // financial command is delegated, even when these reads use the live API.
  @override
  Future<DepositDirectory> getDepositDirectory() async => readDelegate != null
      ? readDelegate!.getDepositDirectory()
      : DepositDirectory(
          walletAddress: _reviewAddress,
          instructions: [
            DepositInstruction(
              chain: 'Arbitrum',
              token: 'USDC',
              tokenContract: _reviewUsdc,
              tokenDecimals: 6,
              address: _reviewAddress,
              qrPayload: _reviewAddress,
              minimumAmount: _token('1', 'USDC'),
              confirmationsRequired: 1,
              estimatedArrivalSeconds: 5,
              warning: 'App Review simulation. Do not send real assets.',
            ),
          ],
          updatedAt: _now,
        );

  List<FundingSourcePosition> get _sources => [
    FundingSourcePosition(
      positionId: 'review-usdc',
      token: 'USDC',
      network: 'arbitrum',
      availableAmount: _token(_number(store.availableCash), 'USDC'),
      eligible: store.availableCash > 0,
    ),
    for (final asset in store.cashAssets.where(
      (a) => a.assetId != 'review-usdc',
    ))
      FundingSourcePosition(
        positionId: asset.assetId,
        token: asset.symbol,
        network: asset.network,
        availableAmount: asset.availableQuantity!,
        eligible: false,
      ),
  ];
  @override
  Future<UnifiedFundingAccountSummary> getUnifiedFundingAccount() async =>
      UnifiedFundingAccountSummary(
        totalUsd: _money(store.spotCash),
        availableToFundUsd: _money(store.availableCash),
        reservedUsd: _money(store.cash - store.availableCash),
        inTransitUsd: _money(0),
        dataStatus: 'complete',
        calculatedAt: _now,
        positions: _sources,
      );
  @override
  Future<FundingCatalogSummary> getFundingCatalog() async {
    final real = await readDelegate?.getFundingCatalog();
    return FundingCatalogSummary(
      catalogVersion: real?.catalogVersion ?? 'review',
      depositRailCount: real?.depositRailCount ?? 1,
      updatedAt: real?.updatedAt ?? _now,
      transferTarget:
          real?.transferTarget ??
          const FundingTransferTarget(token: 'USDC', network: 'hyperliquid'),
    );
  }

  FundingSessionSummary _session(
    String id,
    String amount, {
    int version = 1,
    Map<String, String> allocations = const {},
    String status = 'readyToConfirm',
  }) => FundingSessionSummary(
    sessionId: id,
    status: status,
    version: version,
    canConfirmTransfer:
        status != 'funded' &&
        allocations.isNotEmpty &&
        double.parse(amount) <= store.availableCash,
    expiresAt: _now.add(const Duration(hours: 24)),
    requiredTargetBalance: amount,
    targetAvailableAmount: _number(store.availablePerps),
    remainingMinimumTopUp: amount,
    selectedTargetAmount: amount,
    estimatedReceived: amount,
    minimumReceived: amount,
    targetToken: 'USDC',
    targetNetwork: 'hyperliquid',
    allocations: allocations,
    positions: _sources,
    etaSeconds: 0,
    slippageBps: 0,
    fees: const FundingSessionFees(
      asset: 'USDC',
      providerFee: '0',
      bridgeFee: '0',
      swapFee: '0',
      networkFee: '0',
      totalFee: '0',
      totalCostUsd: '0',
    ),
  );
  Future<void> _ensureOrderQuote(OrderIntent intent) async {
    final hasValidQuote = store.previews.values.any(
      (quote) =>
          quote.intent.fingerprint == intent.fingerprint && !quote.isExpired,
    );
    if (!hasValidQuote && quoteDelegate != null) {
      final quote = await quoteDelegate!.preview(
        intent,
        idempotencyKey: store.id('funding-quote'),
      );
      store.requireActive();
      store.previews[quote.previewId] = quote;
    }
  }

  FundingSessionSummary _orderSession(String id, OrderIntent intent) {
    final quote = store.previews.values
        .where(
          (p) => p.intent.fingerprint == intent.fingerprint && !p.isExpired,
        )
        .lastOrNull;
    if (quote == null) {
      throw StateError('Trade quote not found. Please refresh.');
    }
    final perps = intent.kind == MarketProductKind.perp;
    final required =
        _value(quote.marginRequired ?? quote.orderValue) + _value(quote.fee);
    final available = perps ? store.availablePerps : store.availableCash;
    final shortfall = (required - available).clamp(0.0, double.infinity);
    final amount = _number(shortfall);
    return store.sessions[id] = _session(
      id,
      amount,
      status: shortfall == 0 ? 'funded' : 'readyToConfirm',
      allocations: perps && shortfall > 0 && shortfall <= store.availableCash
          ? {'review-usdc': amount}
          : const {},
    );
  }

  @override
  Future<FundingSessionSummary> getFundingSession(String id) async {
    final intent = store.fundingOrders[id];
    if (intent != null) {
      await _ensureOrderQuote(intent);
      return _orderSession(id, intent);
    }
    return store.sessions[id] ??
        (throw StateError('Funding session not found'));
  }

  @override
  Future<FundingSessionSummary> createFundingSession({
    required OrderIntent intent,
    required String idempotencyKey,
  }) async {
    await _ensureOrderQuote(intent);
    final session = store.once('funding-session:$idempotencyKey', () {
      final id = store.id('session');
      store.fundingOrders[id] = intent;
      return _orderSession(id, intent);
    }, notify: false);
    return getFundingSession(session.sessionId);
  }

  @override
  Future<FundingSessionSummary> createTransferFundingSession({
    required String destination,
    required String amount,
    required String idempotencyKey,
  }) async => store.once('transfer-session:$idempotencyKey', () {
    requirePositiveDecimal(amount);
    if (destination != 'hip3_margin') {
      throw StateError('Unsupported simulated transfer destination');
    }
    final id = store.id('session');
    store.destinations[id] = destination;
    return store.sessions[id] = _session(id, amount);
  }, notify: false);
  @override
  Future<FundingSessionSummary> updateFundingSessionSelection({
    required String fundingSessionId,
    required int version,
    required Map<String, String> allocations,
    String? amount,
    required String idempotencyKey,
  }) async => store.once('selection:$idempotencyKey', () {
    final current =
        store.sessions[fundingSessionId] ??
        (throw StateError('Funding session not found'));
    if (current.version != version) {
      throw StateError('Funding selection changed. Please refresh.');
    }
    for (final entry in allocations.entries) {
      final source = _sources
          .where((s) => s.positionId == entry.key)
          .firstOrNull;
      if (source == null || !source.canAllocate(entry.value)) {
        throw StateError('Insufficient simulated source balance');
      }
    }
    final total = allocations.values.fold(
      0.0,
      (sum, value) => sum + double.parse(value),
    );
    final selected = amount ?? current.selectedTargetAmount ?? _number(total);
    requirePositiveDecimal(selected);
    if ((total - double.parse(selected)).abs() > 0.000001) {
      throw StateError('Transfer sources must match the selected amount');
    }
    return store.sessions[fundingSessionId] = _session(
      fundingSessionId,
      selected,
      version: version + 1,
      allocations: Map.unmodifiable(allocations),
    );
  }, notify: false);
  FundingPlan _plan(String reference, String amount) {
    requirePositiveDecimal(amount);
    if (double.parse(amount) > store.availableCash) {
      throw StateError('Insufficient simulated available balance');
    }
    final id = store.id('funding-plan');
    final value = _token(amount, 'USDC');
    return store.fundingPlans[id] = FundingPlan(
      planId: id,
      tradePreviewId: reference,
      shortfall: value,
      status: FundingPlanState.ready,
      sourceWalletId: 'review-wallet',
      sourceAsset: 'USDC',
      sourceMaximum: value,
      legs: [
        FundingLeg(
          legId: '$id-leg-1',
          walletId: 'review-wallet',
          asset: 'USDC',
          maximumAmount: value,
          outputAmount: value,
          status: FundingLegState.actionReleased,
        ),
      ],
    );
  }

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async => store.once('plan:$idempotencyKey', () {
    final preview =
        store.previews[tradePreviewId] ??
        (throw StateError('Trade preview not found. Please refresh.'));
    final required =
        _value(preview.marginRequired ?? preview.orderValue) +
        _value(preview.fee);
    final available = preview.intent.kind == MarketProductKind.perp
        ? store.availablePerps
        : store.availableCash;
    final shortfall = (required - available).clamp(0.0, double.infinity);
    if (shortfall == 0) {
      final id = store.id('funding-plan');
      return store.fundingPlans[id] = FundingPlan(
        planId: id,
        tradePreviewId: tradePreviewId,
        shortfall: _token('0', 'USDC'),
        status: FundingPlanState.alreadyFunded,
      );
    }
    return _plan(tradePreviewId, _number(shortfall));
  }, notify: false);
  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async => store.once('session-plan:$idempotencyKey', () {
    final session =
        store.sessions[fundingSessionId] ??
        (throw StateError('Funding session not found'));
    if (session.version != selectionVersion || !session.canConfirmTransfer) {
      throw StateError('Funding selection changed. Please refresh.');
    }
    return _plan(fundingSessionId, session.selectedTargetAmount!);
  }, notify: false);
  @override
  Future<FundingPlan> getFundingPlan(String id) async =>
      store.fundingPlans[id] ?? (throw StateError('Funding plan not found'));
  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  }) async => store.once('transfer:$idempotencyKey', () {
    final plan =
        store.fundingPlans[planId] ??
        (throw StateError('Funding plan not found'));
    final leg =
        plan.legs.where((l) => l.legId == legId).firstOrNull ??
        (throw StateError('Funding leg not found'));
    if (leg.transferId != null) return store.fundingTransfers[leg.transferId]!;
    store.spend(_value(leg.maximumAmount));
    store.perpsCash += _value(leg.outputAmount);
    final transfer = FundingTransfer(
      transferId: store.id('funding-transfer'),
      planId: planId,
      amount: leg.maximumAmount,
      status: FundingTransferState.completed,
    );
    store.fundingTransfers[transfer.transferId] = transfer;
    store.fundingPlans[planId] = FundingPlan(
      planId: planId,
      tradePreviewId: plan.tradePreviewId,
      shortfall: plan.shortfall,
      status: FundingPlanState.alreadyFunded,
      sourceWalletId: plan.sourceWalletId,
      sourceAsset: plan.sourceAsset,
      sourceMaximum: plan.sourceMaximum,
      legs: [
        for (final l in plan.legs)
          FundingLeg(
            legId: l.legId,
            walletId: l.walletId,
            asset: l.asset,
            maximumAmount: l.maximumAmount,
            outputAmount: l.outputAmount,
            status: l.legId == legId ? FundingLegState.completed : l.status,
            transferId: l.legId == legId ? transfer.transferId : l.transferId,
          ),
      ],
    );
    final session = store.sessions[plan.tradePreviewId];
    if (session != null) {
      store.sessions[session.sessionId] = _session(
        session.sessionId,
        session.selectedTargetAmount!,
        version: session.version,
        allocations: session.allocations,
        status: 'funded',
      );
    }
    store.record(
      transfer.transferId,
      'transfer',
      _value(transfer.amount),
      category: ActivityCategory.funding,
    );
    return transfer;
  });
  @override
  Future<FundingTransfer> getFundingTransfer(String id) async =>
      store.fundingTransfers[id] ?? (throw StateError('Transfer not found'));
  @override
  Future<ResourceResult<Deposit>> getDeposit(String id) async => ResourceResult(
    resource: store.deposits[id] ?? (throw StateError('Deposit not found')),
  );
  @override
  Future<DomainPage<ResourceResult<Deposit>>> listDeposits({
    String? cursor,
  }) async => DomainPage(
    items: store.deposits.values
        .map((d) => ResourceResult(resource: d))
        .toList(),
  );
  @override
  Future<DomainPage<DepositObservation>> listDepositObservations({
    String? cursor,
  }) async => const DomainPage(items: []);
  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) async {
    requirePositiveDecimal(intent.amount.value);
    // Real fee observations remain useful; sufficiency belongs to our ledger.
    final quote = await readDelegate?.quoteWithdrawal(
      intent,
      idempotencyKey: idempotencyKey,
    );
    final fee = quote?.totalFee ?? _token('0', intent.amount.asset ?? 'USDC');
    final result = WithdrawalQuote(
      quoteId: quote?.quoteId ?? store.id('withdrawal-quote'),
      intent: intent,
      totalFee: fee,
      estimatedReceive: quote?.estimatedReceive ?? intent.amount,
      sufficient: _value(intent.amount) + _value(fee) <= store.availableCash,
    );
    store.withdrawalQuotes[result.quoteId] = result;
    return result;
  }

  @override
  Future<Withdrawal> createWithdrawal(
    WithdrawalIntent intent, {
    required String quoteId,
    required String authorizationId,
    required String idempotencyKey,
  }) async => store.once('withdrawal:$idempotencyKey', () {
    requirePositiveDecimal(intent.amount.value);
    final quote =
        store.withdrawalQuotes[quoteId] ??
        (throw StateError('Withdrawal quote not found. Please refresh.'));
    if (quote.intent.fingerprint != intent.fingerprint) {
      throw StateError('Withdrawal quote does not match the request');
    }
    store.spend(_value(intent.amount) + _value(quote.totalFee));
    final result = Withdrawal(
      withdrawalId: store.id('withdrawal'),
      chain: intent.chain,
      amount: intent.amount,
      receivedAmount: quote.estimatedReceive,
      totalFee: quote.totalFee,
      address: intent.address,
      status: WithdrawalState.completed,
      createdAt: _now,
    );
    store.withdrawals[result.withdrawalId] = result;
    store.record(result.withdrawalId, 'withdrawal', _value(intent.amount));
    return result;
  });
  @override
  Future<Withdrawal> getWithdrawal(String id) async =>
      store.withdrawals[id] ?? (throw StateError('Withdrawal not found'));
  @override
  Future<DomainPage<Withdrawal>> listWithdrawals({String? cursor}) async =>
      DomainPage(items: store.withdrawals.values.toList().reversed.toList());
  @override
  Future<SelfCustodialWithdrawalSummary> getSelfCustodialWithdrawal(
    String id,
  ) async =>
      store.selfWithdrawals[id] ?? (throw StateError('Withdrawal not found'));
  @override
  Future<PreparedSelfCustodialWithdrawal> createSelfCustodialWithdrawal({
    required String walletId,
    required String assetId,
    required String chain,
    required String amount,
    required String destinationAddress,
    required String idempotencyKey,
  }) async => store.once('self-withdrawal:$idempotencyKey', () {
    requirePositiveDecimal(amount);
    final asset = store.withdrawableAssets
        .where(
          (a) =>
              a.walletId == walletId &&
              a.canonicalEvmId?.toLowerCase() == assetId.toLowerCase() &&
              a.normalizedNetwork == normalizeChainLabel(chain),
        )
        .firstOrNull;
    if (asset == null) {
      throw StateError('Unsupported simulated withdrawal asset');
    }
    if (double.parse(amount) > _value(asset.availableQuantity)) {
      throw StateError('Insufficient simulated available balance');
    }
    final id = store.id('self-withdrawal');
    final prepared = PreparedSelfCustodialWithdrawal(
      withdrawalId: id,
      sourceWalletId: walletId,
      assetId: assetId,
      assetSymbol: asset.symbol,
      chain: chain,
      amount: _token(amount, asset.symbol),
      destinationAddress: destinationAddress,
      status: SelfCustodialWithdrawalState.awaitingSubmission,
      transaction: SelfCustodialWithdrawalTransaction(
        chainId: int.parse(assetId.split(':')[1].split('/')[0]),
        from: _reviewAddress,
        to: asset.contractAddress!,
        data: '0x00',
        value: '0x0',
        payloadHash: 'review-only-$id',
        validUntil: _now.add(const Duration(minutes: 5)),
      ),
    );
    store.preparedWithdrawals[id] = prepared;
    store.selfWithdrawals[id] = SelfCustodialWithdrawalSummary(
      withdrawalId: id,
      assetSymbol: asset.symbol,
      amount: prepared.amount,
      destinationAddress: destinationAddress,
      status: SelfCustodialWithdrawalState.awaitingSubmission,
    );
    return prepared;
  }, notify: false);
  @override
  Future<SelfCustodialWithdrawalSummary> submitSelfCustodialWithdrawal({
    required String id,
    required String txHash,
    required String idempotencyKey,
  }) async => store.once('self-submit:$id', () {
    final prepared =
        store.preparedWithdrawals[id] ??
        (throw StateError('Withdrawal not found'));
    final asset = store.withdrawableAssets.singleWhere(
      (a) =>
          a.walletId == prepared.sourceWalletId &&
          a.canonicalEvmId == prepared.assetId,
    );
    store.withdrawAsset(asset, _value(prepared.amount));
    final result = SelfCustodialWithdrawalSummary(
      withdrawalId: id,
      assetSymbol: prepared.assetSymbol,
      amount: prepared.amount,
      destinationAddress: prepared.destinationAddress,
      status: SelfCustodialWithdrawalState.confirmed,
      confirmations: 1,
      requiredConfirmations: 1,
    );
    store.selfWithdrawals[id] = result;
    store.withdrawals[id] = Withdrawal(
      withdrawalId: id,
      chain: prepared.chain,
      amount: prepared.amount,
      receivedAmount: prepared.amount,
      address: prepared.destinationAddress,
      status: WithdrawalState.completed,
      createdAt: _now,
    );
    store.record(id, 'withdrawal', _value(prepared.amount));
    return result;
  });
}

final class AppReviewHip3WithdrawalRepository
    implements Hip3WithdrawalRepository {
  AppReviewHip3WithdrawalRepository(this.store, {this.readDelegate});
  final Hip3WithdrawalRepository? readDelegate;
  final AppReviewStore store;
  @override
  Future<Hip3WithdrawalPreview> preview({
    required String amount,
    required int payoutChainId,
  }) async {
    requirePositiveDecimal(amount);
    final real = await readDelegate?.preview(
      amount: amount,
      payoutChainId: payoutChainId,
    );
    final result = Hip3WithdrawalPreview(
      amount: amount,
      fee: real?.fee ?? '0',
      minimumReceived: real?.minimumReceived ?? amount,
      rail: real?.rail ?? 'bridge2',
      destinationAddress: real?.destinationAddress ?? _reviewAddress,
      chainId: '$payoutChainId',
      maximumTransferable: _number(store.availablePerps),
      blockers: [
        ...?real?.blockers.where(
          (b) =>
              b != 'insufficientWithdrawableBalance' &&
              b != 'insufficient_withdrawable_balance',
        ),
        if (double.parse(amount) > store.availablePerps)
          'insufficient_withdrawable_balance',
      ],
      estimatedArrivalSeconds: real?.estimatedArrivalSeconds ?? 0,
      feeDetails: real?.feeDetails ?? const [],
      crossLiquidationImpacts: const [],
      riskStatus: 'available',
      riskValidUntil: _now.add(const Duration(minutes: 5)),
      payoutAsset: real?.payoutAsset ?? 'USDC',
    );
    store.hip3Quotes['$amount|$payoutChainId'] = result;
    return result;
  }

  @override
  Future<Hip3Withdrawal> create({
    required String amount,
    required String rail,
    required int payoutChainId,
    required String idempotencyKey,
  }) async => store.once('hip3-withdrawal:$idempotencyKey', () {
    requirePositiveDecimal(amount);
    if (double.parse(amount) > store.availablePerps) {
      throw StateError('Insufficient simulated available margin');
    }
    final quote = store.hip3Quotes['$amount|$payoutChainId'];
    if (readDelegate != null &&
        (quote == null ||
            !quote.canProceed ||
            quote.isRiskExpired ||
            quote.rail != rail)) {
      throw StateError('Withdrawal quote changed. Please refresh.');
    }
    final id = store.id('hip3-withdrawal');
    return store.hip3Withdrawals[id] = Hip3Withdrawal(
      id: id,
      ownerAddress: _reviewAddress,
      destinationAddress: quote?.destinationAddress ?? _reviewAddress,
      amount: amount,
      fee: quote?.fee ?? '0',
      minimumReceived: quote?.minimumReceived ?? amount,
      status: 'awaiting_signature',
      rail: rail,
      expiresAt: _now.add(const Duration(minutes: 5)),
      payoutChainId: payoutChainId,
      payoutAsset: payoutChainId == 421614 && rail == 'bridge2'
          ? 'USDC2'
          : 'USDC',
    );
  });
  @override
  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  }) async => store.once('hip3-submit:${prepared.id}', () {
    final p =
        store.hip3Withdrawals[prepared.id] ??
        (throw StateError('Withdrawal not found'));
    if (!p.expiresAt.isAfter(_now)) {
      throw StateError('Withdrawal quote expired. Please refresh.');
    }
    store.spend(double.parse(p.amount), perps: true);
    store.cash += double.parse(p.minimumReceived);
    store.realizedPnl -= double.parse(p.fee);
    final result = Hip3Withdrawal(
      id: p.id,
      ownerAddress: p.ownerAddress,
      destinationAddress: p.destinationAddress,
      amount: p.amount,
      fee: p.fee,
      minimumReceived: p.minimumReceived,
      status: 'completed',
      rail: p.rail,
      expiresAt: p.expiresAt,
      payoutChainId: p.payoutChainId,
      payoutAsset: p.payoutAsset,
    );
    store.hip3Withdrawals[p.id] = result;
    store.record(
      p.id,
      'transfer',
      double.parse(p.amount),
      category: ActivityCategory.funding,
    );
    return result;
  });
  @override
  Future<Hip3Withdrawal> get(String id) async =>
      store.hip3Withdrawals[id] ?? (throw StateError('Withdrawal not found'));
}

final class AppReviewHip3OpeningRepository implements Hip3OpeningRepository {
  AppReviewHip3OpeningRepository(this.store, {this.readDelegate});
  final Hip3OpeningRepository? readDelegate;
  final AppReviewStore store;
  @override
  Future<Hip3OpeningContext> context(String productOrSymbol) async {
    final cached = store.contexts[productOrSymbol];
    final real = cached != null && !cached.isExpired
        ? cached
        : await readDelegate?.context(productOrSymbol);
    final productId =
        real?.productId ??
        store.positions.values
            .where(
              (p) =>
                  p.kind == MarketProductKind.perp &&
                  (p.productId == productOrSymbol ||
                      p.symbol == productOrSymbol),
            )
            .firstOrNull
            ?.productId;
    if (productId == null) {
      throw StateError('Market product identity unavailable. Please refresh.');
    }
    final result = Hip3OpeningContext(
      contextId: 'review-$productId',
      productId: productId,
      environment: real?.environment ?? 'mainnet',
      currentLeverage: store.openingLeverages[productId] ?? 3,
      maximumLeverage: real?.maximumLeverage ?? 50,
      currentMarginMode:
          store.openingModes[productId] ?? TradingMarginMode.cross,
      marginModes: real?.marginModes ?? TradingMarginMode.values.toSet(),
      orderTypes: real?.orderTypes ?? TradingOrderType.values.toSet(),
      timeInForce: const {'Gtc', 'Ioc'},
      availableMargin: _token(_number(store.availablePerps), 'USDC'),
      minimumNotional: real?.minimumNotional ?? _token('10', 'USDC'),
      marketOrderMinimumLong: real?.marketOrderMinimumLong,
      marketOrderMinimumShort: real?.marketOrderMinimumShort,
      maximumNotional: _token(_number(store.availablePerps * 50), 'USDC'),
      sizeDecimals: real?.sizeDecimals ?? 4,
      validUntil: _now.add(const Duration(minutes: 5)),
      operations: const {'setLeverage', 'open'},
      takerFeeRate: real?.takerFeeRate ?? DecimalValue('0.00045'),
      feeReserveMultiplier: real?.feeReserveMultiplier ?? DecimalValue('1'),
    );
    store.contexts[productId] = result;
    store.contexts[productOrSymbol] = result;
    return result;
  }

  @override
  Future<Hip3OpeningContext> setLeverage(
    String productId,
    int leverage,
    TradingMarginMode mode, {
    required String idempotencyKey,
    Future<bool> Function(Hip3StepConfirmation confirmation)? confirm,
  }) async {
    store.once('opening-leverage:$idempotencyKey', () {
      if (leverage < 1 || leverage > 50) {
        throw const FormatException('Leverage must be between 1 and 50');
      }
      final position = store.positions.values
          .where((p) => p.productId == productId)
          .firstOrNull;
      if (position != null) {
        store.changeLeverage(
          position.positionId,
          '$leverage',
          mode == TradingMarginMode.cross
              ? PositionMarginMode.cross
              : PositionMarginMode.isolated,
        );
      }
      store.openingLeverages[productId] = leverage;
      store.openingModes[productId] = mode;
      return true;
    });
    return context(productId);
  }
}

final class AppReviewHip3AccountAbstractionRepository
    implements Hip3AccountAbstractionRepository {
  AppReviewHip3AccountAbstractionRepository(this.store);
  final AppReviewStore store;
  @override
  Future<Hip3AccountAbstractionStatus> getStatus() async =>
      Hip3AccountAbstractionStatus(
        ownerAddress: _reviewAddress,
        currentMode: store.unifiedAccount
            ? Hip3AccountAbstractionMode.unifiedAccount
            : Hip3AccountAbstractionMode.defaultMode,
        switchAvailable: !store.unifiedAccount,
      );
  @override
  Future<Hip3AccountAbstractionStatus> switchToUnifiedAccount({
    required String prepareIdempotencyKey,
    required String executeIdempotencyKey,
  }) async {
    store.once('unified:$executeIdempotencyKey', () {
      store.unifiedAccount = true;
      return true;
    });
    return getStatus();
  }
}

final class AppReviewBstocksOrderExecutionRepository
    implements BstocksOrderExecutionRepository {
  AppReviewBstocksOrderExecutionRepository(this.store);
  final AppReviewStore store;
  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    bool Function()? isCancelled,
  }) async => ResourceResult(
    resource: store.once(
      'cancel-order:$orderId',
      () => store.cancelOrder(orderId),
    ),
  );
  @override
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) async => created;
  @override
  Future<ResourceResult<TradingOrder>> executeExisting({
    required ResourceResult<TradingOrder> order,
    bool Function()? isCancelled,
  }) async => order;
  @override
  Future<ResourceResult<TradingOrder>> continueOrder({
    required OrderIntent intent,
    required String orderId,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) async => ResourceResult(
    resource: store.orders[orderId] ?? (throw StateError('Order not found')),
  );
}
