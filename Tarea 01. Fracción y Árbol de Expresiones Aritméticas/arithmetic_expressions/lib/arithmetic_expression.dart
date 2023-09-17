import 'package:arithmetic_expression/fraction.dart';
import 'dart:io';

class TreeNode {
  dynamic value;
  late TreeNode left;
  late TreeNode right;

  TreeNode(this.value);
}

class ArithmeticExpression {
  late String _expression;
  late TreeNode root;

  ArithmeticExpression(String expression) {
    _expression = expression;
  }

  bool isOperator(dynamic token) {
    return token == '+' || token == '-' || token == '*' || token == '/';
  }

  int precedence(String operator) {
    if (operator == '+' || operator == '-') {
      return 1;
    } else if (operator == '*' || operator == '/') {
      return 2;
    }
    return 0;
  }

  List<dynamic> tokenizeExpression() {
    List<dynamic> tokens = [];
    dynamic currentToken = "";
    bool openBrackets = false;
    int start = 0;

    for (int i = 0; i < _expression.length; i++) {
      String char = _expression[i];
      if (char == ' ') {
        continue;
      }

      if (char == "[" && i < _expression.length) {
        start = i + 1;
        openBrackets = true;
        continue;
      } else if (char == "]") {
        openBrackets = false;
        String fractionStr = _expression.substring(start, i);
        List<String> parts = fractionStr.split('/');
        try {
          tokens.add(Fraction(int.parse(parts[0]), int.parse(parts[1])));
        } on FormatException {
          print('Error: numbers for Fraction must be integers');
          exit(0);
        }
        continue;
      } else if (openBrackets == true) {
        continue;
      }

      if (isOperator(char) || char == '(' || char == ')') {
        if (currentToken.isNotEmpty) {
          tokens.add(currentToken);
          currentToken = "";
        }
        tokens.add(char);
      } else {
        currentToken += char;
      }
    }

    if (currentToken.isNotEmpty) {
      tokens.add(currentToken);
    }

    return tokens;
  }

  TreeNode buildExpressionTree(List<dynamic> tokens) {
    List<TreeNode> stack = [];
    List<String> operators = [];

    for (dynamic token in tokens) {
      if (token == '(') {
        operators.add(token);
      } else if (token == ')') {
        while (operators.isNotEmpty && operators.last != '(') {
          String operator = operators.removeLast();
          TreeNode right = stack.removeLast();
          TreeNode left = stack.removeLast();
          TreeNode newNode = TreeNode(operator);
          newNode.left = left;
          newNode.right = right;
          stack.add(newNode);
        }
        operators.removeLast(); // Remove the '(' from the stack
      } else if (!isOperator(token)) {
        TreeNode node = TreeNode(token);
        stack.add(node);
      } else {
        while (operators.isNotEmpty &&
            precedence(operators.last) >= precedence(token)) {
          String operator = operators.removeLast();
          TreeNode right = stack.removeLast();
          TreeNode left = stack.removeLast();

          TreeNode newNode = TreeNode(operator);
          newNode.left = left;
          newNode.right = right;
          stack.add(newNode);
        }
        operators.add(token);
      }
    }

    while (operators.isNotEmpty) {
      String operator = operators.removeLast();
      TreeNode right = stack.removeLast();
      TreeNode left = stack.removeLast();

      TreeNode newNode = TreeNode(operator);
      newNode.left = left;
      newNode.right = right;
      stack.add(newNode);
    }

    return stack.first;
  }

  Fraction evaluate(TreeNode? node) {
    if (node == null) {
      return Fraction(0, 1);
    }

    if (!isOperator(node.value)) {
      if (node.value is Fraction) {
        return node.value;
      } else if (node.value is String) {
        try {
          return Fraction.fromDouble(double.parse(node.value));
        } on FormatException {
          String value = node.value;
          print('Error: invalid value found: $value');
          exit(0);
        }
      } else {
        return Fraction(int.parse(node.value), 1);
      }
    }

    Fraction leftValue = evaluate(node.left);
    Fraction rightValue = evaluate(node.right);

    switch (node.value) {
      case '+':
        return leftValue + rightValue;
      case '-':
        return leftValue - rightValue;
      case '*':
        return leftValue * rightValue;
      case '/':
        return leftValue / rightValue;
      default:
        throw Exception("Invalid operator: ${node.value}");
    }
  }

  Fraction evaluateExpression() {
    List<dynamic> tokens = tokenizeExpression();
    root = buildExpressionTree(tokens);
    return evaluate(root);
  }
}
