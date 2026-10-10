import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/config/privy_configuration.dart';
import 'package:nobell/domain/auth/authentication.dart';

void main() {
  group('PrivyConfiguration', () {
    test('normalizes public identifiers', () {
      const configuration = PrivyConfiguration(
        appId: ' app-id ',
        clientId: ' client-id ',
      );

      final identity = configuration.validate();

      expect(identity.appId, 'app-id');
      expect(identity.clientId, 'client-id');
    });

    test('fails closed when either identifier is missing', () {
      expect(
        () =>
            const PrivyConfiguration(appId: '', clientId: 'client').validate(),
        throwsA(
          isA<IdentityFailure>().having(
            (failure) => failure.code,
            'code',
            AuthenticationFailureCode.configuration,
          ),
        ),
      );
      expect(
        () => const PrivyConfiguration(appId: 'app', clientId: ' ').validate(),
        throwsA(isA<IdentityFailure>()),
      );
    });

    test('keeps login methods as an explicit code constant', () {
      expect(PrivyConfiguration.loginMethods, {'email', 'google', 'passkey'});
    });

    test('derives the native redirect from the configured URL scheme', () {
      expect(
        PrivyConfiguration.nativeAppRedirect,
        '${PrivyConfiguration.appUrlScheme}://',
      );
      expect(PrivyConfiguration.appUrlScheme, 'nobell');
    });
  });

  group('ReownConfiguration', () {
    test('normalizes the project identifier', () {
      expect(
        const ReownConfiguration(projectId: ' project-id ').validate(),
        'project-id',
      );
    });

    test('fails closed when the project identifier is missing', () {
      expect(
        () => const ReownConfiguration(projectId: ' ').validate(),
        throwsA(
          isA<IdentityFailure>().having(
            (failure) => failure.code,
            'code',
            AuthenticationFailureCode.configuration,
          ),
        ),
      );
    });
  });
}
