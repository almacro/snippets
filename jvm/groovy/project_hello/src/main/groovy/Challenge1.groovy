class Challenge1 {
  static void main(String[] args) {
    Calculator calc = new Calculator()

    println "1 + 2 = " + calc.add(1,2)
    println "3 - 7 = " + calc.subtract(3,7)
    println "4 * 4 = " + calc.multiply(4,4)
    println "21 / 7 = " + calc.divide(21,7)
    println "20 / 7 = " + calc.divide(20,7)

    int a = 9
    int b = 0
    try {
        calc.divide(a,b)
    } catch(Exception e) {
      assert e instanceof ArithmeticException
      println "Error: attempt to divide by zero, " + a + " / " + b
    }
  }
}