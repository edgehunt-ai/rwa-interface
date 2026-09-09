import 'authentication.dart';

abstract interface class WalletConnection {
  String get address;

  String get chainId;

  String get connectorType;

  Future<String> signPersonalMessage(String message);

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

  Future<IdentityPrincipal> loginWithOAuth(String provider);

  Future<IdentityPrincipal> loginWithPasskey();

  Future<IdentityPrincipal> loginWithWallet(WalletConnection connection);

  Future<String?> getAccessToken();

  Future<String?> refreshAccessToken();

  Future<void> logout();
}
