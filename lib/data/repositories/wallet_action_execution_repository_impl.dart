import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/wallet_action_execution.dart';
import '../../domain/repositories/wallet_action_execution_repository.dart';
import '../services/wallet_action_execution_service.dart';

final class WalletActionExecutionRepositoryImpl
    implements WalletActionExecutionRepository {
  const WalletActionExecutionRepositoryImpl(this._service);

  final WalletActionExecutionService _service;

  @override
  Future<WalletActionExecution> createOrderWalletActionExecution({
    required String orderId,
    required String stepId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async => _execution(
    await _service.createOrderExecution(
      orderId,
      stepId,
      api.WalletActionExecutionCreateRequest(
        (request) => request
          ..mode = switch (mode) {
            GasPaymentMode.appSponsored => api.GasPaymentMode.appSponsored,
            GasPaymentMode.userPaidNative => api.GasPaymentMode.userPaidNative,
          },
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<WalletActionExecution> createSelfCustodialWithdrawalExecution({
    required String withdrawalId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  }) async => _execution(
    await _service.createSelfCustodialWithdrawalExecution(
      withdrawalId,
      api.WalletActionExecutionCreateRequest(
        (request) => request
          ..mode = switch (mode) {
            GasPaymentMode.appSponsored => api.GasPaymentMode.appSponsored,
            GasPaymentMode.userPaidNative => api.GasPaymentMode.userPaidNative,
          },
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<WalletActionExecution> submitAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  }) async => _execution(
    await _service.submitExecution(
      executionId,
      api.WalletActionExecutionSubmissionRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [api.SponsoredWalletActionExecutionSubmissionRequest],
          value: api.SponsoredWalletActionExecutionSubmissionRequest(
            (submission) => submission.privyAuthorizationSignature = signature,
          ),
        ),
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<WalletActionExecution> submitTransactionHash({
    required String executionId,
    required String txHash,
    required String idempotencyKey,
  }) async => _execution(
    await _service.submitExecution(
      executionId,
      api.WalletActionExecutionSubmissionRequest(
        (request) => request.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [api.UserPaidWalletActionExecutionSubmissionRequest],
          value: api.UserPaidWalletActionExecutionSubmissionRequest(
            (submission) => submission.txHash = txHash,
          ),
        ),
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  WalletActionExecution _execution(api.WalletActionExecution value) =>
      WalletActionExecution(
        executionId: value.executionId,
        resourceId: value.resourceId,
        chainId: _chainId(value.chainId),
        walletAddress: value.walletAddress,
        mode: _mode(value.mode),
        status: switch (value.status) {
          api.WalletActionExecutionStatus.awaitingUserAuthorization =>
            WalletActionExecutionState.awaitingUserAuthorization,
          api.WalletActionExecutionStatus.submitting =>
            WalletActionExecutionState.submitting,
          api.WalletActionExecutionStatus.providerSubmitted =>
            WalletActionExecutionState.providerSubmitted,
          api.WalletActionExecutionStatus.chainConfirmed =>
            WalletActionExecutionState.chainConfirmed,
          api.WalletActionExecutionStatus.completed =>
            WalletActionExecutionState.completed,
          api.WalletActionExecutionStatus.userGasConfirmationRequired =>
            WalletActionExecutionState.userGasConfirmationRequired,
          api.WalletActionExecutionStatus.failed =>
            WalletActionExecutionState.failed,
          api.WalletActionExecutionStatus.ambiguous =>
            WalletActionExecutionState.ambiguous,
          api.WalletActionExecutionStatus.manualReview =>
            WalletActionExecutionState.manualReview,
          _ => WalletActionExecutionState.unknown,
        },
        gasPayment: _gasPayment(value.gasPayment),
        transaction: FrozenTransaction(
          to: value.frozenTransaction.to,
          data: value.frozenTransaction.data,
          value: switch (value.frozenTransaction.value) {
            api.FrozenEvmTransactionValueEnum.n0x0 => '0x0',
            final other => other.name,
          },
        ),
        authorization: _authorization(value.privyAuthorizationPayload),
        authorizationExpiresAt: value.authorizationExpiresAt?.toUtc(),
        txHash: value.txHash,
        failureReason: value.failureReason,
      );

  GasPaymentMode _mode(api.GasPaymentMode value) => switch (value) {
    api.GasPaymentMode.userPaidNative => GasPaymentMode.userPaidNative,
    _ => GasPaymentMode.appSponsored,
  };

  GasPaymentQuote _gasPayment(api.GasPaymentQuote value) {
    final native = value.nativeAsset;
    return GasPaymentQuote(
      mode: _mode(value.mode),
      decision: switch (value.decision) {
        api.GasSponsorshipDecision.eligible => GasSponsorshipDecision.eligible,
        api.GasSponsorshipDecision.userGasConfirmationRequired =>
          GasSponsorshipDecision.userGasConfirmationRequired,
        api.GasSponsorshipDecision.unavailable =>
          GasSponsorshipDecision.unavailable,
        api.GasSponsorshipDecision.limitExceeded =>
          GasSponsorshipDecision.limitExceeded,
        api.GasSponsorshipDecision.circuitOpen =>
          GasSponsorshipDecision.circuitOpen,
        api.GasSponsorshipDecision.providerRejected =>
          GasSponsorshipDecision.providerRejected,
        api.GasSponsorshipDecision.providerAmbiguous =>
          GasSponsorshipDecision.providerAmbiguous,
        _ => GasSponsorshipDecision.unknown,
      },
      platformPays: value.platformPays,
      nativeAsset: native,
      estimatedNativeFee: DecimalValue(
        value.estimatedNativeFee,
        asset: native,
        unit: 'token',
      ),
      estimatedFeeUsd: DecimalValue(
        value.estimatedFeeUsd,
        asset: 'USD',
        unit: 'usd',
      ),
      walletNativeBalance: switch (value.walletNativeBalance) {
        final String balance => DecimalValue(
          balance,
          asset: native,
          unit: 'token',
        ),
        _ => null,
      },
      fallbackAllowed: value.fallbackAllowed,
      eip7702Required: value.eip7702Required,
      eip7702Notice: value.eip7702Notice,
    );
  }

  /// Rebuilds the request exactly as the server serialized it. The signature
  /// covers these bytes, so the payload is round-tripped through the generated
  /// serializers rather than reassembled field by field.
  WalletAuthorizationRequest? _authorization(
    api.PrivyAuthorizationPayload? value,
  ) {
    if (value == null) return null;
    final headers = _wireMap(
      api.standardSerializers.serializeWith(
        api.PrivyAuthorizationHeaders.serializer,
        value.headers,
      ),
    ).map((key, value) => MapEntry(key, '$value'));
    final body = _wireMap(
      api.standardSerializers.serializeWith(
        api.PrivyAuthorizationBody.serializer,
        value.body,
      ),
    );
    final transaction = value.body.params.transaction;
    return WalletAuthorizationRequest(
      version: switch (value.version) {
        api.PrivyAuthorizationPayloadVersionEnum.number1 => 1,
        _ => 0,
      },
      method: value.method.name.toUpperCase(),
      url: value.url,
      headers: headers,
      body: body,
      referenceId: value.body.referenceId,
      sponsor: value.body.sponsor,
      caip2: _caip2(value.body.caip2),
      transaction: AuthorizedTransaction(
        from: transaction.from,
        to: transaction.to,
        data: transaction.data,
        value: switch (transaction.value) {
          api.PrivyAuthorizationTransactionValueEnum.n0x0 => '0x0',
          final other => other.name,
        },
      ),
    );
  }

  Map<String, Object?> _wireMap(Object? serialized) {
    if (serialized is! Map) {
      throw StateError('Privy authorization payload is not a JSON object');
    }
    return serialized.map((key, value) => MapEntry('$key', value));
  }

  String _caip2(api.PrivyAuthorizationBodyCaip2Enum value) => switch (value) {
    api.PrivyAuthorizationBodyCaip2Enum.eip155Colon1 => 'eip155:1',
    api.PrivyAuthorizationBodyCaip2Enum.eip155Colon56 => 'eip155:56',
    api.PrivyAuthorizationBodyCaip2Enum.eip155Colon97 => 'eip155:97',
    api.PrivyAuthorizationBodyCaip2Enum.eip155Colon8453 => 'eip155:8453',
    api.PrivyAuthorizationBodyCaip2Enum.eip155Colon42161 => 'eip155:42161',
    _ => value.name,
  };

  int _chainId(api.WalletActionExecutionChainIdEnum value) => switch (value) {
    api.WalletActionExecutionChainIdEnum.number1 => 1,
    api.WalletActionExecutionChainIdEnum.number56 => 56,
    api.WalletActionExecutionChainIdEnum.number97 => 97,
    api.WalletActionExecutionChainIdEnum.number8453 => 8453,
    api.WalletActionExecutionChainIdEnum.number42161 => 42161,
    _ => -1,
  };
}
