##
## CMake configuration for gtest-param (src dir)
##

set (CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/bin)
set (EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set (LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib)
set (gtest-param_SRC ${CMAKE_SOURCE_DIR}/src)

include_directories (${gtest-param_SRC}/container)
add_executable(demo main/main.cpp)

