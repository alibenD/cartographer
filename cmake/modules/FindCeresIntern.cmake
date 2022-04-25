if(NOT CMAKE_TOOLCHAIN_FILE)
  find_package(Ceres REQUIRED)
else()
  set(Ceres_DIR ${CMAKE_BINARY_DIR}/lib/cmake/Ceres)
  find_package(Ceres NO_MODULE)

  if(NOT Ceres_FOUND)
    execute_process(
      COMMAND bash ${PROJECT_SOURCE_DIR}/third_party/ceres-solver-1.14.0/build.bash ${CMAKE_BINARY_DIR}/ceres_build ${CMAKE_TOOLCHAIN_FILE} ${CMAKE_BINARY_DIR}
      WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/third_party/ceres-solver-1.14.0
      )

    set(Ceres_DIR ${CMAKE_BINARY_DIR}/lib/cmake/Ceres)
    find_package(Ceres NO_MODULE)
    if(NOT Ceres_FOUND)
      message(FATAL_ERROR "NOT found Ceres")
    else()
      message(STATUS "Found Ceres")
    endif()
  endif()
endif()
