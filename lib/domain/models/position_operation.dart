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

void requireWithinPosition(String value, String positionQuantity) {
  requirePositiveDecimal(value);
  if (DecimalValue(value)
          .compareTo(DecimalValue(absoluteQuantity(positionQuantity))) >
      0) {
    throw ArgumentError('Quantity exceeds the current position');
  }
}

/// Exact upper bound before venue lot-size rounding (which may only reduce it).
String percentageQuantity(String quantity, String percent) {
  final q = DecimalValue(absoluteQuantity(quantity));
  final p = DecimalValue(percent);
  final units =
      BigInt.parse(q.value.replaceAll('.', '')) *
      BigInt.parse(p.value.replaceAll('.', ''));
  final scale = q.scale + p.scale + 2;
  final digits = units.toString().padLeft(scale + 1, '0');
  return '${digits.substring(0, digits.length - scale)}.${digits.substring(digits.length - scale)}';
}
