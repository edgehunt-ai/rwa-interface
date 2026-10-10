import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/config/privy_configuration.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/auth_providers.dart';
import 'package:nobell/app/providers/locale_provider.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/data/api/idempotency_key.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/auth/identity_auth_gateway.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/product_session.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/domain/models/wallet.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/domain/repositories/session_repository.dart';
import 'package:nobell/domain/repositories/wallets_repository.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';

import '../../../../helpers/fake_identity_auth_gateway.dart';

void main() {
  for (final (language, locale) in [
    ('zh-CN', const Locale('zh')),
    ('en', const Locale('en')),
  ]) {
    test(
      'bootstrap applies saved $language without opening settings',
      () async {
        final container = _container(
          FakeIdentityAuthGateway(
            restoredPrincipal: const IdentityPrincipal('did:privy:1'),
          ),
          _SessionRepository()..savedLanguage = language,
        );
        final subscription = container.listen(appLocaleProvider, (_, _) {});
        addTearDown(subscription.close);
        expect(container.read(appLocaleProvider), isNull);

        await container.read(authenticationProvider.notifier).bootstrap();

        expect(container.read(appLocaleProvider), locale);
      },
    );
  }

  test('logout clears language before restoring another account', () async {
    final repository = _SessionRepository()..savedLanguage = 'zh-CN';
    final container = _container(
      FakeIdentityAuthGateway(
        restoredPrincipal: const IdentityPrincipal('did:privy:1'),
      ),
      repository,
    );
    final subscription = container.listen(appLocaleProvider, (_, _) {});
    addTearDown(subscription.close);
    final notifier = container.read(authenticationProvider.notifier);
    await notifier.bootstrap();
    expect(container.read(appLocaleProvider), const Locale('zh'));

    await notifier.logout();
    await container.pump();
    expect(container.read(appLocaleProvider), isNull);

    repository.savedLanguage = 'en';
    await notifier.bootstrap();
    expect(container.read(appLocaleProvider), const Locale('en'));
  });

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
    expect(
      wallets.lastIdempotencyKey,
      scopedIdempotencyKey('wallet-sync-session-1'),
    );
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationAuthenticated>(),
    );
  });

  test('publishes authenticated state before wallet sync completes', () async {
    final syncStarted = Completer<void>();
    final syncBarrier = Completer<void>();
    final wallets = _WalletsRepository()
      ..onSync = syncStarted.complete
      ..syncBarrier = syncBarrier.future;
    final container = _container(
      FakeIdentityAuthGateway(
        restoredPrincipal: const IdentityPrincipal('did:privy:1'),
      ),
      _SessionRepository(),
      wallets: wallets,
    );

    final bootstrap = container
        .read(authenticationProvider.notifier)
        .bootstrap();
    await syncStarted.future;

    var state =
        container.read(authenticationProvider) as AuthenticationAuthenticated;
    expect(state.setupStatus, AuthenticationSetupStatus.initializing);

    syncBarrier.complete();
    await bootstrap;

    state =
        container.read(authenticationProvider) as AuthenticationAuthenticated;
    expect(state.setupStatus, AuthenticationSetupStatus.ready);
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
      final state =
          container.read(authenticationProvider) as AuthenticationAuthenticated;
      expect(state.setupStatus, AuthenticationSetupStatus.failed);
      expect(state.setupFailure?.code, AuthenticationFailureCode.provider);
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

      expect(wallets.syncCalls, 3);
      final state =
          container.read(authenticationProvider) as AuthenticationAuthenticated;
      expect(state.setupStatus, AuthenticationSetupStatus.failed);
      final failure = state.setupFailure!;
      expect(failure.code, AuthenticationFailureCode.walletSync);
      expect(failure.requestId, 'wallet-request-id');
      expect(failure.retryable, isTrue);
      expect(wallets.idempotencyKeys.toSet(), hasLength(1));
    },
  );

  group('wallet sync retries', () {
    test(
      'expired pending session is renewed without losing wallet identity',
      () async {
        final gateway = FakeIdentityAuthGateway();
        final repository = _SessionRepository()..expiresAt = DateTime.utc(2020);
        final wallets = _WalletsRepository();
        final container = _container(gateway, repository, wallets: wallets);
        final notifier = container.read(authenticationProvider.notifier);
        final connection = _WalletConnection();
        await notifier.loginWithWallet(() async => connection);
        expect(
          (container.read(
            authenticationProvider,
          ) as AuthenticationUnauthenticated).failure?.code,
          AuthenticationFailureCode.expired,
        );
        expect(wallets.syncCalls, 0);

        gateway.initializeFailure = const IdentityFailure(
          AuthenticationFailureCode.provider,
          retryable: false,
        );
        gateway.walletLoginFailure = gateway.initializeFailure;
        repository.expiresAt = DateTime.utc(2030);
        repository.sessionId = 'renewed-session';
        await notifier.retry();

        final state = container.read(
          authenticationProvider,
        ) as AuthenticationAuthenticated;
        expect(state.session.isExpired, isFalse);
        expect(state.session.sessionId, 'renewed-session');
        expect(repository.createCalls, 2);
        expect(
          wallets.lastIdempotencyKey,
          scopedIdempotencyKey('wallet-sync-renewed-session'),
        );
        expect(connection.disconnectCalls, 0);
        await notifier.logout();
        expect(connection.disconnectCalls, 1);
      },
    );

    test(
      'session expiring during sync keeps identity and renews on retry',
      () async {
        final repository = _SessionRepository()
          ..expiresAt = DateTime.now().toUtc().add(
            const Duration(milliseconds: 100),
          );
        final barrier = Completer<void>();
        final firstSync = Completer<void>();
        final wallets = _WalletsRepository()
          ..syncBarrier = barrier.future
          ..onSync = () => firstSync.complete();
        final container = _container(
          FakeIdentityAuthGateway(),
          repository,
          wallets: wallets,
        );
        final notifier = container.read(authenticationProvider.notifier);
        final login = notifier.loginWithOAuth('google');
        await firstSync.future;
        await Future<void>.delayed(const Duration(milliseconds: 150));
        barrier.complete();
        await login;

        final expiredState = container.read(
          authenticationProvider,
        ) as AuthenticationAuthenticated;
        expect(expiredState.setupStatus, AuthenticationSetupStatus.failed);
        expect(
          expiredState.setupFailure?.code,
          AuthenticationFailureCode.expired,
        );
        repository.expiresAt = DateTime.utc(2030);
        wallets.onSync = null;
        await notifier.retry();
        expect(repository.createCalls, 2);
        expect(
          (container.read(
            authenticationProvider,
          ) as AuthenticationAuthenticated).session.isExpired,
          isFalse,
        );
      },
    );

    test(
      'scope invalidation disconnects the retained wallet exactly once',
      () async {
        final wallets = _WalletsRepository()
          ..syncFailure = const DecodingFailure();
        final container = _container(
          FakeIdentityAuthGateway(),
          _SessionRepository(),
          wallets: wallets,
        );
        final notifier = container.read(authenticationProvider.notifier);
        final connection = _WalletConnection();
        await notifier.loginWithWallet(() async => connection);

        container.read(sessionGenerationProvider.notifier).clearUserScope();
        expect(
          container.read(authenticationProvider),
          isA<AuthenticationUnauthenticated>(),
        );
        await notifier.logout();
        expect(connection.disconnectCalls, 1);
      },
    );

    test(
      'new wallet login waits until the old connection is disconnected',
      () async {
        final wallets = _WalletsRepository()
          ..syncFailure = const DecodingFailure();
        final container = _container(
          FakeIdentityAuthGateway(),
          _SessionRepository(),
          wallets: wallets,
        );
        final notifier = container.read(authenticationProvider.notifier);
        final disconnectBarrier = Completer<void>();
        final disconnectStarted = Completer<void>();
        final first = _WalletConnection()
          ..disconnectBarrier = disconnectBarrier.future
          ..onDisconnect = () => disconnectStarted.complete();
        final second = _WalletConnection();
        await notifier.loginWithWallet(() async => first);
        wallets.syncFailure = null;
        var connectCalls = 0;
        final login = notifier.loginWithWallet(() async {
          connectCalls++;
          return second;
        });
        await disconnectStarted.future;
        expect(connectCalls, 0);
        disconnectBarrier.complete();
        await login;
        expect(first.disconnectCalls, 1);
        expect(connectCalls, 1);
        await notifier.logout();
        expect(first.disconnectCalls, 1);
        expect(second.disconnectCalls, 1);
      },
    );

    test('provider invalidation releases the retained wallet', () async {
      final wallets = _WalletsRepository()
        ..syncFailure = const DecodingFailure();
      final container = _container(
        FakeIdentityAuthGateway(),
        _SessionRepository(),
        wallets: wallets,
      );
      final notifier = container.read(authenticationProvider.notifier);
      final connection = _WalletConnection();
      await notifier.loginWithWallet(() async => connection);
      container.invalidate(authenticationProvider);
      expect(connection.disconnectCalls, 1);
    });

    for (final method in ['oauth', 'email', 'bootstrap', 'cancel']) {
      test(
        'abandoning wallet retry via $method releases the connection',
        () async {
          final wallets = _WalletsRepository()
            ..syncFailure = const DecodingFailure();
          final container = _container(
            FakeIdentityAuthGateway(),
            _SessionRepository(),
            wallets: wallets,
          );
          final notifier = container.read(authenticationProvider.notifier);
          final connection = _WalletConnection();
          await notifier.loginWithWallet(() async => connection);
          wallets.syncFailure = null;
          switch (method) {
            case 'oauth':
              await notifier.loginWithOAuth('google');
            case 'email':
              await notifier.requestEmailCode('user@example.com');
            case 'bootstrap':
              await notifier.bootstrap();
            case 'cancel':
              notifier.cancelEmailCode();
          }
          expect(connection.disconnectCalls, 1);
        },
      );
    }

    test(
      'connection returned after logout is disconnected without signing',
      () async {
        final gateway = FakeIdentityAuthGateway();
        final repository = _SessionRepository();
        final container = _container(gateway, repository);
        final notifier = container.read(authenticationProvider.notifier);
        final connectBarrier = Completer<WalletConnection>();
        final connectStarted = Completer<void>();
        final login = notifier.loginWithWallet(() {
          connectStarted.complete();
          return connectBarrier.future;
        });
        await connectStarted.future;
        await notifier.logout();
        final connection = _WalletConnection();
        connectBarrier.complete(connection);
        await login;
        expect(connection.disconnectCalls, 1);
        expect(gateway.walletConnection, isNull);
        expect(repository.createCalls, 0);
      },
    );

    for (final abandon in ['logout', 'scope change', 'notifier invalidation']) {
      test('shared wallet waits for stale cleanup after $abandon', () async {
        final gateway = FakeIdentityAuthGateway();
        final repository = _SessionRepository();
        final container = _container(gateway, repository);
        final original = container.read(authenticationProvider.notifier);
        final oldConnectStarted = Completer<void>();
        final oldConnect = Completer<WalletConnection>();
        final session = _SharedWalletSession();
        final cleanupStarted = Completer<void>();
        final cleanupBarrier = Completer<void>();
        final oldConnection = _WalletConnection(sharedSession: session)
          ..disconnectBarrier = cleanupBarrier.future
          ..onDisconnect = () => cleanupStarted.complete();
        final oldLogin = original.loginWithWallet(() {
          oldConnectStarted.complete();
          return oldConnect.future;
        });
        await oldConnectStarted.future;
        switch (abandon) {
          case 'logout':
            await original.logout();
          case 'scope change':
            container.read(sessionGenerationProvider.notifier).clearUserScope();
          case 'notifier invalidation':
            container.invalidate(authenticationProvider);
        }
        // Flush notifier rebuilding as the UI would before another login.
        container.read(authenticationProvider);
        final current = container.read(authenticationProvider.notifier);
        final newConnection = _WalletConnection(sharedSession: session);
        var newConnectCalls = 0;
        final newLogin = current.loginWithWallet(() async {
          newConnectCalls++;
          session.connected = true;
          return newConnection;
        });
        await Future<void>.delayed(Duration.zero);
        expect(newConnectCalls, 0);

        session.connected = true;
        oldConnect.complete(oldConnection);
        await cleanupStarted.future;
        expect(newConnectCalls, 0);
        expect(gateway.walletConnection, isNull);
        cleanupBarrier.complete();
        await Future.wait([oldLogin, newLogin]);

        expect(newConnectCalls, 1);
        expect(oldConnection.disconnectCalls, 1);
        expect(newConnection.disconnectCalls, 0);
        expect(session.connected, isTrue);
        expect(gateway.walletConnection, same(newConnection));
        expect(repository.createCalls, 1);
        expect(
          container.read(authenticationProvider),
          isA<AuthenticationAuthenticated>(),
        );
        expect(await newConnection.signTypedDataV4({}), '0xsignature');
        await current.logout();
        expect(newConnection.disconnectCalls, 1);
        expect(session.connected, isFalse);
      });
    }

    test(
      'a failed stale connect does not block the next wallet login',
      () async {
        final gateway = FakeIdentityAuthGateway();
        final container = _container(gateway, _SessionRepository());
        final notifier = container.read(authenticationProvider.notifier);
        final firstStarted = Completer<void>();
        final firstConnect = Completer<WalletConnection>();
        final firstLogin = notifier.loginWithWallet(() {
          firstStarted.complete();
          return firstConnect.future;
        });
        await firstStarted.future;
        final connection = _WalletConnection();
        final secondLogin = notifier.loginWithWallet(() async => connection);
        firstConnect.completeError(
          const IdentityFailure(
            AuthenticationFailureCode.provider,
            retryable: true,
          ),
        );
        await Future.wait([firstLogin, secondLogin]);
        expect(gateway.walletConnection, same(connection));
        expect(
          container.read(authenticationProvider),
          isA<AuthenticationAuthenticated>(),
        );
      },
    );

    test('superseded queued wallet login never opens the connector', () async {
      final gateway = FakeIdentityAuthGateway();
      final container = _container(gateway, _SessionRepository());
      final notifier = container.read(authenticationProvider.notifier);
      final firstStarted = Completer<void>();
      final firstConnect = Completer<WalletConnection>();
      final firstLogin = notifier.loginWithWallet(() {
        firstStarted.complete();
        return firstConnect.future;
      });
      await firstStarted.future;
      var supersededCalls = 0;
      final superseded = notifier.loginWithWallet(() async {
        supersededCalls++;
        return _WalletConnection();
      });
      final lastConnection = _WalletConnection();
      final lastLogin = notifier.loginWithWallet(() async => lastConnection);
      firstConnect.complete(_WalletConnection());
      await Future.wait([firstLogin, superseded, lastLogin]);
      expect(supersededCalls, 0);
      expect(gateway.walletConnection, same(lastConnection));
      expect(
        container.read(authenticationProvider),
        isA<AuthenticationAuthenticated>(),
      );
    });

    for (final failure in <ApiFailure>[
      const NetworkFailure(),
      const TimeoutFailure(),
      const ServerFailure(
        statusCode: 503,
        code: 'temporarily_unavailable',
        retryable: true,
      ),
    ]) {
      test('recovers from ${failure.runtimeType} with the same key', () async {
        final repository = _SessionRepository();
        final gateway = FakeIdentityAuthGateway(
          restoredPrincipal: const IdentityPrincipal('did:privy:1'),
        );
        final wallets = _WalletsRepository()
          ..syncFailures.addAll([failure, failure]);
        final container = _container(gateway, repository, wallets: wallets);

        await container.read(authenticationProvider.notifier).bootstrap();

        expect(wallets.syncCalls, 3);
        expect(
          wallets.idempotencyKeys,
          List.filled(3, scopedIdempotencyKey('wallet-sync-session-1')),
        );
        expect(repository.createCalls, 1);
        expect(gateway.ensureEmbeddedWalletCalls, 1);
        expect(
          container.read(authenticationProvider),
          isA<AuthenticationAuthenticated>(),
        );
      });
    }

    for (final failure in <ApiFailure>[
      const AuthenticationFailure(),
      const ServerFailure(statusCode: 403, code: 'forbidden'),
      const ServerFailure(statusCode: 409, code: 'conflict'),
      const ServerFailure(statusCode: 422, code: 'invalid_wallet'),
      const ServerFailure(statusCode: 503, code: 'service_unconfigured'),
      const DecodingFailure(),
      const CancelledFailure(),
    ]) {
      test('does not retry ${failure.kind.name} when not retryable', () async {
        final wallets = _WalletsRepository()..syncFailure = failure;
        final container = _container(
          FakeIdentityAuthGateway(
            restoredPrincipal: const IdentityPrincipal('did:privy:1'),
          ),
          _SessionRepository(),
          wallets: wallets,
        );

        await container.read(authenticationProvider.notifier).bootstrap();

        expect(wallets.syncCalls, 1);
        final state = container.read(
          authenticationProvider,
        ) as AuthenticationAuthenticated;
        expect(state.setupStatus, AuthenticationSetupStatus.failed);
        expect(state.setupFailure?.code, AuthenticationFailureCode.walletSync);
        expect(state.setupFailure?.retryable, isFalse);
      });
    }

    test('preserves the final request ID when retries are exhausted', () async {
      final wallets = _WalletsRepository()
        ..syncFailures.addAll([
          const TimeoutFailure(requestId: 'attempt-1'),
          const NetworkFailure(requestId: 'attempt-2'),
          const ServerFailure(
            statusCode: 503,
            code: 'temporarily_unavailable',
            retryable: true,
            requestId: 'attempt-3',
          ),
        ]);
      final container = _container(
        FakeIdentityAuthGateway(
          restoredPrincipal: const IdentityPrincipal('did:privy:1'),
        ),
        _SessionRepository(),
        wallets: wallets,
      );

      await container.read(authenticationProvider.notifier).bootstrap();

      expect(wallets.syncCalls, 3);
      final state =
          container.read(authenticationProvider) as AuthenticationAuthenticated;
      expect(state.setupStatus, AuthenticationSetupStatus.failed);
      expect(state.setupFailure?.code, AuthenticationFailureCode.walletSync);
      expect(state.setupFailure?.requestId, 'attempt-3');
    });

    test('logout during backoff prevents further sync attempts', () async {
      final firstSync = Completer<void>();
      final wallets = _WalletsRepository()
        ..syncFailure = const NetworkFailure()
        ..onSync = () => firstSync.complete();
      final container = _container(
        FakeIdentityAuthGateway(
          restoredPrincipal: const IdentityPrincipal('did:privy:1'),
        ),
        _SessionRepository(),
        wallets: wallets,
      );
      final notifier = container.read(authenticationProvider.notifier);

      final bootstrap = notifier.bootstrap();
      await firstSync.future;
      await notifier.logout();
      await bootstrap;

      expect(wallets.syncCalls, 1);
      expect(
        container.read(authenticationProvider),
        isA<AuthenticationUnauthenticated>(),
      );
    });

    test(
      'manual retry resumes the session without resubmitting the OTP',
      () async {
        final gateway = FakeIdentityAuthGateway();
        final repository = _SessionRepository();
        final wallets = _WalletsRepository()
          ..syncFailure = const NetworkFailure();
        final container = _container(gateway, repository, wallets: wallets);
        final notifier = container.read(authenticationProvider.notifier);
        await notifier.bootstrap();
        await notifier.requestEmailCode('user@example.com');
        await notifier.verifyEmailCode('123456');
        final state = container.read(
          authenticationProvider,
        ) as AuthenticationAuthenticated;
        expect(state.setupStatus, AuthenticationSetupStatus.failed);
        expect(state.setupFailure?.code, AuthenticationFailureCode.walletSync);

        gateway.initializeFailure = const IdentityFailure(
          AuthenticationFailureCode.provider,
          retryable: false,
        );
        gateway.verifyFailure = const IdentityFailure(
          AuthenticationFailureCode.invalidCode,
          retryable: false,
        );
        wallets.syncFailure = null;
        await notifier.retry();

        expect(wallets.syncCalls, 4);
        expect(wallets.idempotencyKeys.toSet(), hasLength(1));
        expect(repository.createCalls, 1);
        expect(gateway.ensureEmbeddedWalletCalls, 1);
        expect(
          container.read(authenticationProvider),
          isA<AuthenticationAuthenticated>(),
        );
      },
    );

    test('manual wallet retry preserves the connected wallet', () async {
      final gateway = FakeIdentityAuthGateway();
      final repository = _SessionRepository();
      final wallets = _WalletsRepository()
        ..syncFailure = const ServerFailure(
          statusCode: 503,
          code: 'service_unconfigured',
        );
      final container = _container(gateway, repository, wallets: wallets);
      final notifier = container.read(authenticationProvider.notifier);
      final connection = _WalletConnection();
      await notifier.loginWithWallet(() async => connection);
      final failedState =
          container.read(authenticationProvider) as AuthenticationAuthenticated;
      expect(failedState.setupStatus, AuthenticationSetupStatus.failed);
      expect(
        failedState.setupFailure?.code,
        AuthenticationFailureCode.walletSync,
      );

      gateway.initializeFailure = const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: false,
      );
      gateway.walletLoginFailure = const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: false,
      );
      wallets.syncFailure = null;
      await notifier.retry();

      expect(
        container.read(authenticationProvider),
        isA<AuthenticationAuthenticated>(),
      );
      expect(repository.createCalls, 1);
      expect(wallets.idempotencyKeys.toSet(), hasLength(1));
      expect(connection.disconnectCalls, 0);
      await notifier.logout();
      expect(connection.disconnectCalls, 1);
    });

    test('repeated manual taps do not start concurrent syncs', () async {
      final repository = _SessionRepository();
      final wallets = _WalletsRepository()
        ..syncFailure = const DecodingFailure();
      final container = _container(
        FakeIdentityAuthGateway(),
        repository,
        wallets: wallets,
      );
      final notifier = container.read(authenticationProvider.notifier);
      await notifier.loginWithOAuth('google');
      final barrier = Completer<void>();
      wallets.syncFailure = null;
      wallets.syncBarrier = barrier.future;

      final retry = notifier.retry();
      await notifier.retry();
      expect(wallets.syncCalls, 2);
      expect(
        (container.read(
          authenticationProvider,
        ) as AuthenticationAuthenticated).setupStatus,
        AuthenticationSetupStatus.initializing,
      );
      barrier.complete();
      await retry;

      expect(repository.createCalls, 1);
      expect(
        container.read(authenticationProvider),
        isA<AuthenticationAuthenticated>(),
      );
    });

    test(
      'changing session scope cancels backoff and clears pending sync',
      () async {
        final firstSync = Completer<void>();
        final wallets = _WalletsRepository()
          ..syncFailure = const NetworkFailure()
          ..onSync = () => firstSync.complete();
        final gateway = FakeIdentityAuthGateway(
          restoredPrincipal: const IdentityPrincipal('did:privy:1'),
        );
        final container = _container(
          gateway,
          _SessionRepository(),
          wallets: wallets,
        );
        final notifier = container.read(authenticationProvider.notifier);

        final bootstrap = notifier.bootstrap();
        await firstSync.future;
        container.read(sessionGenerationProvider.notifier).clearUserScope();
        await bootstrap;
        expect(wallets.syncCalls, 1);
        expect(
          container.read(authenticationProvider),
          isA<AuthenticationUnauthenticated>(),
        );

        gateway.restoredPrincipal = null;
        await notifier.retry();
        expect(wallets.syncCalls, 1);
        expect(
          container.read(authenticationProvider),
          isA<AuthenticationUnauthenticated>(),
        );
      },
    );
  });

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

  test('retries a retryable backend session failure once', () async {
    final repository = _SessionRepository()
      ..createFailures.add(
        const ServerFailure(
          statusCode: 503,
          code: 'temporarily_unavailable',
          retryable: true,
        ),
      );
    final container = _container(
      FakeIdentityAuthGateway(
        restoredPrincipal: const IdentityPrincipal('did:privy:1'),
      ),
      repository,
    );

    await container.read(authenticationProvider.notifier).bootstrap();

    expect(repository.createCalls, 2);
    expect(
      container.read(authenticationProvider),
      isA<AuthenticationAuthenticated>(),
    );
  });

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

  test('concurrent logout calls share one operation', () async {
    final logoutStarted = Completer<void>();
    final releaseLogout = Completer<void>();
    final gateway = FakeIdentityAuthGateway();
    final repository = _SessionRepository()
      ..logoutStarted = logoutStarted
      ..logoutBarrier = releaseLogout.future;
    final container = _container(gateway, repository);
    final notifier = container.read(authenticationProvider.notifier);

    final first = notifier.logout();
    await logoutStarted.future;
    final second = notifier.logout();

    expect(identical(first, second), isTrue);
    expect(repository.logoutCalls, 1);
    releaseLogout.complete();
    await Future.wait([first, second]);
    expect(repository.logoutCalls, 1);
    expect(gateway.logoutCalls, 1);
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
  String savedLanguage = 'en';
  DateTime expiresAt = DateTime.utc(2030);
  String sessionId = 'session-1';
  int createCalls = 0;
  int logoutCalls = 0;
  ApiFailure? createFailure;
  final createFailures = <ApiFailure>[];
  Completer<void>? logoutStarted;
  Future<void>? logoutBarrier;

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) async {
    createCalls++;
    if (createFailures.isNotEmpty) {
      throw createFailures.removeAt(0);
    }
    if (createFailure case final failure?) throw failure;
    return ProductSession(
      sessionId: sessionId,
      createdAt: DateTime.utc(2026),
      expiresAt: expiresAt,
      generation: generation,
      accountCreated: true,
      account: UserAccount(
        userId: 'user-1',
        settings: UserPreferences(
          language: savedLanguage,
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
    logoutStarted?.complete();
    await logoutBarrier;
  }
}

final class _WalletsRepository implements WalletsRepository {
  int syncCalls = 0;
  String? lastIdempotencyKey;
  ApiFailure? syncFailure;
  final syncFailures = <ApiFailure>[];
  final idempotencyKeys = <String>[];
  void Function()? onSync;
  Future<void>? syncBarrier;

  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async {
    syncCalls++;
    lastIdempotencyKey = idempotencyKey;
    idempotencyKeys.add(idempotencyKey);
    onSync?.call();
    await syncBarrier;
    if (syncFailures.isNotEmpty) throw syncFailures.removeAt(0);
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

final class _SharedWalletSession {
  var connected = false;
}

final class _WalletConnection implements WalletConnection {
  _WalletConnection({this.sharedSession});

  final _SharedWalletSession? sharedSession;
  int disconnectCalls = 0;
  Future<void>? disconnectBarrier;
  void Function()? onDisconnect;

  @override
  String get address => '0x0000000000000000000000000000000000000001';

  @override
  String get chainId => '1';

  @override
  String get connectorType => 'walletconnect';

  @override
  Future<void> disconnect() async {
    disconnectCalls++;
    onDisconnect?.call();
    await disconnectBarrier;
    if (sharedSession case final session?) session.connected = false;
  }

  @override
  Future<String> signPersonalMessage(String message) async => '0xsignature';

  @override
  Future<String> signTypedDataV4(Map<String, Object?> typedData) async {
    if (sharedSession?.connected == false) {
      throw StateError('Wallet disconnected');
    }
    return '0xsignature';
  }
}
