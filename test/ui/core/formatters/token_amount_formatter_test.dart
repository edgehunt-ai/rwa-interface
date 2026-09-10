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

    test(
      'formats fiat and percentage values without binary floating point',
      () {
        expect(
          TokenAmountFormatter.formatUsd(DecimalValue('12580.4200')),
          r'$12,580.42',
        );
        expect(
          TokenAmountFormatter.formatPercent(DecimalValue('2.01')),
          '+2.01%',
        );
        expect(
          TokenAmountFormatter.formatPercent(DecimalValue('-0.8')),
          '-0.8%',
        );
        expect(
          TokenAmountFormatter.formatPercent(
            DecimalValue('-0.473949693625376621'),
          ),
          '-0.47%',
        );
        expect(
          TokenAmountFormatter.formatPercent(DecimalValue('2.316')),
          '+2.32%',
        );
        expect(
          TokenAmountFormatter.formatPercent(DecimalValue('-0.0049')),
          '0%',
        );
      },
    );

    test('formats fixed-scale editable values without feature rounding', () {
      expect(
        TokenAmountFormatter.formatFixed(DecimalValue('188'), decimals: 2),
        '188.00',
      );
      expect(
        TokenAmountFormatter.formatFixed(DecimalValue('-0.5'), decimals: 2),
        '-0.50',
      );
      expect(
        () => TokenAmountFormatter.formatFixed(
          DecimalValue('1.001'),
          decimals: 2,
        ),
        throwsFormatException,
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

    test('sums USD values at their decimal precision without double', () {
      expect(
        TokenAmountFormatter.sumUsd([
          DecimalValue('12345678901234567890.01', asset: 'USD', unit: 'fiat'),
          DecimalValue('0.009', asset: 'USD', unit: 'fiat'),
          DecimalValue('-0.004', asset: 'USD', unit: 'fiat'),
        ]),
        r'$12,345,678,901,234,567,890.015',
      );
      expect(TokenAmountFormatter.sumUsd(const []), '—');
    });
  });
}
