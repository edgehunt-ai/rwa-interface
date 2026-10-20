import 'package:rwa_api_client/rwa_api_client.dart' as api;
// Preview-bound plan creation remains available during the contract's v1
// compatibility window. New flows use FundingSessionPlanRequest.
// ignore_for_file: deprecated_member_use

import 'package:one_of/one_of.dart';

import '../../domain/models/decimal_value.dart';
import '../../domain/models/deposit.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/funding_catalog.dart';
import '../../domain/models/funding_transfer.dart';
import '../../domain/models/portfolio_asset.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/models/withdrawal.dart';
import '../../domain/models/deposit_observation.dart';
import '../../domain/models/funding_session.dart';
import '../../domain/models/order_intent.dart';
import '../../domain/models/order_preview.dart';
import '../../domain/models/self_custodial_withdrawal.dart';
import '../../domain/models/funding_catalog_summary.dart';
import '../../domain/models/wallet_action_execution.dart';
import '../../domain/repositories/funding_repository.dart';
import '../services/funding_service.dart';
import '../mappers/chain_name_mapper.dart';
import '../mappers/order_preview_request_mapper.dart';
import '../../domain/models/financial_obligation.dart';
import '../mappers/financial_obligation_mapper.dart';

final class FundingRepositoryImpl implements FundingRepository {
  FundingRepositoryImpl(this._service);
  final FundingService _service;

  @override
  Future<DomainPage<FinancialObligation>> listFinancialObligations({
    String? cursor,
    bool includeResolved = false,
  }) async {
    final page = await _service.listFinancialObligations(
      cursor: cursor,
      includeResolved: includeResolved,
    );
    return DomainPage(
      items: page.items.map(financialObligationFromApi).toList(growable: false),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<DepositDirectory> getDepositDirectory() async {
    final response = await _service.getDepositDirectory();
    final value = response.oneOf.value;
    if (value is! api.DepositInstructionsResponse) {
      throw const FormatException('Expected aggregate deposit instructions');
    }
    final address = value.wallet?.address;
    // The API intentionally returns wallet: null when there is no unique
    // active verified wallet. In that state all rails are unavailable; this
    // is a valid empty directory, not a malformed response.
    if (address == null) {
      return DepositDirectory(
        walletAddress: null,
        updatedAt: value.updatedAt.toUtc(),
        instructions: const [],
      );
    }
    return DepositDirectory(
      walletAddress: address,
      updatedAt: value.updatedAt.toUtc(),
      instructions: value.items
          .where(
            (item) =>
                item.availability.status == 'available' &&
                item.qrPayload != null,
          )
          .map((item) {
            final qrPayload = item.qrPayload!;
            if (qrPayload.toLowerCase() != address.toLowerCase()) {
              throw const FormatException(
                'Deposit QR payload does not match the wallet address',
              );
            }
            final identity = item.identity;
            return DepositInstruction(
              chain: identity.network,
              token: identity.token,
              tokenContract: identity.tokenContract,
              tokenDecimals: identity.tokenDecimals,
              address: address,
              qrPayload: qrPayload,
              minimumAmount: _money(item.minDeposit)!,
              confirmationsRequired: item.confirmationsRequired,
              estimatedArrivalSeconds: item.estimatedArrivalSeconds,
              warning: item.warning,
            );
          })
          .toList(growable: false),
    );
  }

  @override
  Future<UnifiedFundingAccountSummary> getUnifiedFundingAccount() async {
    final value = await _service.getUnifiedFundingAccount();
    return UnifiedFundingAccountSummary(
      totalUsd: DecimalValue(value.valuedTotalUsd, asset: 'USD', unit: 'fiat'),
      availableToFundUsd: DecimalValue(
        value.availableToFundValueUsd,
        asset: 'USD',
        unit: 'fiat',
      ),
      reservedUsd: DecimalValue(
        value.reservedValueUsd,
        asset: 'USD',
        unit: 'fiat',
      ),
      inTransitUsd: DecimalValue(
        value.inTransitValueUsd,
        asset: 'USD',
        unit: 'fiat',
      ),
      dataStatus: value.dataStatus.name,
      calculatedAt: value.calculatedAt.toUtc(),
      positions: value.positions.map(_sourcePosition).toList(growable: false),
    );
  }

  FundingSourcePosition _sourcePosition(api.UnifiedFundingPosition position) =>
      FundingSourcePosition(
        positionId: position.positionId,
        token: position.asset.token,
        network: position.asset.network,
        availableAmount: DecimalValue(
          position.availableAmount,
          asset: position.asset.token,
          unit: 'token',
        ),
        eligible: position.eligibility.status.name == 'eligible',
      );

  @override
  Future<FundingSessionSummary> getFundingSession(String id) async {
    final value = await _service.getFundingSession(id);
    return _session(value);
  }

  @override
  Future<FundingSessionSummary> createFundingSession({
    required OrderIntent intent,
    required String idempotencyKey,
  }) async {
    final value = await _service.createFundingSession(
      api.FundingSessionCreateRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [api.FundingSessionTradeCreateRequest],
          value: api.FundingSessionTradeCreateRequest(
            (trade) => trade.trade.replace(orderPreviewRequest(intent)),
          ),
        ),
      ),
      idempotencyKey: idempotencyKey,
    );
    return _session(value);
  }

