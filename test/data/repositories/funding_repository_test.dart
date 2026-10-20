import 'package:flutter_test/flutter_test.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/repositories/funding_repository_impl.dart';
import 'package:nobell/data/services/funding_service.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';

void main() {
  for (final scalarMode in [false, true]) {
    for (final mode in [
      'app_sponsored',
      'user_paid_native',
      null,
      'unsupported',
    ]) {
      test(
        'transfer action maps exact call and gas mode $mode (scalar: $scalarMode)',
        () async {
          final transfer = await FundingRepositoryImpl(
            _TransferEvidenceFunding(
              nextAction: {
                'action_id': 'action-1',
                'status': 'ready',
                'chain_id': 56,
                'from': '0x2222222222222222222222222222222222222222',
                'to': '0x3333333333333333333333333333333333333333',
                'data': '0xa9059cbb',
                'value': '0x0',
                'valid_until': '2030-01-01T00:00:00Z',
                if (mode != null && scalarMode) 'gas_payment_mode': mode,
                if (mode != null)
                  'gas_payment': {'mode': scalarMode ? 'app_sponsored' : mode},
              },
            ),
          ).getFundingTransfer('transfer-1');
          final action = transfer.nextAction!;
          expect(transfer.nextActionId, action.actionId);
          expect(action.mode, switch (mode) {
            'app_sponsored' => GasPaymentMode.appSponsored,
            'user_paid_native' => GasPaymentMode.userPaidNative,
            _ => null,
          });
          expect(action.chainId, 56);
          expect(action.from, '0x2222222222222222222222222222222222222222');
          expect(
            action.transaction.to,
            '0x3333333333333333333333333333333333333333',
          );
          expect(action.transaction.data, '0xa9059cbb');
          expect(action.transaction.value, '0x0');
          expect(action.validUntil, DateTime.utc(2030));
        },
      );
    }
  }

  test(
    'self custody mapping retains review evidence and immutable identities',
    () async {
      final service = _GasFunding();
      final wire =
          (await service.createSelfCustodialWithdrawal(
            api.SelfCustodialWithdrawalCreateRequest(
              (b) => b
                ..walletId = 'wallet-id'
                ..assetId = 'eip155:56/erc20:0xasset'
                ..chain = api.SelfCustodialWithdrawalChain.BSC
                ..amount = '9007199254740993.123456'
                ..destinationAddress = 'destination',
            ),
            idempotencyKey: 'key',
          )).rebuild(
            (b) => b
              ..status = api.SelfCustodialWithdrawalStatus.manualReview
              ..manualReviewReason = 'receipt_conflict'
              ..failureReason = 'unresolved'
              ..walletActionExecutionId = 'execution-id'
              ..userOperationHash = '0xoperation'
              ..txHash = '0xtransaction'
              ..submittedAt = DateTime.utc(2026, 1, 2)
              ..confirmedAt = DateTime.utc(2026, 1, 3),
          );
      service.selfCustodialResource = wire;
      final result = await FundingRepositoryImpl(service)
          .getSelfCustodialWithdrawal('withdrawal-1');
      expect(result.isCompleted, isFalse);
      expect(result.shouldPoll, isFalse);
      expect(result.sourceWalletId, wire.sourceWalletId);
      expect(result.assetId, wire.assetId);
      expect(result.amount.value, wire.amount);
      expect(result.manualReviewReason, 'receipt_conflict');
      expect(result.walletActionExecutionId, 'execution-id');
      expect(result.userOperationHash, '0xoperation');
      expect(result.txHash, '0xtransaction');
      expect(result.createdAt, wire.createdAt);
      expect(result.updatedAt, wire.updatedAt);
      expect(result.submittedAt, wire.submittedAt);
      expect(result.confirmedAt, wire.confirmedAt);
    },
  );

  test('withdrawal mapping preserves exact fee, received amount and completion metadata', () async {
    final service = _GasFunding()
      ..withdrawalResource = api.Withdrawal(
        (b) => b
          ..withdrawalId = 'withdrawal-id'
          ..asset = api.WithdrawalAssetEnum.USDC
          ..chain = api.Chain.arbitrum
          ..amount = '9007199254740993.123456'
          ..receivedAmount = '9007199254740993.123455'
          ..totalFee = '0.000001'
          ..status = api.WithdrawalStatus.sent
          ..txHash = '0xtransaction'
          ..activityId = 'activity-id'
          ..memo = 'memo'
          ..completedAt = DateTime.utc(2026, 1, 3),
      );
    final result = await FundingRepositoryImpl(service)
        .getWithdrawal('withdrawal-id');
    expect(result.isCompleted, isFalse);
    expect(result.amount.value, '9007199254740993.123456');
    expect(result.receivedAmount!.value, '9007199254740993.123455');
    expect(result.totalFee!.value, '0.000001');
    expect(result.activityId, 'activity-id');
    expect(result.memo, 'memo');
    expect(result.completedAt, DateTime.utc(2026, 1, 3));
  });

  test(
    'transfer mapping retains independent refund credit and recovery evidence',
    () async {
      final transfer = await FundingRepositoryImpl(_TransferEvidenceFunding())
          .getFundingTransfer('transfer-evidence');
      expect(transfer.status.name, 'manualReview');
      expect(transfer.isCompleted, isFalse);
      expect(transfer.canExecuteNextAction, isFalse);
      expect(transfer.planId, 'plan-1');
      expect(transfer.legId, 'leg-1');
      expect(transfer.activityId, 'activity-1');
      expect(transfer.amount.value, '5.000000000000000001');
      expect(transfer.amount.asset, 'USDC-PERPS');
      expect(transfer.sourceExecutionStatus, 'confirmed');
      expect(transfer.providerStatus, 'succeeded');
      expect(transfer.targetCreditStatus, 'pending');
      expect(transfer.refundStatus, 'pending');
      expect(transfer.refund?['amount'], '0.000000000000000001');
      expect(transfer.refund?['tx_hash'], '0xrefund');
      expect(transfer.refund?['log_index'], 9);
      expect(transfer.refund?['actual_fee_amount'], '0.000000000000000002');
      expect(transfer.sourceTransaction?['tx_hash'], '0xsource');
      expect(transfer.targetCredit?['credited_amount'], '2.000000000000000001');
      expect(transfer.targetCredit?['evidence_reference'], 'target-event-1');
      expect(transfer.targetCredit?['transaction_hash'], '0xtarget');
      expect(transfer.targetCredit?['log_index'], 8);
      expect(transfer.targetCredit?['venue_reference'], 'venue-credit-1');
      expect(transfer.reason, 'reconciliation required');
      expect(transfer.failureReason, 'provider conflict');
      expect(transfer.ambiguousReason, 'credit unmatched');
      expect(transfer.updatedAt, DateTime.utc(2026, 9, 29));
      expect(transfer.completedAt, isNull);
    },
  );
  test('target aggregate is distinct from last credit and never creates wallet availability', () async {
    final transfer = await FundingRepositoryImpl(
      _TransferEvidenceFunding(targetReceivedAmount: '4.000000000000000003'),
    ).getFundingTransfer('transfer-credit-aggregate');
    expect(transfer.targetReceivedAmount!.value, '4.000000000000000003');
    expect(transfer.targetCredit?['credited_amount'], '2.000000000000000001');
    expect(transfer.targetCredit!.containsKey('available_after'), isTrue);
    expect(transfer.targetCredit?['available_after'], isNull);
    expect((transfer.refund?['asset'] as Map)['token'], 'USDT');
    expect((transfer.refund?['asset'] as Map)['chain_id'], 56);
    expect(transfer.isCompleted, isFalse);
    final unknown = await FundingRepositoryImpl(_TransferEvidenceFunding())
        .getFundingTransfer('unknown-credit');
    expect(unknown.targetReceivedAmount, isNull);
  });
  test(
    'failed source retains actual debit and never implies refund or closure',
    () async {
      for (final amount in ['0', '0.000000000000000001']) {
        final transfer = await FundingRepositoryImpl(
          _TransferEvidenceFunding(sourceStatus: 'failed', actualDebit: amount),
        ).getFundingTransfer('failed-source');
        expect(transfer.sourceExecutionStatus, 'failed');
        expect(transfer.sourceTransaction?['actual_debited_amount'], amount);
        expect(transfer.sourceTransaction?['required_confirmations'], 15);
        expect(
          transfer.sourceTransaction?['debit_log_indices'],
          amount == '0' ? isEmpty : [7],
        );
        expect(
          transfer.sourceTransaction?['debit_basis'],
          amount == '0' ? 'finalized_revert' : 'transfer_logs',
        );
        expect(transfer.sourceTransaction?['user_operation_hash'], 'userop-1');
        expect(transfer.sourceTransaction?['block_number'], 123456);
        expect(transfer.sourceTransaction?['block_hash'], '0xblock');
        expect(transfer.sourceTransaction?['transaction_index'], 3);
        expect(transfer.sourceTransaction?['canonical'], isTrue);
        expect(transfer.sourceTransaction?['finality_satisfied'], isTrue);
        expect(transfer.isCompleted, isFalse);
        expect(transfer.refundStatus, 'pending');
        expect(transfer.canExecuteNextAction, isFalse);
      }
    },
  );
  test('deposit directory accepts a plain address QR payload', () async {
    final directory = await FundingRepositoryImpl(
      _DepositFunding('0x1111111111111111111111111111111111111111'),
    ).getDepositDirectory();

    expect(directory.instructions.single.qrPayload, directory.walletAddress);
  });

  test('deposit directory rejects a QR payload for another address', () {
    expect(
      FundingRepositoryImpl(
        _DepositFunding('0x2222222222222222222222222222222222222222'),
      ).getDepositDirectory(),
      throwsFormatException,
    );
  });

  test(
    'funding session maps transfer capability and target balances',
    () async {
      final repository = FundingRepositoryImpl(_MappedSessionFunding());

      final session = await repository.getFundingSession('session-1');

      expect(session.canConfirmTransfer, isFalse);
      expect(session.requiredTargetBalance, '20');
      expect(session.targetAvailableAmount, '15');
      expect(session.remainingMinimumTopUp, '5');
      expect(session.estimatedReceived, '4.9');
      expect(session.minimumReceived, '0');
      expect(session.slippageBps, 125);
      expect(session.fees?.asset, 'USD');
      expect(session.fees?.providerFee, '0.1');
      expect(session.fees?.bridgeFee, '0.2');
      expect(session.fees?.swapFee, '0.3');
      expect(session.fees?.networkFee, '0.4');
      expect(session.fees?.totalFee, '1');
      expect(session.fees?.totalCostUsd, '0.75');
      expect(session.targetToken, 'USDC-PERPS');
      expect(session.targetNetwork, 'Hyperliquid');
      expect(session.positions.single.availableAmount.value, '20');
      expect(session.positions.single.eligible, isTrue);
      expect(session.positions.single.canAllocate('20'), isTrue);
      expect(session.positions.single.canAllocate('21'), isFalse);
      expect(session.crossLiquidationImpacts.single.productId, 'xyz:BTC');
      expect(session.crossLiquidationImpacts.single.side, TradingSide.long);
      expect(session.crossLiquidationImpacts.single.markPrice?.value, '1000');
      expect(
        session.crossLiquidationImpacts.single.afterLiquidationPrice?.value,
        '700',
      );
    },
  );

  test('funding session preserves unknown optional quote fields', () async {
    final session = await FundingRepositoryImpl(
      _MappedSessionFunding(includeQuoteDetails: false),
    ).getFundingSession('legacy-session');

    expect(session.estimatedReceived, isNull);
    expect(session.slippageBps, isNull);
    expect(session.minimumReceived, '0');
  });

  test('net funding capacity preserves total account valuation', () async {
    final account = await FundingRepositoryImpl(_MappedSessionFunding())
        .getUnifiedFundingAccount();

    expect(account.totalUsd.value, '100');
    expect(account.availableToFundUsd.value, '20');
    expect(account.reservedUsd.value, '80');
    expect(account.inTransitUsd.value, '0');
    expect(account.positions.single.availableAmount.value, '20');
    expect(account.positions.single.canAllocate('20'), isTrue);
  });

  test('account and session preserve ineligible source capacity', () async {
    final repository = FundingRepositoryImpl(
      _MappedSessionFunding(eligible: false),
    );
    final account = await repository.getUnifiedFundingAccount();
    final session = await repository.getFundingSession('session-1');

    for (final position in [
      account.positions.single,
      session.positions.single,
    ]) {
      expect(position.availableAmount.value, '20');
      expect(position.eligible, isFalse);
      expect(position.canAllocate('1'), isFalse);
    }
  });

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
    'standalone transfer session only sends destination and amount',
    () async {
      final service = _CaptureFunding();
      final repository = FundingRepositoryImpl(service);

      await expectLater(
        repository.createTransferFundingSession(
          destination: 'hip3_margin',
          amount: '160.25',
          idempotencyKey: 'session-key',
        ),
        throwsStateError,
      );

      expect(service.session, {
        'transfer': {'destination': 'hip3_margin', 'amount': '160.25'},
      });
    },
  );

  test(
    'selection amount is an explicit minimum net received constraint',
    () async {
      final service = _CaptureFunding();
      final repository = FundingRepositoryImpl(service);

      await expectLater(
        repository.updateFundingSessionSelection(
          fundingSessionId: 'session-1',
          version: 3,
          allocations: const {'position-1': '5.25'},
          amount: '5',
          idempotencyKey: 'selection-key',
        ),
        throwsStateError,
      );

      expect(service.selection, {
        'version': 3,
        'amount': '5',
        'allocations': [
          {'source_position_id': 'position-1', 'input_amount': '5.25'},
        ],
      });
    },
  );

  test(
    'selection omits amount when allocations determine the quoted output',
    () async {
      final service = _CaptureFunding();
      final repository = FundingRepositoryImpl(service);

      await expectLater(
        repository.updateFundingSessionSelection(
          fundingSessionId: 'session-1',
          version: 3,
          allocations: const {'position-1': '5'},
          idempotencyKey: 'selection-key',
        ),
        throwsStateError,
      );

      expect(service.selection, {
        'version': 3,
        'allocations': [
          {'source_position_id': 'position-1', 'input_amount': '5'},
        ],
      });
    },
  );

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
    'user-selected perp session plan maps its session ID and legs',
    () async {
      final plan = await FundingRepositoryImpl(_SessionPlanFunding())
          .getFundingPlan('plan-1');

      expect(plan.planId, 'plan-1');
      expect(plan.tradePreviewId, isEmpty);
      expect(plan.fundingSessionId, 'session-1');
      expect(plan.status.name, 'ready');
      expect(plan.targetAsset, 'USDC-PERPS');
      expect(plan.targetNetwork, 'Hyperliquid');
      expect(plan.legs, hasLength(1));
      expect(plan.legs.single.walletId, 'wallet-1');
      expect(plan.legs.single.asset, 'USDC');
      expect(plan.legs.single.network, 'Arbitrum');
      expect(plan.legs.single.sourcePositionId, 'position-1');
      expect(plan.legs.single.outputAmount.value, '5');
      expect(plan.legs.single.maximumAmount.asset, 'USDC');
      expect(plan.legs.single.bridgeFee?.asset, 'USD');
      expect(plan.legs.single.fees?.totalCostUsd, '0');
      expect(plan.legs.single.refundAsset, isNull);
      expect(plan.createdAt, DateTime.parse('2026-09-28T08:27:18.331Z'));
    },
  );

  for (final environment in ['mainnet', 'testnet', null]) {
    test(
      'plan preserves frozen $environment scope and unlike refund asset',
      () async {
        final refundAsset = <String, Object?>{
          'asset_id':
              'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955',
          'namespace': 'eip155',
          'network': 'BSC',
          'chain_id': 56,
          'token': 'USDT',
          'token_contract': '0x55d398326f99059ff775485246999027b3197955',
          'token_decimals': 18,
          'provenance': 'binance_peg',
        };
        final plan = await FundingRepositoryImpl(
          _SessionPlanFunding(
            environment: environment,
            refundAsset: refundAsset,
          ),
        ).getFundingPlan('plan-1');
        expect(plan.targetEnvironment, environment);
        expect(plan.legs.single.targetEnvironment, environment);
        expect(plan.legs.single.asset, 'USDC');
        expect(plan.legs.single.refundAsset?['token'], 'USDT');
        expect(plan.legs.single.refundAsset?['chain_id'], 56);
        expect(
          plan.legs.single.refundAsset?['asset_id'],
          refundAsset['asset_id'],
        );
      },
    );
  }

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

