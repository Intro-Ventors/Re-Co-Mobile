# Set the minimum required CMake version.
cmake_minimum_required(VERSION 3.10.2)

project(graphics_engine VERSION 1.0.0 DESCRIPTION "Graphics Engine library for the Reality Core mobile application.")

# Specify the C++ standard
set(CMAKE_CXX_STANDARD 17)

# Add the library.
add_library(graphics_engine

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             src/engine.cpp
             src/firefly_compile.cpp
			 )

# Set the additional includes.
include_directories(graphics_engine PUBLIC "${CMAKE_CURRENT_LIST_DIR}/third_party/Firefly/Include")

add_definitions(-DGLM_FORCE_CXX17)
