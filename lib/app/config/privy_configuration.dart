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
  static const appUrlScheme = String.fromEnvironment(
    'PRIVY_APP_URL_SCHEME',
    defaultValue: 'nobell',
  );
  static const nativeAppRedirect = '$appUrlScheme://';

  /// HTTPS page hosting the React Privy private-key export experience.
  static const privateKeyExportUrl = String.fromEnvironment('PRIVY_EXPORT_URL');

  /// WebAuthn relying-party origin derived from the export site origin.
  ///
  /// Keep one public origin setting for both the export page and passkeys.
  /// Paths, query parameters, and fragments are removed because the relying
  /// party is an origin, not a page URL. Privy's native SDK expects this HTTPS
  /// origin and obtains the hostname RP ID from its server response.
  /// See https://docs.privy.io/authentication/user-authentication/login-methods/passkey
  static String get relyingParty => relyingPartyFor(privateKeyExportUrl);

  static String relyingPartyFor(String exportUrl) {
    final uri = Uri.tryParse(exportUrl.trim());
    if (uri == null ||
        uri.host.isEmpty ||
        uri.scheme != 'https' ||
        uri.userInfo.isNotEmpty) {
      throw const IdentityFailure(
        AuthenticationFailureCode.configuration,
        retryable: true,
      );
    }
    return uri.origin;
  }

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
