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
    if (maximum == null) {
      return _decimal(
        affordable * BigInt.from(percent) ~/ BigInt.from(100),
        scale,
      );
    }
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

/// The 100% opening size after reserving the opening taker fee. The returned
/// notional is recomputed from the size-decimal-truncated quantity, so sending
/// it to the market-order preview cannot exceed the calculated capacity.
Hip3OpeningMaximum hip3OpeningMaximum({
  required DecimalValue availableMargin,
  required DecimalValue venueMaximumQuantity,
  required DecimalValue price,
  required DecimalValue takerFeeRate,
  required DecimalValue feeReserveMultiplier,
  required int leverage,
  required int sizeDecimals,
  DecimalValue? platformMaximumNotional,
}) {
  if (leverage < 1 || sizeDecimals < 0) {
    throw ArgumentError('Invalid HIP3 opening limits');
  }
  final margin = _fixed(availableMargin);
  final maximumQuantity = _fixed(venueMaximumQuantity);
  final executionPrice = _fixed(price);
  final feeRate = _fixed(takerFeeRate);
  final reserveMultiplier = _fixed(feeReserveMultiplier);
  if (margin.units.isNegative ||
      maximumQuantity.units.isNegative ||
      executionPrice.units <= BigInt.zero ||
      feeRate.units.isNegative ||
      reserveMultiplier.units.isNegative) {
    throw ArgumentError('Invalid HIP3 opening capacity');
  }

  final venueNotional = _multiply(maximumQuantity, executionPrice);
  final platformMaximum = platformMaximumNotional == null
      ? null
      : _fixed(platformMaximumNotional);
  if (platformMaximum?.units.isNegative ?? false) {
    throw ArgumentError('Invalid platform maximum notional');
  }
  final initial = _minimum([
    _multiply(margin, _Fixed(BigInt.from(leverage), 0)),
    venueNotional,
    ?platformMaximum,
  ]);
  // Keep this in step with the contract: both fee stages reserve upward to
  // six USDC decimals, while the spendable remainder is truncated downward.
  final estimatedFee = _roundUp(_multiply(initial, feeRate), 6);
  final feeReserve = _roundUp(_multiply(estimatedFee, reserveMultiplier), 6);
  final unroundedRemainingMargin = _subtract(margin, feeReserve);
  final remainingMargin = _floor(
    unroundedRemainingMargin.units.isNegative
        ? _Fixed(BigInt.zero, 0)
        : unroundedRemainingMargin,
    6,
  );
  final finalNotional = _minimum([
    _multiply(remainingMargin, _Fixed(BigInt.from(leverage), 0)),
    venueNotional,
    ?platformMaximum,
  ]);
  final quantity = _divideFloor(finalNotional, executionPrice, sizeDecimals);
  final quantizedNotional = _multiply(quantity, executionPrice);
  return Hip3OpeningMaximum(
    notional: _value(quantizedNotional, asset: 'USDC', unit: 'notional'),
    quantity: _value(quantity, unit: 'quantity'),
  );
}

final class Hip3OpeningMaximum {
  const Hip3OpeningMaximum({required this.notional, required this.quantity});

  final DecimalValue notional;
  final DecimalValue quantity;
}

final class _Fixed {
  const _Fixed(this.units, this.scale);

  final BigInt units;
  final int scale;
}

_Fixed _fixed(DecimalValue value) => _Fixed(_units(value), value.scale);

_Fixed _multiply(_Fixed left, _Fixed right) =>
    _Fixed(left.units * right.units, left.scale + right.scale);

_Fixed _subtract(_Fixed left, _Fixed right) {
  final scale = left.scale > right.scale ? left.scale : right.scale;
  return _Fixed(
    _rescale(left.units, left.scale, scale) -
        _rescale(right.units, right.scale, scale),
    scale,
  );
}

_Fixed _roundUp(_Fixed value, int scale) {
  if (value.scale <= scale) {
    return _Fixed(_rescale(value.units, value.scale, scale), scale);
  }
  final factor = _pow10(value.scale - scale);
  return _Fixed((value.units + factor - BigInt.one) ~/ factor, scale);
}

_Fixed _floor(_Fixed value, int scale) =>
    _Fixed(_rescale(value.units, value.scale, scale), scale);

_Fixed _minimum(List<_Fixed> values) {
  final scale = values
      .map((value) => value.scale)
      .reduce((left, right) => left > right ? left : right);
  final units = values
      .map((value) => _rescale(value.units, value.scale, scale))
      .reduce((left, right) => left < right ? left : right);
  return _Fixed(units, scale);
}

_Fixed _divideFloor(_Fixed dividend, _Fixed divisor, int scale) {
  final numerator = dividend.units * _pow10(divisor.scale + scale);
  final denominator = divisor.units * _pow10(dividend.scale);
  return _Fixed(numerator ~/ denominator, scale);
}

DecimalValue _value(_Fixed value, {String? asset, String? unit}) =>
    DecimalValue(_decimal(value.units, value.scale), asset: asset, unit: unit);

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
