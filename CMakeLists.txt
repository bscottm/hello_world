cmake_minimum_required(VERSION 3.14)

if (${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
  message(FATAL_ERROR
         ""
        "!!! DO NOT BUILD CMake artifacts in the SIMH source directory !!!\n"
        ""
        "Create a subdirectory and build in that subdirectory, e.g.:"
        "\n"
        "  $ mkdir cmake-build\n"
        "  $ cd cmake-build\n"
        "  $ cmake -G \"your generator here\" ..\n"
        ""
        "Preventing in-tree source build.")
endif ()

project(hello_world VERSION "1.0.0" LANGUAGES C)
add_executable(hello_world hello.c)
