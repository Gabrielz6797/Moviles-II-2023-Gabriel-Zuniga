import 'package:flutter/material.dart';

import 'package:calculator_app/presentation/screen/calculator_screen.dart';

void main() {
  runApp(const CalcApp());
}

class CalcApp extends StatelessWidget {
  const CalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightBlueAccent,
      ),
      home: const CalculatorScreen(),
    );
  }
}
