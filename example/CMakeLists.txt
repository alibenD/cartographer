#---Automatically Generated from template 'CMakeList.txt' wrote by @aliben---
#
# @Copyright (C) 2022 All rights reserved.
# @filename: CMakeLists.txt
# @author: aliben.develop@gmail.com
# @create_date: 2022-04-23 18:42:28
# @last_modified_date: 2022-04-24 22:50:00
# @description: TODO
#---****************************************************************---

if(NOT CMAKE_TOOLCHAIN_FILE)
google_binary(cartographer_autogenerate_ground_truth
  SRCS
    autogenerate_ground_truth_main.cc
)

google_binary(cartographer_compute_relations_metrics
  SRCS
    compute_relations_metrics_main.cc
)

google_binary(cartographer_pbstream
  SRCS
    pbstream_main.cc
)

google_binary(cartographer_print_configuration
  SRCS
    print_configuration_main.cc
)
endif()
