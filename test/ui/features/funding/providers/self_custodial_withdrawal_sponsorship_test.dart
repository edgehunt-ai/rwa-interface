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
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/wallet_action_execution_repository.dart';
import 'package:rwa_interface/domain/services/embedded_wallet_transaction_sender.dart';
import 'package:rwa_interface/domain/services/wallet_authorization_signer.dart';
import 'package:rwa_interface/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';

void main() {
  ProviderContainer container({
    required _Executions executions,
    required _Sender sender,
    _Signer? signer,
  }) {
    final result = ProviderContainer(
      overrides: [
        identityAuthGatewayProvider.overrideWithValue(sender),
        walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        walletAuthorizationSignerProvider.overrideWithValue(
          signer ?? _Signer(),
        ),
        fundingRepositoryProvider.overrideWithValue(_Funding()),
      ],
    );
    addTearDown(result.dispose);
    return result;
  }

  test('platform-sponsored withdrawal signs the server request only', () async {
    final signer = _Signer();
    final executions = _Executions(create: _sponsored());
    final sender = _Sender();
    final commands = container(
      executions: executions,
      sender: sender,
      signer: signer,
    ).read(selfCustodialWithdrawalCommandsProvider);

    final summary = await commands.execute(
      quote: _quote,
      prepared: _prepared(canPayGas: false),
      confirmWalletUpgrade: (_) async => true,
    );

    expect(summary.withdrawalId, 'withdrawal-1');
    expect(executions.createdModes, [GasPaymentMode.appSponsored]);
    expect(executions.submittedSignatures, ['0xauthorization']);
    expect(signer.requests.single.referenceId, 'execution-1');
    expect(signer.signers.single, _from);
    // The platform pays and broadcasts: an empty native balance is no longer a
    // reason to refuse, and the wallet never signs a transaction.
    expect(sender.calls, 0);
    expect(executions.submittedHashes, isEmpty);
  });

  test('a declined wallet upgrade signs nothing', () async {
    final signer = _Signer();
    final executions = _Executions(create: _sponsored());
    final sender = _Sender();
    final commands = container(
      executions: executions,
      sender: sender,
      signer: signer,
    ).read(selfCustodialWithdrawalCommandsProvider);

    await expectLater(
      commands.execute(
        quote: _quote,
        prepared: _prepared(canPayGas: true),
        confirmWalletUpgrade: (_) async => false,
      ),
      throwsA(isA<WalletUpgradeDeclined>()),
    );
    expect(signer.requests, isEmpty);
    expect(executions.submittedSignatures, isEmpty);
    expect(sender.calls, 0);
  });

  test(
    'an authorization that drifts from the frozen call is refused',
    () async {
      final signer = _Signer();
      final executions = _Executions(
        create: _sponsored(
          authorizedTo: '0x9999999999999999999999999999999999999999',
        ),
      );
      final sender = _Sender();
      final commands = container(
        executions: executions,
        sender: sender,
        signer: signer,
      ).read(selfCustodialWithdrawalCommandsProvider);

      await expectLater(
        commands.execute(
          quote: _quote,
          prepared: _prepared(canPayGas: true),
          confirmWalletUpgrade: (_) async => true,
        ),
        throwsA(isA<StateError>()),
      );
      expect(signer.requests, isEmpty);
      expect(executions.submittedSignatures, isEmpty);
    },
  );

  test('an expired authorization window is refused', () async {
    final signer = _Signer();
    final executions = _Executions(
      create: _sponsored(expiresAt: DateTime.utc(2020)),
    );
    final commands = container(
      executions: executions,
      sender: _Sender(),
      signer: signer,
    ).read(selfCustodialWithdrawalCommandsProvider);

    await expectLater(
      commands.execute(
        quote: _quote,
        prepared: _prepared(canPayGas: true),
        confirmWalletUpgrade: (_) async => true,
      ),
      throwsA(isA<StateError>()),
    );
    expect(signer.requests, isEmpty);
  });

  test('a refused sponsorship surfaces instead of paying silently', () async {
    final executions = _Executions(create: _refused());
    final sender = _Sender();
    final commands = container(
      executions: executions,
      sender: sender,
    ).read(selfCustodialWithdrawalCommandsProvider);

    await expectLater(
      commands.execute(
        quote: _quote,
        prepared: _prepared(canPayGas: true),
        confirmWalletUpgrade: (_) async => true,
      ),
      throwsA(
        isA<SponsoredGasUnavailable>()
            .having((f) => f.executionId, 'executionId', 'execution-1')
            .having((f) => f.fallbackAllowed, 'fallbackAllowed', isTrue),
      ),
    );
    expect(sender.calls, 0);
    expect(executions.submittedHashes, isEmpty);
  });

  test('the user-paid fallback still gates on the observed gas', () async {
    final executions = _Executions(create: _userPaid());
    final sender = _Sender();
    final commands = container(
      executions: executions,
      sender: sender,
    ).read(selfCustodialWithdrawalCommandsProvider);

    await expectLater(
      commands.executeUserPaid(
        quote: _quote,
        prepared: _prepared(canPayGas: false),
      ),
      throwsA(isA<InsufficientWithdrawalGas>()),
    );
    expect(sender.calls, 0);
    expect(executions.createdModes, isEmpty);
  });

  test('the user-paid fallback reports its hash to the execution', () async {
    final executions = _Executions(create: _userPaid());
    final sender = _Sender();
    final commands = container(
      executions: executions,
      sender: sender,
    ).read(selfCustodialWithdrawalCommandsProvider);

    final summary = await commands.executeUserPaid(
      quote: _quote,
      prepared: _prepared(canPayGas: true),
    );

    expect(summary.withdrawalId, 'withdrawal-1');
    expect(executions.createdModes, [GasPaymentMode.userPaidNative]);
    expect(sender.calls, 1);
    expect(executions.submittedHashes, ['0xtx']);
    expect(executions.submittedSignatures, isEmpty);
  });

  test(
    'an intent the server binds no execution to keeps the direct path',
    () async {
      final executions = _Executions(
        createFailure: const ServerFailure(
          statusCode: 422,
          code: 'sponsorship_unavailable',
        ),
      );
      final sender = _Sender();
      final funding = _Funding();
      final result = ProviderContainer(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(sender),
          walletActionExecutionRepositoryProvider.overrideWithValue(executions),
          walletAuthorizationSignerProvider.overrideWithValue(_Signer()),
          fundingRepositoryProvider.overrideWithValue(funding),
        ],
      );
      addTearDown(result.dispose);

      final summary = await result
          .read(selfCustodialWithdrawalCommandsProvider)
          .execute(
            quote: _quote,
            prepared: _prepared(canPayGas: true),
            confirmWalletUpgrade: (_) async => true,
          );

      expect(summary.withdrawalId, 'withdrawal-1');
      expect(sender.calls, 1);
      expect(funding.submittedHashes, ['0xtx']);
      expect(executions.submittedHashes, isEmpty);
    },
  );

  test('re-preparing an intent never reuses the previous key', () async {
    final executions = _Executions(
      buildCreate: (withdrawalId) => _sponsored(withdrawalId: withdrawalId),
    );
    final commands = container(
      executions: executions,
      sender: _Sender(),
    ).read(selfCustodialWithdrawalCommandsProvider);

    await commands.execute(
      quote: _quote,
      prepared: _prepared(canPayGas: true),
      confirmWalletUpgrade: (_) async => true,
    );
    await commands.execute(
      quote: _quote,
      prepared: _prepared(canPayGas: true, withdrawalId: 'withdrawal-2'),
      confirmWalletUpgrade: (_) async => true,
    );

    // The server rejects a key reused against a different withdrawal.
    expect(executions.createKeys, hasLength(2));
    expect(executions.createKeys.first, isNot(executions.createKeys.last));
  });

  test('a conflicting execution never broadcasts behind the server', () async {
    final executions = _Executions(
      createFailure: const ServerFailure(
        statusCode: 409,
        code: 'execution_already_bound',
      ),
    );
    final sender = _Sender();
    final funding = _Funding();
    final result = ProviderContainer(
      overrides: [
        identityAuthGatewayProvider.overrideWithValue(sender),
        walletActionExecutionRepositoryProvider.overrideWithValue(executions),
        walletAuthorizationSignerProvider.overrideWithValue(_Signer()),
        fundingRepositoryProvider.overrideWithValue(funding),
      ],
    );
    addTearDown(result.dispose);

    await expectLater(
      result
          .read(selfCustodialWithdrawalCommandsProvider)
          .execute(
            quote: _quote,
            prepared: _prepared(canPayGas: true),
            confirmWalletUpgrade: (_) async => true,
          ),
      throwsA(isA<ServerFailure>()),
    );
    // The intent already has an execution bound, so the direct path would be
    // rejected after the transaction had already reached the chain.
    expect(sender.calls, 0);
    expect(funding.submittedHashes, isEmpty);
  });
}

