#---Automatically Generated from template 'CMakeList.txt' wrote by @aliben---
#
# @Copyright (C) 2022 All rights reserved.
# @filename: CMakeLists.txt
# @author: aliben.develop@gmail.com
# @create_date: 2022-04-24 23:32:44
# @last_modified_date: NO_LAST_MODIFIED_DATE
# @description: TODO
#---****************************************************************---

if(BUILD_TESTS)
  enable_testing()
  include(GoogleTest)
  find_package(GTest REQUIRED)

  file(GLOB_RECURSE EXAMPLES *.cc)
  foreach(EXAMPLE ${EXAMPLES})
    get_filename_component(MY_TARGET "${EXAMPLE}" NAME_WE)
    list(APPEND TEST_TARGETS ${MY_TARGET})
    add_executable(${MY_TARGET} ${EXAMPLE})
    add_dependencies(${MY_TARGET} ${PROJECT_NAME}_shared ${PROJECT_NAME}_static)
    target_include_directories(${MY_TARGET}
        PUBLIC
          ${CMAKE_INSTALL_PREFIX}/include
        PRIVATE
          GTest
          ${PROJECT_SOURCE_DIR}/include
          ${PROJECT_BINARY_DIR}/include
          ${CMAKE_INSTALL_PREFIX}/include
      )
    target_link_libraries(${MY_TARGET}
        PRIVATE
          ${THIRD_PARTY_LIBS}
          ${CMAKE_THREAD_LIBS_INIT}
          GTest::gtest
          GTest::gtest_main
          ${PROJECT_NAME}
      )
    gtest_discover_tests(${MY_TARGET})
  endforeach()

  #foreach(test_target IN LISTS TEST_TARGETS)
  #  add_test(
  #    NAME ${test_target}
  #    COMMAND $<TARGET_FILE:${test_target}>)
  #endforeach()

  # if expecting some tests failed.
  # call set_tests_properties(example PROPERTIES WILL_FAIL true)

  # timeout for a test set to 10 seconds
  # set_test_properties(example PROPERTIES TIMEOUT 10)
endif()
