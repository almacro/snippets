// factorial/Test.cpp

#include <gtest/gtest.h>

#include "factorial.h"

// Tests factorial of 0.
TEST(FactorialTest, HandlesZeroInput){
  EXPECT_EQ(1, Factorial(0));
}

// Tests factorial of positive numbers.
TEST(FactorialTest, HandlesPositiveInput){
  EXPECT_EQ(1, Factorial(1));
  EXPECT_EQ(2, Factorial(2));
  EXPECT_EQ(6, Factorial(3));
  EXPECT_EQ(40320, Factorial(8));
}
