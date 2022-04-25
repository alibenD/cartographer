#!/bin/bash

#---Automatically Generated from template 'bash' wrote by @aliben---
# @Copyright (C) 2022 All rights reserved.
# @file: build.bash
# @author: aliben.develop@gmail.com
# @created_date: 2022-04-25 21:38:33
# @last_modified_date: 2022-04-25 22:54:26
# @brief: TODO
# @details: TODO
#---***********************************************---

CMAKE_BUILD_DIR=$1
CMAKE_TOOLCHAIN_FILE=$2
CMAKE_INSTALL_PREFIX=$3
#---Variables
cmake -B${CMAKE_BUILD_DIR} -GNinja -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} -DANDROID_ABI=armeabi-v7a -DANDROID_STL=c++_static -DANDROID_PLATFORM=21 -DBUILD_SHARED_LIBS=OFF -H./
cmake --build ${CMAKE_BUILD_DIR} --target install
