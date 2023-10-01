import 'dart:ui';
import 'package:calculator_app/arithmetic_expression.dart';
import 'package:calculator_app/fraction.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String smallScreen = '';
  String bigScreen = '';

  List<TextSpan> textSpans = [];

  int parenthesisCount = 0;
  int bracketsCount = 0;

  bool waitingForPow = false;

  num result = 0;

  void onPress(String text) {
    setState(() {
      switch (text) {
        case 'AC':
          smallScreen = '';
          bigScreen = '';
          textSpans = [];
          parenthesisCount = 0;
          bracketsCount = 0;
          result = 0;
          break;
        case 'backspace':
          if (bigScreen == '') break;
          if (bigScreen.length == 1) {
            bigScreen = '';
            textSpans.removeLast();
          } else {
            if (bigScreen[bigScreen.length - 1] == "(") {
              parenthesisCount--;
            } else if (bigScreen[bigScreen.length - 1] == ")") {
              parenthesisCount++;
            } else if (bigScreen[bigScreen.length - 1] == "[") {
              bracketsCount--;
            } else if (bigScreen[bigScreen.length - 1] == "]") {
              while (bigScreen[bigScreen.length - 1] != "[") {
                bigScreen = bigScreen.substring(0, bigScreen.length - 1);
              }
            }
            bigScreen = bigScreen.substring(0, bigScreen.length - 1);
            TextSpan lastElement = textSpans.removeLast();
            if (lastElement.children != null) {
              while (bigScreen != "" &&
                  num.tryParse(bigScreen[bigScreen.length - 1]) != null) {
                bigScreen = bigScreen.substring(0, bigScreen.length - 1);
              }
            }
          }
          break;
        case '+':
          if (parenthesisCount == 0 && bracketsCount == 0) {
            calculateResult();
          }
          bigScreen = '$bigScreen+';
          textSpans.add(const TextSpan(text: '+'));
          break;
        case '-':
          if (parenthesisCount == 0 && bracketsCount == 0) {
            calculateResult();
          }
          bigScreen = '$bigScreen-';
          textSpans.add(const TextSpan(text: '-'));
          break;
        case 'x':
          if (parenthesisCount == 0 && bracketsCount == 0) {
            calculateResult();
          }
          bigScreen = '$bigScreen*';
          textSpans.add(const TextSpan(text: '*'));
          break;
        case '/':
          if (parenthesisCount == 0 && bracketsCount == 0) {
            calculateResult();
          }
          bigScreen = '$bigScreen/';
          textSpans.add(const TextSpan(text: '/'));
          break;
        case '=':
          try {
            calculateResult();
          } catch (e) {
            smallScreen = 'Error: ${e.toString().split(':')[1]}';
          }
          break;
        case '.':
          if (bigScreen.isNotEmpty && bigScreen[bigScreen.length - 1] == '.') {
            break;
          } else {
            if (bigScreen == '') {
              bigScreen = text;
            } else {
              bigScreen = bigScreen + text;
            }
            textSpans.add(const TextSpan(text: '.'));
          }
          break;
        case '(':
          parenthesisCount++;
          bigScreen = '$bigScreen(';
          textSpans.add(const TextSpan(text: '('));
          break;
        case ')':
          parenthesisCount--;
          bigScreen = '$bigScreen)';
          textSpans.add(const TextSpan(text: ')'));
          break;
        case '[':
          bracketsCount++;
          bigScreen = '$bigScreen[';
          textSpans.add(const TextSpan(text: '['));
          break;
        case ']':
          bracketsCount--;
          bigScreen = '$bigScreen]';
          List<String?> tokens = [];
          while (textSpans.last.text != "[") {
            TextSpan previous = textSpans.removeLast();
            tokens.add(previous.text);
          }
          textSpans.removeLast();
          String fraction = "";
          while (tokens.isNotEmpty) {
            String? token = tokens.removeLast();
            fraction = fraction + token!;
          }
          textSpans.add(
            TextSpan(
              text: fraction,
              style: const TextStyle(
                fontFeatures: <FontFeature>[
                  FontFeature.fractions(),
                ],
              ),
            ),
          );
          break;
        case 'Pow':
          waitingForPow = true;
          bigScreen = '$bigScreen^';
          textSpans.add(const TextSpan(text: '^'));
          break;
        default:
          if (bigScreen == '') {
            bigScreen = text;
          } else {
            bigScreen = bigScreen + text;
          }
          textSpans.add(TextSpan(text: text));
      }
    });
  }

  void calculateResult() {
    if (waitingForPow) checkPow();
    ArithmeticExpression expression = ArithmeticExpression(bigScreen);
    Fraction resultFraction = expression.evaluateExpression();
    result = resultFraction.toNum();
    if (result % 1 == 0) {
      smallScreen = '${result.toInt()}';
    } else {
      smallScreen = '$result';
    }
  }

  void checkPow() {
    waitingForPow = false;
    List<String> tokens = [];
    while (bigScreen != "" &&
        num.tryParse(bigScreen[bigScreen.length - 1]) != null) {
      tokens.add(bigScreen[bigScreen.length - 1]);
      bigScreen = bigScreen.substring(0, bigScreen.length - 1);
      textSpans.removeLast();
    }
    String num2 = "";
    while (tokens.isNotEmpty) {
      String token = tokens.removeLast();
      num2 = num2 + token;
    }

    bigScreen = bigScreen.substring(0, bigScreen.length - 1);
    textSpans.removeLast();

    while (bigScreen != "" &&
        num.tryParse(bigScreen[bigScreen.length - 1]) != null) {
      tokens.add(bigScreen[bigScreen.length - 1]);
      bigScreen = bigScreen.substring(0, bigScreen.length - 1);
      textSpans.removeLast();
    }
    String num1 = "";
    while (tokens.isNotEmpty) {
      String token = tokens.removeLast();
      num1 = num1 + token;
    }

    bigScreen =
        '$bigScreen${int.parse(num1).toFraction().pow(int.parse(num2))}';
    textSpans.add(
      TextSpan(
        children: [
          TextSpan(
            text: num1,
          ),
          TextSpan(
            text: num2,
            style: const TextStyle(
              fontFeatures: [
                FontFeature.enable('sups'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Calculator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.black,
              height: 40,
              width: double.infinity,
              child: SingleChildScrollView(
                //for horizontal scrolling
                scrollDirection: Axis.horizontal,
                child: Text(
                  smallScreen,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: Colors.black,
              height: 100,
              width: double.infinity,
              child: SingleChildScrollView(
                //for horizontal scrolling
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w400,
                      fontSize: 70,
                    ),
                    children: <TextSpan>[...textSpans],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "AC",
                      backgroundColor: Colors.white38,
                      onPressed: () => onPress("AC"),
                    ),
                    CalculatorBtn(
                      text: "(",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("("),
                    ),
                    CalculatorBtn(
                      text: ")",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress(")"),
                    ),
                    CalculatorBtn(
                      icon: Icons.backspace_rounded,
                      backgroundColor: Colors.white38,
                      onPressed: () => onPress("backspace"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "Pow",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("Pow"),
                    ),
                    CalculatorBtn(
                      text: "[",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("["),
                    ),
                    CalculatorBtn(
                      text: "]",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("]"),
                    ),
                    CalculatorBtn(
                      text: "/",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("/"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "7",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("7"),
                    ),
                    CalculatorBtn(
                      text: "8",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("8"),
                    ),
                    CalculatorBtn(
                      text: "9",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("9"),
                    ),
                    CalculatorBtn(
                      text: "x",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("x"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "4",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("4"),
                    ),
                    CalculatorBtn(
                      text: "5",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("5"),
                    ),
                    CalculatorBtn(
                      text: "6",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("6"),
                    ),
                    CalculatorBtn(
                      text: "-",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("-"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "1",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("1"),
                    ),
                    CalculatorBtn(
                      text: "2",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("2"),
                    ),
                    CalculatorBtn(
                      text: "3",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("3"),
                    ),
                    CalculatorBtn(
                      text: "+",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("+"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CalculatorBtn(
                      text: "+/-",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("+/-"),
                    ),
                    CalculatorBtn(
                      text: "0",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("0"),
                    ),
                    CalculatorBtn(
                      text: ".",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("."),
                    ),
                    CalculatorBtn(
                      text: "=",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("="),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ));
  }
}

class CalculatorBtn extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const CalculatorBtn({
    this.icon,
    this.text = '',
    required this.backgroundColor,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      radius: 16,
      child: Container(
        height: 68,
        width: 84,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: (icon != null)
            ? Icon(icon, size: 35, color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 30,
                ),
              ),
      ),
    );
  }
}