import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/privy_configuration.dart';
import '../../data/api/privy_access_token_provider.dart';
import '../../data/auth/identity_auth_gateway_factory.dart';
import '../../domain/auth/identity_auth_gateway.dart';
import 'session_scope.dart';

final identityAuthGatewayProvider = Provider<IdentityAuthGateway>(
  (ref) => createIdentityAuthGateway(),
);

final privyConfigurationProvider = Provider<PrivyConfiguration>(
  (ref) => PrivyConfiguration.fromEnvironment(),
);

final identityAccessTokenProvider = Provider<PrivyAccessTokenProvider>((ref) {
  return _IdentityAccessTokenAdapter(
    ref.watch(identityAuthGatewayProvider),
    onExpired: () async {
      await ref.read(identityAuthGatewayProvider).logout().catchError((_) {});
      ref.read(sessionGenerationProvider.notifier).clearUserScope();
    },
  );
});

final class _IdentityAccessTokenAdapter implements PrivyAccessTokenProvider {
  const _IdentityAccessTokenAdapter(this._gateway, {required this.onExpired});

  final IdentityAuthGateway _gateway;
  final Future<void> Function() onExpired;

  @override
  Future<String?> getAccessToken() => _gateway.getAccessToken();

  @override
  Future<String?> refreshAccessToken() => _gateway.refreshAccessToken();

  @override
  Future<void> onAuthenticationExpired() => onExpired();
}
