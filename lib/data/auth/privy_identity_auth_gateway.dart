import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:privy_flutter/privy_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../domain/auth/authentication.dart';
import '../../domain/auth/identity_auth_gateway.dart';
import '../../domain/models/wallet_action_execution.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../../domain/services/wallet_authorization_signer.dart';
import '../../app/config/privy_configuration.dart';

typedef PrivyFactory = Privy Function(PrivyConfig configuration);
typedef PrivyDiagnosticReporter = void Function({
  required String operation,
  required String message,
  required String failureCode,
  required String providerError,
  String? providerFlow,
  String? providerStage,
});
typedef PrivyTypedDataRequester = Future<Result<EthereumRpcResponse>> Function(
  EmbeddedEthereumWallet wallet,
  EthereumRpcRequest request,
);
typedef PrivyAuthorizationSigner = Future<Result<String>> Function(
  PrivyUser user,
  WalletApiPayload payload,
);

IdentityPrincipal _principalFromUser(PrivyUser user) => IdentityPrincipal(
  user.id,
  displayName: _privyDisplayName(user.linkedAccounts),
);

String? _privyDisplayName(List<LinkedAccounts> accounts) {
  String? firstValue(Iterable<String?> values) {
    for (final value in values) {
      final trimmed = value?.trim();
      if (trimmed != null && trimmed.isNotEmpty) return trimmed;
    }
    return null;
  }

  final profileName = firstValue([
    for (final account in accounts)
      switch (account) {
        GoogleOAuthAccount(:final name) ||
        TwitterOAuthAccount(:final name) => name,
        TelegramAccount(:final firstName, :final lastName) => [
          firstName,
          lastName,
        ].whereType<String>().join(' '),
        _ => null,
      },
  ]);
  if (profileName != null) return profileName;

  final email = firstValue([
    for (final account in accounts)
      switch (account) {
        EmailAccount(:final emailAddress) => emailAddress,
        GoogleOAuthAccount(:final email) ||
        AppleOAuthAccount(:final email) => email,
        DiscordOAuthAccount(:final email) => email,
        _ => null,
      },
  ]);
  if (email != null) return email;

  final username = firstValue([
    for (final account in accounts)
      switch (account) {
        TwitterOAuthAccount(:final username) ||
        DiscordOAuthAccount(:final username) ||
        TelegramAccount(:final username) => username,
        _ => null,
      },
  ]);
  if (username != null) return username;

  final wallet = firstValue([
    for (final account in accounts)
      switch (account) {
        ExternalWalletAccount(:final address) ||
        EmbeddedEthereumWalletAccount(:final address) ||
        EmbeddedSolanaWalletAccount(:final address) => address,
        _ => null,
      },
  ]);
  return wallet == null ? null : _shortenWalletAddress(wallet);
}

String _shortenWalletAddress(String address) => address.length <= 12
    ? address
    : '${address.substring(0, 6)}...${address.substring(address.length - 4)}';

