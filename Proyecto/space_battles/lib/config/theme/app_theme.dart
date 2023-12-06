import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getAppTheme() {
    return ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blueAccent,
        fontFamily: 'PixelifySans',
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black);
  }
}
