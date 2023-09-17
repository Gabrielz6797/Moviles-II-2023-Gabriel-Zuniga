import 'package:arithmetic_expression/arithmetic_expression.dart';
import 'package:arithmetic_expression/fraction.dart';

void main(List<String> arguments) {
  String expression = "([9/81] + 65.5) / (-3 - 2)";
  print("Entered expression: $expression");
  ArithmeticExpression expressionTree = ArithmeticExpression(expression);
  Fraction resultFraction = expressionTree.evaluateExpression();
  print("Parsed expression: ${expressionTree.getParsedExpression()}");
  print("Result as fraction: $resultFraction");
  num resultNum = resultFraction.toNum();
  print("Result as num: $resultNum");
  print("Preorder Traversal: ${expressionTree.getPreorder()}");
}
