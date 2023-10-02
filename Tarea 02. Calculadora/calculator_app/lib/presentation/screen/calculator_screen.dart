import 'dart:ui';
import 'package:calculator_app/business/arithmetic_expression.dart';
import 'package:calculator_app/business/fraction.dart';
import 'package:calculator_app/presentation/widgets/calculator_button.dart';
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
  bool showAsFraction = false;

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
          waitingForPow = false;
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
            } else if (bigScreen[bigScreen.length - 1] == "^") {
              waitingForPow = false;
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
          if (bigScreen != '') {
            try {
              calculateResult();
            } on RangeError {
              smallScreen = 'Error: Internal error occurred';
              bigScreen = '';
            } catch (e) {
              if (e.toString().split('Exception: ')[1] !=
                  'Expression can not be empty') {
                smallScreen = 'Error: ${e.toString().split("Exception: ")[1]}';
              }
            }
          } else {
            smallScreen = '';
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
        case 'pow':
          waitingForPow = true;
          bigScreen = '$bigScreen^';
          textSpans.add(const TextSpan(text: '^'));
          break;
        case 'frac':
          if (showAsFraction) {
            try {
              smallScreen = double.parse(
                      Fraction.fromString(smallScreen).toNum().toString())
                  .toString();
            } catch (e) {
              smallScreen = smallScreen;
            }
            showAsFraction = false;
          } else {
            smallScreen =
                Fraction.fromDouble(double.parse(smallScreen)).toString();
            showAsFraction = true;
          }
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
    if (showAsFraction) {
      smallScreen = resultFraction.toString();
    } else {
      if (result % 1 == 0) {
        smallScreen = '${result.toInt()}';
      } else {
        smallScreen = '$result';
      }
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

    bool isInsideBrackets = false;

    if (bigScreen[bigScreen.length - 1] == "]") {
      isInsideBrackets = true;
      bigScreen = bigScreen.substring(0, bigScreen.length - 1);
    }

    while (bigScreen != "" &&
        (num.tryParse(bigScreen[bigScreen.length - 1]) != null ||
            bigScreen[bigScreen.length - 1] == "." ||
            isInsideBrackets)) {
      tokens.add(bigScreen[bigScreen.length - 1]);
      bigScreen = bigScreen.substring(0, bigScreen.length - 1);
      if (!isInsideBrackets) textSpans.removeLast();
      if (bigScreen != "" && bigScreen[bigScreen.length - 1] == "[") {
        isInsideBrackets = false;
        bigScreen = bigScreen.substring(0, bigScreen.length - 1);
        textSpans.removeLast();
      }
    }

    String num1 = "";
    while (tokens.isNotEmpty) {
      String token = tokens.removeLast();
      num1 = num1 + token;
    }

    dynamic parsedNum1 = 0;

    try {
      parsedNum1 = int.parse(num1);
    } catch (e) {
      try {
        parsedNum1 = double.parse(num1);
      } catch (e) {
        parsedNum1 = num1.toFraction();
      }
    }

    bigScreen = parsedNum1 is int
        ? '$bigScreen${int.parse(num1).toFraction().pow(int.parse(num2))}'
        : parsedNum1 is double
            ? '$bigScreen[${double.parse(num1).toFraction().pow(int.parse(num2))}]'
            : '$bigScreen[${num1.toFraction().pow(int.parse(num2))}]';

    textSpans.add(
      TextSpan(
        children: [
          TextSpan(
            text: num1,
            style: parsedNum1 is Fraction
                ? const TextStyle(
                    fontFeatures: <FontFeature>[
                      FontFeature.fractions(),
                    ],
                  )
                : const TextStyle(),
          ),
          TextSpan(
            text: num2,
            style: const TextStyle(
              fontFamily: 'Ubuntu',
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
                    fontFamily: 'RobotoCondensed',
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
                      fontFamily: 'RobotoCondensed',
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
                      sups: "2",
                      text: "X",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("pow"),
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
                      text: ".",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("."),
                    ),
                    CalculatorBtn(
                      text: "0",
                      backgroundColor: Colors.white12,
                      onPressed: () => onPress("0"),
                    ),
                    CalculatorBtn(
                      frac: "2",
                      text: "1",
                      backgroundColor: Colors.lightBlueAccent,
                      onPressed: () => onPress("frac"),
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
