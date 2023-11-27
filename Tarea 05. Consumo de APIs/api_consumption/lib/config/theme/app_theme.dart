import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getAppTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.amberAccent,
      useMaterial3: true,
    );
  }
}
