// main.cpp

#include <cstdlib>
#include <iostream>

#include "factorial.h"

int main(int argc, char* argv[])
{
  if(argc < 2)
    {
      std::cerr << "usage: " << argv[0] << " <N>" << std::endl;
      return 1;
    }
  std::cout << Factorial(atoi(argv[1])) << std::endl;
  return 0;
}
