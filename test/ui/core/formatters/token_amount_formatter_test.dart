import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/ui/core/formatters/token_amount_formatter.dart';

void main() {
  group('TokenAmountFormatter', () {
    test('preserves an 18-decimal non-zero amount exactly', () {
      final value = DecimalValue(
        '0.000000000000000001',
        asset: 'ETH',
        unit: 'token',
      );

      expect(
        TokenAmountFormatter.format(value, symbol: 'ETH', decimals: 18),
        '0.000000000000000001 ETH',
      );
    });

    test('groups integer digits and only trims insignificant zeros', () {
      final value = DecimalValue(
        '1234567.120000',
        asset: 'USDC',
        unit: 'token',
      );

      expect(
        TokenAmountFormatter.format(value, symbol: 'USDC', decimals: 6),
        '1,234,567.12 USDC',
      );
      expect(
        TokenAmountFormatter.format(
          value,
          symbol: 'USDC',
          decimals: 6,
          display: TokenAmountDisplay.exact,
        ),
        '1,234,567.120000 USDC',
      );
    });

    test('converts atomic units using token decimals without double', () {
      expect(
        TokenAmountFormatter.formatAtomic(
          BigInt.one,
          symbol: 'ETH',
          decimals: 18,
        ),
        '0.000000000000000001 ETH',
      );
      expect(
        TokenAmountFormatter.formatAtomic(
          BigInt.from(-1234567),
          symbol: 'USDC',
          decimals: 6,
        ),
        '-1.234567 USDC',
      );
    });

    test('rejects non-zero precision beyond token decimals', () {
      final value = DecimalValue('1.0000001', asset: 'USDC', unit: 'token');

      expect(
        () => TokenAmountFormatter.format(value, symbol: 'USDC', decimals: 6),
        throwsFormatException,
      );
    });

    test('allows excess zero scale without changing numeric value', () {
      final value = DecimalValue('1.23000000', asset: 'USDC', unit: 'token');

      expect(
        TokenAmountFormatter.format(
          value,
          symbol: 'USDC',
          decimals: 6,
          display: TokenAmountDisplay.exact,
        ),
        '1.230000 USDC',
      );
    });

    test('rejects invalid decimals and a mismatched token symbol', () {
      final value = DecimalValue('1', asset: 'USDC', unit: 'token');

      expect(
        () => TokenAmountFormatter.format(value, symbol: 'ETH', decimals: 18),
        throwsArgumentError,
      );
      expect(
        () => TokenAmountFormatter.formatAtomic(
          BigInt.one,
          symbol: 'ETH',
          decimals: -1,
        ),
        throwsRangeError,
      );
    });
  });
}
