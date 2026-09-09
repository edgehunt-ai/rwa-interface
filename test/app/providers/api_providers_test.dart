import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/data/api/api_environment.dart';

import '../../helpers/fake_identity_auth_gateway.dart';

void main() {
  test('environment 可 override 且 provider 惰性创建', () {
    var reads = 0;
    final container = ProviderContainer(
      overrides: [
        apiEnvironmentProvider.overrideWith((ref) {
          reads++;
          return const ApiEnvironment(baseUrl: 'https://fixture.example');
        }),
      ],
    );
    addTearDown(container.dispose);
    expect(reads, 0);
    expect(
      container.read(apiEnvironmentProvider).baseUrl,
      'https://fixture.example',
    );
    expect(reads, 1);
  });

  test(
    'production token boundary delegates to identity gateway and expires scope',
    () async {
      final gateway = FakeIdentityAuthGateway(token: 'privy-token');
      final container = ProviderContainer(
        overrides: [identityAuthGatewayProvider.overrideWithValue(gateway)],
      );
      addTearDown(container.dispose);
      final provider = container.read(privyAccessTokenProvider);

      expect(await provider.getAccessToken(), 'privy-token');
      expect(await provider.refreshAccessToken(), 'privy-token');
      expect(gateway.refreshCalls, 1);
      expect(container.read(sessionGenerationProvider).value, 0);

      await provider.onAuthenticationExpired();

      expect(gateway.logoutCalls, 1);
      expect(container.read(sessionGenerationProvider).value, 1);
      expect(await provider.getAccessToken(), isNull);
    },
  );
}
