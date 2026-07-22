import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget paddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
      child: this,
    );
  }

  Widget center() {
    return Center(child: this);
  }

  Widget expanded({
    int flex = 1,
  }) {
    return Expanded(
      flex: flex,
      child: this,
    );
  }

  Widget flexible({
    int flex = 1,
  }) {
    return Flexible(
      flex: flex,
      child: this,
    );
  }
}