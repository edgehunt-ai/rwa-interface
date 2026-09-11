@TestOn('browser')
library;

import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/auth/web_identity_auth_gateway.dart';
import 'package:rwa_interface/domain/auth/authentication.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  const address = '0x1111111111111111111111111111111111111111';
  final signature = '0x${List.filled(64, '33').join()}1b';
  const configuration = IdentityConfiguration(
    appId: 'test-app',
    clientId: 'test-client',
  );
  final payload = <String, Object?>{
    'types': <String, Object?>{},
    'domain': <String, Object?>{},
    'message': <String, Object?>{},
    'primaryType': 'Agent',
  };
  late WebPrivyIdentityAuthGateway gateway;
  late JSObject bridge;
  setUp(() async {
    bridge = JSObject();
    bridge.setProperty(
      'initialize'.toJS,
      ((JSString app, JSString client) => Future<JSAny?>.value(
        'user-a'.toJS,
      ).toJS).toJS,
    );
    bridge.setProperty(
      'logout'.toJS,
      (() => Future<JSAny?>.value(null).toJS).toJS,
    );
    globalContext.setProperty('rwaPrivyAuth'.toJS, bridge);
    gateway = WebPrivyIdentityAuthGateway();
    await gateway.initialize(configuration);
  });
  tearDown(() {
    globalContext.delete('rwaPrivyAuth'.toJS);
  });

  test(
    'Web gateway implements signer and forwards exact wallet and JSON',
    () async {
      expect(gateway, isA<Hip3TypedDataSigner>());
      bridge.setProperty(
        'signTypedDataV4'.toJS,
        ((JSString signer, JSString encoded) {
          expect(signer.toDart, address);
          expect(encoded.toDart, contains('"primaryType":"Agent"'));
          return Future<JSAny?>.value(({'signature': signature}).jsify()).toJS;
        }).toJS,
      );
      expect(
        await gateway.signTypedDataV4(
          expectedSigner: address,
          typedData: payload,
        ),
        signature,
      );
    },
  );
  test('maps bridge refusal to stable signing failure', () async {
    bridge.setProperty(
      'signTypedDataV4'.toJS,
      ((JSString signer, JSString encoded) => Future<JSAny?>.value(
        ({'errorCode': 'rejected'}).jsify(),
      ).toJS).toJS,
    );
    await expectLater(
      gateway.signTypedDataV4(expectedSigner: address, typedData: payload),
      throwsA(
        isA<Hip3SigningFailure>().having(
          (e) => e.code,
          'code',
          Hip3SigningFailureCode.rejected,
        ),
      ),
    );
  });
  test('discard signature arriving after logout', () async {
    final reply = Completer<JSAny?>();
    bridge.setProperty(
      'signTypedDataV4'.toJS,
      ((JSString signer, JSString encoded) => reply.future.toJS).toJS,
    );
    final pending = gateway.signTypedDataV4(
      expectedSigner: address,
      typedData: payload,
    );
    final assertion = expectLater(
      pending,
      throwsA(
        isA<Hip3SigningFailure>().having(
          (e) => e.code,
          'code',
          Hip3SigningFailureCode.walletUnavailable,
        ),
      ),
    );
    await gateway.logout();
    reply.complete(({'signature': signature}).jsify());
    await assertion;
  });
}
