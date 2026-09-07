import '../../../domain/models/decimal_value.dart';

enum TokenAmountDisplay { exact, normalized }

/// Formats token amounts without converting them to binary floating point.
abstract final class TokenAmountFormatter {
  static String format(
    DecimalValue amount, {
    required String symbol,
    int? decimals,
    TokenAmountDisplay display = TokenAmountDisplay.normalized,
  }) {
    final normalizedSymbol = symbol.trim();
    if (normalizedSymbol.isEmpty) {
      throw ArgumentError.value(symbol, 'symbol', 'Must not be empty');
    }
    _validateAsset(amount, normalizedSymbol);
    final effectiveValue = _enforceDecimals(amount.value, decimals);
    final displayedValue = switch (display) {
      TokenAmountDisplay.exact => effectiveValue,
      TokenAmountDisplay.normalized => _trimInsignificantZeros(effectiveValue),
    };
    return '${_groupIntegerDigits(displayedValue)} $normalizedSymbol';
  }

  /// Converts an integer amount in the token's smallest unit and formats it.
  static String formatAtomic(
    BigInt atomicUnits, {
    required String symbol,
    required int decimals,
    TokenAmountDisplay display = TokenAmountDisplay.normalized,
  }) {
    _validateDecimals(decimals);
    final negative = atomicUnits.isNegative;
    final digits = atomicUnits.abs().toString().padLeft(decimals + 1, '0');
    final value = decimals == 0
        ? '${negative ? '-' : ''}$digits'
        : '${negative ? '-' : ''}'
              '${digits.substring(0, digits.length - decimals)}.'
              '${digits.substring(digits.length - decimals)}';
    return format(
      DecimalValue(value, asset: symbol, unit: 'token'),
      symbol: symbol,
      decimals: decimals,
      display: display,
    );
  }

  static void _validateAsset(DecimalValue amount, String symbol) {
    final asset = amount.asset?.trim();
    if (asset != null &&
        asset.isNotEmpty &&
        asset.toUpperCase() != symbol.toUpperCase()) {
      throw ArgumentError.value(
        symbol,
        'symbol',
        'Does not match DecimalValue.asset',
      );
    }
  }

  static String _enforceDecimals(String value, int? decimals) {
    if (decimals == null) return value;
    _validateDecimals(decimals);
    final separator = value.indexOf('.');
    if (separator == -1) return value;
    final fraction = value.substring(separator + 1);
    if (fraction.length <= decimals) return value;
    final excess = fraction.substring(decimals);
    if (excess.contains(RegExp('[1-9]'))) {
      throw FormatException(
        'Amount precision exceeds token decimals without rounding permission',
      );
    }
    if (decimals == 0) return value.substring(0, separator);
    return value.substring(0, separator + 1 + decimals);
  }

  static void _validateDecimals(int decimals) {
    if (decimals < 0) {
      throw RangeError.range(decimals, 0, null, 'decimals');
    }
  }

  static String _trimInsignificantZeros(String value) {
    if (!value.contains('.')) return value;
    final withoutZeros = value.replaceFirst(RegExp(r'0+$'), '');
    return withoutZeros.endsWith('.')
        ? withoutZeros.substring(0, withoutZeros.length - 1)
        : withoutZeros;
  }

  static String _groupIntegerDigits(String value) {
    final negative = value.startsWith('-');
    final unsigned = negative ? value.substring(1) : value;
    final separator = unsigned.indexOf('.');
    final integer = separator == -1
        ? unsigned
        : unsigned.substring(0, separator);
    final fraction = separator == -1 ? '' : unsigned.substring(separator);
    final grouped = integer.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (_) => ',',
    );
    return '${negative ? '-' : ''}$grouped$fraction';
  }
}
