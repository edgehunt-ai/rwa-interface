import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/self_custodial_withdrawal.dart';
import 'package:rwa_interface/domain/models/wallet_action_execution.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/wallet_action_execution_repository.dart';
import 'package:rwa_interface/domain/services/embedded_wallet_transaction_sender.dart';
import 'package:rwa_interface/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';

void main() {
  // The server binds no execution here, so these cases exercise the direct
  // path where the user both pays gas and broadcasts.
  test(
    'a wallet that cannot pay the observed gas never reaches the signer',
    () async {
      final sender = _RecordingSender();
      final container = ProviderContainer(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(sender),
          walletActionExecutionRepositoryProvider.overrideWithValue(
            _UnboundExecutions(),
          ),
        ],
      );
      addTearDown(container.dispose);

      await expectLater(
        container
            .read(selfCustodialWithdrawalCommandsProvider)
            .execute(
              quote: _quote,
              prepared: _prepared(canPayGas: false),
              confirmWalletUpgrade: (_) async => true,
            ),
        throwsA(isA<InsufficientWithdrawalGas>()),
      );
      expect(sender.calls, 0);
    },
  );

  test('an affordable estimate is allowed through to the signer', () async {
    final sender = _RecordingSender();
    final container = ProviderContainer(
      overrides: [
        identityAuthGatewayProvider.overrideWithValue(sender),
        walletActionExecutionRepositoryProvider.overrideWithValue(
          _UnboundExecutions(),
        ),
      ],
    );
    addTearDown(container.dispose);

    // Submission is unwired, so the call still fails — but only after the gate
    // released it and the wallet was asked to sign exactly once.
    await expectLater(
      container
          .read(selfCustodialWithdrawalCommandsProvider)
          .execute(
            quote: _quote,
            prepared: _prepared(canPayGas: true),
            confirmWalletUpgrade: (_) async => true,
          ),
      throwsA(anything),
    );
    expect(sender.calls, 1);
  });

  test('an absent estimate does not block the signer', () async {
    final sender = _RecordingSender();
    final container = ProviderContainer(
      overrides: [
        identityAuthGatewayProvider.overrideWithValue(sender),
        walletActionExecutionRepositoryProvider.overrideWithValue(
          _UnboundExecutions(),
        ),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container
          .read(selfCustodialWithdrawalCommandsProvider)
          .execute(
            quote: _quote,
            prepared: _prepared(),
            confirmWalletUpgrade: (_) async => true,
          ),
      throwsA(anything),
    );
    expect(sender.calls, 1);
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
        validUntil: DateTime.utc(2026),
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

final class _RecordingSender
    implements IdentityAuthGateway, EmbeddedWalletTransactionSender {
  int calls = 0;

  @override
  Future<String> sendTransaction({
    required String expectedSigner,
    required int chainId,
    required String to,
    required String data,
    required String value,
  }) async {
    calls++;
    return '0xtx';
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Sponsorship is not available for this intent, leaving the direct path.
final class _UnboundExecutions implements WalletActionExecutionRepository {
  @override
  Future<WalletActionExecution> createSelfCustodialWithdrawalExecution({
    required String withdrawalId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async => throw const ServerFailure(
    statusCode: 422,
    code: 'sponsorship_unavailable',
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
