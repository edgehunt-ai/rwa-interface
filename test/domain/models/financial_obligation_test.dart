import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/financial_obligation.dart';

void main() {
  test('18 decimal obligation remains exact beyond double precision', () {
    final amount = FinancialObligationAmount.known('2500970232991173395');
    expect(amount.raw, '2500970232991173395');
    expect(amount.decimal(18), '2.500970232991173395');
    expect(FinancialObligationAmount.known('1').decimal(18),
        '0.000000000000000001');
  });

  test('unknown obligation never becomes zero', () {
    final amount = FinancialObligationAmount.unknown('receipt_unavailable');
    expect(amount.raw, isNull);
    expect(amount.decimal(6), isNull);
    expect(amount.unknownReason, 'receipt_unavailable');
    expect(FinancialObligationAmount.known('0').decimal(6), '0.000000');
  });

  test('malformed raw amounts fail rather than rounding', () {
    for (final raw in ['1e18', '100e+16', '-1', '1.2', '', '01']) {
      expect(() => FinancialObligationAmount.known(raw), throwsFormatException);
    }
    expect(() => FinancialObligationAmount.unknown(' '), throwsFormatException);
    expect(() => FinancialObligationAmount.known('1').decimal(-1),
        throwsRangeError);
  });
}
