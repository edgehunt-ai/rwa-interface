import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/self_custodial_withdrawal.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';

import '../../../../helpers/funding_execution_fixture.dart';

void main() {
  SelfCustodialWithdrawalCommands commands(
    RecordingFundingExecutions executions,
    RecordingFundingSigner signer,
  ) {
    final container = ProviderContainer(
      overrides: [
        walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        walletAuthorizationSignerProvider.overrideWithValue(signer),
        fundingRepositoryProvider.overrideWithValue(_Funding()),
      ],
    );
    addTearDown(container.dispose);
    return container.read(selfCustodialWithdrawalCommandsProvider);
  }

  for (final mode in GasPaymentMode.values) {
    test(
      '$mode uses fresh authority and backend signature submission only',
      () async {
        final executions = RecordingFundingExecutions(
          created: fundingExecution(mode: mode),
        );
        final signer = RecordingFundingSigner(executions.events);
        final command = commands(executions, signer);
        final summary = mode == GasPaymentMode.appSponsored
            ? await command.execute(
                quote: _quote,
                prepared: _prepared(canPayGas: false),
              )
            : await command.executeUserPaid(
                quote: _quote,
                prepared: _prepared(),
              );

        expect(summary.withdrawalId, 'withdrawal-1');
        expect(executions.modes, [mode]);
        expect(executions.events, ['create', 'get', 'sign', 'submit']);
        expect(
          signer.requests.single.sponsor,
          mode == GasPaymentMode.appSponsored,
        );
        expect(signer.signers, [fundingSigner]);
        expect(executions.signatures, ['0xauthorization']);
        expect(executions.hashes, isEmpty);
      },
    );
  }

  for (final code in [404, 422, 409]) {
    test('$code cannot invoke a legacy publisher or switch gas mode', () async {
      final executions = RecordingFundingExecutions(
        created: fundingExecution(mode: GasPaymentMode.appSponsored),
        createFailure: ServerFailure(
          statusCode: code,
          code: 'execution_unavailable',
        ),
      );
      final signer = RecordingFundingSigner(executions.events);
      final command = commands(executions, signer);
      await expectLater(
        command.execute(quote: _quote, prepared: _prepared()),
        throwsA(isA<ServerFailure>()),
      );
      await expectLater(
        command.executeUserPaid(quote: _quote, prepared: _prepared()),
        throwsStateError,
      );
      expect(executions.modes, [GasPaymentMode.appSponsored]);
      expect(signer.requests, isEmpty);
      expect(executions.hashes, isEmpty);
    });
  }

  test(
    'only authoritative pre-delivery refusal permits explicit user-paid relay',
    () async {
      final executions = RecordingFundingExecutions(
        created: fundingExecution(
          mode: GasPaymentMode.appSponsored,
          status: WalletActionExecutionState.userGasConfirmationRequired,
          includeAuthorization: false,
        ),
      );
      final signer = RecordingFundingSigner(executions.events);
      final command = commands(executions, signer);
      await expectLater(
        command.execute(quote: _quote, prepared: _prepared()),
        throwsA(isA<SponsoredGasUnavailable>()),
      );
      executions.created = fundingExecution(executionId: 'native-execution');
      await command.executeUserPaid(quote: _quote, prepared: _prepared());
      expect(executions.modes, [
        GasPaymentMode.appSponsored,
        GasPaymentMode.userPaidNative,
      ]);
      expect(signer.requests.single.sponsor, isFalse);
    },
  );

  final invalid = <String, WalletActionExecution Function()>{
    'authorization target drift': () => fundingExecution(
      authorizedTo: '0x9999999999999999999999999999999999999999',
    ),
    'raw request target drift': () =>
        fundingExecution(rawTo: '0x9999999999999999999999999999999999999999'),
    'legacy publisher': () => fundingExecution(provider: 'user_wallet'),
    'native sponsorship': () => fundingExecution(sponsor: true),
    'wrong authorized nonce': () => fundingExecution(authorizedNonce: '0xb'),
    'noncanonical authorized nonce': () =>
        fundingExecution(authorizedNonce: '0x0a'),
    'noncanonical frozen nonce': () => fundingExecution(nonce: '010'),
    'expired authorization': () =>
        fundingExecution(expiresAt: DateTime.utc(2020)),
    'possible provider delivery': () =>
        fundingExecution(deliveryState: 'dispatching'),
  };
  for (final entry in invalid.entries) {
    test('${entry.key} fails closed before signing', () async {
      final executions = RecordingFundingExecutions(created: entry.value());
      final signer = RecordingFundingSigner(executions.events);
      await expectLater(
        commands(
          executions,
          signer,
        ).executeUserPaid(quote: _quote, prepared: _prepared()),
        throwsStateError,
      );
      expect(signer.requests, isEmpty);
      expect(executions.signatures, isEmpty);
    });
  }

  for (final status in [
    WalletActionExecutionState.submitting,
    WalletActionExecutionState.providerSubmitted,
    WalletActionExecutionState.ambiguous,
    WalletActionExecutionState.manualReview,
  ]) {
    test('fresh $status overrides an awaiting create replay', () async {
      final executions = RecordingFundingExecutions(
        created: fundingExecution(),
        current: fundingExecution(status: status, includeAuthorization: false),
      );
      final signer = RecordingFundingSigner(executions.events);
      await commands(
        executions,
        signer,
      ).executeUserPaid(quote: _quote, prepared: _prepared());
      expect(executions.events, ['create', 'get']);
      expect(signer.requests, isEmpty);
    });
  }

  test('fresh nonce drift is rejected before signing', () async {
    final executions = RecordingFundingExecutions(
      created: fundingExecution(),
      current: fundingExecution(nonce: '11', authorizedNonce: '0xb'),
    );
    final signer = RecordingFundingSigner(executions.events);
    await expectLater(
      commands(
        executions,
        signer,
      ).executeUserPaid(quote: _quote, prepared: _prepared()),
      throwsStateError,
    );
    expect(signer.requests, isEmpty);
  });

  test('a failed authority GET never signs the create snapshot', () async {
    final executions = RecordingFundingExecutions(
      created: fundingExecution(),
      getFailure: const NetworkFailure(),
    );
    final signer = RecordingFundingSigner(executions.events);
    await expectLater(
      commands(
        executions,
        signer,
      ).executeUserPaid(quote: _quote, prepared: _prepared()),
      throwsA(isA<NetworkFailure>()),
    );
    expect(signer.requests, isEmpty);
  });

  test('lost authorization response only observes on retry', () async {
    final executions = RecordingFundingExecutions(
      created: fundingExecution(),
      submitFailure: const NetworkFailure(),
    );
    final signer = RecordingFundingSigner(executions.events);
    final command = commands(executions, signer);
    await expectLater(
      command.executeUserPaid(quote: _quote, prepared: _prepared()),
      throwsA(isA<NetworkFailure>()),
    );
    await command.executeUserPaid(quote: _quote, prepared: _prepared());
    expect(executions.events, ['create', 'get', 'sign', 'submit', 'get']);
    expect(signer.requests, hasLength(1));
    expect(executions.signatures, hasLength(1));
    expect(executions.hashes, isEmpty);
  });

  test('missing native gas balance blocks before execution creation', () async {
    final executions = RecordingFundingExecutions(created: fundingExecution());
    final signer = RecordingFundingSigner(executions.events);
    await expectLater(
      commands(
        executions,
        signer,
      ).executeUserPaid(quote: _quote, prepared: _prepared(canPayGas: false)),
      throwsA(isA<InsufficientWithdrawalGas>()),
    );
    expect(executions.events, isEmpty);
  });
}

