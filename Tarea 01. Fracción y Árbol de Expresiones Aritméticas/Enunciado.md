# Tarea 01. Fracción y Árbol de Expresiones Aritméticas

## Practica 01

### Parte 1. Fracción

Elabore una biblioteca que permita manipular fracciones. Para ello:

Implemente una clase Fraction.

Implemente constructores nombrados que permitan construir fracciones pasando por argumentos los siguientes tipos: json, String, int o double. Las fracciones deben simplificarse antes de guardarse (e.g., 5/10 => 1/2). Agregue al constructor un parámetro opcional presicion para tratar con los números irracionales.

var f1 = Fraction(5, 9);  // int
var f2 = Fraction.fromDouble(1.5) // double
var f3 = Fraction.fromString('345/753')  // String
var f4 = Fraction.fromJson({"numerador": 12, "denominador"});  // Json

Sobrecargue los operadores aritméticos +, -, *, /, para poder realizar las operaciones básicas de suma, resta, multiplicación y división con fracciones.

Sobrecargue los operadores relacionales y de igualdad <, <=, ==, >=, > para poder comparar fracciones.

Extienda la clase int, double y String para permitir la conversión a una fracción.

var f1 = 9.toFraction();
var f2 = 1.5.toFraction();
var f3 = "13/61".toFraction();

Implemente los métodos pow, y los getters isProper, isImproper, y isWhole.

Implemente un método que permita pasar de Fraction a num.

Implemente las excepciones pertinentes para manejar posibles errores.

Implemente pruebas unitarias para todos los métodos de la biblioteca. Se debe probar los resultados esperados y las excepciones.

Elabore la documentación externa de toda la biblioteca.

### Parte 2. Expresiones aritméticas

Elabore una biblioteca que permita analizar y resolver expresiones aritméticas. Las expresiones aritméticas deben permitir operaciones entre tipos int, double, y Fraction.

Implemente una clase que permite creación y manipulación de árboles binarios de expresiones aritméticas. Las expresiones aritmeticas se pasaran en forma de String. Esta cadena de caracteres se debe analizar para formar los nodos del árbol. Para mayor facilidad, puede suponer que las fracciones se representan encerradas por corchetes cuadrados (e.g., ([9/81] + 65) * 5).

Para verificar el correcto funcionamiento del árbol, su programa debe poseer un método que perimite retornar un String con el recorrido en pre-orden.

Implemente un método que resuelva expresiones aritméticas respetando la prioridad de los operadores y los paréntesis. Debe ser posible retornar el resultado como num o Fraction.

Implemente las excepciones pertinentes.

Implemente la prueba unitaria pertinente.

Elabore la documentación externa de toda la biblioteca.
