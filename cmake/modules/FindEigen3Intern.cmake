if(NOT CMAKE_TOOLCHAIN_FILE)
  find_package(Eigen3 REQUIRED)
else()
  set(Eigen3_DIR ${CMAKE_BINARY_DIR}/share/eigen3/cmake)
  find_package(Eigen3 NO_MODULE)

  if(NOT Eigen3_FOUND)
    execute_process(
      COMMAND bash ${PROJECT_SOURCE_DIR}/third_party/eigen-3.3.7/build.bash ${CMAKE_BINARY_DIR}/eigen_build ${CMAKE_TOOLCHAIN_FILE} ${CMAKE_BINARY_DIR}
      WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/third_party/eigen-3.3.7
      )

    set(Eigen3_DIR ${CMAKE_BINARY_DIR}/share/eigen3/cmake)
    find_package(Eigen3 NO_MODULE)
    if(NOT Eigen3_FOUND)
      message(FATAL_ERROR "NOT found Eigen3")
    else()
      message(STATUS "Found Eigen3")
    endif()
  endif()
endif()
