import 'decimal_value.dart';

/// Opening protection has no independent size: the native parent owns it.
final class Hip3OpeningProtection {
  Hip3OpeningProtection({this.takeProfit, this.stopLoss}) {
    if (takeProfit == null && stopLoss == null) {
      throw ArgumentError('Enter at least one protection trigger');
    }
  }

  final Hip3OpeningProtectionLeg? takeProfit;
  final Hip3OpeningProtectionLeg? stopLoss;

  String get fingerprint =>
      '${takeProfit?.fingerprint}|${stopLoss?.fingerprint}';
}

final class Hip3OpeningProtectionLeg {
  Hip3OpeningProtectionLeg({required this.triggerPrice, this.limitPrice}) {
    bool positive(DecimalValue value) =>
        value.compareTo(
          DecimalValue('0', asset: value.asset, unit: value.unit),
        ) >
        0;
    if (!positive(triggerPrice) ||
        (limitPrice != null && !positive(limitPrice!))) {
      throw ArgumentError('Protection prices must be positive');
    }
  }

  final DecimalValue triggerPrice;

  /// Null means native market protection, not a guaranteed execution price.
  final DecimalValue? limitPrice;

  String get fingerprint => '${triggerPrice.value}|${limitPrice?.value}';
}

final class Hip3OpeningProtectionConfirmation {
  const Hip3OpeningProtectionConfirmation({
    required this.quantity,
    required this.legs,
  });
  final DecimalValue quantity;
  final List<Hip3ConfirmedProtectionLeg> legs;

  bool matches(Hip3OpeningProtection intent, DecimalValue parentQuantity) {
    bool equal(DecimalValue a, DecimalValue b) =>
        DecimalValue(a.value).compareTo(DecimalValue(b.value)) == 0;
    if (!equal(quantity, parentQuantity) || legs.isEmpty || legs.length > 2) {
      return false;
    }
    final expected = <bool, Hip3OpeningProtectionLeg>{
      if (intent.takeProfit != null) true: intent.takeProfit!,
      if (intent.stopLoss != null) false: intent.stopLoss!,
    };
    if (legs.length != expected.length ||
        legs.map((l) => l.takeProfit).toSet().length != legs.length) {
      return false;
    }
    for (final leg in legs) {
      final requested = expected[leg.takeProfit];
      if (requested == null ||
          !equal(leg.triggerPrice, requested.triggerPrice) ||
          leg.market != (requested.limitPrice == null) ||
          DecimalValue(leg.executionPrice.value).compareTo(DecimalValue('0')) <=
              0 ||
          (requested.limitPrice != null &&
              !equal(leg.executionPrice, requested.limitPrice!))) {
        return false;
      }
    }
    return true;
  }
}

final class Hip3ConfirmedProtectionLeg {
  const Hip3ConfirmedProtectionLeg({
    required this.takeProfit,
    required this.market,
    required this.triggerPrice,
    required this.executionPrice,
  });
  final bool takeProfit;
  final bool market;
  final DecimalValue triggerPrice;
  final DecimalValue executionPrice;
}
