import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/hip3_opening_size.dart';

void main() {
  test('reserves the taker fee from margin before applying leverage', () {
    final maximum = hip3OpeningMaximum(
      availableMargin: DecimalValue('100'),
      venueMaximumQuantity: DecimalValue('100'),
      price: DecimalValue('10'),
      takerFeeRate: DecimalValue('0.001'),
      feeReserveMultiplier: DecimalValue('1'),
      leverage: 10,
      sizeDecimals: 3,
      platformMaximumNotional: DecimalValue('1000'),
    );

    // 100 x 10 starts at 1,000. A 1 USDC reserve leaves 99 USDC margin,
    // which supports 990 USDC of notional, rather than 999.
    expect(maximum.notional.value, '990');
    expect(maximum.quantity.value, '99');
  });

  test(
    'uses the direction capacity and floors its quantity to size decimals',
    () {
      final maximum = hip3OpeningMaximum(
        availableMargin: DecimalValue('100'),
        venueMaximumQuantity: DecimalValue('10'),
        price: DecimalValue('333.333'),
        takerFeeRate: DecimalValue('0.001'),
        feeReserveMultiplier: DecimalValue('1'),
        leverage: 10,
        sizeDecimals: 3,
        platformMaximumNotional: DecimalValue('1000'),
      );

      // The post-reserve cap is 990. Its exact quantity is 2.970002..., so the
      // client sends 2.970 and its corresponding, safely lower, notional.
      expect(maximum.quantity.value, '2.97');
      expect(maximum.notional.value, '989.99901');
    },
  );

  test('rounds fee reserves up and remaining margin down to six decimals', () {
    final maximum = hip3OpeningMaximum(
      availableMargin: DecimalValue('1'),
      venueMaximumQuantity: DecimalValue('100'),
      price: DecimalValue('1'),
      takerFeeRate: DecimalValue('0.00000001'),
      feeReserveMultiplier: DecimalValue('1'),
      leverage: 10,
      sizeDecimals: 8,
      platformMaximumNotional: DecimalValue('100'),
    );

    // The 0.0000001 estimated fee reserves 0.000001, then the remaining
    // margin is truncated to six decimals before multiplying by leverage.
    expect(maximum.notional.value, '9.99999');
    expect(maximum.quantity.value, '9.99999');
  });
}
