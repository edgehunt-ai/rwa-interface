import 'decimal_value.dart';

enum GasPaymentMode { appSponsored, userPaidNative }

enum GasSponsorshipDecision {
  eligible,
  userGasConfirmationRequired,
  unavailable,
  limitExceeded,
  circuitOpen,
  providerRejected,
  providerAmbiguous,
  unknown,
}

enum WalletActionExecutionState {
  awaitingUserAuthorization,
  submitting,
  providerSubmitted,
  chainConfirmed,
  completed,
  userGasConfirmationRequired,
  failed,
  ambiguous,
  manualReview,
  unknown,
}

/// Server-authoritative gas decision for one execution.
final class GasPaymentQuote {
  const GasPaymentQuote({
    required this.mode,
    required this.decision,
    required this.platformPays,
    required this.nativeAsset,
    required this.estimatedNativeFee,
    required this.estimatedFeeUsd,
    required this.fallbackAllowed,
    required this.eip7702Required,
    this.walletNativeBalance,
    this.eip7702Notice,
  });

  final GasPaymentMode mode;
  final GasSponsorshipDecision decision;
  final bool platformPays;
  final String nativeAsset;
  final DecimalValue estimatedNativeFee;
  final DecimalValue estimatedFeeUsd;
  final DecimalValue? walletNativeBalance;

  /// Policy permits falling back to a user-paid execution. Only meaningful
  /// after a rejection proven to have happened before any broadcast.
  final bool fallbackAllowed;

  /// Whether the sponsored path uses EIP-7702 wallet delegation. The server's
  /// optional [eip7702Notice] remains available as execution metadata.
  final bool eip7702Required;
  final String? eip7702Notice;

  bool get isSponsorshipEligible =>
      decision == GasSponsorshipDecision.eligible && platformPays;
}

/// The exact Privy wallet-API request the server needs authorized.
///
/// The app signs it verbatim: it never rewrites, reorders or supplements the
/// fields. [transaction] mirrors the call the signature commits to, so the
/// client can check it against the frozen withdrawal before signing.
final class WalletAuthorizationRequest {
  const WalletAuthorizationRequest({
    required this.version,
    required this.method,
    required this.url,
    required this.headers,
    required this.body,
    required this.referenceId,
    required this.sponsor,
    required this.caip2,
    required this.transaction,
  });

  final int version;
  final String method;
  final String url;
  final Map<String, String> headers;
  final Map<String, Object?> body;
  final String referenceId;
  final bool sponsor;
  final String caip2;
  final AuthorizedTransaction transaction;
}

final class AuthorizedTransaction {
  const AuthorizedTransaction({
    required this.from,
    required this.to,
    required this.data,
    required this.value,
    this.nonce,
  });

  final String from;
  final String to;
  final String data;
  final String value;
  final String? nonce;
}

/// One server-owned execution of a frozen business action.
final class WalletActionExecution {
  const WalletActionExecution({
    required this.executionId,
    required this.resourceId,
    required this.chainId,
    required this.walletAddress,
    required this.mode,
    required this.status,
    required this.gasPayment,
    required this.transaction,
    this.authorization,
    this.authorizationExpiresAt,
    this.txHash,
    this.failureReason,
    this.executionProvider,
    this.nativeNonce,
    this.nativeDeliveryState,
    this.nativeCancellation,
    this.chainObservation,
  });

  final String executionId;
  final String resourceId;
  final int chainId;
  final String walletAddress;
  final GasPaymentMode mode;
  final WalletActionExecutionState status;
  final GasPaymentQuote gasPayment;
  final FrozenTransaction transaction;
  final String? executionProvider;
  final String? nativeNonce;
  final String? nativeDeliveryState;
  final NativeCancellation? nativeCancellation;
  final WalletChainObservation? chainObservation;

  /// Present only while the backend publisher awaits the user signature.
  final WalletAuthorizationRequest? authorization;
  final DateTime? authorizationExpiresAt;
  final String? txHash;
  final String? failureReason;

  bool get awaitsAuthorization =>
      status == WalletActionExecutionState.awaitingUserAuthorization &&
      authorization != null;

  /// Sponsorship was refused before any broadcast, so a user-paid execution
  /// may still be created for the same action.
  bool get requiresUserPaidFallback =>
      status == WalletActionExecutionState.userGasConfirmationRequired;
}

final class FrozenTransaction {
  const FrozenTransaction({
    required this.to,
    required this.data,
    required this.value,
    this.nonce,
  });

  final String to;
  final String data;
  final String value;
  final String? nonce;
}

/// Cancellation is separate from the original transaction, never business success.
final class NativeCancellation {
  const NativeCancellation({
    required this.cancellationId,
    required this.nonce,
    required this.to,
    required this.status,
    this.authorization,
    this.authorizationExpiresAt,
    this.txHash,
    this.chainObservation,
  });

  final String cancellationId;
  final String nonce;
  final String to;
  final String status;
  final WalletAuthorizationRequest? authorization;
  final DateTime? authorizationExpiresAt;
  final String? txHash;
  final WalletChainObservation? chainObservation;
}

final class WalletChainObservation {
  const WalletChainObservation({
    required this.txHash,
    required this.sender,
    required this.recipient,
    required this.payloadHash,
    required this.value,
    required this.receiptSuccess,
    required this.canonical,
    required this.blockNumber,
    required this.blockHash,
    required this.confirmations,
    required this.observedAt,
  });

  final String txHash;
  final String sender;
  final String recipient;
  final String payloadHash;
  final String value;
  final bool receiptSuccess;
  final bool canonical;
  final int blockNumber;
  final String blockHash;
  final int confirmations;
  final DateTime observedAt;
}

/// Sponsorship was refused before any broadcast. The user may still pay gas
/// themselves, but only after confirming it explicitly.
final class SponsoredGasUnavailable implements Exception {
  const SponsoredGasUnavailable({
    required this.executionId,
    required this.gasPayment,
  });

  final String executionId;
  final GasPaymentQuote gasPayment;

  bool get fallbackAllowed => gasPayment.fallbackAllowed;
}
