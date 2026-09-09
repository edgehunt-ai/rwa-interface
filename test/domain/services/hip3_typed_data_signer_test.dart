import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  test('splits a compact signature and normalizes recovery id zero', () {
    final signature = Hip3RsvSignature.fromCompactHex(
      '0x${List.filled(32, '11').join()}${List.filled(32, '22').join()}00',
    );

    expect(signature.r, '0x${List.filled(32, '11').join()}');
    expect(signature.s, '0x${List.filled(32, '22').join()}');
    expect(signature.v, 27);
  });

  test('preserves recovery id 28', () {
    final signature = Hip3RsvSignature.fromCompactHex(
      '0x${List.filled(32, 'aa').join()}${List.filled(32, 'bb').join()}1c',
    );

    expect(signature.v, 28);
  });

  test('rejects malformed or unsupported signatures', () {
    expect(
      () => Hip3RsvSignature.fromCompactHex('0x1234'),
      throwsA(isA<Hip3SigningFailure>()),
    );
    expect(
      () => Hip3RsvSignature.fromCompactHex(
        '0x${List.filled(32, '11').join()}${List.filled(32, '22').join()}02',
      ),
      throwsA(isA<Hip3SigningFailure>()),
    );
  });
}
