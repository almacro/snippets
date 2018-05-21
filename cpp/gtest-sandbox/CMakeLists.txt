##
## CMake configuration for gtest-param (top-level)
##

cmake_minimum_required (VERSION 3.2)

set (CMAKE_CXX_STANDARD 14)

project (gtest-sandbox)

include (CTest)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

#
# download and install GoogleTest
#
include (DownloadProject)
download_project(PROJ              googletest
                 GIT_REPOSITORY    https://github.com/google/googletest.git
                 GIT_TAG           master
                 ${UPDATED_DISCONNECTED_IF_AVAILABLE}
)
add_subdirectory(${googletest_SOURCE_DIR} ${googletest_BINARY_DIR})

add_subdirectory (src)

enable_testing()
add_subdirectory (test)
