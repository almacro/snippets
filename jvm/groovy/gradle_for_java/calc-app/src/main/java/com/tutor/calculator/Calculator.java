package com.tutor.calculator;

/**
 *  The Calculator class provides implementation for arithmetic operations on integers.
 */
public class Calculator {

  /**
   * The add method returns the sum a + b of adding two integers a and b.
   * @param a addend a
   * @param b addend b
   * @return  the sum a + b
   */
  public int add(int a, int b) {
    return a + b; 
  }

  /**
   * The subtract method returns the difference a - b of subtracting two integers b from a.
   * @param a minuend a
   * @param b subtrahend b
   * @return  the difference a - b
   */
  public int subtract(int a, int b) {
    return a - b; 
  }

  /**
   * The multiply method returns the product a * b of multiplying two integers a and b.
   * @param a factor a
   * @param b factor b
   * @return  the product a * b
   */
  public int multiply(int a, int b) { 
    return a * b; 
  }

  /**
   * The add divide returns the quotient a / b of dividing two integers a by b.
   * @param a dividend a
   * @param b divisor b
   * @return  the quotient a / b
   */
  public int divide(int a, int b) { 
    return a / b; 
  }
}
