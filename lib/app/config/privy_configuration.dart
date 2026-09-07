import '../../domain/auth/authentication.dart';

/// Public Privy client configuration supplied at build time.
///
/// Pass values with `--dart-define`; never place a Privy app secret here.
final class PrivyConfiguration {
  const PrivyConfiguration({required this.appId, required this.clientId});

  factory PrivyConfiguration.fromEnvironment() => const PrivyConfiguration(
    appId: String.fromEnvironment('PRIVY_APP_ID'),
    clientId: String.fromEnvironment('PRIVY_CLIENT_ID'),
  );

  static const loginMethods = <String>{'email'};

  final String appId;
  final String clientId;

  IdentityConfiguration validate() {
    final normalizedAppId = appId.trim();
    final normalizedClientId = clientId.trim();
    if (normalizedAppId.isEmpty || normalizedClientId.isEmpty) {
      throw const IdentityFailure(
        AuthenticationFailureCode.configuration,
        retryable: true,
      );
    }
    return IdentityConfiguration(
      appId: normalizedAppId,
      clientId: normalizedClientId,
    );
  }
}
