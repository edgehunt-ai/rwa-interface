import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:one_of/one_of.dart';

import '../../domain/models/decimal_value.dart';
import '../../domain/models/deposit.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/funding_catalog.dart';
import '../../domain/models/funding_transfer.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/models/unsupported_capability.dart';
import '../../domain/models/withdrawal.dart';
import '../../domain/repositories/funding_repository.dart';
import '../services/funding_service.dart';

// The current domain port still exposes the deprecated create-deposit adapter.
// ignore_for_file: deprecated_member_use

final class FundingRepositoryImpl implements FundingRepository {
  FundingRepositoryImpl(this._service);
  final FundingService _service;

  @override
  Future<FundingCatalog> getCatalog() async {
    final value = await _service.getCatalog();
    return FundingCatalog(
      rails: value.rails.map((wire) {
        final rail = wire.oneOf.value;
        if (rail is api.BstockFundingRail) {
          return FundingRail(
            kind: FundingRailKind.bstock,
            network: rail.network.name,
            settlementAsset: rail.settlementAsset.name,
            minimumAmount: _money(rail.minimumAmount),
          );
        }
        final perp = rail as api.PerpFundingRail;
        return FundingRail(
          kind: FundingRailKind.perp,
          network: perp.network.name,
          settlementAsset: perp.settlementAsset.name,
          minimumAmount: _money(perp.minimumAmount),
        );
      }).toList(),
      depositRoutes: value.depositRails
          .map((wire) => wire.oneOf.value)
          .whereType<api.DepositRailBase>()
          .where(
            (rail) =>
                rail.availability.oneOf.value
                    is api.AvailableDepositRailAvailability,
          )
          .map(
            (rail) => DepositRoute(
              chain: rail.chain,
              token: rail.token,
              minimumAmount: _money(rail.minimumAmount)!,
              confirmationsRequired: rail.confirmationsRequired,
            ),
          )
          .toList(),
      updatedAt: value.updatedAt.toUtc(),
    );
  }

