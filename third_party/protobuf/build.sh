#!/bin/sh
#---Generated from template 'sh' wrote by @aliben---
# @Copyright (C) 2022 All rights reserved.
# @file: build.sh
# @author: aliben.develop@gmail.com
# @created_date: 2022-04-24 23:56:09
# @last_modified_date: 2022-04-24 23:56:13
# @brief: TODO
# @details: TODO
#---***********************************************---


#---Variables
CREATED_TIME=`date '+%Y-%m-%d %H:%M:%S'`
CREATED_YEAR=`date '+%Y'`

#---Shell Command
cmake -Bbuild -GNinja -DCMAKE_TOOLCHAIN_FILE=/home/aliben/.local/android-ndk-r23/build/cmake/android.toolchain.cmake -DCMAKE_INSTALL_PREFIX=/home/aliben/dev_ws/ros2/carto_ws/src/cartographer_package/cartographer/build -DANDROID_PLATFORM=21 -Dprotobuf_BUILD_SHARED_LIBS=OFF -DCMAKE_VERBOSE_MAKEFILE=ON -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_BUILD_EXAMPLES=OFF -Dprotobuf_MSVC_STATIC_RUNTIME=OFF -DANDROID_STL=c++_static -DANDROID_LINKER_FLAGS="-landroid -llog" -DANDROID_CPP_FEATURES="rtti exceptions" -Dprotobuf_BUILD_PROTOC_BINARIES=OFF cmake/
