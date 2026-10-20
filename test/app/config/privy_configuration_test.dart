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

    test('uses the export URL build variable without a fallback domain', () {
      const exportUrl = String.fromEnvironment('PRIVY_EXPORT_URL');
      expect(PrivyConfiguration.privateKeyExportUrl, exportUrl);
      if (exportUrl.isEmpty) {
        expect(
          () => PrivyConfiguration.relyingParty,
          throwsA(isA<IdentityFailure>()),
        );
      } else {
        expect(PrivyConfiguration.relyingParty, Uri.parse(exportUrl).origin);
      }
    });

    test('derives the RP origin from an export page URL', () {
      expect(
        PrivyConfiguration.relyingPartyFor(
          ' https://keys.example.test:8443/export?flow=verify#ready ',
        ),
        'https://keys.example.test:8443',
      );
      expect(
        PrivyConfiguration.relyingPartyFor('https://another.example.test/'),
        'https://another.example.test',
      );
    });

    test('passkey RP ID excludes scheme, port, path, query and fragment', () {
      expect(
        PrivyConfiguration.passkeyRelyingPartyFor(
          ' https://keys.example.test:8443/export?flow=verify#ready ',
        ),
        'keys.example.test',
      );
      expect(
        PrivyConfiguration.passkeyRelyingPartyFor(
          'https://another.example.test/',
        ),
        'another.example.test',
      );
    });

    test('rejects missing or invalid export origins', () {
      for (final url in [
        '',
        '   ',
        '/export',
        'http://keys.example.test',
        'https://',
        'https://user:password@keys.example.test/export',
      ]) {
        expect(
          () => PrivyConfiguration.relyingPartyFor(url),
          throwsA(
            isA<IdentityFailure>().having(
              (failure) => failure.code,
              'code',
              AuthenticationFailureCode.configuration,
            ),
          ),
          reason: url,
        );
        expect(
          () => PrivyConfiguration.passkeyRelyingPartyFor(url),
          throwsA(isA<IdentityFailure>()),
          reason: url,
        );
      }
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
