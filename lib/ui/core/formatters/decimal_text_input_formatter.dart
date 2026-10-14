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
    final selection = oldValue.selection;
    final insertionOffset = selection.isValid && selection.isCollapsed
        ? selection.start
        : -1;
    final insertsIntoExistingValue =
        oldValue.text.isNotEmpty &&
        insertionOffset >= 0 &&
        newValue.text.length > oldValue.text.length &&
        newValue.text.startsWith(oldValue.text.substring(0, insertionOffset)) &&
        newValue.text.endsWith(oldValue.text.substring(insertionOffset));
    if (insertsIntoExistingValue && text != newValue.text) return oldValue;
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(
        offset: newValue.selection.end.clamp(0, text.length),
      ),
      composing: TextRange.empty,
    );
  }
}
