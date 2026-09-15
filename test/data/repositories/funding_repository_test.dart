import 'package:flutter_test/flutter_test.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/funding_repository_impl.dart';
import 'package:rwa_interface/data/services/funding_service.dart';

void main() {
  test(
    'generated request type update preserves multi-source funding wire',
    () async {
      final service = _CaptureFunding();
      final repository = FundingRepositoryImpl(service);
      await expectLater(
        repository.createFundingPlan(
          tradePreviewId: 'preview',
          idempotencyKey: 'plan-key',
        ),
        throwsStateError,
      );
      expect(service.plan, {
        'trade_preview_id': 'preview',
        'mode': 'auto_multi_source',
      });
      await expectLater(
        repository.createFundingTransfer(
          planId: 'plan',
          legId: 'leg',
          authorizationId: 'authorization',
          idempotencyKey: 'transfer-key',
        ),
        throwsStateError,
      );
      expect(service.transfer, {
        'plan_id': 'plan',
        'leg_id': 'leg',
        'authorization_id': 'authorization',
      });
    },
  );
  test('confirmed deposits map from the new oneOf response', () async {
    final result = await FundingRepositoryImpl(_Funding())
        .getDeposit('deposit-1');
    expect(result.resource.amount?.value, '0.000000000000000001');
    expect(result.resource.status.name, 'credited');
    expect(result.resource.instructions.address, '0xrecipient');
    expect(result.capability, isNull);
  });

  test(
    'self-custodial withdrawal serializes the exact create request',
    () async {
      final service = _CaptureFunding();
      final repository = FundingRepositoryImpl(service);

      await expectLater(
        repository.createSelfCustodialWithdrawal(
          walletId: 'wallet-1',
          assetId:
              'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831',
          chain: 'Arbitrum',
          amount: '25.000001',
          destinationAddress: '0x1111111111111111111111111111111111111111',
          idempotencyKey: 'withdrawal-key',
        ),
        throwsStateError,
      );

      expect(service.selfCustodialWithdrawal, {
        'wallet_id': 'wallet-1',
        'asset_id':
            'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831',
        'chain': 'Arbitrum',
        'amount': '25.000001',
        'destination_address': '0x1111111111111111111111111111111111111111',
      });
    },
  );
}

final class _CaptureFunding implements FundingService {
  Object? plan;
  Object? transfer;
  Object? selfCustodialWithdrawal;
  @override
  Future<api.FundingPlan> createPlan(
    api.FundingPlanRequest request, {
    required String idempotencyKey,
  }) async {
    plan = api.standardSerializers.serializeWith(
      api.FundingPlanRequest.serializer,
      request,
    );
    throw StateError('captured without sending');
  }

  @override
  Future<api.Transfer> createTransfer(
    api.TransferRequest request, {
    required String idempotencyKey,
  }) async {
    transfer = api.standardSerializers.serializeWith(
      api.TransferRequest.serializer,
      request,
    );
    throw StateError('captured without sending');
  }

  @override
  Future<api.SelfCustodialWithdrawal> createSelfCustodialWithdrawal(
    api.SelfCustodialWithdrawalCreateRequest request, {
    required String idempotencyKey,
  }) async {
    selfCustodialWithdrawal = api.standardSerializers.serializeWith(
      api.SelfCustodialWithdrawalCreateRequest.serializer,
      request,
    );
    throw StateError('captured without sending');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Funding implements FundingService {
  @override
  Future<api.Deposit> getDeposit(String id) async {
    final confirmed = api.BscConfirmedDeposit(
      (deposit) => deposit
        ..depositId = id
        ..chain = 'BSC'
        ..chainId = 56
        ..token = api.DepositBaseTokenEnum.USDC
        ..tokenContract = '0xusdc'
        ..tokenDecimals = 6
        ..amount = '0.000000000000000001'
        ..amountRaw = '1'
        ..status = api.DepositStatus.confirmed
        ..confirmations = 12
        ..confirmationsRequired = 12
        ..txHash = '0xtx'
        ..logIndex = 0
        ..blockNumber = 1
        ..blockHash = '0xblock'
        ..sender = '0xsender'
        ..recipient = '0xrecipient'
        ..detectedAt = DateTime.utc(2026)
        ..confirmedAt = DateTime.utc(2026)
        ..updatedAt = DateTime.utc(2026),
    );
    return api.Deposit(
      (deposit) => deposit.oneOf = OneOfDynamic(
        typeIndex: 1,
        types: const [api.ArbitrumConfirmedDeposit, api.BscConfirmedDeposit],
        value: confirmed,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
