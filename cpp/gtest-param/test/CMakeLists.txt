##
## CMake configuration for gtest-param (test dir)
##

include_directories (${TEST_SOURCE_DIR}
                     ${CMAKE_SOURCE_DIR}/src
                     ${CMAKE_SOURCE_DIR}/src/container
                     ${googletest_INCLUDE_DIRS}
)

#add_executable (demoTest main/Test.cpp)
#target_link_libraries (demoTest
#                       gtest
#                       gmock_main
#)
#add_test(NAME demoTest COMMAND demoTest)

add_executable (containerTest container/Test.cpp)
target_link_libraries (containerTest
                       gtest
                       gmock_main
)
add_test(NAME containerTest COMMAND containerTest)
