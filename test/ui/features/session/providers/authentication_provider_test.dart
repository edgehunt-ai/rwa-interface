import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/config/privy_configuration.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/models/wallet.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/session_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';

import '../../../../helpers/fake_identity_auth_gateway.dart';

void main() {
  test('bootstrap restores identity and establishes product session', () async {
    final gateway = FakeIdentityAuthGateway(
      restoredPrincipal: const IdentityPrincipal('did:privy:1'),
    );
    final repository = _SessionRepository();
    final wallets = _WalletsRepository();
    final container = _container(gateway, repository, wallets: wallets);

    await container.read(authenticationProvider.notifier).bootstrap();

    expect(gateway.configuration?.appId, 'app-id');
    expect(repository.createCalls, 1);
    expect(gateway.ensureEmbeddedWalletCalls, 1);
    expect(wallets.syncCalls, 1);
    expect(wallets.lastIdempotencyKey, 'wallet-sync-session-1');
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationAuthenticated>(),
    );
  });

  test(
    'embedded wallet is provisioned before syncing a wallet-less new signup',
    () async {
      final gateway = FakeIdentityAuthGateway(
        restoredPrincipal: const IdentityPrincipal('did:privy:1'),
      );
      final wallets = _WalletsRepository();
      final container = _container(
        gateway,
        _SessionRepository(),
        wallets: wallets,
      );

      await container.read(authenticationProvider.notifier).bootstrap();

      expect(gateway.ensureEmbeddedWalletCalls, 1);
      expect(wallets.syncCalls, 1);
      expect(
        container.read(authenticationProvider),
        isA<AuthenticationAuthenticated>(),
      );
    },
  );

  test(
    'embedded wallet provisioning failure prevents the wallet sync call',
    () async {
      final gateway =
          FakeIdentityAuthGateway(
              restoredPrincipal: const IdentityPrincipal('did:privy:1'),
            )
            ..ensureEmbeddedWalletFailure = const IdentityFailure(
              AuthenticationFailureCode.provider,
              retryable: true,
            );
      final wallets = _WalletsRepository();
      final container = _container(
        gateway,
        _SessionRepository(),
        wallets: wallets,
      );

      await container.read(authenticationProvider.notifier).bootstrap();

      expect(gateway.ensureEmbeddedWalletCalls, 1);
      expect(wallets.syncCalls, 0);
      final state = container.read(authenticationProvider);
      expect(state, isA<AuthenticationFailed>());
      expect(
        (state as AuthenticationFailed).failure.code,
        AuthenticationFailureCode.provider,
      );
    },
  );

  test('bootstrap without restored identity becomes unauthenticated', () async {
    final container = _container(
      FakeIdentityAuthGateway(),
      _SessionRepository(),
    );
    await container.read(authenticationProvider.notifier).bootstrap();
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationUnauthenticated>(),
    );
  });

  test(
    'wallet sync failure is reported separately from Privy authentication',
    () async {
      final gateway = FakeIdentityAuthGateway(
        restoredPrincipal: const IdentityPrincipal('did:privy:1'),
      );
      final wallets = _WalletsRepository()
        ..syncFailure = const NetworkFailure(requestId: 'wallet-request-id');
      final container = _container(
        gateway,
        _SessionRepository(),
        wallets: wallets,
      );

      await container.read(authenticationProvider.notifier).bootstrap();

      expect(wallets.syncCalls, 1);
      final state = container.read(authenticationProvider);
      expect(state, isA<AuthenticationFailed>());
      final failure = (state as AuthenticationFailed).failure;
      expect(failure.code, AuthenticationFailureCode.walletSync);
      expect(failure.requestId, 'wallet-request-id');
    },
  );

  test(
    'backend session failure is reported separately from Privy authentication',
    () async {
      final repository = _SessionRepository()
        ..createFailure = const ServerFailure(
          statusCode: 503,
          code: 'service_unconfigured',
          requestId: 'session-request-id',
          retryable: true,
        );
      final container = _container(FakeIdentityAuthGateway(), repository);
      final notifier = container.read(authenticationProvider.notifier);
      await notifier.bootstrap();
      await notifier.requestEmailCode('user@example.com');

      await notifier.verifyEmailCode('123456');

      final state =
          container.read(authenticationProvider) as AuthenticationAwaitingCode;
      expect(state.failure?.code, AuthenticationFailureCode.backendSession);
      expect(state.failure?.requestId, 'session-request-id');
    },
  );

  test('email is normalized and valid code establishes session', () async {
    final gateway = FakeIdentityAuthGateway(
      verifiedPrincipal: const IdentityPrincipal(
        'privy-user',
        displayName: 'privy@example.com',
      ),
    );
    final repository = _SessionRepository();
    final container = _container(gateway, repository);
    final notifier = container.read(authenticationProvider.notifier);
    await notifier.bootstrap();

    await notifier.requestEmailCode('  USER@Example.COM ');
    expect(gateway.requestedEmail, 'user@example.com');
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationAwaitingCode>(),
    );

    await notifier.verifyEmailCode('123456');
    expect(gateway.verifiedEmail, 'user@example.com');
    expect(gateway.verifiedCode, '123456');
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationAuthenticated>(),
    );
    expect(
      (container.read(
        authenticationProvider,
      ) as AuthenticationAuthenticated).principal.displayName,
      'privy@example.com',
    );
  });

  test('cancelling an email challenge returns to login methods', () async {
    final gateway = FakeIdentityAuthGateway();
    final container = _container(gateway, _SessionRepository());
    final notifier = container.read(authenticationProvider.notifier);

    await notifier.bootstrap();
    await notifier.requestEmailCode('user@example.com');
    notifier.cancelEmailCode();

    expect(
      container.read(authenticationProvider),
      isA<AuthenticationUnauthenticated>(),
    );
  });

  test('invalid email is rejected before gateway invocation', () async {
    final gateway = FakeIdentityAuthGateway();
    final container = _container(gateway, _SessionRepository());
    final notifier = container.read(authenticationProvider.notifier);
    await notifier.bootstrap();

    await notifier.requestEmailCode('not-an-email');

    expect(gateway.requestedEmail, isNull);
    final state =
        container.read(authenticationProvider) as AuthenticationUnauthenticated;
    expect(state.failure?.code, AuthenticationFailureCode.invalidInput);
  });

  test('wallet signature login establishes a product session', () async {
    final gateway = FakeIdentityAuthGateway();
    final repository = _SessionRepository();
    final container = _container(gateway, repository);
    final notifier = container.read(authenticationProvider.notifier);
    await notifier.bootstrap();
    final wallet = _WalletConnection();

    await notifier.loginWithWallet(() async => wallet);

    expect(gateway.walletConnection, same(wallet));
    expect(repository.createCalls, 1);
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationAuthenticated>(),
    );
  });

  test('provider-owned login establishes a product session', () async {
    final gateway = FakeIdentityAuthGateway();
    final repository = _SessionRepository();
    final container = _container(gateway, repository);
    final notifier = container.read(authenticationProvider.notifier);
    await notifier.bootstrap();

    await notifier.login();

    expect(repository.createCalls, 1);
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationAuthenticated>(),
    );
  });

  test('wallet login failure disconnects the connected wallet', () async {
    final gateway = FakeIdentityAuthGateway()
      ..walletLoginFailure = const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: true,
      );
    final container = _container(gateway, _SessionRepository());
    final notifier = container.read(authenticationProvider.notifier);
    await notifier.bootstrap();
    final wallet = _WalletConnection();

    await notifier.loginWithWallet(() async => wallet);

    expect(wallet.disconnectCalls, 1);
    final state =
        container.read(authenticationProvider) as AuthenticationUnauthenticated;
    expect(state.failure?.code, AuthenticationFailureCode.provider);
  });

  test('failed code preserves challenge for retry with safe failure', () async {
    final gateway = FakeIdentityAuthGateway()
      ..verifyFailure = const IdentityFailure(
        AuthenticationFailureCode.invalidCode,
        retryable: true,
      );
    final container = _container(gateway, _SessionRepository());
    final notifier = container.read(authenticationProvider.notifier);
    await notifier.bootstrap();
    await notifier.requestEmailCode('user@example.com');

    await notifier.verifyEmailCode('bad-code');

    final state =
        container.read(authenticationProvider) as AuthenticationAwaitingCode;
    expect(state.email, 'user@example.com');
    expect(state.failure?.code, AuthenticationFailureCode.invalidCode);
  });

  test('logout invalidates an in-flight bootstrap result', () async {
    final barrier = Completer<void>();
    final gateway = FakeIdentityAuthGateway(
      restoredPrincipal: const IdentityPrincipal('did:privy:1'),
    )..initializeBarrier = barrier.future;
    final repository = _SessionRepository();
    final container = _container(gateway, repository);
    final notifier = container.read(authenticationProvider.notifier);

    final bootstrap = notifier.bootstrap();
    await Future<void>.delayed(Duration.zero);
    await notifier.logout();
    barrier.complete();
    await bootstrap;

    expect(
      container.read(authenticationProvider),
      isA<AuthenticationUnauthenticated>(),
    );
    expect(repository.createCalls, 0);
  });

  test('unsupported platform does not initialize Privy', () async {
    final repository = _SessionRepository();
    final container = _container(
      FakeIdentityAuthGateway(supported: false),
      repository,
    );

    await container.read(authenticationProvider.notifier).bootstrap();

    expect(
      container.read(authenticationProvider),
      isA<AuthenticationUnsupported>(),
    );
    expect(repository.createCalls, 0);
  });
}

