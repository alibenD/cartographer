if(NOT CMAKE_TOOLCHAIN_FILE)
  find_package(gflags REQUIRED)
else()
  set(gflags_DIR ${CMAKE_BINARY_DIR}/lib/cmake/gflags)
  find_package(gflags NO_MODULE)

  if(NOT gflags_FOUND)
    execute_process(
      COMMAND bash ${PROJECT_SOURCE_DIR}/third_party/gflags/build.bash ${CMAKE_BINARY_DIR}/gflags ${CMAKE_TOOLCHAIN_FILE} ${CMAKE_BINARY_DIR}
      WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/third_party/gflags
      )

    set(gflags_DIR ${CMAKE_BINARY_DIR}/lib/cmake/gflags)
    find_package(gflags NO_MODULE)
    if(NOT gflags_FOUND)
      message(FATAL_ERROR "NOT found gflags")
    else()
      message(STATUS "Found gflags")
    endif()
  endif()
endif()
