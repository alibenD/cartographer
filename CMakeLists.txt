# Copyright 2016 The Cartographer Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.2)

project(cartographer)

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
    set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache) # Less useful to do it for linking, see edit2
endif(CCACHE_FOUND)

set(CARTOGRAPHER_MAJOR_VERSION 1)
set(CARTOGRAPHER_MINOR_VERSION 0)
set(CARTOGRAPHER_PATCH_VERSION 0)
set(CARTOGRAPHER_VERSION ${CARTOGRAPHER_MAJOR_VERSION}.${CARTOGRAPHER_MINOR_VERSION}.${CARTOGRAPHER_PATCH_VERSION})
set(CARTOGRAPHER_SOVERSION ${CARTOGRAPHER_MAJOR_VERSION}.${CARTOGRAPHER_MINOR_VERSION})

set(TARGET_COMPILE_FLAGS "${TARGET_COMPILE_FLAGS} ${GOOG_CXX_FLAGS}")

include("${PROJECT_SOURCE_DIR}/cmake/functions.cmake")
google_initialize_cartographer_project()
google_enable_testing()

find_package(absl REQUIRED)
set(BOOST_COMPONENTS iostreams)
find_package(Boost REQUIRED COMPONENTS ${BOOST_COMPONENTS})
find_package(Ceres REQUIRED COMPONENTS SuiteSparse)
find_package(Eigen3 REQUIRED)
find_package(LuaGoogle REQUIRED)
find_package(Protobuf 3.0.0 REQUIRED)

include(FindPkgConfig)
find_library(CAIRO_LIBRARIES cairo)

# Install catkin package.xml
install(FILES package.xml DESTINATION share/cartographer)

set(CARTOGRAPHER_CONFIGURATION_FILES_DIRECTORY ${CMAKE_INSTALL_PREFIX}/share/cartographer/configuration_files
  CACHE PATH ".lua configuration files directory")

install(DIRECTORY configuration_files DESTINATION share/cartographer/)

install(DIRECTORY cmake DESTINATION share/cartographer/)

file(GLOB_RECURSE ALL_LIBRARY_HDRS "include/cartographer/*.h")
file(GLOB_RECURSE ALL_LIBRARY_SRCS "src/cartographer/*.cc")

file(GLOB_RECURSE ALL_EXECUTABLES "example/cartographer/*_main.cc")

file(GLOB_RECURSE ALL_PROTOS "proto/cartographer/*.proto")
#file(GLOB_RECURSE ALL_PROTOS "cartographer/*.proto")

# TODO(cschuet): Move proto compilation to separate function.
#set(ALL_PROTO_SRCS)
#set(ALL_PROTO_HDRS)
#foreach(ABS_FIL ${ALL_PROTOS})
#  file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR}/proto ${ABS_FIL})
#  get_filename_component(DIR ${REL_FIL} DIRECTORY)
#  get_filename_component(FIL_WE ${REL_FIL} NAME_WE)
#
#  list(APPEND ALL_PROTO_SRCS "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.cc")
#  list(APPEND ALL_PROTO_HDRS "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.h")
#
#  add_custom_command(
#    OUTPUT "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.cc"
#           "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.h"
#    COMMAND  ${PROTOBUF_PROTOC_EXECUTABLE}
#    ARGS --cpp_out  ${PROJECT_BINARY_DIR} -I
#      ${PROJECT_SOURCE_DIR}/proto ${ABS_FIL}
#    DEPENDS ${ABS_FIL}
#    COMMENT "Running C++ protocol buffer compiler on ${ABS_FIL}"
#    VERBATIM
#  )
#endforeach()
#set_source_files_properties(${ALL_PROTO_SRCS} ${ALL_PROTO_HDRS} PROPERTIES GENERATED TRUE)
#list(APPEND ALL_LIBRARY_HDRS ${ALL_PROTO_HDRS})
#list(APPEND ALL_LIBRARY_SRCS ${ALL_PROTO_SRCS})
#
#set(INSTALL_GENERATED_HDRS ${ALL_PROTO_HDRS})

#add_library(${PROJECT_NAME} STATIC ${ALL_LIBRARY_HDRS} ${ALL_LIBRARY_SRCS})

configure_file(
  ${PROJECT_SOURCE_DIR}/include/cartographer/common/config.h.cmake
  ${PROJECT_BINARY_DIR}/cartographer/common/config.h)

add_subdirectory(src)
add_subdirectory(example)

#google_binary(cartographer_autogenerate_ground_truth
#  SRCS
#    example/autogenerate_ground_truth_main.cc
#)
#
#google_binary(cartographer_compute_relations_metrics
#  SRCS
#    example/compute_relations_metrics_main.cc
#)
#
#google_binary(cartographer_pbstream
#  SRCS
#    example/pbstream_main.cc
#)
#
#google_binary(cartographer_print_configuration
#  SRCS
#    example/print_configuration_main.cc
#)

#target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC
#  "${EIGEN3_INCLUDE_DIR}")
#target_link_libraries(${PROJECT_NAME} PUBLIC ${EIGEN3_LIBRARIES})
#
#target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC
#  "${CERES_INCLUDE_DIRS}")
#target_link_libraries(${PROJECT_NAME} PUBLIC ${CERES_LIBRARIES})
#
#target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC
#  "${LUA_INCLUDE_DIR}")
#target_link_libraries(${PROJECT_NAME} PUBLIC ${LUA_LIBRARIES})
#
#target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC
#  "${Boost_INCLUDE_DIRS}")
#target_link_libraries(${PROJECT_NAME} PUBLIC ${Boost_LIBRARIES})
#
#set(GLOG_LIBRARY glog)
#
#target_link_libraries(${PROJECT_NAME} PUBLIC ${GLOG_LIBRARY})
#target_link_libraries(${PROJECT_NAME} PUBLIC gflags)

