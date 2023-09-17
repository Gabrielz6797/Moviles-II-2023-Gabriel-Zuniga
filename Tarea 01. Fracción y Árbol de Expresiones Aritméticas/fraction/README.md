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
`var f5 = 9.toFraction();`
`var f6 = 1.5.toFraction();`
`var f7 = "13/61".toFraction();`

Also basic operations:
`var sum = f1 + f2;`
`var difference = f1 - f2;`
`var product = f1 * f2;`
`var quotient = f1 / f2;`

Comparisons:
`var lessThan = f1 < f2;`
`var lessThanOrEqual = f1 <= f2;`
`var equalTo = f1 == f2;`
`var greaterThanOrEqual = f1 >= f2;`
`var greaterThan = f1 > f2;`

And some extras:
`var isProper = f1.isProper;`
`var isImproper = f1.isImproper;`
`var isWhole = f1.isWhole;`
`var pow = f1.pow(2);`
`var numValue = f1.toNum();`
