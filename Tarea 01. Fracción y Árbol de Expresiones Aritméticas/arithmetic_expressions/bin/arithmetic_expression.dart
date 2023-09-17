import 'package:arithmetic_expression/arithmetic_expression.dart';
import 'package:arithmetic_expression/fraction.dart';

void main(List<String> arguments) {
  String expression = "([9/81] + 65.5) * 5";
  ArithmeticExpression expressionTree = ArithmeticExpression(expression);
  Fraction resultFraction = expressionTree.evaluateExpression();
  num resultNum = resultFraction.toNum();
  print("Entered expression: $expression");
  print("Result as fraction: $resultFraction");
  print("Result as num: $resultNum");
  print("Preorder Traversal: ${expressionTree.getPreorder()}");
}
