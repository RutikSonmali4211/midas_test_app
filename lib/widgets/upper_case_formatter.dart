import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    if (newValue.text == oldValue.text) {
      return newValue;
    }
    return TextEditingValue(
        text: newValue.text.toUpperCase(),
        selection: newValue.selection);
  }
}