final _quote = WithdrawalQuote(
  quoteId: 'self-custodial-local',
  intent: WithdrawalIntent(
    chain: 'BSC',
    amount: DecimalValue('25.000001', asset: 'USDC', unit: 'token'),
    address: '0x1111111111111111111111111111111111111111',
  ),
  totalFee: DecimalValue('0', asset: 'USDC', unit: 'token'),
  estimatedReceive: DecimalValue('25.000001', asset: 'USDC', unit: 'token'),
  sufficient: true,
);

PreparedSelfCustodialWithdrawal _prepared({
  bool canPayGas = true,
}) => PreparedSelfCustodialWithdrawal(
  withdrawalId: 'withdrawal-1',
  sourceWalletId: 'wallet-1',
  assetId: 'eip155:56/erc20:0xusdc',
  assetSymbol: 'USDC',
  chain: 'BSC',
  amount: DecimalValue('25.000001', asset: 'USDC', unit: 'token'),
  destinationAddress: '0x1111111111111111111111111111111111111111',
  transaction: SelfCustodialWithdrawalTransaction(
    chainId: 56,
    from: fundingSigner,
    to: fundingTarget,
    data: fundingData,
    value: '0x0',
    payloadHash: '0xpayload',
    validUntil: DateTime.utc(2030),
  ),
  status: SelfCustodialWithdrawalState.awaitingSubmission,
  gas: SelfCustodialWithdrawalGasEstimate(
    nativeAsset: 'BNB',
    gasUnits: '65000',
    gasPriceWei: DecimalValue('1000000000', asset: 'BNB', unit: 'wei'),
    estimatedNativeFee: DecimalValue('0.000065', asset: 'BNB', unit: 'token'),
    walletNativeBalance: DecimalValue('0.00001', asset: 'BNB', unit: 'token'),
    canPayGas: canPayGas,
    observedAt: DateTime.utc(2026),
  ),
);

final class _Funding implements FundingRepository {
  @override
  Future<SelfCustodialWithdrawalSummary> getSelfCustodialWithdrawal(
    String id,
  ) async => SelfCustodialWithdrawalSummary(
    withdrawalId: id,
    assetSymbol: 'USDC',
    amount: DecimalValue('25.000001', asset: 'USDC', unit: 'token'),
    destinationAddress: '0x1111111111111111111111111111111111111111',
    status: SelfCustodialWithdrawalState.submitted,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
