import 'package:arithmetic_expression/arithmetic_expression.dart';
import 'package:test/test.dart';

void main() {
  test('calculate', () {
    final expression = ArithmeticExpression('([2/3] + 5) * 3.5 - (8/2)');
    final result = expression.evaluate();
    expect(result, 0);
  });
}
