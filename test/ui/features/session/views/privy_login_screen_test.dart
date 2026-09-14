import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/data/auth/reown_wallet_connector.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';
import 'package:rwa_interface/ui/core/feedback/app_toast.dart';
import 'package:rwa_interface/ui/features/session/views/privy_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../helpers/fake_identity_auth_gateway.dart';
import '../../../../helpers/test_app.dart';

void main() {
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

final class _FakeWalletConnector implements WalletConnector {
  var connectCalls = 0;
  final _connection = Completer<WalletConnection>();

  @override
  Future<WalletConnection> connect(BuildContext context) {
    connectCalls++;
    return _connection.future;
  }
}
