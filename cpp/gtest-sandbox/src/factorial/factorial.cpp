// factorial.cpp

#include "factorial.h"

int Factorial(int n)
{
  int result = 1;
  if(n > 1) {
    int i = n;
    while(i > 1) {
      result *= i--;
    }
  }
  return result;
}
