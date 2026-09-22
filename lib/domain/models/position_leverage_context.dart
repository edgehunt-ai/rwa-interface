import 'decimal_value.dart';
import 'position.dart';

final class PositionLeverageContext {
  const PositionLeverageContext({
    required this.productId,
    required this.maximum,
    required this.validUntil,
    required this.canChange,
    this.current,
    this.marginMode,
    this.marginModes = const {},
  });
  final String productId;
  final DecimalValue maximum;
  final DecimalValue? current;
  final PositionMarginMode? marginMode;
  final Set<PositionMarginMode> marginModes;
  final DateTime validUntil;
  final bool canChange;

  bool accepts(String value, DateTime now) =>
      canChange &&
      now.isBefore(validUntil) &&
      RegExp(r'^[1-9][0-9]*$').hasMatch(value) &&
      DecimalValue(value).compareTo(DecimalValue(maximum.value)) <= 0;
}
