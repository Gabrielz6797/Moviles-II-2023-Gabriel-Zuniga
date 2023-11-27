import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getAppTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.blueAccent,
      useMaterial3: true,
    );
  }
}
