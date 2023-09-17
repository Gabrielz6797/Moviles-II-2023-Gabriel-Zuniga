import 'package:arithmetic_expression/arithmetic_expression.dart';
import 'package:arithmetic_expression/fraction.dart';

void main(List<String> arguments) {
  String expression = "((9/81) + 65) * 5";
  ArithmeticExpression expressionTree = ArithmeticExpression(expression);
  Fraction result = expressionTree.evaluateExpression();
  print("Result: $result");
}
