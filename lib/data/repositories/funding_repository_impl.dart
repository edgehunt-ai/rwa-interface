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
import '../../domain/models/self_custodial_withdrawal.dart';
import '../../domain/models/funding_catalog_summary.dart';
import '../../domain/repositories/funding_repository.dart';
import '../services/funding_service.dart';
import '../mappers/chain_name_mapper.dart';
import '../mappers/order_preview_request_mapper.dart';

final class FundingRepositoryImpl implements FundingRepository {
  FundingRepositoryImpl(this._service);
  final FundingService _service;

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
            final identity = item.identity;
            return DepositInstruction(
              chain: identity.network,
              token: identity.token,
              tokenContract: identity.tokenContract,
              tokenDecimals: identity.tokenDecimals,
              address: address,
              qrPayload: item.qrPayload!,
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
    );
  }

  @override
  Future<FundingSessionSummary> getFundingSession(String id) async {
    final value = await _service.getFundingSession(id);
    return FundingSessionSummary(
      sessionId: value.fundingSessionId,
      status: value.status.name,
      version: value.version,
      canConfirmTransfer: value.canConfirmTransfer,
      expiresAt: value.expiresAt.toUtc(),
    );
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
    return FundingSessionSummary(
      sessionId: value.fundingSessionId,
      status: value.status.name,
      version: value.version,
      canConfirmTransfer: value.canConfirmTransfer,
      expiresAt: value.expiresAt.toUtc(),
    );
  }

  @override
  Future<FundingCatalogSummary> getFundingCatalog() async {
    final value = await _service.getFundingCatalog();
    return FundingCatalogSummary(
      catalogVersion: value.catalogVersion,
      depositRailCount: value.depositRails.length,
      updatedAt: value.updatedAt.toUtc(),
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
  );

  FundingPlan _fundingPlan(api.FundingPlan wire) {
    final value = wire.oneOf.value;
    if (value
        case api.MultiSourceBstockFundingPlan() ||
            api.MultiSourcePerpFundingPlan()) {
      final plan = value as dynamic;
      final legs = (plan.multiSource as api.MultiSourceFundingPlanDetails).legs
          .map((leg) {
            final source = leg.sourcePositionSnapshot;
            return FundingLeg(
              legId: leg.legId,
              walletId: source.walletId,
              asset: source.asset.token,
              maximumAmount: _money(leg.route.maximumInputAmount)!,
              outputAmount: _money(leg.outputAmount)!,
              status: switch (leg.status.name) {
                'planned' => FundingLegState.planned,
                'actionReleased' => FundingLegState.actionReleased,
                'submitted' => FundingLegState.submitted,
                'completed' => FundingLegState.completed,
                'failed' => FundingLegState.failed,
                'ambiguous' => FundingLegState.ambiguous,
                'manualReview' => FundingLegState.manualReview,
                _ => FundingLegState.unknown,
              },
              transferId: leg.transferId,
            );
          })
          .toList(growable: false);
      return FundingPlan(
        planId: plan.planId as String,
        tradePreviewId: plan.tradePreviewId as String,
        shortfall: _money(plan.shortfall as String)!,
        status: switch (plan.status.name as String) {
          'ready' => FundingPlanState.ready,
          'funded' => FundingPlanState.alreadyFunded,
          'blocked' => FundingPlanState.blocked,
          'expired' => FundingPlanState.expired,
          'cancelled' => FundingPlanState.cancelled,
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
      amount: _money(value.amount)!,
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
      failureReason: value.failureReason,
    );
  }

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
    _ => throw ArgumentError('Unsupported self-custodial chain id'),
  };

  String _selfCustodialChainName(api.SelfCustodialWithdrawalChainId value) =>
      switch (value) {
        api.SelfCustodialWithdrawalChainId.n1 => 'Ethereum',
        api.SelfCustodialWithdrawalChainId.n42161 => 'Arbitrum',
        api.SelfCustodialWithdrawalChainId.n8453 => 'Base',
        api.SelfCustodialWithdrawalChainId.n56 => 'BSC',
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
