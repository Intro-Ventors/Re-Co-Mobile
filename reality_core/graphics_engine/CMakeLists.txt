# Set the minimum required CMake version.
cmake_minimum_required(VERSION 3.10.2)

project(graphics_engine VERSION 1.0.0 DESCRIPTION "Graphics Engine library for the Reality Core mobile application.")

# Specify the C++ standard
set(CMAKE_CXX_STANDARD 17)

# Add the library.
add_library	(graphics_engine
             SHARED

             src/engine.cpp
             src/export.cpp
             src/firefly_compile.cpp
			 )

# Set the additional includes.
include_directories(graphics_engine PUBLIC "${CMAKE_CURRENT_LIST_DIR}/third_party/Firefly/Include")

add_definitions(-DGLM_FORCE_CXX17)
find_library(ANDROID_LOG_LIB log)
target_link_libraries(graphics_engine ${ANDROID_LOG_LIB})

# Set the variables needed to export the shaders to the header files.
set(SPIRV_TO_HEADER ${CMAKE_CURRENT_SOURCE_DIR}/../scripts/spirv_to_header.py)
set(SHADER_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../assets/Shaders)
set(SHADER_DESTINATION_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src/)

add_custom_command (TARGET graphics_engine 
					PRE_BUILD

				   	COMMAND python ${SPIRV_TO_HEADER} ${SHADER_SOURCE_DIR}/shader.vert.spv ${SHADER_DESTINATION_DIR}/vert_spv.h vert_spv
				   	COMMAND python ${SPIRV_TO_HEADER} ${SHADER_SOURCE_DIR}/shader.frag.spv ${SHADER_DESTINATION_DIR}/frag_spv.h frag_spv
					)

if(DEFINED ${SANITIZE})
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fsanitize=undefined,address")
endif()
