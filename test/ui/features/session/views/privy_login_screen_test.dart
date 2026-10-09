import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/config/privy_configuration.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/data/auth/reown_wallet_connector.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/product_session.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/models/wallet.dart';
import 'package:rwa_interface/domain/repositories/session_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/session/providers/authentication_provider.dart';
import 'package:rwa_interface/ui/features/session/views/privy_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/fake_identity_auth_gateway.dart';
import '../../../../helpers/test_app.dart';

void main() {
  for (final method in [
    'startup',
    'OAuth login',
    'email verification',
    'expired session',
  ]) {
    testWidgets('wallet sync failure after $method retries and closes login', (
      tester,
    ) async {
      SharedPreferences.setMockInitialValues({});
      final retryBarrier = Completer<void>();
      final gateway = FakeIdentityAuthGateway(
        restoredPrincipal: method == 'startup'
            ? const IdentityPrincipal('privy-user')
            : null,
      );
      final sessions = _LoginSessions();
      final expired = method == 'expired session';
      if (expired) sessions.expiresAt = DateTime.utc(2020);
      final wallets = _LoginWallets();
      final container = ProviderContainer(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(gateway),
          privyConfigurationProvider.overrideWithValue(
            const PrivyConfiguration(appId: 'app-id', clientId: 'client-id'),
          ),
          sessionRepositoryProvider.overrideWithValue(sessions),
          walletsRepositoryProvider.overrideWithValue(wallets),
        ],
      );
      addTearDown(container.dispose);
      container.listen(authenticationProvider, (_, _) {});
      final notifier = container.read(authenticationProvider.notifier);
      await tester.runAsync(() async {
        await notifier.bootstrap();
        if (method == 'OAuth login' || expired) {
          await notifier.loginWithOAuth('google');
        } else if (method == 'email verification') {
          await notifier.requestEmailCode('user@example.com');
          await notifier.verifyEmailCode('123456');
        }
      });
      expect(sessions.createCalls, 1);
      expect(wallets.syncCalls, expired ? 0 : 1);
      gateway.initializeFailure = const IdentityFailure(
        AuthenticationFailureCode.provider,
        retryable: false,
      );
      gateway.verifyFailure = gateway.initializeFailure;
      gateway.oauthFailure = gateway.initializeFailure;
      wallets.failure = null;
      wallets.barrier = retryBarrier.future;
      sessions.expiresAt = DateTime.utc(2030);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: _buildLoginApp(
            Builder(
              builder: (context) => TextButton(
                onPressed: () => pushLoginScreen(context),
                child: const Text('Open login'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open login'));
      await tester.pumpAndSettle();

      if (!expired) {
        expect(
          find.text(
            'You are signed in, but your wallet could not be synchronized. '
            'Try again later.',
          ),
          findsOneWidget,
        );
      }
      final retry = find.widgetWithText(OutlinedButton, 'Retry');
      expect(retry, findsOneWidget);
      await tester.ensureVisible(retry);
      await tester.tap(retry);
      await tester.pump();

      expect(wallets.syncCalls, expired ? 1 : 2);
      expect(sessions.createCalls, expired ? 2 : 1);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(retry, findsNothing);
      retryBarrier.complete();
      await tester.pumpAndSettle();
      expect(
        container.read(authenticationProvider),
        isA<AuthenticationAuthenticated>(),
      );
      expect(wallets.keys.toSet(), hasLength(1));
      expect(find.byType(PrivyLoginScreen), findsNothing);
      expect(find.text('Open login'), findsOneWidget);
    });
  }

  testWidgets('invalid code does not offer session restoration', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(),
          ),
        ],
        child: _buildLoginApp(
          const PrivyLoginScreen(
            authentication: AuthenticationAwaitingCode(
              'user@example.com',
              failure: IdentityFailure(
                AuthenticationFailureCode.invalidCode,
                retryable: true,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.widgetWithText(OutlinedButton, 'Retry'), findsNothing);
    expect(find.text('Resend code'), findsOneWidget);
  });

  testWidgets('invalid email is rejected before requesting a code', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final gateway = FakeIdentityAuthGateway();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [identityAuthGatewayProvider.overrideWithValue(gateway)],
        child: buildTestApp(
          const PrivyLoginScreen(
            authentication: AuthenticationUnauthenticated(),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(TextField));
    await tester.enterText(find.byType(TextField), 'not-an-email');
    await tester.pump();
    await tester.tap(find.byIcon(Icons.arrow_upward_rounded));
    await tester.pump();

    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(gateway.requestedEmail, isNull);
  });

  testWidgets('wallet action starts the Reown connection flow', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final connector = _FakeWalletConnector();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          reownWalletConnectorProvider.overrideWithValue(connector),
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(),
          ),
        ],
        child: buildTestApp(
          const PrivyLoginScreen(
            authentication: AuthenticationUnauthenticated(),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Wallet'));
    await tester.pump();

    expect(connector.connectCalls, 1);
  });

  testWidgets('renders Passkey as a centered text action below Wallet', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(),
          ),
        ],
        child: buildTestApp(
          const PrivyLoginScreen(
            authentication: AuthenticationUnauthenticated(),
          ),
        ),
      ),
    );

    final walletBottom = tester.getBottomRight(find.text('Wallet')).dy;
    final passkeyFinder = find.text('Sign in with Passkey');
    final passkeyTop = tester.getTopLeft(passkeyFinder).dy;

    expect(passkeyTop, greaterThan(walletBottom + 12));
    expect(passkeyTop, lessThan(walletBottom + 40));
    expect(find.byIcon(Icons.lock), findsNothing);
  });

  testWidgets('hides Passkey while authentication is loading', (tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(),
          ),
        ],
        child: buildTestApp(
          const PrivyLoginScreen(
            authentication: AuthenticationAuthenticating(),
          ),
        ),
      ),
    );

    expect(find.text('Sign in with Passkey'), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('keeps the legal footer fixed when the keyboard appears', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    addTearDown(tester.view.resetViewInsets);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(),
          ),
        ],
        child: _buildLoginApp(
          const PrivyLoginScreen(
            authentication: AuthenticationUnauthenticated(),
          ),
        ),
      ),
    );

    final legalCopy = find.text(
      'By using this app, you agree to the Terms & Conditions.',
    );
    final bottomBeforeKeyboard = tester.getBottomLeft(legalCopy).dy;

    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    await tester.pump();

    expect(tester.getBottomLeft(legalCopy).dy, bottomBeforeKeyboard);
  });

  testWidgets('restores verification input focus after keyboard dismissal', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          identityAuthGatewayProvider.overrideWithValue(
            FakeIdentityAuthGateway(),
          ),
        ],
        child: buildTestApp(
          const PrivyLoginScreen(
            authentication: AuthenticationAwaitingCode('user@example.com'),
          ),
        ),
      ),
    );
    await tester.pump();

    final input = find.byType(TextField);
    expect(tester.widget<TextField>(input).focusNode?.hasFocus, isTrue);

    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    expect(tester.widget<TextField>(input).focusNode?.hasFocus, isFalse);

    await tester.tapAt(tester.getCenter(input));
    await tester.pump();
    expect(tester.widget<TextField>(input).focusNode?.hasFocus, isTrue);
  });

  testWidgets('resend clears the entered code and shows a success toast', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final gateway = FakeIdentityAuthGateway();
    addTearDown(AppToast.dismiss);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [identityAuthGatewayProvider.overrideWithValue(gateway)],
        child: buildTestApp(
          const PrivyLoginScreen(
            authentication: AuthenticationAwaitingCode('user@example.com'),
          ),
        ),
      ),
    );
    await tester.pump();

    final input = find.byType(TextField);
    await tester.enterText(input, '123');
    await tester.pump();
    expect(tester.widget<TextField>(input).controller?.text, '123');

    await tester.tap(find.text('Resend code'));
    await tester.pump();
    await tester.pump();

    expect(tester.widget<TextField>(input).controller?.text, isEmpty);
    expect(gateway.requestedEmail, 'user@example.com');
    expect(find.text('Code resent'), findsOneWidget);
  });
}

