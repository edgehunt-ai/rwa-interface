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

  /// The sponsored path upgrades the wallet into a smart contract account via
  /// EIP-7702. [eip7702Notice] is the disclosure that must reach the user
  /// before any authorization is signed.
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
  });

  final String from;
  final String to;
  final String data;
  final String value;
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
  });

  final String executionId;
  final String resourceId;
  final int chainId;
  final String walletAddress;
  final GasPaymentMode mode;
  final WalletActionExecutionState status;
  final GasPaymentQuote gasPayment;
  final FrozenTransaction transaction;

  /// Non-null only while an app-sponsored execution awaits the user signature.
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
  });

  final String to;
  final String data;
  final String value;
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

/// The user declined the EIP-7702 wallet upgrade the sponsored path requires.
final class WalletUpgradeDeclined implements Exception {
  const WalletUpgradeDeclined();
}
