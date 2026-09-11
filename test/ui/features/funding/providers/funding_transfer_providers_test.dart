import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
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

  test('funding plan retries retain a stable idempotency key', () async {
    final funding = _FundingRepository();
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
    );
    addTearDown(container.dispose);

    final commands = container.read(fundingTransferCommandsProvider);
    await commands.plan(tradePreviewId: 'preview-1');
    await commands.plan(tradePreviewId: 'preview-1');

    expect(funding.planKeys.toSet(), hasLength(1));
  });

  test('funding plan query exposes a stable domain failure', () async {
    final funding = _FundingRepository(failPlanQuery: true);
    final container = ProviderContainer(
      overrides: [fundingRepositoryProvider.overrideWithValue(funding)],
      retry: (_, _) => null,
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      fundingPlanProvider('plan-1'),
      (_, _) {},
    );
    addTearDown(subscription.close);

    await expectLater(
      container.read(fundingPlanProvider('plan-1').future),
      throwsA(isA<NetworkFailure>()),
    );
  });
}

final class _FundingRepository implements FundingRepository {
  _FundingRepository({this.failPlanQuery = false});

  String? createdPlanFor;
  String? transferAuthorizationId;
  final bool failPlanQuery;
  final List<String> planKeys = [];
  final plan = FundingPlan(
    planId: 'plan-1',
    tradePreviewId: 'preview-1',
    shortfall: DecimalValue('12', asset: 'USDT', unit: 'token'),
    status: FundingPlanState.ready,
    sourceWalletId: 'wallet-1',
    sourceAsset: 'USDC',
    sourceMaximum: DecimalValue('15', asset: 'USDC', unit: 'token'),
    legs: [
      FundingLeg(
        legId: 'leg-1',
        walletId: 'wallet-1',
        asset: 'USDC',
        maximumAmount: DecimalValue('15', asset: 'USDC', unit: 'token'),
        outputAmount: DecimalValue('12', asset: 'USDT', unit: 'token'),
        status: FundingLegState.actionReleased,
      ),
    ],
  );

  @override
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  }) async {
    createdPlanFor = tradePreviewId;
    planKeys.add(idempotencyKey);
    return plan;
  }

  @override
  Future<FundingPlan> getFundingPlan(String id) async {
    if (failPlanQuery) throw const NetworkFailure(retryable: false);
    return plan;
  }

  @override
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
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