final class _LoginSessions implements SessionRepository {
  var createCalls = 0;
  DateTime expiresAt = DateTime.utc(2030);

  @override
  Future<ProductSession> createOrRestore({
    String? language,
    required int generation,
  }) async {
    createCalls++;
    return ProductSession(
      sessionId: 'login-session',
      createdAt: DateTime.utc(2026),
      expiresAt: expiresAt,
      generation: generation,
      accountCreated: false,
      account: const UserAccount(
        userId: 'login-user',
        settings: UserPreferences(
          language: 'en',
          pushEnabled: false,
          notifyOrderFilled: false,
          notifyOrderFailed: false,
          notifyLiquidationWarning: false,
        ),
      ),
    );
  }

  @override
  Future<void> endSession() async {}
}

final class _LoginWallets implements WalletsRepository {
  var syncCalls = 0;
  final keys = <String>[];
  ApiFailure? failure = const DecodingFailure(requestId: 'wallet-request-id');
  Future<void>? barrier;

  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async {
    syncCalls++;
    keys.add(idempotencyKey);
    await barrier;
    if (failure case final value?) throw value;
    return Wallet(
      walletId: 'login-wallet',
      address: '0x1',
      chain: 'ethereum',
      status: WalletState.active,
      createdAt: DateTime.utc(2026),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget _buildLoginApp(Widget child) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: child,
);

final class _FakeWalletConnector implements WalletConnector {
  var connectCalls = 0;
  final _connection = Completer<WalletConnection>();

  @override
  Future<WalletConnection> connect(BuildContext context) {
    connectCalls++;
    return _connection.future;
  }
}
