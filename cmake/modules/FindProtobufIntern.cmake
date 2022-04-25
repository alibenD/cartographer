if(NOT CMAKE_TOOLCHAIN_FILE)
  find_package(Protobuf 3.0.0 REQUIRED)
else()
  set(Protobuf_DIR ${CMAKE_BINARY_DIR}/lib/cmake/protobuf)
  find_package(Protobuf NO_MODULE)

  if(NOT Protobuf_FOUND)
    execute_process(
      COMMAND bash ${PROJECT_SOURCE_DIR}/third_party/protobuf/build.bash ${CMAKE_BINARY_DIR}/protobuf_build ${CMAKE_TOOLCHAIN_FILE} ${CMAKE_BINARY_DIR}
      WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/third_party/protobuf
      )

    set(Protobuf_DIR ${CMAKE_BINARY_DIR}/lib/cmake/protobuf)
    find_package(Protobuf NO_MODULE)
    if(NOT Protobuf_FOUND)
      message(FATAL_ERROR "NOT found Protobuf")
    else()
      message(STATUS "Found Protobuf")
    endif()
  endif()
  set(PROTOBUF_PROTOC_EXECUTABLE /usr/bin/protoc)
endif()
