class Fraction {
  late int _numerator;
  late int _denominator;

  Fraction(int numerator, int denominator, {precision = 2}) {
    if (denominator == 0) {
      throw FractionException("Denominator cannot be zero");
    }

    final gcd = _calculateGCD(numerator, denominator);
    _numerator = (numerator ~/ gcd);
    _denominator = (denominator ~/ gcd);
  }

  Fraction.fromDouble(double value, {int precision = 2}) {
    final int multiplier = _pow(10, precision);

    final int numerator = (value * multiplier).toInt();
    final int denominator = multiplier;

    final gcd = _calculateGCD(numerator, denominator);
    _numerator = (numerator ~/ gcd);
    _denominator = (denominator ~/ gcd);
  }

  Fraction.fromString(String fractionString, {int precision = 2}) {
    final parts = fractionString.split('/');
    if (parts.length != 2) {
      throw FractionException("Invalid fraction format");
    }

    final int numerator = int.parse(parts[0]);
    final int denominator = int.parse(parts[1]);

    if (denominator == 0) {
      throw FractionException("Denominator cannot be zero");
    }

    final gcd = _calculateGCD(numerator, denominator);
    _numerator = (numerator ~/ gcd);
    _denominator = (denominator ~/ gcd);
  }

  Fraction.fromJson(Map<String, dynamic> json, {int precision = 2}) {
    final numerator = json['numerator'];
    final denominator = json['denominator'];

    if (numerator == null || denominator == null) {
      throw FractionException("Invalid JSON format");
    }

    if (denominator == 0) {
      throw FractionException("Denominator cannot be zero");
    }

    final gcd = _calculateGCD(numerator, denominator);
    _numerator = (numerator ~/ gcd);
    _denominator = (denominator ~/ gcd);
  }

  int get numerator => _numerator;

  int get denominator => _denominator;

  Fraction operator +(Fraction other) {
    final newNumerator =
        (_numerator * other.denominator) + (other.numerator * _denominator);
    final newDenominator = _denominator * other.denominator;
    return Fraction(newNumerator, newDenominator);
  }

  Fraction operator -(Fraction other) {
    final newNumerator =
        (_numerator * other.denominator) - (other.numerator * _denominator);
    final newDenominator = _denominator * other.denominator;
    return Fraction(newNumerator, newDenominator);
  }

  Fraction operator *(Fraction other) {
    final newNumerator = _numerator * other.numerator;
    final newDenominator = _denominator * other.denominator;
    return Fraction(newNumerator, newDenominator);
  }

  Fraction operator /(Fraction other) {
    if (other.numerator == 0) {
      throw FractionException("Division by zero");
    }

    final newNumerator = _numerator * other.denominator;
    final newDenominator = _denominator * other.numerator;
    return Fraction(newNumerator, newDenominator);
  }

  bool operator <(Fraction other) {
    final thisValue = _numerator / _denominator;
    final otherValue = other.numerator / other.denominator;
    return thisValue < otherValue;
  }

  bool operator <=(Fraction other) {
    final thisValue = _numerator / _denominator;
    final otherValue = other.numerator / other.denominator;
    return thisValue <= otherValue;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Fraction &&
          runtimeType == other.runtimeType &&
          _numerator == other._numerator &&
          _denominator == other._denominator;

  bool operator >=(Fraction other) {
    final thisValue = _numerator / _denominator;
    final otherValue = other.numerator / other.denominator;
    return thisValue >= otherValue;
  }

  bool operator >(Fraction other) {
    final thisValue = _numerator / _denominator;
    final otherValue = other.numerator / other.denominator;
    return thisValue > otherValue;
  }

  int _calculateGCD(int a, int b) {
    if (b == 0) {
      return a;
    } else {
      return _calculateGCD(b, a % b);
    }
  }

  int _pow(int x, int n) {
    int res = 1;
    for (int i = 0; i < n; i++) {
      res *= x;
    }

    return res;
  }

  Fraction pow(int exponent) {
    if (exponent < 0) {
      return Fraction(_denominator, _numerator).pow(-exponent);
    } else if (exponent == 0) {
      return Fraction(1, 1);
    } else {
      int resultNumerator = _numerator;
      int resultDenominator = _denominator;

      for (int i = 1; i < exponent; i++) {
        resultNumerator *= _numerator;
        resultDenominator *= _denominator;
      }

      return Fraction(resultNumerator, resultDenominator);
    }
  }

  bool get isProper => _numerator.abs() < _denominator;

  bool get isImproper => _numerator.abs() >= _denominator;

  bool get isWhole => _numerator % _denominator == 0;

  num toNum() => _numerator / _denominator;

  @override
  String toString() {
    if (_denominator == 1) {
      return '$_numerator';
    } else {
      return '$_numerator/$_denominator';
    }
  }

  @override
  int get hashCode => _numerator.hashCode ^ _denominator.hashCode;
}

extension FractionConversion on int {
  Fraction toFraction() {
    return Fraction(this, 1);
  }
}

extension FractionConversionDouble on double {
  Fraction toFraction({int precision = 2}) {
    return Fraction.fromDouble(this, precision: precision);
  }
}

extension FractionConversionString on String {
  Fraction toFraction({int precision = 2}) {
    return Fraction.fromString(this, precision: precision);
  }
}

class FractionException implements Exception {
  final String message;

  FractionException(this.message);

  @override
  String toString() {
    return 'FractionException: $message';
  }
}
