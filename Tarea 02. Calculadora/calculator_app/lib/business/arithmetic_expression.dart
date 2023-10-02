import 'package:calculator_app/business/fraction.dart';

/// Class to save the tokens that form the given expression
class TreeNode {
  dynamic value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value);
}

/// Main class of the file, saves the expression in [_expression], and saves a
/// String with the equivalent preorder expression in [_preorder], also has a
/// [root]
class ArithmeticExpression {
  late String _expression;
  late String _preorder;
  late TreeNode root;

  /// Class contructor, checks for black expressions and can throw an
  /// [ExpressionException]
  ArithmeticExpression(String expression) {
    if (expression == "") {
      throw ExpressionException("Expression can not be empty");
    }
    _expression = expression;
    _preorder = "";
  }

  /// Main function of the class, calls other functions to solve the expression
  Fraction evaluateExpression() {
    verifyInput();
    List<dynamic> tokens = tokenizeExpression();
    _expression = tokens.join(' ');
    root = _buildExpressionTree(tokens);
    return _evaluate(root);
  }

  /// Verifies that the input expression is supported, right now the algorithm
  /// doesn't work with negative parenthesis ('-()')
  verifyInput() {
    _expression = _expression.replaceAll(' ', '');
    for (int i = 0; i < _expression.length; i++) {
      if (_expression[i] == "-") {
        if (i + 1 < _expression.length && _expression[i + 1] == "(") {
          if (i - 1 > 0 && _isOperator(_expression[i - 1])) {
            throw ExpressionException(
                "The actual algorithm can't handle negative parenthesis ('-()'), please rewrite the expression");
          }
        }
      }
    }
  }

  /// Separates the expression into tokens and stores them into a list
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
          throw ExpressionException("Numbers for Fraction must be integers");
        }
        continue;
      } else if (openBrackets == true) {
        continue;
      }

      if (_isOperator(char) || char == '(' || char == ')') {
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
        if (i == 0 || _isOperator(tokens[i - 1]) || tokens[i - 1] == '(') {
          if (i + 1 < tokens.length && !_isOperator(tokens[i + 1])) {
            tokens[i + 1] = '-${tokens[i + 1]}';
            tokens.removeAt(i);
          }
        }
      }
    }

    return tokens;
  }

  /// Checks if a character is an operator
  bool _isOperator(dynamic token) {
    return token == '+' || token == '-' || token == '*' || token == '/';
  }

  /// Uses the list of tokens to build the tree
  TreeNode _buildExpressionTree(List<dynamic> tokens) {
    List<TreeNode> stack = [];
    List<String> operators = [];

    // Traverses the list of tokens and removes them while adding them to the tree
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
        // Remove the '(' from the stack
        operators.removeLast();
      } else if (!_isOperator(token)) {
        TreeNode node = TreeNode(token);
        stack.add(node);
      } else {
        while (operators.isNotEmpty &&
            _precedence(operators.last) >= _precedence(token)) {
          try {
            String operator = operators.removeLast();
            TreeNode right = stack.removeLast();
            TreeNode left = stack.removeLast();

            TreeNode newNode = TreeNode(operator);
            newNode.left = left;
            newNode.right = right;
            stack.add(newNode);
          } on RangeError {
            throw ExpressionException("Bad expression");
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
        throw ExpressionException("Bad expression");
      }
    }

    return stack.first;
  }

  /// Calculates the precedence of operators
  int _precedence(String operator) {
    if (operator == '+' || operator == '-') {
      return 1;
    } else if (operator == '*' || operator == '/') {
      return 2;
    }
    return 0;
  }

  /// Evaluates the value of the given node and depending on the type of the
  /// token it contains, also throws [ExpressionException] if the value is not
  /// valid
  Fraction _evaluate(TreeNode? node) {
    if (node == null) {
      return Fraction(0, 1);
    }

    if (!_isOperator(node.value)) {
      if (node.value is Fraction) {
        return node.value;
      } else if (node.value is String) {
        try {
          return Fraction.fromDouble(double.parse(node.value));
        } on FormatException {
          throw ExpressionException("Invalid value found: '${node.value}'");
        }
      } else {
        return Fraction(int.parse(node.value), 1);
      }
    }

    Fraction leftValue = _evaluate(node.left);
    Fraction rightValue = _evaluate(node.right);

    // Performs the required operation if the node contains an operator
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
        throw ExpressionException("Invalid operator: ${node.value}");
    }
  }

  /// Auxiliary function to calculate the tree in preorder
  void _calculatePreorder(TreeNode? node) {
    if (node == null) {
      return;
    }

    _preorder += "${node.value} ";

    // Recursively read the left subtree
    _calculatePreorder(node.left);

    // Recursively read the right subtree
    _calculatePreorder(node.right);
  }

  /// Function to calculate the tree in preorder
  String getPreorder() {
    _calculatePreorder(root);
    return _preorder;
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