  @override
  Future<FundingSessionSummary> createTransferFundingSession({
    required String destination,
    required String amount,
    required String idempotencyKey,
  }) async {
    if (destination != 'hip3_margin') {
      throw ArgumentError.value(destination, 'destination');
    }
    final value = await _service.createFundingSession(
      api.FundingSessionCreateRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 1,
          types: const [
            api.FundingSessionTradeCreateRequest,
            api.FundingSessionTransferCreateRequest,
          ],
          value: api.FundingSessionTransferCreateRequest(
            (session) => session.transfer.replace(
              api.FundingSessionTransferIntent(
                (transfer) => transfer
                  ..destination =
                      api.FundingSessionTransferIntentDestinationEnum.hip3Margin
                  ..amount = amount,
              ),
            ),
          ),
        ),
      ),
      idempotencyKey: idempotencyKey,
    );
    return _session(value);
  }

  @override
  Future<FundingSessionSummary> updateFundingSessionSelection({
    required String fundingSessionId,
    required int version,
    required Map<String, String> allocations,
    String? amount,
    required String idempotencyKey,
  }) async {
    final value = await _service.updateFundingSessionSelection(
      fundingSessionId,
      api.FundingSessionSelectionRequest((request) {
        request.version = version;
        // An explicit amount is a minimum net received constraint. When it is
        // omitted, the server quotes minimum net output from the allocations.
        if (amount != null) request.amount = amount;
        request.allocations.addAll(
          allocations.entries.map(
            (entry) => api.FundingSessionSourceAllocationInput(
              (allocation) => allocation
                ..sourcePositionId = entry.key
                ..inputAmount = entry.value,
            ),
          ),
        );
      }),
      idempotencyKey: idempotencyKey,
    );
    return _session(value);
  }

  FundingSessionSummary _session(api.FundingSession value) =>
      FundingSessionSummary(
        sessionId: value.fundingSessionId,
        status: value.status.name,
        version: value.version,
        canConfirmTransfer: value.canConfirmTransfer,
        expiresAt: value.expiresAt.toUtc(),
        createdAt: value.createdAt.toUtc(),
        updatedAt: value.updatedAt.toUtc(),
        estimateObservedAt: value.estimateObservedAt.toUtc(),
        requiredTargetBalance: value.requiredTargetBalance,
        targetAvailableAmount: value.targetSnapshot.availableAmount,
        remainingMinimumTopUp: value.remainingMinimumTopUp,
        selectedTargetAmount: value.selectedTargetAmount,
        estimatedReceived: value.estimatedReceived,
        minimumReceived: value.minimumReceived,
        slippageBps: value.slippageBps,
        fees: FundingSessionFees(
          asset: value.estimatedFees.feeAsset,
          providerFee: value.estimatedFees.providerFee,
          bridgeFee: value.estimatedFees.bridgeFee,
          swapFee: value.estimatedFees.swapFee,
          networkFee: value.estimatedFees.networkFee,
          totalFee: value.estimatedFees.totalFee,
          totalCostUsd: value.estimatedFees.totalCostUsd,
        ),
        etaSeconds: value.etaSeconds,
        targetToken: value.targetSnapshot.asset.token,
        targetNetwork: canonicalChainName(
          value.targetSnapshot.asset.network.name,
        ),
        allocations: {
          for (final allocation in value.allocations)
            allocation.sourcePositionId: allocation.inputAmount,
        },
        positions: value.positions.map(_sourcePosition).toList(growable: false),
        crossLiquidationImpacts: List.unmodifiable(
          value.riskPreview?.crossLiquidationImpacts.map(_fundingImpact) ??
              const <Hip3CrossLiquidationImpact>[],
        ),
      );

  Hip3CrossLiquidationImpact _fundingImpact(
    api.Hip3CrossLiquidationImpact impact,
  ) => Hip3CrossLiquidationImpact(
    productId: impact.productId,
    side: switch (impact.side) {
      api.Hip3CrossLiquidationImpactSideEnum.long => TradingSide.long,
      api.Hip3CrossLiquidationImpactSideEnum.short => TradingSide.short,
      _ => throw const FormatException(
        'Unsupported cross liquidation impact side',
      ),
    },
    markPrice: impact.markPrice == null
        ? null
        : DecimalValue(impact.markPrice!, asset: 'USDC', unit: 'price'),
    beforeLiquidationPrice: impact.beforeLiquidationPrice == null
        ? null
        : DecimalValue(
            impact.beforeLiquidationPrice!,
            asset: 'USDC',
            unit: 'price',
          ),
    afterLiquidationPrice: impact.afterLiquidationPrice == null
        ? null
        : DecimalValue(
            impact.afterLiquidationPrice!,
            asset: 'USDC',
            unit: 'price',
          ),
    unavailableReason: impact.unavailableReason?.name,
  );

  @override
  Future<FundingCatalogSummary> getFundingCatalog() async {
    final value = await _service.getFundingCatalog();
    FundingTransferTarget? transferTarget;
    for (final rail in value.rails) {
      final variant = rail.oneOf.value;
      if (variant is api.PerpFundingRail) {
        transferTarget = FundingTransferTarget(
          token: variant.settlementAsset.name,
          network: variant.network.name,
        );
        break;
      }
      if (variant is api.LegacyPerpFundingRail) {
        transferTarget = FundingTransferTarget(
          token: variant.settlementAsset.name,
          network: variant.network.name,
        );
        break;
      }
    }
    return FundingCatalogSummary(
      catalogVersion: value.catalogVersion,
      depositRailCount: value.depositRails.length,
      updatedAt: value.updatedAt.toUtc(),
      transferTarget: transferTarget,
    );
  }

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async => _fundingPlan(
    await _service.createPlan(
      api.FundingPlanRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [api.AutoMultiSourceFundingPlanRequest],
          value: api.AutoMultiSourceFundingPlanRequest(
            (plan) => plan
              ..tradePreviewId = tradePreviewId
              ..mode =
                  api.AutoMultiSourceFundingPlanRequestModeEnum.autoMultiSource,
          ),
        ),
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  }) async => _fundingPlan(
    await _service.createPlan(
      api.FundingPlanRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [api.FundingSessionPlanRequest],
          value: api.FundingSessionPlanRequest(
            (plan) => plan
              ..fundingSessionId = fundingSessionId
              ..selectionVersion = selectionVersion,
          ),
        ),
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<FundingPlan> getFundingPlan(String id) async =>
      _fundingPlan(await _service.getPlan(id));

  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  }) async => _transfer(
    await _service.createTransfer(
      api.TransferRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [api.MultiSourceFundingTransferRequest],
          value: api.MultiSourceFundingTransferRequest(
            (transfer) => transfer
              ..planId = planId
              ..legId = legId
              ..authorizationId = authorizationId,
          ),
        ),
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<FundingTransfer> getFundingTransfer(String id) async =>
      _transfer(await _service.getTransfer(id));

  @override
  Future<ResourceResult<Deposit>> getDeposit(String id) async =>
      _depositResult(await _service.getDeposit(id));
  @override
  Future<DomainPage<ResourceResult<Deposit>>> listDeposits({
    String? cursor,
  }) async {
    final page = await _service.listDeposits(cursor: cursor);
    return DomainPage(
      items: page.items.map(_depositResult).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<DomainPage<DepositObservation>> listDepositObservations({
    String? cursor,
  }) async {
    final page = await _service.listDepositObservations(cursor: cursor);
    return DomainPage(
      items: page.items
          .map(
            (value) => DepositObservation(
              observationId: value.observationId,
              chain: canonicalChainName(value.chain.name),
              asset: value.asset,
              amount: DecimalValue(
                value.amount,
                asset: value.asset,
                unit: 'token',
              ),
              status: switch (value.status) {
                api.DepositObservationStatus.detected =>
                  DepositObservationState.detected,
                api.DepositObservationStatus.confirming =>
                  DepositObservationState.confirming,
                api.DepositObservationStatus.confirmed =>
                  DepositObservationState.confirmed,
                api.DepositObservationStatus.manualReview =>
                  DepositObservationState.manualReview,
                _ => DepositObservationState.unknown,
              },
              confirmations: value.confirmations,
              confirmationsRequired: value.confirmationsRequired,
              txHash: value.txHash,
              detectedAt: value.detectedAt.toUtc(),
              updatedAt: value.updatedAt.toUtc(),
              confirmedAt: value.confirmedAt?.toUtc(),
              depositId: value.depositId,
            ),
          )
          .toList(growable: false),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) async {
    final value = await _service.quote(
      api.WithdrawalQuoteRequest(
        (request) => request
          ..asset = api.WithdrawalQuoteRequestAssetEnum.USDC
          ..chain = _chain(intent.chain)
          ..amount = intent.amount.value
          ..address = intent.address,
      ),
      idempotencyKey: idempotencyKey,
    );
    return WithdrawalQuote(
      quoteId: value.quoteId,
      intent: intent,
      totalFee: _money(value.totalFee)!,
      estimatedReceive: _money(value.estimatedReceive)!,
      sufficient: value.sufficient,
    );
  }

  @override
  Future<Withdrawal> createWithdrawal(
    WithdrawalIntent intent, {
    required String quoteId,
    required String authorizationId,
    required String idempotencyKey,
  }) async => _withdrawal(
    await _service.createWithdrawal(
      api.CreateWithdrawalRequest(
        (request) => request
          ..asset = api.CreateWithdrawalRequestAssetEnum.USDC
          ..chain = _chain(intent.chain)
          ..amount = intent.amount.value
          ..address = intent.address
          ..memo = intent.memo
          ..authorizationId = authorizationId
          ..quoteId = quoteId,
      ),
      idempotencyKey: idempotencyKey,
    ),
  );
  @override
  Future<Withdrawal> getWithdrawal(String id) async =>
      _withdrawal(await _service.getWithdrawal(id));
  @override
  Future<DomainPage<Withdrawal>> listWithdrawals({String? cursor}) async {
    final page = await _service.listWithdrawals(cursor: cursor);
    return DomainPage(
      items: page.items.map(_withdrawal).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<SelfCustodialWithdrawalSummary> getSelfCustodialWithdrawal(
    String id,
  ) async => _selfCustodial(await _service.getSelfCustodialWithdrawal(id));

  @override
  Future<PreparedSelfCustodialWithdrawal> createSelfCustodialWithdrawal({
    required String walletId,
    required String assetId,
    required String chain,
    required String amount,
    required String destinationAddress,
    required String idempotencyKey,
  }) async {
    final value = await _service.createSelfCustodialWithdrawal(
      api.SelfCustodialWithdrawalCreateRequest(
        (request) => request
          ..walletId = walletId
          ..assetId = assetId
          ..chain = _selfCustodialChain(chain)
          ..amount = amount
          ..destinationAddress = destinationAddress,
      ),
      idempotencyKey: idempotencyKey,
    );
    return _preparedSelfCustodial(value);
  }

  @override
  Future<SelfCustodialWithdrawalSummary> submitSelfCustodialWithdrawal({
    required String id,
    required String txHash,
    required String idempotencyKey,
  }) async => _selfCustodial(
    await _service.submitSelfCustodialWithdrawal(
      id,
      api.SelfCustodialWithdrawalSubmissionRequest(
        (request) => request..txHash = txHash,
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  SelfCustodialWithdrawalSummary _selfCustodial(
    api.SelfCustodialWithdrawal value,
  ) => SelfCustodialWithdrawalSummary(
    withdrawalId: value.withdrawalId,
    assetSymbol: value.assetSymbol,
    amount: DecimalValue(value.amount, asset: value.assetSymbol, unit: 'token'),
    destinationAddress: value.destinationAddress,
    status: switch (value.status) {
      api.SelfCustodialWithdrawalStatus.awaitingSubmission =>
        SelfCustodialWithdrawalState.awaitingSubmission,
      api.SelfCustodialWithdrawalStatus.submitted =>
        SelfCustodialWithdrawalState.submitted,
      api.SelfCustodialWithdrawalStatus.confirming =>
        SelfCustodialWithdrawalState.confirming,
      api.SelfCustodialWithdrawalStatus.confirmed =>
        SelfCustodialWithdrawalState.confirmed,
      api.SelfCustodialWithdrawalStatus.failed =>
        SelfCustodialWithdrawalState.failed,
      api.SelfCustodialWithdrawalStatus.noncanonical =>
        SelfCustodialWithdrawalState.noncanonical,
      api.SelfCustodialWithdrawalStatus.manualReview =>
        SelfCustodialWithdrawalState.manualReview,
      _ => SelfCustodialWithdrawalState.unknown,
    },
    txHash: value.txHash,
    failureReason: value.failureReason,
    confirmations: value.confirmations,
    requiredConfirmations: value.requiredConfirmations,
    sourceWalletId: value.sourceWalletId,
    assetId: value.assetId,
    walletActionExecutionId: value.walletActionExecutionId,
    userOperationHash: value.userOperationHash,
    manualReviewReason: value.manualReviewReason,
    createdAt: value.createdAt.toUtc(),
    updatedAt: value.updatedAt.toUtc(),
    submittedAt: value.submittedAt?.toUtc(),
    confirmedAt: value.confirmedAt?.toUtc(),
  );

  PreparedSelfCustodialWithdrawal _preparedSelfCustodial(
    api.SelfCustodialWithdrawal value,
  ) {
    final transaction = value.transaction;
    return PreparedSelfCustodialWithdrawal(
      withdrawalId: value.withdrawalId,
      sourceWalletId: value.sourceWalletId,
      assetId: value.assetId,
      assetSymbol: value.assetSymbol,
      chain: _selfCustodialChainName(transaction.chainId),
      amount: DecimalValue(
        value.amount,
        asset: value.assetSymbol,
        unit: 'token',
      ),
      destinationAddress: value.destinationAddress,
      transaction: SelfCustodialWithdrawalTransaction(
        chainId: _chainId(transaction.chainId),
        from: transaction.from,
        to: transaction.to,
        data: transaction.data,
        value: switch (transaction.value) {
          api.SelfCustodialWithdrawalTransactionValueEnum.n0x0 => '0x0',
          _ => transaction.value.name,
        },
        payloadHash: transaction.payloadHash,
        validUntil: transaction.validUntil.toUtc(),
      ),
      status: switch (value.status) {
        api.SelfCustodialWithdrawalStatus.awaitingSubmission =>
          SelfCustodialWithdrawalState.awaitingSubmission,
        api.SelfCustodialWithdrawalStatus.submitted =>
          SelfCustodialWithdrawalState.submitted,
        api.SelfCustodialWithdrawalStatus.confirming =>
          SelfCustodialWithdrawalState.confirming,
        api.SelfCustodialWithdrawalStatus.confirmed =>
          SelfCustodialWithdrawalState.confirmed,
        api.SelfCustodialWithdrawalStatus.failed =>
          SelfCustodialWithdrawalState.failed,
        api.SelfCustodialWithdrawalStatus.noncanonical =>
          SelfCustodialWithdrawalState.noncanonical,
        api.SelfCustodialWithdrawalStatus.manualReview =>
          SelfCustodialWithdrawalState.manualReview,
        _ => SelfCustodialWithdrawalState.unknown,
      },
      gas: _gasEstimate(value.gas),
    );
  }

  SelfCustodialWithdrawalGasEstimate? _gasEstimate(
    api.SelfCustodialWithdrawalGasEstimate? value,
  ) {
    if (value == null) return null;
    final native = value.nativeAsset;
    return SelfCustodialWithdrawalGasEstimate(
      nativeAsset: native,
      gasUnits: value.gasUnits,
      gasPriceWei: DecimalValue(value.gasPriceWei, asset: native, unit: 'wei'),
      estimatedNativeFee: DecimalValue(
        value.estimatedNativeFee,
        asset: native,
        unit: 'token',
      ),
      walletNativeBalance: DecimalValue(
        value.walletNativeBalance,
        asset: native,
        unit: 'token',
      ),
      canPayGas: value.canPayGas,
      observedAt: value.observedAt.toUtc(),
    );
  }

  ResourceResult<Deposit> _depositResult(api.Deposit wire) {
    final value = wire.oneOf.value;
    if (value is! api.DepositBase) {
      throw StateError('Unsupported confirmed deposit response');
    }
    return ResourceResult(
      resource: Deposit(
        depositId: value.depositId,
        chain: value.chain,
        token: value.token.name,
        amount: _money(value.amount),
        status: _confirmedDepositStatus(value.status),
        instructions: DepositInstructions(address: value.recipient),
        confirmations: value.confirmations,
        confirmationsRequired: value.confirmationsRequired,
        txHash: value.txHash,
        createdAt: value.detectedAt.toUtc(),
      ),
    );
  }

  Withdrawal _withdrawal(api.Withdrawal wire) => Withdrawal(
    withdrawalId: wire.withdrawalId,
    chain: canonicalChainName(wire.chain.name),
    amount: _money(wire.amount)!,
    receivedAmount: _money(wire.receivedAmount),
    totalFee: _money(wire.totalFee),
    address: wire.address,
    status: _withdrawalStatus(wire.status),
    txHash: wire.txHash,
    failureReason: wire.failureReason,
    createdAt: wire.createdAt?.toUtc(),
    completedAt: wire.completedAt?.toUtc(),
    activityId: wire.activityId,
    memo: wire.memo,
  );

  FundingPlan _fundingPlan(api.FundingPlan wire) {
    final value = wire.oneOf.value;
    if (value
        case api.MultiSourceBstockFundingPlan() ||
            api.MultiSourceBstockTestnetFundingPlan() ||
            api.MultiSourcePerpFundingPlan() ||
            api.UserSelectedMultiSourceBstockFundingPlan() ||
            api.UserSelectedMultiSourceBstockTestnetFundingPlan() ||
            api.UserSelectedMultiSourcePerpFundingPlan()) {
      final plan = value as dynamic;
      final targetAsset = (plan.targetSnapshot as dynamic).asset as dynamic;
      final rawTargetToken = (targetAsset.token as dynamic).name as String;
      final targetToken = rawTargetToken == 'USDC_PERPS'
          ? 'USDC-PERPS'
          : rawTargetToken;
      final legs = (plan.multiSource as api.MultiSourceFundingPlanDetails).legs
          .map((leg) {
            final source = leg.sourcePositionSnapshot;
            return FundingLeg(
              legId: leg.legId,
              walletId: source.walletId,
              asset: source.asset.token,
              sourcePositionId: source.positionId,
              network: source.asset.network,
              maximumAmount: DecimalValue(
                leg.route.maximumInputAmount,
                asset: source.asset.token,
                unit: 'token',
              ),
              outputAmount: DecimalValue(
                leg.outputAmount,
                asset: targetToken,
                unit: 'token',
              ),
              status: switch (leg.status.name) {
                'planned' => FundingLegState.planned,
                'actionReleased' => FundingLegState.actionReleased,
                'submitted' => FundingLegState.submitted,
                'originConfirmed' => FundingLegState.originConfirmed,
                'providerConfirmed' => FundingLegState.providerConfirmed,
                'targetConfirmed' => FundingLegState.targetConfirmed,
                'cancelledAsUnneeded' => FundingLegState.cancelledAsUnneeded,
                'completed' => FundingLegState.completed,
                'failed' => FundingLegState.failed,
                'ambiguous' => FundingLegState.ambiguous,
                'manualReview' => FundingLegState.manualReview,
                _ => FundingLegState.unknown,
              },
              etaSeconds: leg.route.etaSeconds,
              bridgeFee: DecimalValue(
                leg.route.fees.bridgeFee,
                asset: leg.route.fees.feeAsset,
                unit: 'token',
              ),
              networkFee: DecimalValue(
                leg.route.fees.networkFee,
                asset: leg.route.fees.feeAsset,
                unit: 'token',
              ),
              fees: FundingSessionFees(
                asset: leg.route.fees.feeAsset,
                providerFee: leg.route.fees.providerFee,
                bridgeFee: leg.route.fees.bridgeFee,
                swapFee: leg.route.fees.swapFee,
                networkFee: leg.route.fees.networkFee,
                totalFee: leg.route.fees.totalFee,
                totalCostUsd: leg.route.fees.totalCostUsd,
              ),
              feeAsset: leg.route.fees.feeAsset,
              transferId: leg.transferId,
              targetEnvironment: leg.route.targetEnvironment?.name,
              refundAsset: leg.route.refund.asset == null
                  ? null
                  : _transferEvidence(
                      api.standardSerializers.serializeWith(
                        api.FundingAssetIdentity.serializer,
                        leg.route.refund.asset,
                      ),
                    ),
            );
          })
          .toList(growable: false);
      return FundingPlan(
        planId: plan.planId as String,
        tradePreviewId: (plan.tradePreviewId as String?) ?? '',
        fundingSessionId: plan.fundingSessionId as String?,
        createdAt: (plan.createdAt as DateTime).toUtc(),
        expiresAt: (plan.expiresAt as DateTime?)?.toUtc(),
        shortfall: DecimalValue(
          plan.shortfall as String,
          asset: targetToken,
          unit: 'token',
        ),
        requiredTargetAmount: DecimalValue(
          plan.requiredTargetAmount as String,
          asset: targetToken,
          unit: 'token',
        ),
        targetAvailableAmount: DecimalValue(
          (plan.targetSnapshot as dynamic).availableAmount as String,
          asset: targetToken,
          unit: 'token',
        ),
        targetAsset: targetToken,
        targetEnvironment:
            ((plan.targetSnapshot as dynamic).targetEnvironment as dynamic)
                    ?.name
                as String?,
        targetNetwork: canonicalChainName(
          (targetAsset.network as dynamic).name as String,
        ),
        status: switch (plan.status.name as String) {
          'ready' => FundingPlanState.ready,
          'executing' => FundingPlanState.executing,
          'partiallyFunded' => FundingPlanState.partiallyFunded,
          'funded' => FundingPlanState.alreadyFunded,
          'blocked' => FundingPlanState.blocked,
          'failed' => FundingPlanState.failed,
          'expired' => FundingPlanState.expired,
          'cancelled' => FundingPlanState.cancelled,
          'manualReview' => FundingPlanState.manualReview,
          _ => FundingPlanState.unknown,
        },
        blocker: (plan.blocker as api.FundingPlanBlocker?)?.name,
        legs: legs,
      );
    }
    throw StateError('Unsupported funding plan response');
  }

  FundingTransfer _transfer(api.Transfer wire) {
    final value = wire.oneOf.value;
    if (value is! api.CrossChainFundingTransfer) {
      throw StateError('Unsupported transfer response');
    }
    return FundingTransfer(
      transferId: value.transferId,
      planId: value.planId,
      targetEnvironment: value.target.targetEnvironment?.name,
      amount: DecimalValue(
        value.amount,
        asset: value.target.asset.token,
        unit: 'token',
      ),
      targetReceivedAmount: value.targetReceivedAmount == null
          ? null
          : DecimalValue(
              value.targetReceivedAmount!,
              asset: value.target.asset.token,
              unit: 'token',
            ),
      status: switch (value.status.name) {
        'awaitingAuthorization' => FundingTransferState.awaitingAuthorization,
        'awaitingWallet' => FundingTransferState.awaitingWallet,
        'originSubmitted' => FundingTransferState.originSubmitted,
        'originConfirmed' => FundingTransferState.originConfirmed,
        'filling' => FundingTransferState.filling,
        'completed' => FundingTransferState.completed,
        'refundPending' => FundingTransferState.refundPending,
        'refunded' => FundingTransferState.refunded,
        'failed' => FundingTransferState.failed,
        'ambiguous' => FundingTransferState.ambiguous,
        'manualReview' => FundingTransferState.manualReview,
        _ => FundingTransferState.unknown,
      },
      nextActionId: switch (value.nextAction?.value) {
        final Map<Object?, Object?> action =>
          (action['action_id'] ?? action['actionId']) as String?,
        _ => null,
      },
      nextAction: _transferAction(value.nextAction?.value),
      failureReason: value.failureReason,
      legId: value.legId,
      activityId: value.activityId,
      sourceExecutionStatus: value.sourceExecutionStatus.name,
      providerStatus: value.providerStatus.name,
      targetCreditStatus: value.targetCreditStatus.name,
      refundStatus: value.refundStatus.name,
      recoveryStatus: value.recoveryStatus.name,
      sourceTransaction: _transferEvidence(value.sourceTransaction?.value),
      providerObservation: _transferEvidence(value.providerObservation?.value),
      targetCredit: _transferEvidence(value.targetCredit?.value),
      refund: _transferEvidence(value.refund?.value),
      ambiguousReason: value.ambiguousReason,
      manualReviewReason: value.manualReviewReason,
      createdAt: value.createdAt.toUtc(),
      updatedAt: value.updatedAt.toUtc(),
      completedAt: value.completedAt?.toUtc(),
      routeLockedAt: value.routeLockedAt?.toUtc(),
      walletActionReleasedAt: value.walletActionReleasedAt?.toUtc(),
    );
  }

  FundingTransferAction? _transferAction(Object? value) {
    if (value == null) return null;
    if (value is! Map) throw StateError('Unsupported transfer wallet action');
    if (value['status'] != 'ready') return null;
    final gas = value['gas_payment'];
    final mode = value.containsKey('gas_payment_mode')
        ? value['gas_payment_mode']
        : gas is Map
        ? gas['mode']
        : null;
    return FundingTransferAction(
      actionId: value['action_id'] as String,
      status: value['status'] as String,
      mode: switch (mode) {
        'app_sponsored' => GasPaymentMode.appSponsored,
        'user_paid_native' => GasPaymentMode.userPaidNative,
        _ => null,
      },
      chainId: value['chain_id'] as int,
      from: value['from'] as String,
      transaction: FrozenTransaction(
        to: value['to'] as String,
        data: value['data'] as String,
        value: value['value'] as String,
      ),
      validUntil: DateTime.parse(value['valid_until'] as String).toUtc(),
    );
  }

  Map<String, Object?>? _transferEvidence(Object? value) =>
      value == null ? null : Map<String, Object?>.unmodifiable(value as Map);

  DecimalValue? _money(String? value) =>
      value == null ? null : DecimalValue(value, asset: 'USDC', unit: 'token');
  api.Chain _chain(String value) => switch (value.toLowerCase()) {
    'bsc' => api.Chain.BSC,
    'arbitrum' => api.Chain.arbitrum,
    'base' => api.Chain.base_,
    'ethereum' => api.Chain.ethereum,
    'hyperliquid' => api.Chain.hyperliquid,
    'polygon' => api.Chain.polygon,
    'solana' => api.Chain.solana,
    _ => throw ArgumentError('Unsupported chain'),
  };

  // Callers pass chain labels that may come from a generated enum name, where
  // `Base` arrives as `base_`, so normalise before matching.
  api.SelfCustodialWithdrawalChain _selfCustodialChain(String value) =>
      switch (normalizeChainLabel(value)) {
        'bsc' => api.SelfCustodialWithdrawalChain.BSC,
        'arbitrum' => api.SelfCustodialWithdrawalChain.arbitrum,
        'base' => api.SelfCustodialWithdrawalChain.base_,
        'ethereum' => api.SelfCustodialWithdrawalChain.ethereum,
        _ => throw ArgumentError('Unsupported self-custodial chain'),
      };

  int _chainId(api.SelfCustodialWithdrawalChainId value) => switch (value) {
    api.SelfCustodialWithdrawalChainId.n1 => 1,
    api.SelfCustodialWithdrawalChainId.n42161 => 42161,
    api.SelfCustodialWithdrawalChainId.n8453 => 8453,
    api.SelfCustodialWithdrawalChainId.n56 => 56,
    api.SelfCustodialWithdrawalChainId.n97 => 97,
    api.SelfCustodialWithdrawalChainId.n421614 => 421614,
    _ => throw ArgumentError('Unsupported self-custodial chain id'),
  };

  String _selfCustodialChainName(api.SelfCustodialWithdrawalChainId value) =>
      switch (value) {
        api.SelfCustodialWithdrawalChainId.n1 => 'Ethereum',
        api.SelfCustodialWithdrawalChainId.n42161 => 'Arbitrum',
        api.SelfCustodialWithdrawalChainId.n8453 => 'Base',
        api.SelfCustodialWithdrawalChainId.n56 => 'BSC',
        api.SelfCustodialWithdrawalChainId.n97 => 'BSC',
        api.SelfCustodialWithdrawalChainId.n421614 => 'Arbitrum',
        _ => throw ArgumentError('Unsupported self-custodial chain id'),
      };
  DepositState _confirmedDepositStatus(api.DepositStatus value) =>
      switch (value) {
        api.DepositStatus.confirmed => DepositState.credited,
        _ => DepositState.unknown,
      };
  WithdrawalState _withdrawalStatus(api.WithdrawalStatus value) =>
      switch (value) {
        api.WithdrawalStatus.pendingSignature =>
          WithdrawalState.pendingSignature,
        api.WithdrawalStatus.processing => WithdrawalState.processing,
        api.WithdrawalStatus.sent => WithdrawalState.sent,
        api.WithdrawalStatus.completed => WithdrawalState.completed,
        api.WithdrawalStatus.failed => WithdrawalState.failed,
        api.WithdrawalStatus.ambiguous => WithdrawalState.ambiguous,
        api.WithdrawalStatus.manualReview => WithdrawalState.manualReview,
        _ => WithdrawalState.unknown,
      };
}
