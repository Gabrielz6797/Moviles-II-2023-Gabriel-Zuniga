import 'package:arithmetic_expression/fraction.dart';

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

  bool isOperator(String token) {
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

  List<String> tokenizeExpression() {
    List<String> tokens = [];
    String currentToken = "";

    for (int i = 0; i < _expression.length; i++) {
      String char = _expression[i];
      if (char == ' ') {
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

  TreeNode buildExpressionTree(List<String> tokens) {
    List<TreeNode> stack = [];
    List<String> operators = [];

    for (String token in tokens) {
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
        if (token.startsWith("[") && token.endsWith("]")) {
          // Handle fractions enclosed in square brackets
          String fractionStr = token.substring(1, token.length - 1);
          List<String> parts = fractionStr.split("/");
          int numerator = int.parse(parts[0]);
          int denominator = int.parse(parts[1]);
          Fraction fraction = Fraction(numerator, denominator);
          stack.add(TreeNode(fraction));
        } else {
          TreeNode node = TreeNode(token);
          stack.add(node);
        }
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
    List<String> tokens = tokenizeExpression();
    root = buildExpressionTree(tokens);
    return evaluate(root);
  }
}
