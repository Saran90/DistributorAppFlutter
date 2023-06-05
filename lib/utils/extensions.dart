import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExtension on BuildContext {
  void showMessage(String message) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

extension DoublePrecisionExtension on double {
  double to2DigitFraction() {
    return double.parse(toStringAsFixed(2));
  }
}
extension DateTimeApiFormatExtension on DateTime {
  String toApiFormat() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd, hh:mm:ss');
    return formatter.format(this);
  }
}