const _from = '0x2222222222222222222222222222222222222222';
const _to = '0x3333333333333333333333333333333333333333';
const _data = '0xa9059cbb';

WalletActionExecution _sponsored({
  String? authorizedTo,
  DateTime? expiresAt,
  String withdrawalId = 'withdrawal-1',
}) {
  final to = authorizedTo ?? _to;
  return WalletActionExecution(
    executionId: 'execution-1',
    resourceId: withdrawalId,
    chainId: 56,
    walletAddress: _from,
    mode: GasPaymentMode.appSponsored,
    status: WalletActionExecutionState.awaitingUserAuthorization,
    gasPayment: _gasQuote(GasSponsorshipDecision.eligible, platformPays: true),
    transaction: const FrozenTransaction(to: _to, data: _data, value: '0x0'),
    authorization: WalletAuthorizationRequest(
      version: 1,
      method: 'POST',
      url: 'https://api.privy.io/v1/wallets/wallet-1/rpc',
      headers: const {'privy-app-id': 'app'},
      body: const {'method': 'eth_sendTransaction'},
      referenceId: 'execution-1',
      sponsor: true,
      caip2: 'eip155:56',
      transaction: AuthorizedTransaction(
        from: _from,
        to: to,
        data: _data,
        value: '0x0',
      ),
    ),
    authorizationExpiresAt:
        expiresAt ?? DateTime.now().toUtc().add(const Duration(seconds: 45)),
  );
}

