import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:privy_flutter/privy_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../domain/auth/authentication.dart';
import '../../domain/auth/identity_auth_gateway.dart';
import '../../app/config/privy_configuration.dart';

typedef PrivyFactory = Privy Function(PrivyConfig configuration);
typedef PrivyDiagnosticReporter = void Function({
  required String operation,
  required String message,
});

final class PrivyIdentityAuthGateway implements IdentityAuthGateway {
  PrivyIdentityAuthGateway({
    PrivyFactory? createPrivy,
    PrivyDiagnosticReporter? reportDiagnostic,
  }) : _createPrivy = createPrivy ?? ((config) => Privy.init(config: config)),
       _reportDiagnostic = reportDiagnostic ?? _reportToSentry;

  final PrivyFactory _createPrivy;
  final PrivyDiagnosticReporter _reportDiagnostic;
  Privy? _privy;
  PrivyUser? _user;
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
          _sessionUsable = true;
          return IdentityPrincipal(user.id);
        case Unauthenticated():
          _user = null;
          _sessionUsable = false;
          return null;
        case NotReady() || AuthenticatedUnverified():
          _user = null;
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
          _sessionUsable = true;
          return IdentityPrincipal(value.id);
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
          _sessionUsable = true;
          return IdentityPrincipal(value.id);
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
        relyingParty: PrivyConfiguration.relyingParty,
      );
      switch (result) {
        case Success<PrivyUser>(:final value):
          _user = value;
          _sessionUsable = true;
          return IdentityPrincipal(value.id);
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
  Future<IdentityPrincipal> loginWithWallet(WalletConnection connection) async {
    try {
      final uri = Uri.tryParse(PrivyConfiguration.relyingParty);
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
          _sessionUsable = true;
          return IdentityPrincipal(value.id);
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

  String? _tokenFrom(Result<String> result) => switch (result) {
    Success<String>(:final value) when value.isNotEmpty => value,
    _ => null,
  };

  IdentityFailure _mapFailure(
    PrivyException error, {
    required String operation,
    required bool codeOperation,
  }) => _failureForMessage(
    operation: operation,
    message: error.message,
    codeOperation: codeOperation,
  );

  IdentityFailure _mapUnexpectedFailure({
    required String operation,
    required Object error,
  }) => _failureForMessage(
    operation: operation,
    message: error.toString(),
    codeOperation: operation == 'verify_email_code',
  );

  IdentityFailure _failureForMessage({
    required String operation,
    required String message,
    required bool codeOperation,
  }) {
    final normalized = message.toLowerCase();
    _reportFailure(operation: operation, message: message);
    if (normalized.contains('network') || normalized.contains('timeout')) {
      return const IdentityFailure(
        AuthenticationFailureCode.network,
        retryable: true,
      );
    }
    if (normalized.contains('failed to launch oauth browser')) {
      return const IdentityFailure(
        AuthenticationFailureCode.browserUnavailable,
        retryable: true,
      );
    }
    if (codeOperation &&
        (normalized.contains('code') ||
            normalized.contains('otp') ||
            normalized.contains('verification') ||
            normalized.contains('invalid email'))) {
      return const IdentityFailure(
        AuthenticationFailureCode.invalidCode,
        retryable: true,
      );
    }
    return const IdentityFailure(
      AuthenticationFailureCode.provider,
      retryable: true,
    );
  }

  void _reportFailure({required String operation, required String message}) {
    final safeMessage = _sanitizeDiagnosticMessage(message);
    if (kDebugMode) debugPrint('Privy $operation failed: $safeMessage');
    _reportDiagnostic(operation: operation, message: safeMessage);
  }

  static String _sanitizeDiagnosticMessage(String value) => value
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
      )
      .replaceAll(RegExp(r'\b\d{4,10}\b'), '<redacted-code>');

  static void _reportToSentry({
    required String operation,
    required String message,
  }) {
    unawaited(
      Sentry.captureMessage(
        'Privy authentication failed',
        withScope: (scope) {
          scope
            ..setTag('auth_provider', 'privy')
            ..setTag('operation', operation);
          scope.setContexts('privy_auth', {'safe_message': message});
        },
      ),
    );
  }
}
