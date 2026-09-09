import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  test('splits a compact signature and normalizes recovery id', () {
    final r = List.filled(32, '11').join();
    final s = List.filled(32, '22').join();
    final signature = Hip3RsvSignature.fromCompactHex('0x${r}${s}01');
    expect(signature.r, '0x$r');
    expect(signature.s, '0x$s');
    expect(signature.v, 28);
  });

  test('rejects malformed compact signatures', () {
    expect(
      () => Hip3RsvSignature.fromCompactHex('0x12'),
      throwsFormatException,
    );
  });
}
