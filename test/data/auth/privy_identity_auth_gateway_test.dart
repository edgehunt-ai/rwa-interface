import 'package:flutter_test/flutter_test.dart';
import 'package:privy_flutter/privy_flutter.dart';
import 'package:privy_flutter/src/modules/email/login_with_email.dart';
import 'package:privy_flutter/src/modules/login_with_siwe/login_with_siwe.dart';
import 'package:privy_flutter/src/modules/oauth/login_with_oauth.dart';
import 'package:rwa_interface/data/auth/privy_identity_auth_gateway.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';
import 'package:rwa_interface/domain/models/wallet_action_execution.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
import 'package:rwa_interface/domain/services/wallet_authorization_signer.dart';

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
    late String capturedOperation;
    late String capturedDiagnostic;
    final email = _FakeEmail(
      sendResult: const Success(null),
      loginResult: const Failure(
        PrivyException(
          'invalid otp 123456 for user@example.com with Bearer token-value',
        ),
      ),
    );
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) =>
          _FakePrivy(authState: const Unauthenticated(), email: email),
      reportDiagnostic: ({required operation, required message}) {
        capturedOperation = operation;
        capturedDiagnostic = message;
      },
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
    expect(capturedOperation, 'verify_email_code');
    expect(
      capturedDiagnostic,
      'invalid otp <redacted-code> for <redacted-email> with Bearer <redacted>',
    );
  });

  test(
    'maps an invalid email and code combination as an invalid code',
    () async {
      final email = _FakeEmail(
        sendResult: const Success(null),
        loginResult: const Failure(
          PrivyException('Invalid email and code combination'),
        ),
      );
      final gateway = PrivyIdentityAuthGateway(
        createPrivy: (_) =>
            _FakePrivy(authState: const Unauthenticated(), email: email),
      );
      await gateway.initialize(configuration);

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
    },
  );

  test('reports an unavailable OAuth browser separately', () async {
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) => _FakePrivy(
        authState: const Unauthenticated(),
        oauth: _FakeOAuth(
          loginResult: const Failure(
            PrivyException('Failed to launch OAuth browser'),
          ),
        ),
      ),
    );
    await gateway.initialize(configuration);

    await expectLater(
      gateway.loginWithOAuth('google'),
      throwsA(
        isA<IdentityFailure>().having(
          (failure) => failure.code,
          'code',
          AuthenticationFailureCode.browserUnavailable,
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

  test('signs in with the Reown wallet through Privy SIWE', () async {
    final user = _FakeUser(id: 'did:privy:wallet', token: 'wallet-token');
    final siwe = _FakeSiwe(loginResult: Success(user));
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) =>
          _FakePrivy(authState: const Unauthenticated(), siwe: siwe),
    );
    await gateway.initialize(configuration);
    final wallet = _WalletConnection();

    final principal = await gateway.loginWithWallet(wallet);

    expect(principal.id, 'did:privy:wallet');
    expect(siwe.generatedParams?.appDomain, 'rwa.dxd.ink');
    expect(siwe.generatedParams?.appUri, 'https://rwa.dxd.ink');
    expect(siwe.generatedParams?.chainId, '1');
    expect(siwe.generatedParams?.walletAddress, wallet.address);
    expect(wallet.signedMessage, 'Sign in with Ethereum');
    expect(siwe.submittedSignature, '0xsignature');
    expect(await gateway.getAccessToken(), 'wallet-token');
  });

  test('uses the authenticated external wallet for HIP-3 typed data', () async {
    final user = _FakeUser(id: 'did:privy:wallet', token: 'wallet-token');
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) => _FakePrivy(
        authState: const Unauthenticated(),
        siwe: _FakeSiwe(loginResult: Success(user)),
      ),
    );
    await gateway.initialize(configuration);
    final wallet = _WalletConnection();
    await gateway.loginWithWallet(wallet);
    final typedData = <String, Object?>{
      'primaryType': 'Agent',
      'message': <String, Object?>{'source': 'b'},
    };

    final signature = await gateway.signTypedDataV4(
      expectedSigner: wallet.address,
      typedData: typedData,
    );

    expect(signature, '0x${List.filled(64, '11').join()}1b');
    expect(wallet.signedTypedData, same(typedData));
  });

  test(
    'selects the exact Privy embedded wallet requested by backend',
    () async {
      final expected = EmbeddedEthereumWallet(
        address: '0x0000000000000000000000000000000000000002',
        hdWalletIndex: 1,
      );
      final user = _FakeUser(
        id: 'did:privy:1',
        token: 'token',
        ethereumWallets: [
          EmbeddedEthereumWallet(
            address: '0x0000000000000000000000000000000000000001',
            hdWalletIndex: 0,
          ),
          expected,
        ],
      );
      EthereumRpcRequest? captured;
      final gateway = PrivyIdentityAuthGateway(
        createPrivy: (_) => _FakePrivy(authState: Authenticated(user)),
        requestTypedData: (wallet, request) async {
          expect(wallet.address, expected.address);
          captured = request;
          return Success(
            EthereumRpcResponse(
              method: request.method,
              data: '0x${List.filled(64, '22').join()}1c',
            ),
          );
        },
      );
      await gateway.initialize(configuration);

      final signature = await gateway.signTypedDataV4(
        expectedSigner: expected.address.toUpperCase().replaceFirst('0X', '0x'),
        typedData: const {'primaryType': 'Agent'},
      );

      expect(signature, '0x${List.filled(64, '22').join()}1c');
      expect(captured?.method, 'eth_signTypedData_v4');
      expect(captured?.params.first, expected.address);
      expect(captured?.params.last, '{"primaryType":"Agent"}');
    },
  );

  test('fails closed when expected signer is not an owned wallet', () async {
    final gateway = PrivyIdentityAuthGateway(
      createPrivy: (_) => _FakePrivy(
        authState: Authenticated(_FakeUser(id: 'user', token: 'token')),
      ),
    );
    await gateway.initialize(configuration);

    await expectLater(
      gateway.signTypedDataV4(
        expectedSigner: '0x0000000000000000000000000000000000000009',
        typedData: const {'primaryType': 'Agent'},
      ),
      throwsA(
        isA<Hip3SigningFailure>().having(
          (failure) => failure.code,
          'code',
          Hip3SigningFailureCode.walletMismatch,
        ),
      ),
    );
  });

  group('Privy authorization signatures', () {
    WalletAuthorizationRequest request({String? from, String? url}) =>
        WalletAuthorizationRequest(
          version: 1,
          method: 'POST',
          url: url ?? 'https://api.privy.io/v1/wallets/wallet-1/rpc',
          headers: const {
            'privy-app-id': 'app-id',
            'privy-idempotency-key': 'privy-key-1',
            'privy-request-expiry': '1780000000000',
          },
          body: const {
            'method': 'eth_sendTransaction',
            'sponsor': true,
            'reference_id': 'execution-1',
          },
          referenceId: 'execution-1',
          sponsor: true,
          caip2: 'eip155:56',
          transaction: AuthorizedTransaction(
            from: from ?? '0x0000000000000000000000000000000000000002',
            to: '0x0000000000000000000000000000000000000003',
            data: '0xa9059cbb',
            value: '0x0',
          ),
        );

    EmbeddedEthereumWallet wallet() => EmbeddedEthereumWallet(
      address: '0x0000000000000000000000000000000000000002',
      hdWalletIndex: 0,
    );

    test('signs the server payload verbatim', () async {
      WalletApiPayload? captured;
      final gateway = PrivyIdentityAuthGateway(
        createPrivy: (_) => _FakePrivy(
          authState: Authenticated(
            _FakeUser(id: 'user', token: 'token', ethereumWallets: [wallet()]),
          ),
        ),
        signAuthorization: (_, payload) async {
          captured = payload;
          return const Success('privy-signature');
        },
      );
      await gateway.initialize(configuration);

      final signature = await gateway.signWalletAuthorization(
        expectedSigner: wallet().address.toUpperCase().replaceFirst('0X', '0x'),
        request: request(),
      );

      expect(signature, 'privy-signature');
      expect(captured?.version, 1);
      expect(captured?.method, 'POST');
      expect(captured?.url, 'https://api.privy.io/v1/wallets/wallet-1/rpc');
      expect(captured?.headers['privy-idempotency-key'], 'privy-key-1');
      expect(captured?.body['reference_id'], 'execution-1');
    });

    test('fails closed when the payload binds another wallet', () async {
      var signed = false;
      final gateway = PrivyIdentityAuthGateway(
        createPrivy: (_) => _FakePrivy(
          authState: Authenticated(
            _FakeUser(id: 'user', token: 'token', ethereumWallets: [wallet()]),
          ),
        ),
        signAuthorization: (_, _) async {
          signed = true;
          return const Success('privy-signature');
        },
      );
      await gateway.initialize(configuration);

      await expectLater(
        gateway.signWalletAuthorization(
          expectedSigner: '0x0000000000000000000000000000000000000009',
          request: request(from: '0x0000000000000000000000000000000000000009'),
        ),
        throwsA(
          isA<WalletAuthorizationFailure>().having(
            (failure) => failure.code,
            'code',
            WalletAuthorizationFailureCode.walletMismatch,
          ),
        ),
      );
      expect(signed, isFalse);
    });

    test('preserves provider error when authorization signing fails', () async {
      final gateway = PrivyIdentityAuthGateway(
        createPrivy: (_) => _FakePrivy(
          authState: Authenticated(
            _FakeUser(id: 'user', token: 'token', ethereumWallets: [wallet()]),
          ),
        ),
        signAuthorization: (_, _) async => const Failure(
          PrivyException(
            'GENERATE_AUTHORIZATION_SIGNATURE_ERROR: EIP-7702 unsupported',
          ),
        ),
      );
      await gateway.initialize(configuration);

      await expectLater(
        gateway.signWalletAuthorization(
          expectedSigner: wallet().address,
          request: request(),
        ),
        throwsA(
          isA<WalletAuthorizationFailure>()
              .having(
                (failure) => failure.code,
                'code',
                WalletAuthorizationFailureCode.rejected,
              )
              .having(
                (failure) => failure.reason,
                'reason',
                contains('EIP-7702 unsupported'),
              ),
        ),
      );
    });

    test('refuses a request aimed anywhere but the Privy wallet API', () async {
      var signed = false;
      final gateway = PrivyIdentityAuthGateway(
        createPrivy: (_) => _FakePrivy(
          authState: Authenticated(
            _FakeUser(id: 'user', token: 'token', ethereumWallets: [wallet()]),
          ),
        ),
        signAuthorization: (_, _) async {
          signed = true;
          return const Success('privy-signature');
        },
      );
      await gateway.initialize(configuration);

      await expectLater(
        gateway.signWalletAuthorization(
          expectedSigner: wallet().address,
          request: request(url: 'https://attacker.example/v1/wallets/1/rpc'),
        ),
        throwsA(
          isA<WalletAuthorizationFailure>().having(
            (failure) => failure.code,
            'code',
            WalletAuthorizationFailureCode.invalidPayload,
          ),
        ),
      );
      expect(signed, isFalse);
    });

    test('external wallets cannot produce authorization signatures', () async {
      final user = _FakeUser(id: 'did:privy:wallet', token: 'wallet-token');
      final gateway = PrivyIdentityAuthGateway(
        createPrivy: (_) => _FakePrivy(
          authState: const Unauthenticated(),
          siwe: _FakeSiwe(loginResult: Success(user)),
        ),
      );
      await gateway.initialize(configuration);
      final connection = _WalletConnection();
      await gateway.loginWithWallet(connection);

      await expectLater(
        gateway.signWalletAuthorization(
          expectedSigner: connection.address,
          request: request(from: connection.address),
        ),
        throwsA(
          isA<WalletAuthorizationFailure>().having(
            (failure) => failure.code,
            'code',
            WalletAuthorizationFailureCode.unsupportedWallet,
          ),
        ),
      );
    });
  });
}

