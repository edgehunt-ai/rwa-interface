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

  static const loginMethods = <String>{'email', 'google', 'passkey'};

  /// Must match the Android/iOS deep-link configuration in the host app.
  static const appUrlScheme = String.fromEnvironment('PRIVY_APP_URL_SCHEME');

  /// The WebAuthn relying-party identifier configured in Privy.
  static const relyingParty = String.fromEnvironment(
    'PRIVY_RELYING_PARTY',
    defaultValue: 'https://rwa.dxd.ink',
  );

  /// HTTPS page hosting the React Privy private-key export experience.
  static const privateKeyExportUrl = String.fromEnvironment(
    'PRIVY_EXPORT_URL',
    defaultValue: 'https://rwa.dxd.ink/private-key-export.html',
  );

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

/// Public WalletConnect/Reown configuration supplied at build time.
///
/// A Reown Project ID identifies the client application; it is not a secret.
/// Keep it out of source control by passing it with `--dart-define`.
final class ReownConfiguration {
  const ReownConfiguration({required this.projectId});

  factory ReownConfiguration.fromEnvironment() => const ReownConfiguration(
    projectId: String.fromEnvironment('REOWN_PROJECT_ID'),
  );

  final String projectId;

  bool get isConfigured => projectId.trim().isNotEmpty;

  String validate() {
    final normalizedProjectId = projectId.trim();
    if (normalizedProjectId.isEmpty) {
      throw const IdentityFailure(
        AuthenticationFailureCode.configuration,
        retryable: true,
      );
    }
    return normalizedProjectId;
  }
}
