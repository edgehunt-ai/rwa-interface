import '../../domain/auth/authentication.dart';
import '../../domain/auth/identity_auth_gateway.dart';

final class UnsupportedIdentityAuthGateway implements IdentityAuthGateway {
  const UnsupportedIdentityAuthGateway();

  @override
  bool get isSupported => false;

  IdentityFailure get _failure => const IdentityFailure(
    AuthenticationFailureCode.unsupportedPlatform,
    retryable: false,
  );

  @override
  Future<String?> getAccessToken() async => null;

  @override
  Future<IdentityPrincipal?> initialize(
    IdentityConfiguration configuration,
  ) async => throw _failure;

  @override
  Future<void> logout() async {}

  @override
  Future<String?> refreshAccessToken() async => null;

  @override
  Future<void> requestEmailCode(String email) async => throw _failure;

  @override
  Future<IdentityPrincipal> verifyEmailCode({
    required String email,
    required String code,
  }) async => throw _failure;
}
