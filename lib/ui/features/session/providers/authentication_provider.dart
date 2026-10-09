import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../data/api/idempotency_key.dart';
import '../../../../app/providers/auth_providers.dart';
import '../../../../app_review/app_review.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../app/providers/push_notification_providers.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/config/privy_configuration.dart';
import '../../../../domain/auth/authentication.dart';
import '../../../../domain/auth/identity_auth_gateway.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/product_session.dart';
import '../../../../domain/models/user_account.dart';

final authenticationProvider =
    NotifierProvider<AuthenticationNotifier, AuthenticationState>(
      AuthenticationNotifier.new,
    );

typedef _PendingWalletSync = ({
  ProductSession session,
  IdentityPrincipal principal,
});

final class AuthenticationNotifier extends Notifier<AuthenticationState> {
  var _epoch = 0;
  var _hasBuilt = false;
  String? _activeEmail;
  WalletConnection? _walletConnection;
  Future<void>? _walletDisconnectInFlight;
  Future<void>? _logoutInFlight;
  _PendingWalletSync? _pendingWalletSync;

  IdentityAuthGateway get _gateway => ref.read(identityAuthGatewayProvider);

  @override
  AuthenticationState build() {
    ref.watch(sessionGenerationProvider);
    ref.onDispose(() => unawaited(_disconnectWallet()));
    _epoch++;
    _activeEmail = null;
    _pendingWalletSync = null;
    if (_hasBuilt) return const AuthenticationUnauthenticated();
    _hasBuilt = true;
    return const AuthenticationInitializing();
  }

  Future<void> bootstrap({String? language}) async {
    _clearAppReviewMode();
    final operation = ++_epoch;
    _activeEmail = null;
    _pendingWalletSync = null;
    state = const AuthenticationInitializing();
    if (!_gateway.isSupported) {
      if (_isCurrent(operation)) state = const AuthenticationUnsupported();
      return;
    }

    try {
      await _disconnectWallet();
      if (!_isCurrent(operation)) return;
      final identityConfiguration = ref
          .read(privyConfigurationProvider)
          .validate();
      final principal = await _gateway.initialize(identityConfiguration);
      if (!_isCurrent(operation)) return;
      if (principal == null) {
        state = const AuthenticationUnauthenticated();
        return;
      }
      _updateAppReviewMode(principal);
      await _establishSession(operation, principal, language: language);
    } on IdentityFailure catch (failure) {
      if (_isCurrent(operation)) state = AuthenticationFailed(failure);
    } catch (_) {
      if (_isCurrent(operation)) {
        state = const AuthenticationFailed(
          IdentityFailure(AuthenticationFailureCode.provider, retryable: true),
        );
      }
    }
  }

