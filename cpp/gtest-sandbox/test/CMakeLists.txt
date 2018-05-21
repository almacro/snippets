##
## CMake configuration for gtest-sandbox (test dir)
##

include_directories (${TEST_SOURCE_DIR}
                     ${CMAKE_SOURCE_DIR}/include
                     ${googletest_INCLUDE_DIRS}
)

add_executable (factorialTest factorial/Test.cpp)
target_link_libraries (factorialTest
                       factorial
                       gtest
                       gmock_main
)
add_test(NAME factorial COMMAND factorialTest)

add_executable (containerTest container/Test.cpp)
target_link_libraries (containerTest
                       gtest
                       gmock
)
add_test(NAME container COMMAND containerTest)
