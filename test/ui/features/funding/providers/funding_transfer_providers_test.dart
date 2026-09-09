import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/funding_transfer.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/funding_transfer_providers.dart';

void main() {
  test(
    'funding transfer lifecycle uses a server-selected plan and authorization',
    () async {
      final funding = _FundingRepository();
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
        ],
      );
      addTearDown(container.dispose);

      final commands = container.read(fundingTransferCommandsProvider);
      final plan = await commands.plan(tradePreviewId: 'preview-1');
      expect(plan.sourceWalletId, 'wallet-1');
      final authorization = await commands.authorize(plan);
      final transfer = await commands.create(
        plan: plan,
        authorization: authorization,
      );

      expect(funding.createdPlanFor, 'preview-1');
      expect(funding.transferAuthorizationId, authorization.authorizationId);
      expect(transfer.status, FundingTransferState.awaitingWallet);
    },
  );
}

final class _FundingRepository implements FundingRepository {
  String? createdPlanFor;
  String? transferAuthorizationId;
  final plan = FundingPlan(
    planId: 'plan-1',
    tradePreviewId: 'preview-1',
    shortfall: DecimalValue('12', asset: 'USDT', unit: 'token'),
    status: FundingPlanState.ready,
    sourceWalletId: 'wallet-1',
    sourceAsset: 'USDC',
    sourceMaximum: DecimalValue('15', asset: 'USDC', unit: 'token'),
  );

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    String? sourceAssetId,
    required String idempotencyKey,
  }) async {
    createdPlanFor = tradePreviewId;
    return plan;
  }

  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    transferAuthorizationId = authorizationId;
    return FundingTransfer(
      transferId: 'transfer-1',
      planId: 'plan-1',
      amount: DecimalValue('12', asset: 'USDT', unit: 'token'),
      status: FundingTransferState.awaitingWallet,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _WalletsRepository implements WalletsRepository {
  @override
  Future<WalletAuthorization> authorizeFundingTransfer({
    required String walletId,
    required String planId,
    required String asset,
    required String maximumAmount,
    required String idempotencyKey,
  }) async => WalletAuthorization(
    authorizationId: 'authorization-1',
    walletId: walletId,
    status: WalletAuthorizationState.authorized,
    expiresAt: DateTime.now().toUtc().add(const Duration(minutes: 1)),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
