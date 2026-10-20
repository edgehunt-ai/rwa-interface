import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/self_custodial_withdrawal.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';

import '../../../../helpers/funding_execution_fixture.dart';

void main() {
  for (final canPayGas in [false, true, null]) {
    test('native gas gate $canPayGas never restores a client publisher', () async {
      final executions = RecordingFundingExecutions(
        created: fundingExecution(),
        createFailure: StateError('backend execution unavailable'),
      );
      final signer = RecordingFundingSigner(executions.events);
      final container = ProviderContainer(overrides: [
        walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        walletAuthorizationSignerProvider.overrideWithValue(signer),
      ]);
      addTearDown(container.dispose);
      await expectLater(
        container.read(selfCustodialWithdrawalCommandsProvider).executeUserPaid(
          quote: _quote,
          prepared: _prepared(canPayGas: canPayGas),
        ),
        canPayGas == false ? throwsA(isA<InsufficientWithdrawalGas>()) : throwsStateError,
      );
      expect(executions.events, canPayGas == false ? isEmpty : ['create']);
      expect(signer.requests, isEmpty);
      expect(executions.hashes, isEmpty);
    });
  }
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

PreparedSelfCustodialWithdrawal _prepared({bool? canPayGas}) =>
    PreparedSelfCustodialWithdrawal(
      withdrawalId: 'withdrawal-1',
      sourceWalletId: 'wallet-1',
      assetId: 'eip155:56/erc20:0xusdc',
      assetSymbol: 'USDC',
      chain: 'BSC',
      amount: DecimalValue('25.000001', asset: 'USDC', unit: 'token'),
      destinationAddress: '0x1111111111111111111111111111111111111111',
      transaction: SelfCustodialWithdrawalTransaction(
        chainId: 56,
        from: '0x2222222222222222222222222222222222222222',
        to: '0x3333333333333333333333333333333333333333',
        data: '0xa9059cbb',
        value: '0x0',
        payloadHash: '0xpayload',
        validUntil: DateTime.utc(2030),
      ),
      status: SelfCustodialWithdrawalState.awaitingSubmission,
      gas: canPayGas == null
          ? null
          : SelfCustodialWithdrawalGasEstimate(
              nativeAsset: 'BNB',
              gasUnits: '65000',
              gasPriceWei: DecimalValue(
                '1000000000',
                asset: 'BNB',
                unit: 'wei',
              ),
              estimatedNativeFee: DecimalValue(
                '0.000065',
                asset: 'BNB',
                unit: 'token',
              ),
              walletNativeBalance: DecimalValue(
                '0.00001',
                asset: 'BNB',
                unit: 'token',
              ),
              canPayGas: canPayGas,
              observedAt: DateTime.utc(2026),
            ),
    );
