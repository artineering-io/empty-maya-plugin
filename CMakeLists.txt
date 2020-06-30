cmake_minimum_required(VERSION 2.8)
project(pluginName)

# FindMaya.cmake directory
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" )

# Enable C++11
if(CMAKE_VERSION VERSION_GREATER 3.1)
    set(CMAKE_CXX_STANDARD 11) # C++11...
    set(CMAKE_CXX_STANDARD_REQUIRED ON) #...is required...
else()
    add_compile_options(-std=c++11)
endif()

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# FindMaya (required)
set(MAYA_VERSION 2017 CACHE STRING "Maya version")
find_package( Maya REQUIRED )

include_directories(${MAYA_INCLUDE_DIR})  # define a list of preprocessor include file search directories
include_directories("/")  # header files should also be included

link_directories(${MAYA_LIBRARY_DIR}) #specifies a directory where a linker should search for libraries

# Set source files
file( GLOB SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.c *.hpp )
file( GLOB HEADERS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.h )

set( SRCS ${SRCS} ${HEADERS})

# Plugin as a library
ADD_LIBRARY(${PROJECT_NAME} SHARED ${SRCS})

get_filename_component(PARENT_DIR ${CMAKE_CURRENT_SOURCE_DIR} PATH)
if(WIN32)
    # Windows
    MESSAGE(STATUS "Compiling for Windows")
    set_target_properties( ${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION} )
    if (MSVC)
      set_target_properties( ${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION} )
      # define each individual release (necessary if you don't want plugins in a Debug, Release, etc folders)
      set_target_properties( ${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION} )
      set_target_properties( ${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION} )
      set_target_properties( ${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION} )
      set_target_properties( ${PROJECT_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION} )
endif()
elseif(APPLE)
    # macOS
    MESSAGE(STATUS "Compiling for macOS")
    set_target_properties( ${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION} )
else()
    # Linux
    MESSAGE(STATUS "Compiling for Linux")
    set_target_properties( ${PROJECT_NAME} PROPERTIES LIBRARY_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/plug-ins/${MAYA_VERSION})
endif()

# Link Maya libraries
TARGET_LINK_LIBRARIES(
    ${PROJECT_NAME} 
    ${MAYA_LIBRARIES} 
    ${OPENGL_gl_LIBRARY})

# Compile (set in FindMaya.cmake)
MAYA_PLUGIN(${PROJECT_NAME})
