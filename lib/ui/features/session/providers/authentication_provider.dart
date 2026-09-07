import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/auth_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../app/config/privy_configuration.dart';
import '../../../../domain/auth/authentication.dart';
import '../../../../domain/auth/identity_auth_gateway.dart';
import '../../../../domain/models/api_failure.dart';

final authenticationProvider =
    NotifierProvider<AuthenticationNotifier, AuthenticationState>(
      AuthenticationNotifier.new,
    );

final class AuthenticationNotifier extends Notifier<AuthenticationState> {
  var _epoch = 0;
  var _hasBuilt = false;
  String? _activeEmail;

  IdentityAuthGateway get _gateway => ref.read(identityAuthGatewayProvider);

  @override
  AuthenticationState build() {
    ref.watch(sessionGenerationProvider);
    _epoch++;
    _activeEmail = null;
    if (_hasBuilt) return const AuthenticationUnauthenticated();
    _hasBuilt = true;
    return const AuthenticationInitializing();
  }

  Future<void> bootstrap({String? language}) async {
    final operation = ++_epoch;
    _activeEmail = null;
    state = const AuthenticationInitializing();
    if (!_gateway.isSupported) {
      if (_isCurrent(operation)) state = const AuthenticationUnsupported();
      return;
    }

    try {
      final identityConfiguration = ref
          .read(privyConfigurationProvider)
          .validate();
      final principal = await _gateway.initialize(identityConfiguration);
      if (!_isCurrent(operation)) return;
      if (principal == null) {
        state = const AuthenticationUnauthenticated();
        return;
      }
      await _establishSession(operation, language: language);
    } on IdentityFailure catch (failure) {
      if (_isCurrent(operation)) state = AuthenticationFailed(failure);
    } on ApiFailure catch (failure) {
      if (_isCurrent(operation)) state = AuthenticationFailed(_mapApi(failure));
    } catch (_) {
      if (_isCurrent(operation)) {
        state = const AuthenticationFailed(
          IdentityFailure(AuthenticationFailureCode.provider, retryable: true),
        );
      }
    }
  }

  Future<void> requestEmailCode(String value) async {
    final email = _normalizeEmail(value);
    if (email == null) {
      state = const AuthenticationUnauthenticated(
        failure: IdentityFailure(
          AuthenticationFailureCode.invalidInput,
          retryable: true,
        ),
      );
      return;
    }
    if (!_emailEnabled) {
      state = const AuthenticationUnauthenticated(
        failure: IdentityFailure(
          AuthenticationFailureCode.methodUnavailable,
          retryable: false,
        ),
      );
      return;
    }

    final operation = ++_epoch;
    state = const AuthenticationAuthenticating();
    try {
      await _gateway.requestEmailCode(email);
      if (_isCurrent(operation)) {
        _activeEmail = email;
        state = AuthenticationAwaitingCode(email);
      }
    } on IdentityFailure catch (failure) {
      if (_isCurrent(operation)) {
        state = AuthenticationUnauthenticated(failure: failure);
      }
    }
  }

  Future<void> verifyEmailCode(String code, {String? language}) async {
    final email = _activeEmail;
    final submittedCode = code.trim();
    if (email == null || submittedCode.isEmpty) {
      final failure = const IdentityFailure(
        AuthenticationFailureCode.invalidInput,
        retryable: true,
      );
      state = email == null
          ? AuthenticationUnauthenticated(failure: failure)
          : AuthenticationAwaitingCode(email, failure: failure);
      return;
    }

    final operation = ++_epoch;
    state = AuthenticationAuthenticating(email: email);
    try {
      await _gateway.verifyEmailCode(email: email, code: submittedCode);
      if (!_isCurrent(operation)) return;
      await _establishSession(operation, language: language);
      if (_isCurrent(operation) && state is AuthenticationAuthenticated) {
        _activeEmail = null;
      }
    } on IdentityFailure catch (failure) {
      if (_isCurrent(operation)) {
        state = AuthenticationAwaitingCode(email, failure: failure);
      }
    } on ApiFailure catch (failure) {
      if (_isCurrent(operation)) {
        state = AuthenticationAwaitingCode(email, failure: _mapApi(failure));
      }
    } catch (_) {
      if (_isCurrent(operation)) {
        state = AuthenticationAwaitingCode(
          email,
          failure: const IdentityFailure(
            AuthenticationFailureCode.provider,
            retryable: true,
          ),
        );
      }
    }
  }

  Future<void> logout() async {
    ++_epoch;
    IdentityFailure? failure;
    try {
      await ref.read(sessionRepositoryProvider).endSession();
    } on AuthenticationFailure {
      // An expired backend session is already logged out remotely.
    } on ApiFailure {
      failure = const IdentityFailure(
        AuthenticationFailureCode.network,
        retryable: true,
      );
    }
    try {
      await _gateway.logout();
    } on IdentityFailure catch (value) {
      failure ??= value;
    } finally {
      _activeEmail = null;
      ref.read(sessionGenerationProvider.notifier).clearUserScope();
      state = AuthenticationUnauthenticated(failure: failure);
    }
  }

  Future<void> _establishSession(int operation, {String? language}) async {
    final generation = ref.read(sessionGenerationProvider).value;
    final session = await ref
        .read(sessionRepositoryProvider)
        .createOrRestore(language: language, generation: generation);
    await ref
        .read(walletsRepositoryProvider)
        .syncWallet(idempotencyKey: 'wallet-sync-${session.sessionId}');
    if (_isCurrent(operation) &&
        ref.read(sessionGenerationProvider).value == generation) {
      state = AuthenticationAuthenticated(session);
    }
  }

  bool get _emailEnabled => PrivyConfiguration.loginMethods.contains('email');

  String? _normalizeEmail(String value) {
    final email = value.trim().toLowerCase();
    final valid = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    return valid ? email : null;
  }

  bool _isCurrent(int operation) => operation == _epoch;

  IdentityFailure _mapApi(ApiFailure failure) => IdentityFailure(
    failure is AuthenticationFailure
        ? AuthenticationFailureCode.expired
        : failure.kind == FailureKind.network
        ? AuthenticationFailureCode.network
        : AuthenticationFailureCode.provider,
    retryable: failure.retryable,
  );
}