ProviderContainer _container(
  FakeIdentityAuthGateway gateway,
  _SessionRepository repository, {
  _WalletsRepository? wallets,
}) {
  final container = ProviderContainer(
    overrides: [
      identityAuthGatewayProvider.overrideWithValue(gateway),
      privyConfigurationProvider.overrideWithValue(
        const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
      ),
      sessionRepositoryProvider.overrideWithValue(repository),
      walletsRepositoryProvider.overrideWithValue(
        wallets ?? _WalletsRepository(),
      ),
    ],
  );
  addTearDown(container.dispose);
  container.listen(authenticationProvider, (_, _) {});
  return container;
}

final class _SessionRepository implements SessionRepository {
  int createCalls = 0;
  int logoutCalls = 0;
  ApiFailure? createFailure;

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) async {
    createCalls++;
    if (createFailure case final failure?) throw failure;
    return ProductSession(
      sessionId: 'session-1',
      createdAt: DateTime.utc(2026),
      expiresAt: DateTime.utc(2027),
      generation: generation,
      accountCreated: true,
      account: const UserAccount(
        userId: 'user-1',
        settings: UserPreferences(
          language: 'en',
          pushEnabled: true,
          notifyOrderFilled: true,
          notifyOrderFailed: true,
          notifyLiquidationWarning: true,
        ),
      ),
    );
  }

  @override
  Future<void> endSession() async {
    logoutCalls++;
  }
}

