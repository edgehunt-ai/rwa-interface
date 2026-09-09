import 'authentication.dart';

abstract interface class WalletConnection {
  String get address;

  String get chainId;

  String get connectorType;

  Future<String> signPersonalMessage(String message);

  Future<String> signTypedDataV4(Map<String, Object?> typedData);

  Future<void> disconnect();
}

abstract interface class IdentityAuthGateway {
  bool get isSupported;

  Future<IdentityPrincipal?> initialize(IdentityConfiguration configuration);

  Future<void> requestEmailCode(String email);

  Future<IdentityPrincipal> verifyEmailCode({
    required String email,
    required String code,
  });

  /// Opens the provider-owned login experience when it is available.
  ///
  /// Browser clients use this instead of reproducing Privy's login methods in
  /// Flutter. Native clients retain their method-specific flows below.
  Future<IdentityPrincipal> login();

  Future<IdentityPrincipal> loginWithOAuth(String provider);

  Future<IdentityPrincipal> loginWithPasskey();

  Future<PasskeyCredential?> getPasskey();

  Future<PasskeyCredential> linkPasskey({String? displayName});

  Future<void> unlinkPasskey(String credentialId);

  Future<IdentityPrincipal> loginWithWallet(WalletConnection connection);

  Future<String?> getAccessToken();

  Future<String?> refreshAccessToken();

  Future<void> logout();
}

final class PasskeyCredential {
  const PasskeyCredential({required this.id, this.authenticatorName});

  final String id;
  final String? authenticatorName;
}
