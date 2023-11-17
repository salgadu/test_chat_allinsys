import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CapitalizeTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.capitalize.toString(),
      selection: newValue.selection,
    );
  }
}
