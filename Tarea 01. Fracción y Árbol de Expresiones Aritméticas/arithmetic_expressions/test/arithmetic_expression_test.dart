import 'package:arithmetic_expression/arithmetic_expression.dart';
import 'package:test/test.dart';

void main() {
  test('4 + 5', () {
    final expression = ArithmeticExpression('4 + 5');
    final result = expression.evaluateExpression().toNum();
    expect(result, 9);
  });

  test('4 - 5', () {
    final expression = ArithmeticExpression('4 - 5');
    final result = expression.evaluateExpression().toNum();
    expect(result, -1);
  });

  test('(10 + -20)', () {
    final expression = ArithmeticExpression('(10 + -20)');
    final result = expression.evaluateExpression().toNum();
    expect(result, -10);
  });

  test('[3/2] + 1.5', () {
    final expression = ArithmeticExpression('[3/2] + 1.5');
    final result = expression.evaluateExpression().toNum();
    expect(result, 3);
  });

  test('[3/2] + 1.55', () {
    final expression = ArithmeticExpression('[3/2] + 1.55');
    final result = expression.evaluateExpression().toNum();
    expect(result, 3.05);
  });

  test('[5/2] * [8/2]', () {
    final expression = ArithmeticExpression('[5/2] * [8/2]');
    final result = expression.evaluateExpression().toNum();
    expect(result, 10);
  });

  test('[-5/2] - [8/2]', () {
    final expression = ArithmeticExpression('[-5/2] - [8/2]');
    final result = expression.evaluateExpression().toNum();
    expect(result, -6.5);
  });

  test('4.33 * -7.88', () {
    final expression = ArithmeticExpression('4.33 * -7.88');
    final result = expression.evaluateExpression().toNum();
    expect(result, -34.1204);
  });

  test('([2/3] + 5) * 3.5 - (8 / 2)', () {
    final expression = ArithmeticExpression('([2/3] + 5) * 3.5 - (8 / 2)');
    final result = expression.evaluateExpression().toNum();
    expect(result, 15.833333333333334);
  });

  test('([200/30] + 543.6) * 3.5 - (86 / 490.8)', () {
    final expression =
        ArithmeticExpression('([200/30] + 543.6) * 3.5 - (86 / 490.8)');
    final result = expression.evaluateExpression().toNum();
    expect(result, 1925.758109209454);
  });

  test('2334 + 50.3 * 700 - (8 * 2)', () {
    final expression = ArithmeticExpression('2334 + 50.3 * 700 - (8 * 2)');
    final result = expression.evaluateExpression().toNum();
    expect(result, 37528);
  });

  test('([2/30] * [54/270]) / (35.2 - 1000000)', () {
    final expression =
        ArithmeticExpression('([2/30] * [54/270]) / (35.2 - 1000000)');
    final result = expression.evaluateExpression().toNum();
    expect(result, -1.3333802683187781e-8);
  });

  test('4 + + * 5', () {
    final expression = ArithmeticExpression('4 + + * 5');
    expect(() => expression.evaluateExpression(),
        throwsA(isA<ExpressionException>()));
  });

  test('4 5A', () {
    final expression = ArithmeticExpression('4 5A');
    expect(() => expression.evaluateExpression(),
        throwsA(isA<ExpressionException>()));
  });

  test('', () {
    final expression = ArithmeticExpression('A');
    expect(() => expression.evaluateExpression(),
        throwsA(isA<ExpressionException>()));
  });

  test('(10 + 20', () {
    final expression = ArithmeticExpression('(10 + 20');
    expect(() => expression.evaluateExpression(),
        throwsA(isA<ExpressionException>()));
  });

  test('([3/3 + 5)', () {
    final expression = ArithmeticExpression('([3/3 + 5)');
    expect(() => expression.evaluateExpression(),
        throwsA(isA<ExpressionException>()));
  });

  test(')]3/3[ + 5(', () {
    final expression = ArithmeticExpression(')]3/3[ + 5(');
    expect(() => expression.evaluateExpression(),
        throwsA(isA<ExpressionException>()));
  });
}