final class _FakePrivy implements Privy {
  _FakePrivy({
    required this.authState,
    LoginWithEmail? email,
    LoginWithSiwe? siwe,
    LoginWithOAuth? oauth,
    this.logoutError,
  }) : _email = email ?? _FakeEmail(),
       _siwe = siwe ?? _FakeSiwe(),
       _oauth = oauth ?? _FakeOAuth();

  final AuthState authState;
  final LoginWithEmail _email;
  final LoginWithSiwe _siwe;
  final LoginWithOAuth _oauth;
  final Object? logoutError;

  @override
  LoginWithEmail get email => _email;

  @override
  LoginWithSiwe get siwe => _siwe;

  @override
  LoginWithOAuth get oAuth => _oauth;

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

final class _FakeOAuth implements LoginWithOAuth {
  _FakeOAuth({Result<PrivyUser>? loginResult})
    : _loginResult =
          loginResult ?? Success(_FakeUser(id: 'user', token: 'token'));

  final Result<PrivyUser> _loginResult;

  @override
  Future<Result<PrivyUser>> login({
    required OAuthProvider provider,
    required String appUrlScheme,
  }) async => _loginResult;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _FakeUser implements PrivyUser {
  _FakeUser({
    required this.id,
    required this.token,
    this.ethereumWallets = const [],
  });

  @override
  final String id;
  final String token;
  final List<EmbeddedEthereumWallet> ethereumWallets;
  int refreshCalls = 0;

  @override
  List<EmbeddedEthereumWallet> get embeddedEthereumWallets => ethereumWallets;

  @override
  List<LinkedAccounts> get linkedAccounts => const [];

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

final class _FakeSiwe implements LoginWithSiwe {
  _FakeSiwe({Result<PrivyUser>? loginResult})
    : _loginResult =
          loginResult ??
          Success(_FakeUser(id: 'did:privy:wallet', token: 'wallet-token'));

  final Result<PrivyUser> _loginResult;
  SiweMessageParams? generatedParams;
  String? submittedSignature;

  @override
  Future<Result<String>> generateMessage(SiweMessageParams params) async {
    generatedParams = params;
    return const Success('Sign in with Ethereum');
  }

  @override
  Future<Result<PrivyUser>> login({
    required String message,
    required String signature,
    required SiweMessageParams params,
    WalletLoginMetadata? metadata,
  }) async {
    submittedSignature = signature;
    return _loginResult;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _WalletConnection implements WalletConnection {
  String? signedMessage;
  Map<String, Object?>? signedTypedData;

  @override
  String get address => '0x0000000000000000000000000000000000000001';

  @override
  String get chainId => '1';

  @override
  String get connectorType => 'walletconnect';

  @override
  Future<void> disconnect() async {}

  @override
  Future<String> signPersonalMessage(String message) async {
    signedMessage = message;
    return '0xsignature';
  }

  @override
  Future<String> signTypedDataV4(Map<String, Object?> typedData) async {
    signedTypedData = typedData;
    return '0x${List.filled(64, '11').join()}1b';
  }
}
