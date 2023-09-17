import 'package:arithmetic_expression/arithmetic_expression.dart';

void main(List<String> arguments) {
  String expression = "([9/81] + 65.5) * 5";
  print("Entered expression: $expression");
  ArithmeticExpression expressionTree = ArithmeticExpression(expression);
  num result = expressionTree.evaluateExpression().toNum();
  print("Result: $result");
  print("");
  print("Tree");
}