  @override
  Future<DepositInstruction> getDepositInstruction({
    required String chain,
    required String token,
  }) async {
    final wire = await _service.getDepositInstruction(
      chain: chain,
      token: token,
    );
    final value = wire.oneOf.value;
    if (value is! api.DepositAddressBase) {
      throw StateError('Unsupported deposit instruction response');
    }
    return DepositInstruction(
      chain: value.chain,
      token: value.token,
      tokenContract: value.tokenContract,
      tokenDecimals: value.tokenDecimals,
      address: value.address,
      memo: value.memo,
      qrPayload: value.qrPayload,
      minimumAmount: _money(value.minDeposit)!,
      confirmationsRequired: value.confirmationsRequired,
      estimatedArrivalSeconds: value.estimatedArrivalSeconds,
      warning: value.warning,
    );
  }

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    String? sourceAssetId,
    required String idempotencyKey,
  }) async => _fundingPlan(
    await _service.createPlan(
      api.FundingPlanRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [api.AutoSingleSourceFundingPlanRequest],
          value: api.AutoSingleSourceFundingPlanRequest(
            (plan) => plan
              ..tradePreviewId = tradePreviewId
              ..mode = api
                  .AutoSingleSourceFundingPlanRequestModeEnum
                  .autoSingleSource
              ..sourceAssetId = sourceAssetId == null
                  ? null
                  : api.FundingSourceAssetId.valueOf(sourceAssetId),
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
    required String authorizationId,
    required String idempotencyKey,
  }) async => _transfer(
    await _service.createTransfer(
      api.TransferRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [
            api.LegacyFundingTransferRequest,
            api.MultiSourceFundingTransferRequest,
          ],
          value: api.LegacyFundingTransferRequest(
            (b) => b
              ..planId = planId
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
  Future<ResourceResult<Deposit>> createDeposit({
    required String chain,
    String? amount,
    required String idempotencyKey,
  }) async => _legacyDepositResult(
    await _service.createDeposit(
      api.CreateDepositIntentRequest(
        (request) => request
          ..chain = _depositChain(chain)
          ..token = api.CreateDepositIntentRequestTokenEnum.USDC
          ..amount = amount,
      ),
      idempotencyKey: idempotencyKey,
    ),
  );
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

  ResourceResult<Deposit> _depositResult(api.Deposit wire) {
    final value = wire.oneOf.value;
    if (value is! api.DepositBase) {
      throw StateError('Unsupported confirmed deposit response');
    }
    return _result(
      Deposit(
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

  ResourceResult<Deposit> _legacyDepositResult(api.LegacyDeposit wire) =>
      _result(
        Deposit(
          depositId: wire.depositId,
          chain: wire.chain.name,
          token: wire.token.name,
          amount: _money(wire.amount),
          status: _legacyDepositStatus(wire.status),
          instructions: DepositInstructions(
            address: wire.instructions.address,
            memo: wire.instructions.memo,
          ),
          confirmations: wire.confirmations,
          confirmationsRequired: wire.confirmationsRequired,
          requiresTransfer: wire.requiresTransfer ?? false,
          txHash: wire.txHash,
          createdAt: wire.createdAt?.toUtc(),
        ),
      );

  ResourceResult<Deposit> _result(Deposit deposit) {
    return ResourceResult(
      resource: deposit,
      capability: deposit.requiresTransfer
          ? UnsupportedCapability.fundingTransfer(resourceId: deposit.depositId)
          : null,
    );
  }

  Withdrawal _withdrawal(api.Withdrawal wire) => Withdrawal(
    withdrawalId: wire.withdrawalId,
    chain: wire.chain.name,
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
    if (value is! api.BstockFundingPlan && value is! api.PerpFundingPlan) {
      throw StateError('Unsupported funding plan response');
    }
    // Both current discriminated plan variants expose this same contract.
    final plan = value as dynamic;
    final source = plan.source_ as api.FundingSourceBalanceSnapshot?;
    final sourceAsset = source?.asset.oneOf.value as dynamic;
    return FundingPlan(
      planId: plan.planId as String,
      tradePreviewId: plan.tradePreviewId as String,
      shortfall: _money(plan.shortfall as String)!,
      status: switch ((plan.status as api.FundingPlanStatus).name) {
        'ready' => FundingPlanState.ready,
        'alreadyFunded' => FundingPlanState.alreadyFunded,
        'blocked' => FundingPlanState.blocked,
        'expired' => FundingPlanState.expired,
        'consumed' => FundingPlanState.consumed,
        'cancelled' => FundingPlanState.cancelled,
        _ => FundingPlanState.unknown,
      },
      sourceWalletId: source?.walletId,
      sourceAsset: sourceAsset?.token.name as String?,
      sourceMaximum: source == null ? null : _money(source.availableAmount),
      blocker: (plan.blocker as api.FundingPlanBlocker?)?.name,
    );
  }

  FundingTransfer _transfer(api.Transfer wire) {
    final value = wire.oneOf.value;
    if (value is! api.CrossChainFundingTransfer) {
      throw StateError('Unsupported legacy transfer response');
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
  DepositState _confirmedDepositStatus(api.DepositStatus value) =>
      switch (value) {
        api.DepositStatus.confirmed => DepositState.credited,
        _ => DepositState.unknown,
      };
  DepositState _legacyDepositStatus(api.LegacyDepositStatus value) =>
      switch (value) {
        api.LegacyDepositStatus.awaiting => DepositState.awaiting,
        api.LegacyDepositStatus.confirming => DepositState.confirming,
        api.LegacyDepositStatus.credited => DepositState.credited,
        api.LegacyDepositStatus.failed => DepositState.failed,
        api.LegacyDepositStatus.ambiguous => DepositState.ambiguous,
        api.LegacyDepositStatus.manualReview => DepositState.manualReview,
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

api.CreateDepositIntentRequestChainEnum _depositChain(String value) =>
    value.toLowerCase() == 'bsc'
    ? api.CreateDepositIntentRequestChainEnum.BSC
    : api.CreateDepositIntentRequestChainEnum.arbitrum;
