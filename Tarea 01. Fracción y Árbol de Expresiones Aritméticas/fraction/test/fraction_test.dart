import 'package:fraction/fraction.dart';
import 'package:test/test.dart';

void main() {
  group("Fractions from ints", () {
    test("Fraction(5, 9) to String. Value should be 5/9", () {
      var fraction = Fraction(5, 9);
      expect(fraction.toString(), "5/9");
    });

    test("Fraction(5, 9) to num. Value should be 0.5555555555555556", () {
      var fraction = Fraction(5, 9);
      expect(fraction.toNum(), 0.5555555555555556);
    });

    test("Fraction(-100, 0). Value should be FractionException", () {
      expect(() => Fraction(-100, 0), throwsA(isA<FractionException>()));
    });

    test("Fraction(0, -100). Value should be 0", () {
      var fraction = Fraction(0, -100);
      expect(fraction.toNum(), 0);
    });
  });

  group("Fractions from doubles", () {
    test("Fraction.fromDouble(1.5) to String. Value should be 3/2", () {
      var fraction = Fraction.fromDouble(1.5);
      expect(fraction.toString(), "3/2");
    });

    test("Fraction.fromDouble(1.5) to num. Value should be 1.5", () {
      var fraction = Fraction.fromDouble(1.5);
      expect(fraction.toNum(), 1.5);
    });

    test("Fraction.fromDouble(0). Value should be 0", () {
      var fraction = Fraction.fromDouble(0);
      expect(fraction.toNum(), 0);
    });
  });

  group("Fractions from Strings", () {
    test("Fraction.fromString('345/753') to String. Value should be 345/753",
        () {
      var fraction = Fraction.fromString("345/753");
      expect(fraction.toString(), "115/251");
    });

    test(
        "Fraction.fromString(345/753) to num. Value should be 0.4581673306772908",
        () {
      var fraction = Fraction.fromString("345/753");
      expect(fraction.toNum(), 0.4581673306772908);
    });

    test("Fraction.fromString('0/10'). Value should be FractionException", () {
      var fraction = Fraction.fromString("0/10");
      expect(fraction.toNum(), 0);
    });

    test("Fraction.fromString('1/+'). Value should be FractionException", () {
      expect(() => Fraction.fromString('1/+'), throwsA(isA<FormatException>()));
    });

    test("Fraction.fromString('hola'). Value should be FractionException", () {
      expect(
          () => Fraction.fromString("hola"), throwsA(isA<FractionException>()));
    });
  });

  group("Fractions from JSON", () {
    test(
        "Fraction.fromJson({'numerator': 12, 'denominator': 1}) to String. Value should be 12",
        () {
      var fraction = Fraction.fromJson({'numerator': 12, 'denominator': 1});
      expect(fraction.toString(), "12");
    });

    test(
        "Fraction.fromJson({'numerator': 12, 'denominator': 16}) to num. Value should be 0.75",
        () {
      var fraction = Fraction.fromJson({'numerator': 12, 'denominator': -16});
      expect(fraction.toNum(), -0.75);
    });

    test(
        "Fraction.fromJson({'numerator': 0, 'denominator': 3}. Value should be 0",
        () {
      var fraction = Fraction.fromJson({'numerator': 0, 'denominator': 3});
      expect(fraction.toNum(), 0);
    });

    test(
        "Fraction.fromJson({'numerator': 12, 'denominator': 0}). Value should be FractionException",
        () {
      expect(() => Fraction.fromJson({'numerator': 12, 'denominator': 0}),
          throwsA(isA<FractionException>()));
    });

    test(
        "Fraction.fromJson({'hola': 12, 'denominator': adios}). Value should be FractionException",
        () {
      expect(() => Fraction.fromJson({'hola': 12, 'denominator': 'adios'}),
          throwsA(isA<FractionException>()));
    });
  });

  group("Conversions to fraction", () {
    test("9.toFraction()", () {
      var fraction = 9.toFraction();
      expect(fraction.toString(), "9");
    });

    test("1.5.toFraction()", () {
      var fraction = 1.5.toFraction();
      expect(fraction.toString(), "3/2");
    });

    test("'13/61'.toFraction()", () {
      var fraction = "13/61".toFraction();
      expect(fraction.toString(), "13/61");
    });
  });

  group("Fraction operations", () {
    var f1 = Fraction(5, 9);
    var f2 = Fraction.fromDouble(1.5);

    test("Sum", () {
      var sum = f1 + f2;
      expect(sum.toString(), "37/18");
    });

    test("Difference", () {
      var difference = f1 - f2;
      expect(difference.toString(), "-17/18");
    });

    test("Product", () {
      var product = f1 * f2;
      expect(product.toString(), "5/6");
    });

    test("Quotient", () {
      var quotient = f1 / f2;
      expect(quotient.toString(), "10/27");
    });
  });

  group("Fraction comparisons", () {
    var f1 = Fraction(5, 9);
    var f2 = Fraction.fromDouble(1.5);

    test("Less than", () {
      var lessThan = f1 < f2;
      expect(lessThan, true);
    });

    test("Less than or equal", () {
      var lessThanOrEqual = f1 <= f2;
      expect(lessThanOrEqual, true);
    });

    test("Equal to", () {
      var equalTo = f1 == f2;
      expect(equalTo, false);
    });

    test("Greater than or equal", () {
      var greaterThanOrEqual = f1 >= f2;
      expect(greaterThanOrEqual, false);
    });

    test("Greater than", () {
      var greaterThan = f1 > f2;
      expect(greaterThan, false);
    });
  });

  group("Fraction isProper, isImproper, isWhole", () {
    var f1 = Fraction(5, 9);

    test("isProper", () {
      var isProper = f1.isProper;
      expect(isProper, true);
    });

    test("isImproper", () {
      var isImproper = f1.isImproper;
      expect(isImproper, false);
    });

    test("isWhole", () {
      var isWhole = f1.isWhole;
      expect(isWhole, false);
    });
  });

  group("Fraction power and toNum", () {
    var f1 = Fraction(5, 9);

    test("pow", () {
      var pow = f1.pow(2);
      expect(pow.toString(), "25/81");
    });

    test("toNum", () {
      var numValue = f1.toNum();
      expect(numValue, 0.5555555555555556);
    });
  });
}
