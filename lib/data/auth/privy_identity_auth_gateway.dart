import 'package:privy_flutter/privy_flutter.dart';

import '../../domain/auth/authentication.dart';
import '../../domain/auth/identity_auth_gateway.dart';

typedef PrivyFactory = Privy Function(PrivyConfig configuration);

final class PrivyIdentityAuthGateway implements IdentityAuthGateway {
  PrivyIdentityAuthGateway({PrivyFactory? createPrivy})
    : _createPrivy = createPrivy ?? ((config) => Privy.init(config: config));

  final PrivyFactory _createPrivy;
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
    } catch (_) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
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
          throw _mapFailure(error, codeOperation: false);
      }
    } on IdentityFailure {
      rethrow;
    } catch (_) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
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
          throw _mapFailure(error, codeOperation: true);
      }
    } on IdentityFailure {
      rethrow;
    } catch (_) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
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
    required bool codeOperation,
  }) {
    final normalized = error.message.toLowerCase();
    if (normalized.contains('network') || normalized.contains('timeout')) {
      return const IdentityFailure(
        AuthenticationFailureCode.network,
        retryable: true,
      );
    }
    if (codeOperation &&
        (normalized.contains('code') || normalized.contains('otp'))) {
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
}