final class _WalletsRepository implements WalletsRepository {
  int syncCalls = 0;
  String? lastIdempotencyKey;
  ApiFailure? syncFailure;

  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async {
    syncCalls++;
    lastIdempotencyKey = idempotencyKey;
    if (syncFailure case final failure?) throw failure;
    return Wallet(
      walletId: 'wallet-1',
      address: '0x1',
      chain: 'ethereum',
      status: WalletState.active,
      createdAt: DateTime.utc(2026),
    );
  }

  @override
  Future<DomainPage<Wallet>> listWallets({String? cursor}) =>
      throw UnimplementedError();

  @override
  Future<WalletAuthorization> authorizeWithdrawal({
    required String walletId,
    required String quoteId,
    required String amount,
    required String idempotencyKey,
  }) => throw UnimplementedError();

  @override
  Future<WalletAuthorization> authorizeFundingTransfer({
    required String walletId,
    required String planId,
    required String asset,
    required String maximumAmount,
    required String idempotencyKey,
  }) => throw UnimplementedError();
}

final class _WalletConnection implements WalletConnection {
  int disconnectCalls = 0;

  @override
  String get address => '0x0000000000000000000000000000000000000001';

  @override
  String get chainId => '1';

  @override
  String get connectorType => 'walletconnect';

  @override
  Future<void> disconnect() async {
    disconnectCalls++;
  }

  @override
  Future<String> signPersonalMessage(String message) async => '0xsignature';

  @override
  Future<String> signTypedDataV4(Map<String, Object?> typedData) async =>
      '0xsignature';
}
