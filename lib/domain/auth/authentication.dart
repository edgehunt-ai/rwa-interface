import '../models/product_session.dart';

enum AuthenticationFailureCode {
  invalidInput,
  methodUnavailable,
  invalidCode,
  network,
  browserUnavailable,
  configuration,
  expired,
  backendSession,
  walletSync,
  provider,
  unsupportedPlatform,
}

final class IdentityFailure implements Exception {
  const IdentityFailure(this.code, {required this.retryable, this.requestId});

  final AuthenticationFailureCode code;
  final bool retryable;
  final String? requestId;
}

final class IdentityConfiguration {
  const IdentityConfiguration({required this.appId, required this.clientId});

  final String appId;
  final String clientId;
}

final class IdentityPrincipal {
  const IdentityPrincipal(this.id, {this.displayName});

  final String id;
  final String? displayName;
}

sealed class AuthenticationState {
  const AuthenticationState();
}

final class AuthenticationInitializing extends AuthenticationState {
  const AuthenticationInitializing();
}

final class AuthenticationUnauthenticated extends AuthenticationState {
  const AuthenticationUnauthenticated({this.failure});

  final IdentityFailure? failure;
}

final class AuthenticationAwaitingCode extends AuthenticationState {
  const AuthenticationAwaitingCode(this.email, {this.failure});

  final String email;
  final IdentityFailure? failure;
}

final class AuthenticationAuthenticating extends AuthenticationState {
  const AuthenticationAuthenticating({this.email});

  final String? email;
}

final class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated(this.session, {required this.principal});

  final ProductSession session;
  final IdentityPrincipal principal;
}

final class AuthenticationFailed extends AuthenticationState {
  const AuthenticationFailed(this.failure);

  final IdentityFailure failure;
}

final class AuthenticationUnsupported extends AuthenticationState {
  const AuthenticationUnsupported()
    : failure = const IdentityFailure(
        AuthenticationFailureCode.unsupportedPlatform,
        retryable: false,
      );

  final IdentityFailure failure;
}
