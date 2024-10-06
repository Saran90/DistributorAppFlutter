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
    final DateFormat formatter = DateFormat('yyyy-MM-dd, HH:mm:ss');
    return formatter.format(this);
  }

  String toDDMMYYYYFormat() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(this);
  }

  String toDDMMYYYYHHMMSSFormat() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy, HH:mm:ss');
    return formatter.format(this);
  }
}

extension StringToDateExtension on String {
  DateTime toDate() {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    return formatter.parse(this);
  }
}
