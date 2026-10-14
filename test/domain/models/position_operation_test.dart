import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/position_operation.dart';

void main() {
  group('HIP-3 position quantity precision', () {
    test('rejects significant digits beyond size decimals', () {
      expect(() => requireQuantityPrecision('0.123', 2), throwsArgumentError);
      expect(() => requireQuantityPrecision('0.1200', 2), returnsNormally);
      expect(
        () => requireWithinPosition('0.123', '1', maxFractionDigits: 2),
        throwsArgumentError,
      );
    });

    test('percentage quantities are floored to the product size step', () {
      expect(percentageQuantity('1.2345', '33', maxFractionDigits: 3), '0.407');
      expect(
        percentageQuantity('-1.2345', '100', maxFractionDigits: 3),
        '1.234',
      );
    });
  });
}
