import 'package:arithmetic_expression/fraction.dart';
import 'dart:io';

class TreeNode {
  dynamic value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value);
}

class ArithmeticExpression {
  late String _expression;
  late String _preOrder;
  late TreeNode root;

  ArithmeticExpression(String expression) {
    if (expression == "") {
      print("Error: expression can not be empty");
      exit(0);
    }
    _expression = expression;
    _preOrder = "";
  }

  Fraction evaluateExpression() {
    verifyInput();
    List<dynamic> tokens = tokenizeExpression();
    _expression = tokens.join(' ');
    root = buildExpressionTree(tokens);
    return evaluate(root);
  }

  verifyInput() {
    _expression = _expression.replaceAll(' ', '');
    for (int i = 0; i < _expression.length; i++) {
      if (_expression[i] == "-") {
        if (_expression[i + 1] == "(") {
          print(
              "Error: the actual algorithm doesn't work with minus signs before a parenthesis ('-()'), please rewrite it");
          exit(0);
        }
      }
    }
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

    // Handle negative numbers
    for (int i = 0; i < tokens.length; i++) {
      if (tokens[i] == '-') {
        if (i == 0 || isOperator(tokens[i - 1]) || tokens[i - 1] == '(') {
          if (i + 1 < tokens.length && !isOperator(tokens[i + 1])) {
            tokens[i + 1] = '-${tokens[i + 1]}'; // Make the next token negative
            tokens.removeAt(i); // Remove the '-' token
          }
        }
      }
    }

    return tokens;
  }

  bool isOperator(dynamic token) {
    return token == '+' || token == '-' || token == '*' || token == '/';
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
          try {
            String operator = operators.removeLast();
            TreeNode right = stack.removeLast();
            TreeNode left = stack.removeLast();

            TreeNode newNode = TreeNode(operator);
            newNode.left = left;
            newNode.right = right;
            stack.add(newNode);
          } on RangeError {
            print('Error: bad expression');
            exit(0);
          }
        }
        operators.add(token);
      }
    }

    while (operators.isNotEmpty) {
      try {
        String operator = operators.removeLast();
        TreeNode right = stack.removeLast();
        TreeNode left = stack.removeLast();

        TreeNode newNode = TreeNode(operator);
        newNode.left = left;
        newNode.right = right;
        stack.add(newNode);
      } on RangeError {
        print('Error: bad expression');
        exit(0);
      }
    }

    return stack.first;
  }

  int precedence(String operator) {
    if (operator == '+' || operator == '-') {
      return 1;
    } else if (operator == '*' || operator == '/') {
      return 2;
    }
    return 0;
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
          print('Error: invalid value found: ${node.value}');
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

  // Function to print the tree in pre-order
  void calculatePreorder(TreeNode? node) {
    if (node == null) {
      return;
    }

    _preOrder += "${node.value} ";

    // Recursively print the left subtree
    calculatePreorder(node.left);

    // Recursively print the right subtree
    calculatePreorder(node.right);
  }

  // Call this function to print the tree in pre-order
  String getPreorder() {
    calculatePreorder(root);
    return _preOrder;
  }

  String getParsedExpression() {
    return _expression;
  }
}

/// Generic exception to handle bad input format
class ExpressionException implements Exception {
  final String message;

  ExpressionException(this.message);

  @override
  String toString() {
    return 'ExpressionException: $message';
  }
}
