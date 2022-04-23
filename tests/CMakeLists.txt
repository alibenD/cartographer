#---Automatically Generated from template 'CMakeList.txt' wrote by @aliben---
#
# @Copyright (C) 2022 All rights reserved.
# @filename: CMakeLists.txt
# @author: aliben.develop@gmail.com
# @create_date: 2022-04-23 19:18:58
# @last_modified_date: 2022-04-23 19:21:23
# @description: TODO
#---****************************************************************---

file(GLOB_RECURSE TEST_LIBRARY_HDRS "include/cartographer/fake_*.h" "tests/include/cartographer/*test_helpers*.h" "tests/include/cartographer/mock_*.h")
file(GLOB_RECURSE TEST_LIBRARY_SRCS "cartographer/fake_*.cc" "cartographer/*test_helpers*.cc" "cartographer/mock_*.cc")
file(GLOB_RECURSE ALL_TESTS "cartographer/*_test.cc")
# Remove dotfiles/-folders that could potentially pollute the build.
set(INSTALL_SOURCE_HDRS ${ALL_LIBRARY_HDRS} ${TEST_LIBRARY_HDRS})

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
