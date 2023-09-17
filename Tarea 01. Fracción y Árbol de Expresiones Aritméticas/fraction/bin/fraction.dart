import 'package:fraction/fraction.dart';

void main(List<String> arguments) {
  // Same code in test file

  // Constructors
  var f1 = Fraction(5, 9);
  var f2 = Fraction.fromDouble(1.5);
  var f3 = Fraction.fromString("345/753");
  var f4 = Fraction.fromJson({'numerator': 12, 'denominator': 1});

  // Conversions
  var f5 = 9.toFraction();
  var f6 = 1.5.toFraction();
  var f7 = "13/61".toFraction();

  // Operations
  var sum = f1 + f2;
  var difference = f1 - f2;
  var product = f1 * f2;
  var quotient = f1 / f2;

  // Comparisons
  var lessThan = f1 < f2;
  var lessThanOrEqual = f1 <= f2;
  var equalTo = f1 == f2;
  var greaterThanOrEqual = f1 >= f2;
  var greaterThan = f1 > f2;

  // isProper, isImproper, isWhole
  var isProper = f1.isProper;
  var isImproper = f1.isImproper;
  var isWhole = f1.isWhole;

  // pow, toNum
  var pow = f1.pow(2);
  var numValue = f1.toNum();

  print("f1: $f1");
  print("f2: $f2");
  print("f3: $f3");
  print("f4: $f4");
  print("f5: $f5");
  print("f6: $f6");
  print("f7: $f7");

  print("");

  print("Sum (f1 + f2): $sum");
  print("Difference (f1 - f2): $difference");
  print("Product (f1 * f2): $product");
  print("Quotient (f1 / f2): $quotient");

  print("");

  print("Less than (f1 < f2): $lessThan");
  print("Less than or equal (f1 <= f2): $lessThanOrEqual");
  print("Equal to (f1 == f2): $equalTo");
  print("Greater than or equal (f1 >= f2): $greaterThanOrEqual");
  print("Greater than (f1 > f2): $greaterThan");

  print("");

  print("Is Proper (f1): $isProper");
  print("Is Improper (f1): $isImproper");
  print("Is Whole (f1): $isWhole");

  print("");

  print("Power (f1): $pow");
  print("To Num (f1): $numValue");
}
