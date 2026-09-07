import 'authentication.dart';

abstract interface class IdentityAuthGateway {
  bool get isSupported;

  Future<IdentityPrincipal?> initialize(IdentityConfiguration configuration);

  Future<void> requestEmailCode(String email);

  Future<IdentityPrincipal> verifyEmailCode({
    required String email,
    required String code,
  });

  Future<String?> getAccessToken();

  Future<String?> refreshAccessToken();

  Future<void> logout();
}
