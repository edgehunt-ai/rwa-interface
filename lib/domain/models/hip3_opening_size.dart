import 'decimal_value.dart';
import 'order_preview.dart';

/// A percentage of the server-quoted maximum, floored to whole venue lots.
/// The resulting input still requires a new server preview before signing.
String hip3OpeningPercentage(
  Hip3PreviewExecution quote,
  int percent,
  int sizeDecimals, {
  required bool notional,
}) {
  if (percent < 0 || percent > 100 || sizeDecimals < 0 || sizeDecimals > 6) {
    throw ArgumentError('Invalid HIP3 size percentage');
  }
  final maximum = quote.maximumQuantity;
  final units = BigInt.parse(maximum.value.replaceAll('.', ''));
  if (units.isNegative) throw ArgumentError('Invalid maximum quantity');
  final lots =
      units *
      BigInt.from(percent) *
      BigInt.from(10).pow(sizeDecimals) ~/
      (BigInt.from(100) * BigInt.from(10).pow(maximum.scale));
  if (!notional) return _decimal(lots, sizeDecimals);
  final price = DecimalValue(quote.limitPrice.value);
  final priceUnits = BigInt.parse(price.value.replaceAll('.', ''));
  if (priceUnits <= BigInt.zero) throw ArgumentError('Invalid quote price');
  return _decimal(lots * priceUnits, sizeDecimals + price.scale);
}

String _decimal(BigInt units, int scale) {
  if (scale == 0) return units.toString();
  final text = units.toString().padLeft(scale + 1, '0');
  final value =
      '${text.substring(0, text.length - scale)}.${text.substring(text.length - scale)}'
          .replaceFirst(RegExp(r'0+$'), '')
          .replaceFirst(RegExp(r'\.$'), '');
  return value;
}
