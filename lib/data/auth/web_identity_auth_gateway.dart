import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import '../../domain/auth/authentication.dart';
import '../../domain/auth/identity_auth_gateway.dart';

/// Browser implementation backed by the React Privy SDK bundle in
/// `web/privy-auth`. The bundle is copied only into Flutter Web output.
final class WebPrivyIdentityAuthGateway implements IdentityAuthGateway {
  JSObject? _bridge;
  bool _sessionUsable = false;

  @override
  bool get isSupported => true;

  JSObject get _initializedBridge {
    final bridge = _bridge;
    if (bridge == null) {
      throw const IdentityFailure(
        AuthenticationFailureCode.configuration,
        retryable: true,
      );
    }
    return bridge;
  }

  @override
  Future<IdentityPrincipal?> initialize(
    IdentityConfiguration configuration,
  ) async {
    final candidate = globalContext.getProperty('rwaPrivyAuth'.toJS);
    if (!candidate.isA<JSObject>()) {
      throw const IdentityFailure(
        AuthenticationFailureCode.configuration,
        retryable: true,
      );
    }
    _bridge = candidate as JSObject;
    try {
      final userId = await _call(
        'initialize',
        configuration.appId.toJS,
        configuration.clientId.toJS,
      );
      if (!userId.isA<JSString>() ||
          (userId as JSString).toDart.trim().isEmpty) {
        _sessionUsable = false;
        return null;
      }
      _sessionUsable = true;
      return IdentityPrincipal(userId.toDart);
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
  Future<IdentityPrincipal> login() => _loginWithPrivyModal();

  @override
  Future<void> requestEmailCode(String email) async =>
      throw const IdentityFailure(
        AuthenticationFailureCode.methodUnavailable,
        retryable: false,
      );

  @override
  Future<IdentityPrincipal> verifyEmailCode({
    required String email,
    required String code,
  }) async => throw const IdentityFailure(
    AuthenticationFailureCode.methodUnavailable,
    retryable: false,
  );

  @override
  Future<IdentityPrincipal> loginWithOAuth(String provider) =>
      _loginWithPrivyModal();

  @override
  Future<IdentityPrincipal> loginWithPasskey() => _loginWithPrivyModal();

  @override
  Future<PasskeyCredential?> getPasskey() async {
    if (!_sessionUsable) return null;
    try {
      return _passkeyFromValue(await _call('getPasskey'));
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
  Future<PasskeyCredential> linkPasskey({String? displayName}) async {
    try {
      final passkey = _passkeyFromValue(
        await _call('linkPasskey', displayName?.toJS),
      );
      if (passkey == null) {
        throw const IdentityFailure(
          AuthenticationFailureCode.provider,
          retryable: true,
        );
      }
      return passkey;
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
  Future<void> unlinkPasskey(String credentialId) async {
    try {
      await _call('unlinkPasskey', credentialId.toJS);
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
  Future<IdentityPrincipal> loginWithWallet(WalletConnection connection) =>
      _loginWithPrivyModal();

  @override
  Future<void> ensureEmbeddedWallet() async {
    // The React Privy SDK bundle provisions embedded wallets itself
    // (create_on_login config) as part of its own login flow, so there is
    // no separate step to trigger here.
  }

  Future<IdentityPrincipal> _loginWithPrivyModal() async {
    try {
      final userId = await _call('login');
      if (!userId.isA<JSString>() ||
          (userId as JSString).toDart.trim().isEmpty) {
        throw const IdentityFailure(
          AuthenticationFailureCode.provider,
          retryable: true,
        );
      }
      _sessionUsable = true;
      return IdentityPrincipal(userId.toDart);
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
    try {
      final token = await _call('getAccessToken');
      if (!token.isA<JSString>()) return null;
      final tokenString = token as JSString?;
      if (tokenString == null || tokenString.toDart.isEmpty) return null;
      return tokenString.toDart;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> refreshAccessToken() => getAccessToken();

  @override
  Future<void> logout() async {
    _sessionUsable = false;
    final bridge = _bridge;
    if (bridge == null) return;
    try {
      await _call('logout');
    } catch (_) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
    }
  }

  Future<JSAny?> _call(String name, [JSAny? first, JSAny? second]) async {
    final bridge = _initializedBridge;
    final method = bridge.getProperty(name.toJS);
    if (!method.isA<JSFunction>()) {
      throw const IdentityFailure(
        AuthenticationFailureCode.configuration,
        retryable: true,
      );
    }
    final function = method as JSFunction;
    final result = switch ((first, second)) {
      (null, null) => function.callAsFunction(bridge),
      (_, null) => function.callAsFunction(bridge, first),
      _ => function.callAsFunction(bridge, first, second),
    };
    if (!result.isA<JSPromise<JSAny?>>()) {
      throw const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
    }
    return (result as JSPromise<JSAny?>).toDart;
  }

  PasskeyCredential? _passkeyFromValue(JSAny? value) {
    if (value == null || !value.isA<JSObject>()) return null;
    final passkey = value as JSObject;
    final credentialId = passkey.getProperty('credentialId'.toJS);
    if (!credentialId.isA<JSString>()) return null;
    final id = (credentialId as JSString).toDart;
    if (id.trim().isEmpty) return null;
    final authenticatorName = passkey.getProperty('authenticatorName'.toJS);
    return PasskeyCredential(
      id: id,
      authenticatorName: authenticatorName.isA<JSString>()
          ? (authenticatorName as JSString).toDart
          : null,
    );
  }
}

IdentityAuthGateway createWebIdentityAuthGateway() =>
    WebPrivyIdentityAuthGateway();
