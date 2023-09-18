# A command-line application with an entrypoint in `bin/`, library code in `lib/`, and example unit test in `test/`

This is a library to implement a `Fraction` data type. A `Fraction` can be created from two `int`, from a `double`, from a `String`, or from a `JSON` using the following format:

From two ints:
`var f1 = Fraction(5, 9);`

From a double:
`var f2 = Fraction.fromDouble(1.5);`

From a String:
`var f3 = Fraction.fromString("345/753");`

From a JSON:
`var f4 = Fraction.fromJson({'numerator': 12, 'denominator': 1});`

It also allows for data conversions:

1. `var f5 = 9.toFraction();`
2. `var f6 = 1.5.toFraction();`
3. `var f7 = "13/61".toFraction();`

Also basic operations:

1. `var sum = f1 + f2;`
2. `var difference = f1 - f2;`
3. `var product = f1 * f2;`
4. `var quotient = f1 / f2;`

Comparisons:

1. `var lessThan = f1 < f2;`
2. `var lessThanOrEqual = f1 <= f2;`
3. `var equalTo = f1 == f2;`
4. `var greaterThanOrEqual = f1 >= f2;`
5. `var greaterThan = f1 > f2;`

And some extras:

1. `var isProper = f1.isProper;`
2. `var isImproper = f1.isImproper;`
3. `var isWhole = f1.isWhole;`
4. `var pow = f1.pow(2);`
5. `var numValue = f1.toNum();`