final class PrivyIdentityAuthGateway
    implements
        IdentityAuthGateway,
        Hip3TypedDataSigner,
        WalletAuthorizationSigner {
  PrivyIdentityAuthGateway({
    PrivyFactory? createPrivy,
    PrivyDiagnosticReporter? reportDiagnostic,
    PrivyTypedDataRequester? requestTypedData,
    PrivyAuthorizationSigner? signAuthorization,
    this._exportUrl = PrivyConfiguration.privateKeyExportUrl,
  }) : _createPrivy = createPrivy ?? ((config) => Privy.init(config: config)),
       _reportDiagnostic = reportDiagnostic ?? _reportToSentry,
       _requestTypedData =
           requestTypedData ??
           ((wallet, request) => wallet.provider.request(request)),
       _signAuthorization =
           signAuthorization ??
           ((user, payload) => user.generateAuthorizationSignature(payload));

  final PrivyFactory _createPrivy;
  final String _exportUrl;
  final PrivyDiagnosticReporter _reportDiagnostic;
  final PrivyTypedDataRequester _requestTypedData;
  final PrivyAuthorizationSigner _signAuthorization;
  Privy? _privy;
  PrivyUser? _user;
  WalletConnection? _externalWallet;
  bool _sessionUsable = false;

  @override
  bool get isSupported => true;

  Privy get _initializedPrivy {
    final privy = _privy;
    if (privy == null) {
      throw const IdentityFailure(
        AuthenticationFailureCode.configuration,
        retryable: true,
      );
    }
    return privy;
  }

  @override
  Future<IdentityPrincipal?> initialize(
    IdentityConfiguration configuration,
  ) async {
    try {
      final privy = _createPrivy(
        PrivyConfig(
          appId: configuration.appId,
          appClientId: configuration.clientId,
          logLevel: PrivyLogLevel.none,
        ),
      );
      _privy = privy;
      final authState = await privy.getAuthState();
      switch (authState) {
        case Authenticated(:final user):
          _user = user;
          _externalWallet = null;
          _sessionUsable = true;
          return _principalFromUser(user);
        case Unauthenticated():
          _user = null;
          _externalWallet = null;
          _sessionUsable = false;
          return null;
        case NotReady() || AuthenticatedUnverified():
          _user = null;
          _externalWallet = null;
          _sessionUsable = false;
          throw const IdentityFailure(
            AuthenticationFailureCode.provider,
            retryable: true,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'initialize', error: error);
    }
  }

  @override
  Future<void> requestEmailCode(String email) async {
    try {
      final result = await _initializedPrivy.email.sendCode(email);
      switch (result) {
        case Success<void>():
          return;
        case Failure<void>(:final error):
          throw _mapFailure(
            error,
            operation: 'send_email_code',
            codeOperation: false,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'send_email_code', error: error);
    }
  }

  @override
  Future<IdentityPrincipal> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    try {
      final result = await _initializedPrivy.email.loginWithCode(
        code: code,
        email: email,
      );
      switch (result) {
        case Success<PrivyUser>(:final value):
          _user = value;
          _externalWallet = null;
          _sessionUsable = true;
          return _principalFromUser(value);
        case Failure<PrivyUser>(:final error):
          throw _mapFailure(
            error,
            operation: 'verify_email_code',
            codeOperation: true,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'verify_email_code', error: error);
    }
  }

  @override
  Future<String> signTypedDataV4({
    required String expectedSigner,
    required Map<String, Object?> typedData,
  }) async {
    final normalized = expectedSigner.toLowerCase();
    if (!RegExp(r'^0x[0-9a-f]{40}$').hasMatch(normalized) ||
        typedData.isEmpty) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    if (!_sessionUsable) {
      throw const Hip3SigningFailure(
        Hip3SigningFailureCode.walletUnavailable,
        retryable: true,
      );
    }

    final external = _externalWallet;
    if (external != null && external.address.toLowerCase() == normalized) {
      try {
        return await external.signTypedDataV4(typedData);
      } catch (_) {
        throw const Hip3SigningFailure(Hip3SigningFailureCode.rejected);
      }
    }

    final user = _user ?? await _privy?.getUser();
    if (user == null) {
      throw const Hip3SigningFailure(
        Hip3SigningFailureCode.walletUnavailable,
        retryable: true,
      );
    }
    _user = user;
    final matches = user.embeddedEthereumWallets
        .where((wallet) => wallet.address.toLowerCase() == normalized)
        .toList(growable: false);
    if (matches.length != 1) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.walletMismatch);
    }

    final request = EthereumRpcRequest.ethSignTypedDataV4(
      matches.single.address,
      _encodeTypedData(typedData),
    );
    try {
      return switch (await _requestTypedData(matches.single, request)) {
        Success<EthereumRpcResponse>(:final value) when value.data.isNotEmpty =>
          value.data,
        _ => throw const Hip3SigningFailure(Hip3SigningFailureCode.rejected),
      };
    } on Hip3SigningFailure {
      rethrow;
    } catch (_) {
      throw const Hip3SigningFailure(
        Hip3SigningFailureCode.walletUnavailable,
        retryable: true,
      );
    }
  }

  @override
  Future<String> signWalletAuthorization({
    required String expectedSigner,
    required WalletAuthorizationRequest request,
  }) async {
    final normalizedSigner = expectedSigner.toLowerCase();
    if (!RegExp(r'^0x[0-9a-f]{40}$').hasMatch(normalizedSigner) ||
        request.transaction.from.toLowerCase() != normalizedSigner ||
        !request.url.startsWith('https://api.privy.io/v1/wallets/') ||
        request.method != 'POST' ||
        request.version != 1 ||
        request.headers.isEmpty ||
        request.body.isEmpty) {
      throw const WalletAuthorizationFailure(
        WalletAuthorizationFailureCode.invalidPayload,
      );
    }
    if (!_sessionUsable) {
      throw const WalletAuthorizationFailure(
        WalletAuthorizationFailureCode.walletUnavailable,
        retryable: true,
      );
    }

    final external = _externalWallet;
    if (external != null &&
        external.address.toLowerCase() == normalizedSigner) {
      // Authorization signatures come from the Privy signing key; a connected
      // WalletConnect session has no way to produce one.
      throw const WalletAuthorizationFailure(
        WalletAuthorizationFailureCode.unsupportedWallet,
      );
    }

    final user = _user ?? await _privy?.getUser();
    if (user == null) {
      throw const WalletAuthorizationFailure(
        WalletAuthorizationFailureCode.walletUnavailable,
        retryable: true,
      );
    }
    _user = user;
    final owned = user.embeddedEthereumWallets.any(
      (wallet) => wallet.address.toLowerCase() == normalizedSigner,
    );
    if (!owned) {
      throw const WalletAuthorizationFailure(
        WalletAuthorizationFailureCode.walletMismatch,
      );
    }

    try {
      final result = await _signAuthorization(
        user,
        WalletApiPayload(
          version: request.version,
          url: request.url,
          method: request.method,
          headers: request.headers,
          body: request.body,
        ),
      );
      return switch (result) {
        Success<String>(:final value) when value.isNotEmpty => value,
        Failure<String>(:final error) => throw WalletAuthorizationFailure(
          WalletAuthorizationFailureCode.rejected,
          reason: error.message,
        ),
        _ => throw const WalletAuthorizationFailure(
          WalletAuthorizationFailureCode.rejected,
        ),
      };
    } on WalletAuthorizationFailure {
      rethrow;
    } catch (error, stackTrace) {
      final reason =
          (error is PrivyException ? error.message : error.toString()).trim();
      final providerDiagnostic = _providerDiagnostic(error);
      _reportDiagnostic(
        operation: 'generate_authorization_signature',
        message: _sanitizeDiagnosticMessage('$reason\n$stackTrace'),
        failureCode: 'wallet_unavailable',
        providerError: providerDiagnostic.error,
        providerFlow: providerDiagnostic.flow,
        providerStage: providerDiagnostic.stage,
      );
      throw WalletAuthorizationFailure(
        WalletAuthorizationFailureCode.walletUnavailable,
        retryable: true,
        reason: reason.isEmpty ? null : reason,
      );
    }
  }

  @override
  Future<IdentityPrincipal> login() async => throw const IdentityFailure(
    AuthenticationFailureCode.methodUnavailable,
    retryable: false,
  );

  @override
  Future<IdentityPrincipal> loginWithOAuth(String provider) async {
    try {
      final oauthProvider = switch (provider.toLowerCase()) {
        'google' => OAuthProvider.google,
        'apple' => OAuthProvider.apple,
        'twitter' => OAuthProvider.twitter,
        'discord' => OAuthProvider.discord,
        'telegram' => OAuthProvider.telegram,
        _ => throw const IdentityFailure(
          AuthenticationFailureCode.methodUnavailable,
          retryable: false,
        ),
      };
      final result = await _initializedPrivy.oAuth.login(
        provider: oauthProvider,
        appUrlScheme: PrivyConfiguration.appUrlScheme,
      );
      switch (result) {
        case Success<PrivyUser>(:final value):
          _user = value;
          _externalWallet = null;
          _sessionUsable = true;
          return _principalFromUser(value);
        case Failure<PrivyUser>(:final error):
          throw _mapFailure(
            error,
            operation: 'oauth_login',
            codeOperation: false,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'oauth_login', error: error);
    }
  }

  @override
  Future<IdentityPrincipal> loginWithPasskey() async {
    try {
      final result = await _initializedPrivy.passkey.login(
        relyingParty: PrivyConfiguration.relyingPartyFor(_exportUrl),
      );
      switch (result) {
        case Success<PrivyUser>(:final value):
          _user = value;
          _externalWallet = null;
          _sessionUsable = true;
          return _principalFromUser(value);
        case Failure<PrivyUser>(:final error):
          throw _mapFailure(
            error,
            operation: 'passkey_login',
            codeOperation: false,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'passkey_login', error: error);
    }
  }

  @override
  Future<PasskeyCredential?> getPasskey() async {
    if (!_sessionUsable) return null;
    final user = _user ?? await _privy?.getUser();
    if (user == null) return null;
    _user = user;
    return _passkeyFromUser(user);
  }

  @override
  Future<PasskeyCredential> linkPasskey({String? displayName}) async {
    try {
      final result = await _initializedPrivy.passkey.link(
        relyingParty: PrivyConfiguration.relyingPartyFor(_exportUrl),
        displayName: displayName,
      );
      switch (result) {
        case Success<PrivyUser>(:final value):
          _user = value;
          _sessionUsable = true;
          final passkey = _passkeyFromUser(value);
          if (passkey == null) {
            throw const IdentityFailure(
              AuthenticationFailureCode.provider,
              retryable: true,
            );
          }
          return passkey;
        case Failure<PrivyUser>(:final error):
          throw _mapFailure(
            error,
            operation: 'passkey_link',
            codeOperation: false,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'passkey_link', error: error);
    }
  }

  @override
  Future<void> unlinkPasskey(String credentialId) async {
    try {
      final result = await _initializedPrivy.passkey.unlink(
        credentialId: credentialId,
      );
      switch (result) {
        case Success<PrivyUser>(:final value):
          _user = value;
          _sessionUsable = true;
        case Failure<PrivyUser>(:final error):
          throw _mapFailure(
            error,
            operation: 'passkey_unlink',
            codeOperation: false,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'passkey_unlink', error: error);
    }
  }

  @override
  Future<IdentityPrincipal> loginWithWallet(WalletConnection connection) async {
    try {
      final uri = Uri.tryParse(PrivyConfiguration.relyingPartyFor(_exportUrl));
      if (uri == null || uri.host.isEmpty) {
        throw const IdentityFailure(
          AuthenticationFailureCode.configuration,
          retryable: true,
        );
      }
      final params = SiweMessageParams(
        appDomain: uri.host,
        appUri: uri.toString(),
        chainId: connection.chainId,
        walletAddress: connection.address,
      );
      final message = switch (await _initializedPrivy.siwe.generateMessage(
        params,
      )) {
        Success<String>(:final value) => value,
        Failure<String>(:final error) => throw _mapFailure(
          error,
          operation: 'siwe_generate_message',
          codeOperation: false,
        ),
      };
      final signature = await connection.signPersonalMessage(message);
      final result = await _initializedPrivy.siwe.login(
        message: message,
        signature: signature,
        params: params,
        metadata: WalletLoginMetadata(connectorType: connection.connectorType),
      );
      switch (result) {
        case Success<PrivyUser>(:final value):
          _user = value;
          _externalWallet = connection;
          _sessionUsable = true;
          return _principalFromUser(value);
        case Failure<PrivyUser>(:final error):
          throw _mapFailure(
            error,
            operation: 'wallet_login',
            codeOperation: false,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(operation: 'wallet_login', error: error);
    }
  }

  @override
  Future<void> ensureEmbeddedWallet() async {
    if (!_sessionUsable) return;
    try {
      final user = _user ?? await _privy?.getUser();
      if (user == null) return;
      _user = user;
      if (user.embeddedEthereumWallets.isNotEmpty) return;
      switch (await user.createEthereumWallet()) {
        case Success<EmbeddedEthereumWallet>():
          return;
        case Failure<EmbeddedEthereumWallet>(:final error):
          throw _mapFailure(
            error,
            operation: 'create_embedded_wallet',
            codeOperation: false,
          );
      }
    } on IdentityFailure {
      rethrow;
    } catch (error) {
      throw _mapUnexpectedFailure(
        operation: 'create_embedded_wallet',
        error: error,
      );
    }
  }

  @override
  Future<String?> getAccessToken() async {
    if (!_sessionUsable) return null;
    final user = _user ?? await _privy?.getUser();
    if (user == null) return null;
    _user = user;
    try {
      return _tokenFrom(await user.getAccessToken());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> refreshAccessToken() async {
    if (!_sessionUsable) return null;
    final user = _user ?? await _privy?.getUser();
    if (user == null) return null;
    try {
      switch (await user.refresh()) {
        case Success<void>():
          _user = user;
          return _tokenFrom(await user.getAccessToken());
        case Failure<void>():
          return null;
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> logout() async {
    final privy = _privy;
    _user = null;
    _externalWallet = null;
    _sessionUsable = false;
    if (privy == null) return;
    try {
      await privy.logout();
    } catch (_) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
    }
  }

  static String _encodeTypedData(Map<String, Object?> typedData) {
    try {
      return jsonEncode(typedData);
    } catch (_) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
  }

  String? _tokenFrom(Result<String> result) => switch (result) {
    Success<String>(:final value) when value.isNotEmpty => value,
    _ => null,
  };

  PasskeyCredential? _passkeyFromUser(PrivyUser user) {
    final account = user.linkedAccounts.whereType<PasskeyAccount>().firstOrNull;
    return account == null
        ? null
        : PasskeyCredential(
            id: account.credentialId,
            authenticatorName: account.authenticatorName,
          );
  }

  IdentityFailure _mapFailure(
    PrivyException error, {
    required String operation,
    required bool codeOperation,
  }) => _failureForMessage(
    operation: operation,
    message: error.message,
    codeOperation: codeOperation,
    providerDiagnostic: _providerDiagnostic(error),
  );

  IdentityFailure _mapUnexpectedFailure({
    required String operation,
    required Object error,
  }) => _failureForMessage(
    operation: operation,
    message: error.toString(),
    codeOperation: operation == 'verify_email_code',
    providerDiagnostic: _providerDiagnostic(error),
  );

  IdentityFailure _failureForMessage({
    required String operation,
    required String message,
    required bool codeOperation,
    required _PrivyProviderDiagnostic providerDiagnostic,
  }) {
    final normalized = message.toLowerCase();
    final reason = operation.startsWith('passkey_')
        ? _sanitizeDiagnosticMessage(
            message.split('\n').first,
            redactCodes: false,
          ).trim()
        : null;
    late final IdentityFailure failure;
    if (normalized.contains('network') || normalized.contains('timeout')) {
      failure = IdentityFailure(
        AuthenticationFailureCode.network,
        retryable: true,
        reason: reason,
      );
    } else if (normalized.contains('failed to launch oauth browser')) {
      failure = IdentityFailure(
        AuthenticationFailureCode.browserUnavailable,
        retryable: true,
        reason: reason,
      );
    } else if (codeOperation &&
        (normalized.contains('code') ||
            normalized.contains('otp') ||
            normalized.contains('verification') ||
            normalized.contains('invalid email'))) {
      failure = IdentityFailure(
        AuthenticationFailureCode.invalidCode,
        retryable: true,
        reason: reason,
      );
    } else {
      failure = IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
        reason: reason,
      );
    }
    _reportFailure(
      operation: operation,
      message: message,
      failureCode: failure.code.name,
      providerDiagnostic: providerDiagnostic,
    );
    return failure;
  }

  void _reportFailure({
    required String operation,
    required String message,
    required String failureCode,
    required _PrivyProviderDiagnostic providerDiagnostic,
  }) {
    final safeMessage = _sanitizeDiagnosticMessage(message);
    if (kDebugMode) debugPrint('Privy $operation failed: $safeMessage');
    _reportDiagnostic(
      operation: operation,
      message: safeMessage,
      failureCode: failureCode,
      providerError: providerDiagnostic.error,
      providerFlow: providerDiagnostic.flow,
      providerStage: providerDiagnostic.stage,
    );
  }

  static _PrivyProviderDiagnostic _providerDiagnostic(Object error) =>
      switch (error) {
        PrivyAuthException(:final flow, :final stage) => (
          error: 'auth_exception',
          flow: _safeDiagnosticLabel(flow),
          stage: _safeDiagnosticLabel(stage),
        ),
        PrivyTimeoutException(:final operation) => (
          error: 'timeout_exception',
          flow: null,
          stage: _safeDiagnosticLabel(operation),
        ),
        PrivyWalletException(:final operation) => (
          error: 'wallet_exception',
          flow: null,
          stage: _safeDiagnosticLabel(operation),
        ),
        PrivyException() => (error: 'privy_exception', flow: null, stage: null),
        PlatformException(:final code) => (
          error: 'platform_exception',
          flow: null,
          stage: _safeDiagnosticLabel(code),
        ),
        _ => (error: 'unexpected', flow: null, stage: null),
      };

  static String? _safeDiagnosticLabel(String value) {
    final normalized = value.trim().toLowerCase().replaceAll(
      RegExp(r'[^a-z0-9._-]+'),
      '-',
    );
    if (normalized.isEmpty) return null;
    return normalized.length <= 64 ? normalized : normalized.substring(0, 64);
  }

  static String _sanitizeDiagnosticMessage(
    String value, {
    bool redactCodes = true,
  }) {
    final sanitized = value
        .replaceAll(RegExp(r'\b[^\s@]+@[^\s@]+\b'), '<redacted-email>')
        .replaceAll(
          RegExp(r'Bearer\s+\S+', caseSensitive: false),
          'Bearer <redacted>',
        )
        .replaceAll(
          RegExp(
            r'([?&](?:access_token|authorization|code|id_token|state|token)=)[^&#\s]+',
            caseSensitive: false,
          ),
          r'$1<redacted>',
        )
        .replaceAll(
          RegExp(
            r'("(?:access_token|authorization|code|id_token|state|token)"\s*:\s*")[^"]+',
            caseSensitive: false,
          ),
          r'$1<redacted>',
        );
    return redactCodes
        ? sanitized.replaceAll(RegExp(r'\b\d{4,10}\b'), '<redacted-code>')
        : sanitized;
  }

  static void _reportToSentry({
    required String operation,
    required String message,
    required String failureCode,
    required String providerError,
    String? providerFlow,
    String? providerStage,
  }) {
    unawaited(
      Sentry.captureMessage(
        'Privy authentication failed',
        withScope: (scope) {
          scope
            ..setTag('auth_provider', 'privy')
            ..setTag('operation', operation)
            ..setTag('auth_failure', failureCode)
            ..setTag('provider_error', providerError);
          if (providerFlow != null) {
            scope.setTag('provider_flow', providerFlow);
          }
          if (providerStage != null) {
            scope.setTag('provider_stage', providerStage);
          }
          scope.setContexts('privy_auth', {
            'safe_message': message,
            'failure_code': failureCode,
            'provider_error': providerError,
            'provider_flow': ?providerFlow,
            'provider_stage': ?providerStage,
          });
        },
      ),
    );
  }
}

typedef _PrivyProviderDiagnostic = ({
  String error,
  String? flow,
  String? stage,
});
