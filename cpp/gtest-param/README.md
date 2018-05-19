## gtest-param

This is a C++ [CMake](https://cmake.org/) project that demonstrates type-parametrized testing with [GoogleTest](https://github.com/google/googletest).  It is inspired by and largely copies from the post [Type-parametrized unit testing in GTest](http://anadoxin.org/blog/type-parametrized-unit-testing-in-gtest.html) written by 0xcafebabe.

It is also parenthetically a template for a basic CMake project with unit test support through CTest.
It demonstrates usage of in-build download and install of GTest using crascit's [DownloadProject](https://github.com/Crascit/DownloadProject).

A bash script is used to drive the build, patterned after the script in frankliuao's tutorial [post](https://www.frankliuao.com/a-tutorial-for-cmake-simplized-and-with-examples/). It replaces the `if` with a `switch` that calls out to helper functions. 

To build use
```
./build.sh
```

To run tests use
```
./build.sh
```

To clean up use
```
./build.sh clean
```

To paranoid build and test use
```
./build.sh clean && ./build.sh test
```

