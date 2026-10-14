import 'package:flutter/services.dart';

final class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.maxFractionDigits}) {
    if (maxFractionDigits < 0) {
      throw ArgumentError.value(
        maxFractionDigits,
        'maxFractionDigits',
        'Must not be negative',
      );
    }
  }

  final int maxFractionDigits;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!RegExp(r'^\d*\.?\d*$').hasMatch(newValue.text)) return oldValue;
    final separator = newValue.text.indexOf('.');
    if (separator == -1) return newValue;
    final end = separator + 1 + maxFractionDigits;
    final text = maxFractionDigits == 0
        ? newValue.text.substring(0, separator)
        : newValue.text.length <= end
        ? newValue.text
        : newValue.text.substring(0, end);
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(
        offset: newValue.selection.end.clamp(0, text.length),
      ),
      composing: TextRange.empty,
    );
  }
}
