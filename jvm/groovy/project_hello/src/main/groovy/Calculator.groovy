class Calculator {
  public int add(int a, int b) {
    a + b
  }
  public int subtract(int a, int b) {
    a - b
  }
  public int multiply(int a, int b) {
    a * b
  }
  public float divide(int a, int b) {
    if(b == 0) {
      throw new ArithmeticException("divide by zero error")
    }
    else a/b
  }
}