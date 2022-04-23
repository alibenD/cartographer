#---Automatically Generated from template 'CMakeList.txt' wrote by @aliben---
#
# @Copyright (C) 2022 All rights reserved.
# @filename: CMakeLists.txt
# @author: aliben.develop@gmail.com
# @create_date: 2022-04-23 18:13:24
# @last_modified_date: 2022-04-23 19:15:51
# @description: TODO
#---****************************************************************---
set(ALL_PROTO_SRCS)
set(ALL_PROTO_HDRS)

foreach(ABS_FIL ${ALL_PROTOS})
  file(RELATIVE_PATH REL_FIL ${PROJECT_SOURCE_DIR}/proto ${ABS_FIL})
  get_filename_component(DIR ${REL_FIL} DIRECTORY)
  get_filename_component(FIL_WE ${REL_FIL} NAME_WE)

  list(APPEND ALL_PROTO_SRCS "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.cc")
  list(APPEND ALL_PROTO_HDRS "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.h")

  add_custom_command(
    OUTPUT "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.cc"
           "${PROJECT_BINARY_DIR}/${DIR}/${FIL_WE}.pb.h"
    COMMAND  ${PROTOBUF_PROTOC_EXECUTABLE}
    ARGS --cpp_out  ${PROJECT_BINARY_DIR} -I
      ${PROJECT_SOURCE_DIR}/proto ${ABS_FIL}
    DEPENDS ${ABS_FIL}
    COMMENT "Running C++ protocol buffer compiler on ${ABS_FIL}"
    VERBATIM
  )
endforeach()
set_source_files_properties(${ALL_PROTO_SRCS} ${ALL_PROTO_HDRS} PROPERTIES GENERATED TRUE)

file(GLOB_RECURSE ALL_LIBRARY_SRCS "cartographer/*.cc")
list(APPEND ALL_LIBRARY_HDRS ${ALL_PROTO_HDRS})
list(APPEND ALL_LIBRARY_SRCS ${ALL_PROTO_SRCS})

set(INSTALL_GENERATED_HDRS ${ALL_PROTO_HDRS})

add_library(${PROJECT_NAME} STATIC ${ALL_LIBRARY_HDRS} ${ALL_LIBRARY_SRCS})
target_include_directories(${PROJECT_NAME}
  SYSTEM PUBLIC
    ${EIGEN3_INCLUDE_DIR}
    ${CERES_INCLUDE_DIRS}
    ${LUA_INCLUDE_DIR}
    ${Boost_INCLUDE_DIRS}
    ${CAIRO_INCLUDE_DIRS}
    ${PROTOBUF_INCLUDE_DIR}
  )

target_link_libraries(${PROJECT_NAME}
  PUBLIC
    ${EIGEN3_LIBRARIES}
    ${CERES_LIBRARIES}
    ${LUA_LIBRARIES}
    ${Boost_LIBRARIES}
    glog
    gflags
    ${CAIRO_LIBRARIES}
    ${PROTOBUF_LIBRARY}
    absl::algorithm
    absl::base
    absl::debugging
    absl::flat_hash_map
    absl::memory
    absl::meta
    absl::numeric
    absl::str_format
    absl::strings
    absl::synchronization
    absl::time
    absl::utility
    pthread
  )

#set(TARGET_COMPILE_FLAGS "${TARGET_COMPILE_FLAGS} ${GOOG_CXX_FLAGS}")
set_target_properties(${PROJECT_NAME} PROPERTIES
  COMPILE_FLAGS ${TARGET_COMPILE_FLAGS})

target_include_directories(${PROJECT_NAME} PUBLIC
    $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
    $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
