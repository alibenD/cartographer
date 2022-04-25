if(NOT CMAKE_TOOLCHAIN_FILE)
  find_package(absl REQUIRED)
else()
  set(absl_DIR ${CMAKE_BINARY_DIR}/lib/cmake/absl)
  find_package(absl NO_MODULE)

  if(NOT absl_FOUND)
    execute_process(
      COMMAND bash ${PROJECT_SOURCE_DIR}/third_party/abseil-cpp/build.bash ${CMAKE_BINARY_DIR}/abseil_build ${CMAKE_TOOLCHAIN_FILE} ${CMAKE_BINARY_DIR}
      WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/third_party/abseil-cpp
      )

    set(absl_DIR ${CMAKE_BINARY_DIR}/lib/cmake/absl)
    find_package(absl NO_MODULE)
    if(NOT absl_FOUND)
      message(FATAL_ERROR "NOT found absl")
    else()
      message(STATUS "Found absl")
    endif()
  endif()
endif()
