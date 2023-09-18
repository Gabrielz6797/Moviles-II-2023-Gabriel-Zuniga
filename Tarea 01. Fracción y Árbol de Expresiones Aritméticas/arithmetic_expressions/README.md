# A command-line application with an entrypoint in `bin/`, library code in `lib/`, and example unit test in `test/`

This is a library to create and solve arithmetic expression trees formed of ints, doubles, and `Fraction` objects represented as numbers in between brackets separated by a slash. (Eg. `[4/3]`).

Starting by it's limitations, the current algorithm is not capable of handling negative parentheses, for example `-(3 + 2)` can't be converted to `(-3 - 2)`, the user will have to keep that in mind when writing an expression.

Other than that, it is expected to be able to solve expressions like:

1. `4 + 5`
2. `(10 + -20)`
3. `[3/2] + 1.5`
4. `[5/2] * [8/2]`
5. `[-5/2] - [8/2]`
6. `4.33 * -7.88`
7. `([2/3] + 5) * 3.5 - (8/2)`
8. `([200/30] + 543.6) * 3.5 - (86 / 490.8)`
9. `2334 + 50.3 * 700 - (8 * 2)`
10. `([2/30] * [54/270]) / (35.2 - 1000000)`

It will also throw `ExpressionException` if the input is not valid, for example:

1. `4 + + * 5`
2. `4 5A`
3. `(Blank)`
4. `(10 + 20`
5. `([3/3 + 5)`
6. `)]3/3[ + 5(`
