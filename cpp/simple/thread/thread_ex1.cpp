#include <chrono>
#include <cstdlib>
#include <iostream>
#include <thread>

void foo() {
  std::cout << "foo starting" << std::endl;
  for (int i = 0; i < 10; i++) {
    std::cout << i << std::endl;
    std::this_thread::sleep_for(std::chrono::seconds(1));
  }
  std::cout << "foo finished" << std::endl;
}

void bar(int x) {
  std::cout << "bar starting" << std::endl;
  for (int i = 0; i < x; i += 10) {
    std::cout << i << std::endl;
    std::this_thread::sleep_for(std::chrono::milliseconds(500));
  }
  std::cout << "bar finished" << std::endl;
}

int main() {
  std::thread first(foo);          // Spawn new thread that calls foo()
  std::thread second(bar, 100);    // Spawn new thread that calls bar()

  std::cout << "main, foo, and bar are now executing concurrently...\n";

  // Synchronize threads:
  first.join();    // Pauses until first finishes
  second.join();   // Pauses until second finishes

  std::cout << "foo and bar completed\n";

  return EXIT_SUCCESS;
}
