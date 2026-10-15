import 'decimal_value.dart';

enum ProtectionClearScope { takeProfit, stopLoss, both }

/// UI validation uses exact decimals; the server still normalizes size/price.
void requirePositiveDecimal(String value) {
  if (DecimalValue(value).compareTo(DecimalValue('0')) <= 0) {
    throw ArgumentError('Enter a positive number');
  }
}

String absoluteQuantity(String value) =>
    value.startsWith('-') ? value.substring(1) : value;

void requireWithinPosition(
  String value,
  String positionQuantity, {
  int? maxFractionDigits,
}) {
  requirePositiveDecimal(value);
  if (maxFractionDigits != null) {
    requireQuantityPrecision(value, maxFractionDigits);
  }
  if (DecimalValue(value)
          .compareTo(DecimalValue(absoluteQuantity(positionQuantity))) >
      0) {
    throw ArgumentError('Quantity exceeds the current position');
  }
}

void requireQuantityPrecision(String value, int maxFractionDigits) {
  if (maxFractionDigits < 0) {
    throw ArgumentError.value(
      maxFractionDigits,
      'maxFractionDigits',
      'Must not be negative',
    );
  }
  final normalized = value.trim().replaceFirst(RegExp(r'0+$'), '');
  final separator = normalized.indexOf('.');
  final fractionDigits = separator == -1
      ? 0
      : normalized.length - separator - 1;
  if (fractionDigits > maxFractionDigits) {
    throw ArgumentError('Quantity exceeds the product size precision');
  }
}

String truncateQuantity(String value, int maxFractionDigits) {
  if (maxFractionDigits < 0) {
    throw ArgumentError.value(
      maxFractionDigits,
      'maxFractionDigits',
      'Must not be negative',
    );
  }
  final separator = value.indexOf('.');
  if (separator == -1) return value;
  if (maxFractionDigits == 0) return value.substring(0, separator);
  final end = separator + 1 + maxFractionDigits;
  return value.length <= end ? value : value.substring(0, end);
}

/// Exact upper bound before venue lot-size rounding (which may only reduce it).
String percentageQuantity(
  String quantity,
  String percent, {
  int? maxFractionDigits,
}) {
  final q = DecimalValue(absoluteQuantity(quantity));
  final p = DecimalValue(percent);
  final units =
      BigInt.parse(q.value.replaceAll('.', '')) *
      BigInt.parse(p.value.replaceAll('.', ''));
  final scale = q.scale + p.scale + 2;
  final digits = units.toString().padLeft(scale + 1, '0');
  final value =
      '${digits.substring(0, digits.length - scale)}.${digits.substring(digits.length - scale)}';
  return maxFractionDigits == null
      ? value
      : truncateQuantity(value, maxFractionDigits);
}
