import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/wallet_action_execution.dart';
import 'package:nobell/domain/repositories/wallet_action_execution_repository.dart';
import 'package:nobell/domain/services/wallet_authorization_signer.dart';

const fundingSigner = '0x2222222222222222222222222222222222222222';
const fundingTarget = '0x3333333333333333333333333333333333333333';
const fundingData = '0xa9059cbb';

WalletActionExecution fundingExecution({
  GasPaymentMode mode = GasPaymentMode.userPaidNative,
  WalletActionExecutionState status = WalletActionExecutionState.awaitingUserAuthorization,
  String resourceId = 'withdrawal-1',
  String executionId = 'execution-1',
  String provider = 'privy_native',
  String deliveryState = 'prepared',
  String nonce = '10',
  String authorizedNonce = '0xa',
  String? authorizedTo,
  String? rawTo,
  bool? sponsor,
  DateTime? expiresAt,
  bool includeAuthorization = true,
}) {
  final sponsored = mode == GasPaymentMode.appSponsored;
  final expiry = expiresAt ?? DateTime.now().toUtc().add(const Duration(seconds: 45));
  final to = authorizedTo ?? fundingTarget;
  return WalletActionExecution(
    executionId: executionId,
    resourceId: resourceId,
    chainId: 56,
    walletAddress: fundingSigner,
    mode: mode,
    status: status,
    executionProvider: sponsored ? 'privy' : provider,
    nativeNonce: sponsored ? null : nonce,
    nativeDeliveryState: sponsored ? null : deliveryState,
    gasPayment: GasPaymentQuote(
      mode: mode,
      decision: status == WalletActionExecutionState.userGasConfirmationRequired
          ? GasSponsorshipDecision.userGasConfirmationRequired
          : GasSponsorshipDecision.eligible,
      platformPays: sponsored && status != WalletActionExecutionState.userGasConfirmationRequired,
      nativeAsset: 'BNB',
      estimatedNativeFee: DecimalValue('0.000065'),
      estimatedFeeUsd: DecimalValue('0.05'),
      fallbackAllowed: true,
      eip7702Required: sponsored,
    ),
    transaction: FrozenTransaction(
      to: fundingTarget,
      data: fundingData,
      value: '0x0',
      nonce: sponsored ? null : nonce,
    ),
    authorization: !includeAuthorization ? null : WalletAuthorizationRequest(
      version: 1,
      method: 'POST',
      url: 'https://api.privy.io/v1/wallets/wallet-1/rpc',
      headers: {
        'privy-app-id': 'app',
        'privy-idempotency-key': executionId,
        'privy-request-expiry': '${expiry.millisecondsSinceEpoch}',
      },
      body: {
        'method': 'eth_sendTransaction',
        'chain_type': 'ethereum',
        'sponsor': sponsor ?? sponsored,
        'reference_id': executionId,
        'caip2': 'eip155:56',
        'params': {
          'transaction': {
            'from': fundingSigner,
            'to': rawTo ?? to,
            'data': fundingData,
            'value': '0x0',
            if (!sponsored) 'nonce': authorizedNonce,
          },
        },
      },
      referenceId: executionId,
      sponsor: sponsor ?? sponsored,
      caip2: 'eip155:56',
      transaction: AuthorizedTransaction(
        from: fundingSigner,
        to: to,
        data: fundingData,
        value: '0x0',
        nonce: sponsored ? null : authorizedNonce,
      ),
    ),
    authorizationExpiresAt: expiry,
  );
}

final class RecordingFundingExecutions implements WalletActionExecutionRepository {
  RecordingFundingExecutions({
    required this.created,
    this.current,
    this.createFailure,
    this.getFailure,
    this.submitFailure,
  });

  WalletActionExecution created;
  WalletActionExecution? current;
  Object? createFailure;
  Object? getFailure;
  Object? submitFailure;
  final modes = <GasPaymentMode>[];
  final createKeys = <String>[];
  final signatures = <String>[];
  final hashes = <String>[];
  final events = <String>[];
  final _snapshots = <String, WalletActionExecution>{};

  @override
  Future<WalletActionExecution> createSelfCustodialWithdrawalExecution({
    required String withdrawalId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async => _create(mode, idempotencyKey);

  @override
  Future<WalletActionExecution> createTransferWalletActionExecution({
    required String transferId,
    required String actionId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async => _create(mode, idempotencyKey);

  WalletActionExecution _create(GasPaymentMode mode, String key) {
    events.add('create');
    modes.add(mode);
    createKeys.add(key);
    if (createFailure case final failure?) throw failure;
    _snapshots[created.executionId] = created;
    return created;
  }

  @override
  Future<WalletActionExecution> get(String executionId) async {
    events.add('get');
    if (getFailure case final failure?) throw failure;
    return current ?? _snapshots[executionId] ?? created;
  }

  @override
  Future<WalletActionExecution> submitAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  }) async {
    events.add('submit');
    signatures.add(signature);
    if (submitFailure case final failure?) throw failure;
    return current ?? created;
  }

  @override
  Future<WalletActionExecution> submitTransactionHash({
    required String executionId,
    required String txHash,
    required String idempotencyKey,
  }) async {
    hashes.add(txHash);
    return current ?? created;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class RecordingFundingSigner implements WalletAuthorizationSigner {
  RecordingFundingSigner(this.events);
  final List<String> events;
  final requests = <WalletAuthorizationRequest>[];
  final signers = <String>[];

  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) async {
    events.add('sign');
    requests.add(request);
    signers.add(expectedSigner);
    return '0xauthorization';
  }
}
