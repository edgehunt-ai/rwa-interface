import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/auth_providers.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/domain/auth/authentication.dart';
import 'package:nobell/domain/models/product_session.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/ui/features/session/providers/authentication_provider.dart';
import 'package:nobell/ui/features/legal/views/legal_document_screen.dart';
import 'package:nobell/ui/features/session/views/privy_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helpers/fake_identity_auth_gateway.dart';
import '../../../helpers/test_app.dart';

void main() {
  for (final initialState in <AuthenticationState>[
    const AuthenticationAuthenticating(),
    const AuthenticationAwaitingCode('reader@example.com'),
  ]) {
    for (final document in LegalDocument.values) {
      testWidgets(
        'authentication from $initialState closes login and ${document.name}',
        (tester) async {
          SharedPreferences.setMockInitialValues({});
          var authentication = initialState;
          final container = ProviderContainer(
            overrides: [
              identityAuthGatewayProvider.overrideWithValue(
                FakeIdentityAuthGateway(),
              ),
              authenticationProvider.overrideWithBuild(
                (_, _) => authentication,
              ),
            ],
          );
          addTearDown(container.dispose);
          var loginReturned = false;
          var actionResumed = false;
          await tester.pumpWidget(
            UncontrolledProviderScope(
              container: container,
              child: buildTestApp(
                Consumer(
                  builder: (context, ref, _) => TextButton(
                    onPressed: () async {
                      actionResumed = await requireAuthentication(context, ref);
                      loginReturned = true;
                    },
                    child: const Text('Open login'),
                  ),
                ),
              ),
            ),
          );
          await tester.tap(find.text('Open login'));
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 400));
          final documentClosed = pushLegalDocument(
            tester.element(find.byType(PrivyLoginScreen)),
            document,
          );
          await tester.pump();
          await tester.pump(const Duration(milliseconds: 400));
          expect(find.byType(LegalDocumentScreen), findsOneWidget);
          authentication = AuthenticationAuthenticated(
            ProductSession(
              sessionId: 'session',
              createdAt: DateTime.utc(2026),
              expiresAt: DateTime.utc(2030),
              generation: 1,
              accountCreated: true,
              account: const UserAccount(
                userId: 'user',
                settings: UserPreferences(
                  language: 'en',
                  pushEnabled: false,
                  notifyOrderFilled: true,
                  notifyOrderFailed: true,
                  notifyLiquidationWarning: true,
                ),
              ),
            ),
            principal: const IdentityPrincipal('user'),
          );
          container.invalidate(authenticationProvider);
          container.read(authenticationProvider);
          await tester.pumpAndSettle();
          await documentClosed;
          expect(find.byType(LegalDocumentScreen), findsNothing);
          expect(find.byType(PrivyLoginScreen), findsNothing);
          expect(loginReturned, isTrue);
          expect(actionResumed, isTrue);
          expect(find.text('Open login'), findsOneWidget);
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  for (final entry in [
    ('/terms', 'Term of Use'),
    ('/privacy', 'Privacy Policy'),
  ]) {
    testWidgets('${entry.$1} is publicly accessible without signing in', (
      tester,
    ) async {
      final router = AppRouter.create(initialLocation: entry.$1);
      addTearDown(router.dispose);
      await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
      await tester.pumpAndSettle();
      expect(find.text(entry.$2), findsOneWidget);
      expect(find.byType(PrivyLoginScreen), findsNothing);
      expect(find.text('9:41'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('login legal links navigate separately and preserve the email', (
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
    await tester.pumpAndSettle();
    await tester.tap(find.byType(TextField).first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'reader@example.com');
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();

    for (final entry in [
      ('Terms', LegalDocument.terms, 'Term of Use'),
      ('Privacy', LegalDocument.privacy, 'Privacy Policy'),
    ]) {
      final footer = find
          .descendant(
            of: find.byKey(const Key('login-legal-footer')),
            matching: find.byType(RichText),
          )
          .last;
      final paragraph = tester.renderObject<RenderParagraph>(footer);
      final plain = paragraph.text.toPlainText();
      final start = plain.indexOf(entry.$1);
      final box = paragraph
          .getBoxesForSelection(
            TextSelection(
              baseOffset: start,
              extentOffset: start + entry.$1.length,
            ),
          )
          .first;
      await tester.tapAt(paragraph.localToGlobal(box.toRect().center));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<LegalDocumentScreen>(find.byType(LegalDocumentScreen))
            .document,
        entry.$2,
      );
      expect(find.text(entry.$3), findsOneWidget);
      await tester.tap(find.byKey(const Key('legal-back')));
      await tester.pumpAndSettle();
      expect(find.text('reader@example.com'), findsOneWidget);
    }
  });

  testWidgets('privacy can scroll to the final section with enlarged text', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(320, 700),
            textScaler: TextScaler.linear(2),
          ),
          child: const LegalDocumentScreen(document: LegalDocument.privacy),
        ),
      ),
    );
    await tester.scrollUntilVisible(
      find.text('8. Contact Us'),
      500,
      maxScrolls: 100,
    );
    expect(find.text('8. Contact Us'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