WalletActionExecution _refused() => WalletActionExecution(
  executionId: 'execution-1',
  resourceId: 'withdrawal-1',
  chainId: 56,
  walletAddress: _from,
  mode: GasPaymentMode.appSponsored,
  status: WalletActionExecutionState.userGasConfirmationRequired,
  gasPayment: _gasQuote(
    GasSponsorshipDecision.userGasConfirmationRequired,
    platformPays: false,
  ),
  transaction: const FrozenTransaction(to: _to, data: _data, value: '0x0'),
);

WalletActionExecution _userPaid() => WalletActionExecution(
  executionId: 'execution-2',
  resourceId: 'withdrawal-1',
  chainId: 56,
  walletAddress: _from,
  mode: GasPaymentMode.userPaidNative,
  status: WalletActionExecutionState.awaitingUserAuthorization,
  gasPayment: _gasQuote(
    GasSponsorshipDecision.userGasConfirmationRequired,
    platformPays: false,
  ),
  transaction: const FrozenTransaction(to: _to, data: _data, value: '0x0'),
);

GasPaymentQuote _gasQuote(
  GasSponsorshipDecision decision, {
  required bool platformPays,
}) => GasPaymentQuote(
  mode: platformPays
      ? GasPaymentMode.appSponsored
      : GasPaymentMode.userPaidNative,
  decision: decision,
  platformPays: platformPays,
  nativeAsset: 'BNB',
  estimatedNativeFee: DecimalValue('0.000065', asset: 'BNB', unit: 'token'),
  estimatedFeeUsd: DecimalValue('0.05', asset: 'USD', unit: 'usd'),
  fallbackAllowed: true,
  eip7702Required: true,
  eip7702Notice: 'Your wallet will be upgraded.',
);

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
  bool? canPayGas,
  String withdrawalId = 'withdrawal-1',
}) => PreparedSelfCustodialWithdrawal(
  withdrawalId: withdrawalId,
  sourceWalletId: 'wallet-1',
  assetId: 'eip155:56/erc20:0xusdc',
  assetSymbol: 'USDC',
  chain: 'BSC',
  amount: DecimalValue('25.000001', asset: 'USDC', unit: 'token'),
  destinationAddress: '0x1111111111111111111111111111111111111111',
  transaction: SelfCustodialWithdrawalTransaction(
    chainId: 56,
    from: _from,
    to: _to,
    data: _data,
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
          gasPriceWei: DecimalValue('1000000000', asset: 'BNB', unit: 'wei'),
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

final class _Executions implements WalletActionExecutionRepository {
  _Executions({this.create, this.buildCreate, this.createFailure});

  final WalletActionExecution? create;
  final WalletActionExecution Function(String withdrawalId)? buildCreate;
  final ApiFailure? createFailure;
  final List<GasPaymentMode> createdModes = [];
  final List<String> createKeys = [];
  final List<String> submittedSignatures = [];
  final List<String> submittedHashes = [];

  @override
  Future<WalletActionExecution> createSelfCustodialWithdrawalExecution({
    required String withdrawalId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async {
    final failure = createFailure;
    if (failure != null) throw failure;
    createdModes.add(mode);
    createKeys.add(idempotencyKey);
    return buildCreate?.call(withdrawalId) ?? create!;
  }

  WalletActionExecution _result() => create ?? buildCreate!('withdrawal-1');

  @override
  Future<WalletActionExecution> submitAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  }) async {
    submittedSignatures.add(signature);
    return _result();
  }

  @override
  Future<WalletActionExecution> submitTransactionHash({
    required String executionId,
    required String txHash,
    required String idempotencyKey,
  }) async {
    submittedHashes.add(txHash);
    return _result();
  }
}

final class _Signer implements WalletAuthorizationSigner {
  final List<WalletAuthorizationRequest> requests = [];
  final List<String> signers = [];

  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) async {
    signers.add(expectedSigner);
    requests.add(request);
    return '0xauthorization';
  }
}

final class _Sender
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

final class _Funding implements FundingRepository {
  final List<String> submittedHashes = [];

  @override
  Future<SelfCustodialWithdrawalSummary> getSelfCustodialWithdrawal(
    String id,
  ) async => _summary(id);

  @override
  Future<SelfCustodialWithdrawalSummary> submitSelfCustodialWithdrawal({
    required String id,
    required String txHash,
    required String idempotencyKey,
  }) async {
    submittedHashes.add(txHash);
    return _summary(id);
  }

  SelfCustodialWithdrawalSummary _summary(String id) =>
      SelfCustodialWithdrawalSummary(
        withdrawalId: id,
        assetSymbol: 'USDC',
        amount: DecimalValue('25.000001', asset: 'USDC', unit: 'token'),
        destinationAddress: '0x1111111111111111111111111111111111111111',
        status: SelfCustodialWithdrawalState.submitted,
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
