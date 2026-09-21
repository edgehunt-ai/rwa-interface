import '../models/wallet_action_execution.dart';

enum WalletAuthorizationFailureCode {
  /// The request is malformed or does not match the action being authorized.
  invalidPayload,

  /// No usable provider session, or the wallet could not be reached.
  walletUnavailable,

  /// The wallet the request binds is not an embedded wallet of this user.
  walletMismatch,

  /// The signer cannot produce Privy authorization signatures, e.g. an
  /// external WalletConnect session.
  unsupportedWallet,

  /// The request expired before it could be signed; a fresh execution is
  /// required because the server caps the window at 60 seconds.
  expired,

  /// The provider refused to sign.
  rejected,
}

final class WalletAuthorizationFailure implements Exception {
  const WalletAuthorizationFailure(
    this.code, {
    this.retryable = false,
    this.reason,
  });

  final WalletAuthorizationFailureCode code;
  final bool retryable;

  /// Provider/SDK detail safe to show when authorization cannot be created.
  final String? reason;
}

/// Signs the server-issued Privy wallet-API request so the backend can relay it
/// for gas-sponsored execution.
///
/// The signature authorizes exactly one request: it carries that request's
/// frozen transaction, reference id and expiry. Implementations must never
/// persist or log it.
abstract interface class WalletAuthorizationSigner {
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  });
}