  Future<void> requestEmailCode(String value) async {
    _clearAppReviewMode();
    _pendingWalletSync = null;
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
      await _disconnectWallet();
      if (!_isCurrent(operation)) return;
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
      final principal = await _gateway.verifyEmailCode(
        email: email,
        code: submittedCode,
      );
      if (!_isCurrent(operation)) return;
      _updateAppReviewMode(principal);
      await _establishSession(operation, principal, language: language);
      if (_isCurrent(operation) && state is AuthenticationAuthenticated) {
        _activeEmail = null;
      }
    } on IdentityFailure catch (failure) {
      if (_isCurrent(operation)) {
        state = AuthenticationAwaitingCode(email, failure: failure);
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

  void cancelEmailCode() {
    ++_epoch;
    _activeEmail = null;
    _pendingWalletSync = null;
    unawaited(_disconnectWallet());
    state = const AuthenticationUnauthenticated();
  }

  Future<void> loginWithOAuth(String provider, {String? language}) async {
    await _loginWithProvider(
      () => _gateway.loginWithOAuth(provider),
      language: language,
    );
  }

  Future<void> login({String? language}) async {
    await _loginWithProvider(_gateway.login, language: language);
  }

  Future<void> loginWithPasskey({String? language}) async {
    await _loginWithProvider(_gateway.loginWithPasskey, language: language);
  }

  Future<void> loginWithWallet(
    Future<WalletConnection> Function() connect, {
    String? language,
  }) async {
    _clearAppReviewMode();
    _pendingWalletSync = null;
    final operation = ++_epoch;
    state = const AuthenticationAuthenticating();
    await ref.read(walletLoginCoordinatorProvider).run(() async {
      if (!_isCurrent(operation)) return;
      try {
        await _disconnectWallet();
        if (!_isCurrent(operation)) return;
        final connection = await connect();
        if (!_isCurrent(operation)) {
          await _disconnectConnection(connection);
          return;
        }
        _walletConnection = connection;
        final principal = await _gateway.loginWithWallet(connection);
        if (_isCurrent(operation)) {
          _updateAppReviewMode(principal);
          await _establishSession(operation, principal, language: language);
        }
      } on IdentityFailure catch (failure) {
        if (_isCurrent(operation)) {
          // A pending session still needs the wallet for sync or renewal.
          if (_pendingWalletSync == null) {
            await _disconnectWallet();
          }
          if (_isCurrent(operation)) {
            state = AuthenticationUnauthenticated(failure: failure);
          }
        }
      } catch (_) {
        if (_isCurrent(operation)) {
          await _disconnectWallet();
          if (_isCurrent(operation)) {
            state = const AuthenticationUnauthenticated(
              failure: IdentityFailure(
                AuthenticationFailureCode.provider,
                retryable: true,
              ),
            );
          }
        }
      }
    });
  }

  Future<void> _loginWithProvider(
    Future<IdentityPrincipal> Function() login, {
    String? language,
  }) async {
    _clearAppReviewMode();
    _pendingWalletSync = null;
    final operation = ++_epoch;
    state = const AuthenticationAuthenticating();
    try {
      await _disconnectWallet();
      if (!_isCurrent(operation)) return;
      final principal = await login();
      if (_isCurrent(operation)) {
        _updateAppReviewMode(principal);
        await _establishSession(operation, principal, language: language);
      }
    } on IdentityFailure catch (failure) {
      if (_isCurrent(operation)) {
        state = AuthenticationUnauthenticated(failure: failure);
      }
    } catch (_) {
      if (_isCurrent(operation)) {
        state = const AuthenticationUnauthenticated(
          failure: IdentityFailure(
            AuthenticationFailureCode.provider,
            retryable: true,
          ),
        );
      }
    }
  }

  Future<void> retry({String? language}) async {
    if (state is AuthenticationInitializing ||
        state is AuthenticationAuthenticating ||
        state is AuthenticationAuthenticated) {
      return;
    }
    final pending = _pendingWalletSync;
    if (pending == null ||
        pending.session.generation !=
            ref.read(sessionGenerationProvider).value) {
      await bootstrap(language: language);
      return;
    }

    // Identity and the product session already succeeded. Resume the failed
    // sync without reinitializing Privy or asking for another OTP/signature.
    final operation = ++_epoch;
    state = const AuthenticationAuthenticating();
    try {
      if (pending.session.isExpired) {
        await _establishSession(
          operation,
          pending.principal,
          language: language ?? pending.session.account.settings.language,
        );
      } else {
        await _completeSession(operation, pending.session, pending.principal);
      }
    } on IdentityFailure catch (failure) {
      if (_isCurrent(operation)) state = AuthenticationFailed(failure);
    } catch (_) {
      if (_isCurrent(operation)) {
        state = const AuthenticationFailed(
          IdentityFailure(AuthenticationFailureCode.provider, retryable: true),
        );
      }
    }
  }

  Future<void> logout() {
    final active = _logoutInFlight;
    if (active != null) return active;

    late final Future<void> tracked;
    tracked = _performLogout().whenComplete(() {
      if (identical(_logoutInFlight, tracked)) _logoutInFlight = null;
    });
    _logoutInFlight = tracked;
    return tracked;
  }

  Future<void> _performLogout() async {
    ++_epoch;
    _pendingWalletSync = null;
    IdentityFailure? failure;
    await _deactivateNotifications();
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
      await _disconnectWallet();
      _activeEmail = null;
      await ref.read(observabilityReporterProvider).clearUser();
      ref.read(sessionGenerationProvider.notifier).clearUserScope();
      _clearAppReviewMode();
      state = AuthenticationUnauthenticated(failure: failure);
    }
  }

  Future<void> _establishSession(
    int operation,
    IdentityPrincipal principal, {
    String? language,
  }) async {
    final generation = ref.read(sessionGenerationProvider).value;
    final session = await _createBackendSession(
      language: language,
      generation: generation,
    );
    if (!_isCurrent(operation) ||
        ref.read(sessionGenerationProvider).value != generation) {
      return;
    }
    if (AppReviewConfiguration.buildEnabled) {
      final reviewConfiguration = ref.read(appReviewConfigurationProvider);
      if (reviewConfiguration.matchesSession(session)) {
        ref.read(appReviewModeProvider.notifier).setEnabled(true);
      }
    }
    await _gateway.ensureEmbeddedWallet();
    if (!_isCurrent(operation) ||
        ref.read(sessionGenerationProvider).value != generation) {
      return;
    }
    _pendingWalletSync = (session: session, principal: principal);
    await _completeSession(operation, session, principal);
  }

  Future<void> _completeSession(
    int operation,
    ProductSession session,
    IdentityPrincipal principal,
  ) async {
    final generation = session.generation;
    _requireUsableSession(session);
    if (!await _syncWallet(session, operation: operation)) return;
    _requireUsableSession(session);
    await _activateNotifications(session.account.settings);
    if (!_isCurrent(operation) ||
        ref.read(sessionGenerationProvider).value != generation) {
      return;
    }
    await ref
        .read(observabilityReporterProvider)
        .setUserId(session.account.userId);
    if (!_isCurrent(operation) ||
        ref.read(sessionGenerationProvider).value != generation) {
      await ref.read(observabilityReporterProvider).clearUser();
      return;
    }
    // The session can expire while synchronization or optional setup is pending.
    _requireUsableSession(session);
    _pendingWalletSync = null;
    _activeEmail = null;
    state = AuthenticationAuthenticated(session, principal: principal);
  }

  bool get _emailEnabled => PrivyConfiguration.loginMethods.contains('email');

  void _updateAppReviewMode(IdentityPrincipal principal) {
    if (!AppReviewConfiguration.buildEnabled) return;
    final configuration = ref.read(appReviewConfigurationProvider);
    ref
        .read(appReviewModeProvider.notifier)
        .setEnabled(configuration.matchesPrincipal(principal));
  }

  void _clearAppReviewMode() {
    if (!AppReviewConfiguration.buildEnabled) return;
    ref.read(appReviewModeProvider.notifier).clear();
  }

  String? _normalizeEmail(String value) {
    final email = value.trim().toLowerCase();
    final valid = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(email);
    return valid ? email : null;
  }

  bool _isCurrent(int operation) => ref.mounted && operation == _epoch;

  void _requireUsableSession(ProductSession session) {
    if (session.isExpired) {
      throw const IdentityFailure(
        AuthenticationFailureCode.expired,
        retryable: true,
      );
    }
  }

  Future<void> _disconnectWallet() {
    final connection = _walletConnection;
    _walletConnection = null;
    if (connection == null) {
      return _walletDisconnectInFlight ?? Future<void>.value();
    }
    final disconnect = _disconnectConnection(
      connection,
      after: _walletDisconnectInFlight,
    );
    _walletDisconnectInFlight = disconnect;
    return disconnect;
  }

  Future<void> _disconnectConnection(
    WalletConnection connection, {
    Future<void>? after,
  }) async {
    if (after != null) await after;
    try {
      await connection.disconnect();
    } catch (_) {
      // Local wallet disconnect failures do not invalidate a completed logout.
    }
  }

  Future<ProductSession> _createBackendSession({
    required String? language,
    required int generation,
  }) async {
    final repository = ref.read(sessionRepositoryProvider);
    for (var attempt = 0; attempt < 2; attempt++) {
      try {
        return await repository.createOrRestore(
          language: language,
          generation: generation,
        );
      } on ApiFailure catch (failure) {
        if (attempt == 0 && failure.retryable) {
          await Future<void>.delayed(const Duration(milliseconds: 250));
          continue;
        }
        throw IdentityFailure(
          failure is AuthenticationFailure
              ? AuthenticationFailureCode.expired
              : AuthenticationFailureCode.backendSession,
          retryable: failure.retryable,
          requestId: failure.requestId,
        );
      }
    }
    throw StateError('Backend session creation exhausted its retry budget');
  }

  Future<bool> _syncWallet(
    ProductSession session, {
    required int operation,
  }) async {
    final repository = ref.read(walletsRepositoryProvider);
    // A lost response must replay the same logical sync, even if the backend
    // already completed it. Keep the key stable across all attempts.
    final idempotencyKey = scopedIdempotencyKey(
      'wallet-sync-${session.sessionId}',
    );
    for (var attempt = 0; attempt < 3; attempt++) {
      if (!_isCurrent(operation) ||
          ref.read(sessionGenerationProvider).value != session.generation) {
        return false;
      }
      try {
        await repository.syncWallet(idempotencyKey: idempotencyKey);
        return _isCurrent(operation) &&
            ref.read(sessionGenerationProvider).value == session.generation;
      } on ApiFailure catch (failure) {
        if (attempt < 2 && failure.retryable) {
          await Future<void>.delayed(
            Duration(milliseconds: 250 * (1 << attempt)),
          );
          continue;
        }
        throw IdentityFailure(
          AuthenticationFailureCode.walletSync,
          retryable: failure.retryable,
          requestId: failure.requestId,
        );
      }
    }
    throw StateError('Wallet synchronization exhausted its retry budget');
  }

  Future<void> _activateNotifications(UserPreferences preferences) async {
    if (_isAppReviewMode) return;
    try {
      await ref.read(pushNotificationCoordinatorProvider).activate(preferences);
    } catch (_) {
      // Push setup is optional and must not prevent an authenticated session.
    }
  }

  Future<void> _deactivateNotifications() async {
    try {
      await ref.read(pushNotificationCoordinatorProvider).deactivate();
    } catch (_) {
      // Local sign-out remains available when device deregistration is offline.
    }
  }

  bool get _isAppReviewMode =>
      AppReviewConfiguration.buildEnabled && ref.read(appReviewModeProvider);
}
