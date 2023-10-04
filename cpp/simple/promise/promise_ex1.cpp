#include <chrono>
#include <future>
#include <iostream>
#include <numeric>
#include <thread>
#include <vector>

void accumulate(
  std::vector<int>::iterator first,
  std::vector<int>::iterator last,
  std::promise<int> accumulate_promise) {
  int sum = std::accumulate(first, last, 0);
  accumulate_promise.set_value(sum);
}

int main() {
  // Demonstrating using promise<int> to transmit a result between threads
  std::vector<int> numbers = { 1, 2, 3, 4, 5, 6 };
  std::promise<int> accumulate_promise;
  std::future<int> accumulate_future = accumulate_promise.get_future();
  std::thread work_thread(accumulate, numbers.begin(), numbers.end(), std::move(accumulate_promise));

  // future.get() will wait until the future has a valid result and retrieves it.
  // Calling accumulate_future.wait() before accumulate_future.get() is not needed.
  std::cout << "result = " << accumulate_future.get() << "\n";
  work_thread.join();    // Wait for thread completion.
}
