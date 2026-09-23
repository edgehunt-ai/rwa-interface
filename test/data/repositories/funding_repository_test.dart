import 'package:flutter_test/flutter_test.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/funding_repository_impl.dart';
import 'package:rwa_interface/data/services/funding_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';

void main() {
  test('funding session wraps the order draft in the trade variant', () async {
    final service = _CaptureFunding();
    final repository = FundingRepositoryImpl(service);

    await expectLater(
      repository.createFundingSession(
        intent: OrderIntent(
          symbol: 'NVDA',
          kind: MarketProductKind.perp,
          side: TradingSide.long,
          type: TradingOrderType.market,
          amount: DecimalValue('100'),
          marginMode: TradingMarginMode.cross,
        ),
        idempotencyKey: 'session-key',
      ),
      throwsStateError,
    );

    expect(service.session, {
      'trade': {
        'symbol': 'NVDA',
        'kind': 'perp',
        'side': 'long',
        'type': 'market',
        'amount': '100',
        'margin_mode': 'cross',
        'reduce_only': false,
      },
    });
  });

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
  test(
    'prepared withdrawal carries the observed gas estimate verbatim',
    () async {
      final prepared = await FundingRepositoryImpl(_GasFunding())
          .createSelfCustodialWithdrawal(
            walletId: 'wallet-1',
            assetId: 'eip155:56/erc20:0xusdc',
            chain: 'BSC',
            amount: '25.000001',
            destinationAddress: '0x1111111111111111111111111111111111111111',
            idempotencyKey: 'withdrawal-key',
          );

      final gas = prepared.gas!;
      expect(gas.nativeAsset, 'BNB');
      expect(gas.gasUnits, '65000');
      // Financial strings must survive the boundary without reformatting.
      expect(gas.gasPriceWei.value, '1000000000');
      expect(gas.estimatedNativeFee.value, '0.000065000000000000');
      expect(gas.walletNativeBalance.value, '0.000010000000000000');
      expect(gas.estimatedNativeFee.asset, 'BNB');
      expect(gas.canPayGas, isFalse);
      expect(gas.observedAt, DateTime.utc(2026));
    },
  );

  test('a withdrawal without a gas estimate maps to null', () async {
    final prepared = await FundingRepositoryImpl(_GasFunding(gas: false))
        .createSelfCustodialWithdrawal(
          walletId: 'wallet-1',
          assetId: 'eip155:56/erc20:0xusdc',
          chain: 'BSC',
          amount: '25.000001',
          destinationAddress: '0x1111111111111111111111111111111111111111',
          idempotencyKey: 'withdrawal-key',
        );
    expect(prepared.gas, isNull);
  });

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
  Object? session;
  Object? plan;
  Object? transfer;
  Object? selfCustodialWithdrawal;

  @override
  Future<api.FundingSession> createFundingSession(
    api.FundingSessionCreateRequest request, {
    required String idempotencyKey,
  }) async {
    session = api.standardSerializers.serializeWith(
      api.FundingSessionCreateRequest.serializer,
      request,
    );
    throw StateError('captured without sending');
  }

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

final class _GasFunding implements FundingService {
  _GasFunding({this.gas = true});
  final bool gas;

  @override
  Future<api.SelfCustodialWithdrawal> createSelfCustodialWithdrawal(
    api.SelfCustodialWithdrawalCreateRequest request, {
    required String idempotencyKey,
  }) async => api.SelfCustodialWithdrawal(
    (withdrawal) => withdrawal
      ..withdrawalId = 'withdrawal-1'
      ..sourceWalletId = request.walletId
      ..assetId = request.assetId
      ..assetSymbol = 'USDC'
      ..amount = request.amount
      ..destinationAddress = request.destinationAddress
      ..transaction = api.SelfCustodialWithdrawalTransaction(
        (transaction) => transaction
          ..chainId = api.SelfCustodialWithdrawalChainId.n56
          ..from = '0x2222222222222222222222222222222222222222'
          ..to = '0x3333333333333333333333333333333333333333'
          ..data = '0xa9059cbb'
          ..value = api.SelfCustodialWithdrawalTransactionValueEnum.n0x0
          ..payloadHash = '0xpayload'
          ..validUntil = DateTime.utc(2026),
      ).toBuilder()
      ..gas = !gas
          ? null
          : api.SelfCustodialWithdrawalGasEstimate(
              (estimate) => estimate
                ..nativeAsset = 'BNB'
                ..gasUnits = '65000'
                ..gasPriceWei = '1000000000'
                ..estimatedNativeFee = '0.000065000000000000'
                ..walletNativeBalance = '0.000010000000000000'
                ..canPayGas = false
                ..observedAt = DateTime.utc(2026),
            ).toBuilder()
      ..status = api.SelfCustodialWithdrawalStatus.awaitingSubmission
      ..gasPaymentMode = api.GasPaymentMode.userPaidNative
      ..requiredConfirmations = 12
      ..createdAt = DateTime.utc(2026)
      ..updatedAt = DateTime.utc(2026),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