final class _DepositFunding implements FundingService {
  const _DepositFunding(this.qrPayload);

  final String qrPayload;

  @override
  Future<api.DepositInstruction> getDepositDirectory() async {
    const address = '0x1111111111111111111111111111111111111111';
    final response = api.DepositInstructionsResponse(
      (builder) => builder
        ..catalogVersion = 'v1'
        ..wallet.replace(
          api.DepositInstructionWallet(
            (wallet) => wallet
              ..walletId = 'wallet-1'
              ..address = address
              ..custody =
                  api.DepositInstructionWalletCustodyEnum.embeddedWallet,
          ),
        )
        ..items.add(
          api.DepositInstructionItem(
            (item) => item
              ..identity.replace(
                api.FundingSourceAssetIdentity(
                  (identity) => identity
                    ..assetId = 'eip155:56/erc20:token'
                    ..namespace = 'eip155'
                    ..network = 'BSC'
                    ..chainId = 56
                    ..token = 'USDT'
                    ..tokenContract =
                        '0x3333333333333333333333333333333333333333'
                    ..tokenDecimals = 18
                    ..provenance = 'catalog',
                ),
              )
              ..minDeposit = '1'
              ..confirmationsRequired = 15
              ..estimatedArrivalSeconds = 60
              ..qrPayload = qrPayload
              ..creditedTo = api.DepositCreditTarget.wallet
              ..availability.replace(
                api.DepositInstructionAvailability(
                  (availability) => availability..status = 'available',
                ),
              )
              ..warning = 'Send USDT only',
          ),
        )
        ..updatedAt = DateTime.utc(2026),
    );
    return api.DepositInstruction(
      (builder) => builder.oneOf = OneOfDynamic(
        typeIndex: 0,
        types: const [api.DepositInstructionsResponse],
        value: response,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _MappedSessionFunding implements FundingService {
  _MappedSessionFunding({
    this.eligible = true,
    this.includeQuoteDetails = true,
  });
  final bool eligible;
  final bool includeQuoteDetails;

  @override
  Future<api.UnifiedFundingAccount> getUnifiedFundingAccount() async => api
      .standardSerializers
      .deserializeWith(api.UnifiedFundingAccount.serializer, {
        'account_id': 'account-1',
        'valuation_currency': 'USD',
        'valued_total_usd': '100',
        'available_to_fund_value_usd': '20',
        'reserved_value_usd': '80',
        'in_transit_value_usd': '0',
        'unavailable_value_usd': '0',
        'unvalued_position_count': 0,
        'positions': [_fundingPositionBody(eligible: eligible)],
        'transfers': <Object?>[],
        'data_status': 'complete',
        'blockers': <Object?>[],
        'calculated_at': '2026-09-28T08:27:18.098Z',
      })!;

  @override
  Future<api.FundingSession> getFundingSession(String id) async =>
      api.standardSerializers.deserializeWith(api.FundingSession.serializer, {
        ..._fundingSessionBody(id, includeQuoteDetails: includeQuoteDetails),
        'positions': [_fundingPositionBody(eligible: eligible)],
      })!;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Map<String, Object?> _fundingPositionBody({required bool eligible}) => {
  'position_id': 'position-1',
  'custody': 'embedded_wallet',
  'wallet_id': 'wallet-1',
  'wallet_address': '0x1111111111111111111111111111111111111111',
  'asset': {
    'asset_id': 'eip155:56/erc20:0x1111111111111111111111111111111111111111',
    'namespace': 'eip155',
    'network': 'BSC',
    'chain_id': 56,
    'token': 'USDC',
    'token_contract': '0x1111111111111111111111111111111111111111',
    'token_decimals': 18,
    'provenance': 'wallet_rpc',
  },
  'total_amount': '100',
  'available_amount': '20',
  'reserved_amount': '80',
  'in_transit_amount': '0',
  'value_usd': '100',
  'freshness': 'live',
  'eligibility': {
    'status': eligible ? 'eligible' : 'ineligible',
    'blockers': <Object?>[],
  },
  'observed_at': '2026-09-28T08:27:18.098Z',
  'valid_until': '2026-09-28T08:28:18.098Z',
};

Map<String, Object?> _fundingSessionBody(
  String id, {
  bool includeQuoteDetails = true,
}) => {
  'funding_session_id': id,
  'status': 'editing',
  'version': 1,
  'trade': {
    'symbol': 'NVDA',
    'kind': 'perp',
    'side': 'long',
    'type': 'market',
    'amount': '20',
    'margin_mode': 'cross',
    'reduce_only': false,
  },
  'continuation': null,
  'rail': 'perp',
  'risk_preview': {
    'status': 'available',
    'collateral_asset': 'USDC',
    'shared_margin_delta': '5',
    'observed_at': '2026-09-28T08:27:18.098Z',
    'valid_until': '2026-09-28T08:28:18.098Z',
    'cross_liquidation_impacts': [
      {
        'product_id': 'xyz:BTC',
        'side': 'long',
        'mark_price': '1000',
        'before_liquidation_price': '800',
        'after_liquidation_price': '700',
        'unavailable_reason': null,
      },
    ],
    'unavailable_reason': null,
  },
  'target_snapshot': {
    'account': 'hip3',
    'account_ref': '0x09920a496942e7aa8c9adabf97cdf035524248c1',
    'asset': {
      'asset_id': 'hyperliquid:1337/perps:USDC-PERPS',
      'namespace': 'hyperliquid',
      'network': 'Hyperliquid',
      'chain_id': 1337,
      'token': 'USDC-PERPS',
      'token_contract': '0x2100000000000000000000000000000000000000',
      'token_decimals': 8,
      'provenance': 'hyperliquid_perps',
    },
    'available_amount': '15',
    'source': 'hyperliquid_info',
    'observed_at': '2026-09-28T08:27:18.098Z',
    'valid_until': '2026-09-28T08:28:18.098Z',
  },
  'required_target_balance': '20',
  'minimum_top_up': '5',
  'recommended_top_up': '6',
  'safety_buffer_bps': 2000,
  'selected_target_amount': '0',
  if (includeQuoteDetails) 'estimated_received': '4.9',
  'minimum_received': '0',
  if (includeQuoteDetails) 'slippage_bps': 125,
  'maximum_selectable_target_amount': '0',
  'total_source_value_usd': '0',
  'estimated_fees': {
    'fee_asset': 'USD',
    'provider_fee': '0.1',
    'bridge_fee': '0.2',
    'swap_fee': '0.3',
    'network_fee': '0.4',
    'total_fee': '1',
    'total_cost_usd': '0.75',
  },
  'eta_seconds': 0,
  'positions': <Object?>[],
  'allocations': <Object?>[],
  'can_confirm_transfer': false,
  'remaining_minimum_top_up': '5',
  'estimate_observed_at': '2026-09-28T08:27:18.098Z',
  'created_at': '2026-09-28T08:27:18.098Z',
  'updated_at': '2026-09-28T08:27:18.098Z',
  'expires_at': '2026-09-29T08:27:18.098Z',
};

final class _CaptureFunding implements FundingService {
  Object? session;
  Object? plan;
  Object? selection;
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
  Future<api.FundingSession> updateFundingSessionSelection(
    String id,
    api.FundingSessionSelectionRequest request, {
    required String idempotencyKey,
  }) async {
    selection = api.standardSerializers.serializeWith(
      api.FundingSessionSelectionRequest.serializer,
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

final class _SessionPlanFunding implements FundingService {
  _SessionPlanFunding({this.environment, this.refundAsset});
  final String? environment;
  final Map<String, Object?>? refundAsset;
  @override
  Future<api.FundingPlan> getPlan(String id) async => api.standardSerializers
      .deserializeWith(api.FundingPlan.serializer, <String, Object?>{
        'plan_id': id,
        'trade_preview_id': null,
        'funding_session_id': 'session-1',
        'selection_version': 1,
        'mode': 'user_selected_multi_source',
        'required_target_amount': '5',
        'target_snapshot': {
          'account': 'hip3',
          'account_ref': '0x09920a496942e7aa8c9adabf97cdf035524248c1',
          'target_environment': environment,
          'asset': {
            'asset_id': 'hyperliquid:1337/perps:USDC-PERPS',
            'namespace': 'hyperliquid',
            'network': 'Hyperliquid',
            'chain_id': 1337,
            'token': 'USDC-PERPS',
            'token_contract': '0x2100000000000000000000000000000000000000',
            'token_decimals': 8,
            'provenance': 'hyperliquid_perps',
          },
          'available_amount': '0',
          'source': 'hyperliquid_info',
          'observed_at': '2026-09-28T08:27:18.098Z',
          'valid_until': '2026-09-28T08:28:18.098Z',
        },
        'shortfall': '5',
        'status': 'ready',
        'blocker': null,
        'wallet_actions': <Object?>[],
        'multi_source': {
          'allocated_output_amount': '5',
          'allocation_policy_version': 'decimal-bisection-v1',
          'excluded_source_position_ids': <Object?>[],
          'max_legs': 3,
          'legs': [
            {
              'leg_id': 'leg-1',
              'ordinal': 1,
              'output_amount': '5',
              'source_position_snapshot': {
                'position_id': 'position-1',
                'wallet_id': 'wallet-1',
                'wallet_address': '0x09920a496942e7aa8c9adabf97cdf035524248c1',
                'asset': {
                  'asset_id': 'eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831',
                  'namespace': 'eip155',
                  'network': 'Arbitrum',
                  'chain_id': 42161,
                  'token': 'USDC',
                  'token_contract':
                      '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
                  'token_decimals': 6,
                  'provenance': 'circle_native',
                },
                'available_amount': '5',
                'reserved_amount': '5',
                'gas_asset': 'ETH',
                'gas_balance': '0',
                'observed_at': '2026-09-28T08:27:18.143Z',
                'valid_until': '2026-09-28T08:28:18.143Z',
              },
              'route': {
                'quote_id': 'quote-1',
                'provider': 'hyperliquid_bridge2',
                'target_environment': environment,
                'input_amount': '5',
                'output_amount': '5',
                'minimum_received': '5',
                'maximum_input_amount': '5',
                'fees': {
                  'network_fee': '0',
                  'provider_fee': '0',
                  'bridge_fee': '0',
                  'swap_fee': '0',
                  'total_fee': '0',
                  'fee_asset': 'USD',
                  'total_cost_usd': '0',
                },
                'eta_seconds': 60,
                'quoted_at': '2026-09-28T08:27:18.143Z',
                'expires_at': '2026-09-28T08:28:18.143Z',
                'quote_hash': 'a' * 64,
                'refund': {
                  'asset': refundAsset,
                  'address': '0x09920a496942e7aa8c9adabf97cdf035524248c1',
                  'address_role': 'source_wallet',
                  'may_deduct_gas': false,
                  'timing_note': 'No provider refund path',
                },
              },
              'status': 'planned',
              'transfer_id': null,
              'wallet_actions': <Object?>[],
            },
          ],
        },
        'circuit_snapshot': {
          'global': {'scope': 'global', 'state': 'closed', 'generation': 1},
          'rail': {'scope': 'hip3', 'state': 'closed', 'generation': 1},
        },
        'created_at': '2026-09-28T08:27:18.331Z',
        'expires_at': '2026-09-28T08:28:18.143Z',
        'rail': 'perp',
        'network': 'Hyperliquid',
        'asset': 'USDC',
      })!;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _GasFunding implements FundingService {
  _GasFunding({this.gas = true});
  final bool gas;
  api.SelfCustodialWithdrawal? selfCustodialResource;
  api.Withdrawal? withdrawalResource;

  @override
  Future<api.SelfCustodialWithdrawal> getSelfCustodialWithdrawal(
    String id,
  ) async => selfCustodialResource!;

  @override
  Future<api.Withdrawal> getWithdrawal(String id) async => withdrawalResource!;

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

final class _TransferEvidenceFunding implements FundingService {
  _TransferEvidenceFunding({
    this.sourceStatus = 'confirmed',
    this.actualDebit = '5.000000000000000001',
    this.nextAction = const {'action_id': 'stale-action'},
    this.targetReceivedAmount,
  });
  final String sourceStatus;
  final String actualDebit;
  final Map<String, Object?> nextAction;
  final String? targetReceivedAmount;
  @override
  Future<api.Transfer> getTransfer(String id) async {
    final plan = api.standardSerializers.serializeWith(
      api.FundingPlan.serializer,
      await _SessionPlanFunding().getPlan('plan-1'),
    ) as Map;
    final source =
        ((plan['multi_source'] as Map)['legs'] as List).single as Map;
    final value = api.standardSerializers.deserializeWith(
      api.CrossChainFundingTransfer.serializer,
      {
        'transfer_id': id,
        'plan_id': 'plan-1',
        'leg_id': 'leg-1',
        'activity_id': 'activity-1',
        'amount': '5.000000000000000001',
        'target_received_amount': targetReceivedAmount,
        'status': 'manual_review',
        'source_execution_status': sourceStatus,
        'provider_status': 'succeeded',
        'target_credit_status': 'pending',
        'recovery_status': 'manual_review',
        'refund_status': 'pending',
        'rail': 'perp',
        'provider': 'relay',
        'source': source['source_position_snapshot'],
        'target': plan['target_snapshot'],
        'source_transaction': {
          'tx_hash': '0xsource',
          'observed_at': '2026-09-28T00:00:00Z',
          'status': sourceStatus,
          'required_confirmations': 15,
          'actual_debited_amount': actualDebit,
          'debit_basis': actualDebit == '0'
              ? 'finalized_revert'
              : 'transfer_logs',
          'debit_log_indices': actualDebit == '0' ? <int>[] : [7],
          'user_operation_hash': 'userop-1',
          'block_number': 123456,
          'block_hash': '0xblock',
          'transaction_index': 3,
          'canonical': true,
          'finality_satisfied': true,
        },
        'provider_observation': {
          'request_id': 'provider-1',
          'status': 'succeeded',
        },
        'target_credit': {
          'credited_amount': '2.000000000000000001',
          'available_after': null,
          'evidence_reference': 'target-event-1',
          'transaction_hash': '0xtarget',
          'log_index': 8,
          'venue_reference': 'venue-credit-1',
        },
        'refund': {
          'amount': '0.000000000000000001',
          'tx_hash': '0xrefund',
          'status': 'pending',
          'log_index': 9,
          'asset': {
            'asset_id':
                'eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955',
            'namespace': 'eip155',
            'network': 'BSC',
            'chain_id': 56,
            'token': 'USDT',
            'token_contract': '0x55d398326f99059ff775485246999027b3197955',
            'token_decimals': 18,
          },
          'actual_fee_amount': '0.000000000000000002',
        },
        'failure_reason': 'provider conflict',
        'ambiguous_reason': 'credit unmatched',
        'manual_review_reason': 'reconciliation required',
        'next_action': nextAction,
        'created_at': '2026-09-28T00:00:00Z',
        'updated_at': '2026-09-29T00:00:00Z',
        'route_locked_at': '2026-09-28T00:00:01Z',
        'wallet_action_released_at': '2026-09-28T00:00:02Z',
      },
    )!;
    return api.Transfer(
      (builder) => builder.oneOf = OneOfDynamic(
        typeIndex: 0,
        types: const [api.CrossChainFundingTransfer],
        value: value,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
