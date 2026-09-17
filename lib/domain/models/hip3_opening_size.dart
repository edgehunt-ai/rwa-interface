import 'decimal_value.dart';
import 'order_preview.dart';

/// Notional for a percentage of the balance the account can actually commit:
/// available balance times leverage, the same "money I can spend" the slider
/// means on a bStocks order. Needs no quote and no price — a percentage of
/// spendable balance is already a notional amount — so the slider works before
/// anything is typed.
///
/// When a quote happens to be available its maximum quantity caps the result,
/// since the venue and policy limits it folds in can be tighter than balance.
/// The resulting input still requires a new server preview before signing.
String hip3OpeningNotional(
  DecimalValue availableBalance,
  int leverage,
  int percent, {
  Hip3PreviewExecution? quote,
}) {
  if (percent < 0 || percent > 100) {
    throw ArgumentError('Invalid HIP3 size percentage');
  }
  if (leverage < 1) throw ArgumentError('Invalid leverage');
  final balanceUnits = _units(availableBalance);
  if (balanceUnits.isNegative) throw ArgumentError('Invalid available balance');

  // Work in balance scale throughout; notional shares the settlement asset.
  var scale = availableBalance.scale;
  var affordable = balanceUnits * BigInt.from(leverage);

  if (quote != null) {
    final maximum = quote.maximumQuantity;
    final price = DecimalValue(quote.limitPrice.value);
    final maximumUnits = _units(maximum);
    final priceUnits = _units(price);
    if (maximumUnits.isNegative) {
      throw ArgumentError('Invalid maximum quantity');
    }
    if (priceUnits <= BigInt.zero) throw ArgumentError('Invalid quote price');
    // Compare at the finer of the two scales so a cap like 14.8 is not
    // truncated by a whole-number balance.
    final capScale = maximum.scale + price.scale;
    final common = scale > capScale ? scale : capScale;
    final scaled = _rescale(affordable, scale, common);
    final cap = _rescale(maximumUnits * priceUnits, capScale, common);
    affordable = cap < scaled ? cap : scaled;
    scale = common;
  }

  return _decimal(affordable * BigInt.from(percent) ~/ BigInt.from(100), scale);
}

BigInt _units(DecimalValue value) =>
    BigInt.parse(value.value.replaceAll('.', ''));

BigInt _pow10(int exponent) => BigInt.from(10).pow(exponent);

/// Restates [units] from [from] decimal places to [to], truncating toward zero.
BigInt _rescale(BigInt units, int from, int to) =>
    to >= from ? units * _pow10(to - from) : units ~/ _pow10(from - to);

String _decimal(BigInt units, int scale) {
  if (scale == 0) return units.toString();
  final text = units.toString().padLeft(scale + 1, '0');
  final value =
      '${text.substring(0, text.length - scale)}.${text.substring(text.length - scale)}'
          .replaceFirst(RegExp(r'0+$'), '')
          .replaceFirst(RegExp(r'\.$'), '');
  return value;
}
