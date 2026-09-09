import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/auth_providers.dart';
import 'package:rwa_interface/data/auth/reown_wallet_connector.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/auth/identity_auth_gateway.dart';
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
