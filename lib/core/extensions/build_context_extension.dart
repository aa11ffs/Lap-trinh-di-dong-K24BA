import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  double get getWidth => MediaQuery.of(this).size.width;
  double get getHeight => MediaQuery.of(this).size.height;
  void get unFocus => FocusScope.of(this).unfocus();
}
