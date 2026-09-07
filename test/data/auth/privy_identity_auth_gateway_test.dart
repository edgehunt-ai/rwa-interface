import 'package:flutter_test/flutter_test.dart';
import 'package:privy_flutter/privy_flutter.dart';
import 'package:privy_flutter/src/modules/email/login_with_email.dart';
import 'package:rwa_interface/data/auth/privy_identity_auth_gateway.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';

void main() {
  const configuration = IdentityConfiguration(
    appId: 'app-id',
    clientId: 'client-id',
  );

  test('initializes with disabled SDK logging and restores user', () async {
    final user = _FakeUser(id: 'did:privy:1', token: 'token');
    late PrivyConfig captured;
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (config) {
        captured = config;
        return _FakePrivy(authState: Authenticated(user));
      },
    );

    final principal = await gateway.initialize(configuration);

    expect(principal?.id, 'did:privy:1');
    expect(captured.appId, 'app-id');
    expect(captured.appClientId, 'client-id');
    expect(captured.logLevel, PrivyLogLevel.none);
    expect(await gateway.getAccessToken(), 'token');
  });

  test('unauthenticated restore returns null', () async {
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) => _FakePrivy(authState: const Unauthenticated()),
    );
    expect(await gateway.initialize(configuration), isNull);
  });

  test('maps email code failure without exposing provider exception', () async {
    final email = _FakeEmail(
      sendResult: const Success(null),
      loginResult: const Failure(PrivyException('invalid otp 123456')),
    );
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) =>
          _FakePrivy(authState: const Unauthenticated(), email: email),
    );
    await gateway.initialize(configuration);
    await gateway.requestEmailCode('user@example.com');

    await expectLater(
      gateway.verifyEmailCode(email: 'user@example.com', code: '123456'),
      throwsA(
        isA<IdentityFailure>().having(
          (failure) => failure.code,
          'code',
          AuthenticationFailureCode.invalidCode,
        ),
      ),
    );
  });

  test('refreshes user before returning replacement token', () async {
    final user = _FakeUser(id: 'did:privy:1', token: 'fresh');
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) => _FakePrivy(authState: Authenticated(user)),
    );
    await gateway.initialize(configuration);

    expect(await gateway.refreshAccessToken(), 'fresh');
    expect(user.refreshCalls, 1);
  });

  test('logout clears cached user even when provider throws', () async {
    final user = _FakeUser(id: 'did:privy:1', token: 'token');
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) => _FakePrivy(
        authState: Authenticated(user),
        logoutError: StateError('provider unavailable'),
      ),
    );
    await gateway.initialize(configuration);
    await expectLater(gateway.logout(), throwsA(isA<IdentityFailure>()));
    expect(await gateway.getAccessToken(), isNull);
  });
}

final class _FakePrivy implements Privy {
  _FakePrivy({required this.authState, LoginWithEmail? email, this.logoutError})
    : _email = email ?? _FakeEmail();

  final AuthState authState;
  final LoginWithEmail _email;
  final Object? logoutError;

  @override
  LoginWithEmail get email => _email;

  @override
  Future<AuthState> getAuthState() async => authState;

  @override
  Future<PrivyUser?> getUser() async => authState.user;

  @override
  Future<void> logout() async {
    if (logoutError case final error?) throw error;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FakeEmail implements LoginWithEmail {
  _FakeEmail({Result<void>? sendResult, Result<PrivyUser>? loginResult})
    : sendResult = sendResult ?? const Success(null),
      loginResult =
          loginResult ?? Success(_FakeUser(id: 'user', token: 'token'));

  final Result<void> sendResult;
  final Result<PrivyUser> loginResult;

  @override
  Future<Result<void>> sendCode(String email) async => sendResult;

  @override
  Future<Result<PrivyUser>> loginWithCode({
    required String code,
    required String email,
  }) async => loginResult;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FakeUser implements PrivyUser {
  _FakeUser({required this.id, required this.token});

  @override
  final String id;
  final String token;
  int refreshCalls = 0;

  @override
  Future<Result<String>> getAccessToken() async => Success(token);

  @override
  Future<Result<void>> refresh() async {
    refreshCalls++;
    return const Success(null);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
