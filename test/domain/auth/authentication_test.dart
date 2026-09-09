import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/auth/identity_auth_gateway_factory.dart';
import 'package:rwa_interface/data/auth/unsupported_identity_auth_gateway.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';

void main() {
  test('web and desktop select deterministic unsupported gateway', () {
    expect(
      createIdentityAuthGateway(isWeb: true),
      isA<UnsupportedIdentityAuthGateway>(),
    );
    expect(
      const AuthenticationUnsupported().failure.code,
      AuthenticationFailureCode.unsupportedPlatform,
    );
  });

  test(
    'unsupported gateway does not throw for token lookup or logout',
    () async {
      const gateway = UnsupportedIdentityAuthGateway();
      expect(await gateway.getAccessToken(), isNull);
      expect(await gateway.refreshAccessToken(), isNull);
      await gateway.logout();
    },
  );
}
