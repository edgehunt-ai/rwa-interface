import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';

final class FakeIdentityAuthGateway implements IdentityAuthGateway {
  FakeIdentityAuthGateway({
    this.supported = true,
    this.restoredPrincipal,
    this.verifiedPrincipal = const IdentityPrincipal('privy-user'),
    this.token = 'access-token',
  });

  final bool supported;
  IdentityPrincipal? restoredPrincipal;
  IdentityPrincipal verifiedPrincipal;
  String? token;
  IdentityFailure? initializeFailure;
  IdentityFailure? sendFailure;
  IdentityFailure? verifyFailure;
  IdentityFailure? logoutFailure;
  Future<void>? initializeBarrier;
  IdentityConfiguration? configuration;
  String? requestedEmail;
  String? verifiedEmail;
  String? verifiedCode;
  int refreshCalls = 0;
  int logoutCalls = 0;

  @override
  bool get isSupported => supported;

  @override
  Future<String?> getAccessToken() async => token;

  @override
  Future<IdentityPrincipal?> initialize(
    IdentityConfiguration configuration,
  ) async {
    this.configuration = configuration;
    await initializeBarrier;
    if (initializeFailure case final failure?) throw failure;
    return restoredPrincipal;
  }

  @override
  Future<void> logout() async {
    logoutCalls++;
    token = null;
    if (logoutFailure case final failure?) throw failure;
  }

  @override
  Future<String?> refreshAccessToken() async {
    refreshCalls++;
    return token;
  }

  @override
  Future<void> requestEmailCode(String email) async {
    requestedEmail = email;
    if (sendFailure case final failure?) throw failure;
  }

  @override
  Future<IdentityPrincipal> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    verifiedEmail = email;
    verifiedCode = code;
    if (verifyFailure case final failure?) throw failure;
    return verifiedPrincipal;
  }
}
