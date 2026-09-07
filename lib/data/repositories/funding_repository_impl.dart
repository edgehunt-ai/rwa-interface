import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/deposit.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/funding_catalog.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/models/unsupported_capability.dart';
import '../../domain/models/withdrawal.dart';
import '../../domain/repositories/funding_repository.dart';
import '../services/funding_service.dart';

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
      updatedAt: value.updatedAt.toUtc(),
    );
  }

  @override
  Future<ResourceResult<Deposit>> createDeposit({
    required String chain,
    String? amount,
    required String idempotencyKey,
  }) async => _depositResult(
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
    final deposit = Deposit(
      depositId: wire.depositId, chain: wire.chain.name, token: wire.token.name,
      amount: _money(wire.amount), status: _depositStatus(wire.status),
      instructions: DepositInstructions(address: wire.instructions.address, memo: wire.instructions.memo),
      confirmations: wire.confirmations, confirmationsRequired: wire.confirmationsRequired,
      requiresTransfer: wire.requiresTransfer ?? false, txHash: wire.txHash,
      createdAt: wire.createdAt?.toUtc(),
    );
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
  DepositState _depositStatus(api.DepositStatus value) => switch (value) {
    api.DepositStatus.awaiting => DepositState.awaiting,
    api.DepositStatus.confirming => DepositState.confirming,
    api.DepositStatus.credited => DepositState.credited,
    api.DepositStatus.failed => DepositState.failed,
    api.DepositStatus.ambiguous => DepositState.ambiguous,
    api.DepositStatus.manualReview => DepositState.manualReview,
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
      value.toLowerCase() == 'bsc' ? api.CreateDepositIntentRequestChainEnum.BSC : api.CreateDepositIntentRequestChainEnum.arbitrum;