#if("${CAIRO_INCLUDE_DIRS}")
#  target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC
#    "${CAIRO_INCLUDE_DIRS}")
#endif()
#target_link_libraries(${PROJECT_NAME} PUBLIC ${CAIRO_LIBRARIES})

#target_include_directories(${PROJECT_NAME} SYSTEM PUBLIC
#  ${PROTOBUF_INCLUDE_DIR})
# TODO(hrapp): This should not explicitly list pthread and use
# PROTOBUF_LIBRARIES, but that failed on first try.
#target_link_libraries(${PROJECT_NAME} PUBLIC ${PROTOBUF_LIBRARY} 
#  absl::algorithm
#  absl::base
#  absl::debugging
#  absl::flat_hash_map
#  absl::memory
#  absl::meta
#  absl::numeric
#  absl::str_format
#  absl::strings
#  absl::synchronization
#  absl::time
#  absl::utility 
#)
#target_link_libraries(${PROJECT_NAME} PUBLIC pthread)

#set_target_properties(${PROJECT_NAME} PROPERTIES
#  COMPILE_FLAGS ${TARGET_COMPILE_FLAGS})

file(GLOB_RECURSE TEST_LIBRARY_HDRS "tests/include/cartographer/fake_*.h" "tests/include/cartographer/*test_helpers*.h" "tests/include/cartographer/mock_*.h")
file(GLOB_RECURSE TEST_LIBRARY_SRCS "tests/cartographer/fake_*.cc" "tests/cartographer/*test_helpers*.cc" "tests/cartographer/mock_*.cc")
file(GLOB_RECURSE ALL_TESTS "tests/cartographer/*_test.cc")
# Remove dotfiles/-folders that could potentially pollute the build.
set(INSTALL_SOURCE_HDRS ${ALL_LIBRARY_HDRS} ${TEST_LIBRARY_HDRS})
file(GLOB_RECURSE INTERNAL_HDRS "include/cartographer/*/internal/*.h")
list(REMOVE_ITEM INSTALL_SOURCE_HDRS ${INTERNAL_HDRS})


set(TEST_LIB
  cartographer_test_library
)
add_library(${TEST_LIB} ${TEST_LIBRARY_HDRS} ${TEST_LIBRARY_SRCS})
target_include_directories(${TEST_LIB} SYSTEM PRIVATE
  "${GMOCK_INCLUDE_DIRS}"
  ${PROJECT_SOURCE_DIR}/tests/include
  )
# Needed for dynamically linked GTest on Windows.
target_compile_definitions(${TEST_LIB} PUBLIC -DGTEST_LINKED_AS_SHARED_LIBRARY)
target_link_libraries(${TEST_LIB} PUBLIC ${GMOCK_LIBRARY})
target_link_libraries(${TEST_LIB} PUBLIC ${PROJECT_NAME})
set_target_properties(${TEST_LIB} PROPERTIES
  COMPILE_FLAGS ${TARGET_COMPILE_FLAGS})

foreach(ABS_FIL ${ALL_TESTS})
  file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR} ${ABS_FIL})
  get_filename_component(DIR ${REL_FIL} DIRECTORY)
  get_filename_component(FIL_WE ${REL_FIL} NAME_WE)
  # Replace slashes as required for CMP0037.
  string(REPLACE "/" "." TEST_TARGET_NAME "${DIR}/${FIL_WE}")
  google_test("${TEST_TARGET_NAME}" ${ABS_FIL})
  target_link_libraries("${TEST_TARGET_NAME}" PUBLIC ${TEST_LIB})
endforeach()

# Add the binary directory first, so that port.h is included after it has
# been generated.
#target_include_directories(${PROJECT_NAME} PUBLIC
#    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
#    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
#    $<INSTALL_INTERFACE:include>
#)

install(
  TARGETS ${PROJECT_NAME}
  EXPORT CartographerExport
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

foreach(HDR ${INSTALL_SOURCE_HDRS})
  file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR} ${HDR})
  get_filename_component(DIR ${REL_FIL} DIRECTORY)
  install(
    FILES ${HDR}
    DESTINATION include/${DIR}
  )
endforeach()

foreach(HDR ${INSTALL_GENERATED_HDRS})
  file(RELATIVE_PATH REL_FIL ${PROJECT_BINARY_DIR} ${HDR})
  get_filename_component(DIR ${REL_FIL} DIRECTORY)
  install(
    FILES ${HDR}
    DESTINATION include/${DIR}
  )
endforeach()

set(CARTOGRAPHER_CMAKE_DIR share/cartographer/cmake)
include(CMakePackageConfigHelpers)
configure_package_config_file(
  cartographer-config.cmake.in
  ${PROJECT_BINARY_DIR}/cmake/cartographer/cartographer-config.cmake
  PATH_VARS CARTOGRAPHER_CMAKE_DIR
  INSTALL_DESTINATION ${CMAKE_INSTALL_PREFIX}/share/cartographer
)

install(
  EXPORT CartographerExport
  DESTINATION share/cartographer/cmake/
  FILE CartographerTargets.cmake
)

install(
  FILES ${PROJECT_BINARY_DIR}/cmake/cartographer/cartographer-config.cmake
  DESTINATION share/cartographer/
)
