##
## CMake configuration for gtest-sandbox (src dir)
##

set (CMAKE_BINARY_DIR ${CMAKE_SOURCE_DIR}/bin)
set (EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set (LIBRARY_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/lib)
set (gtest-sandbox_SRC ${CMAKE_SOURCE_DIR}/src)

include_directories (${CMAKE_SOURCE_DIR}/include)
add_library(factorial factorial/factorial.cpp)

add_executable(fact factorial/main.cpp)
target_link_libraries(fact factorial)

#add_library(container container/list.cpp container/queue.cpp)
