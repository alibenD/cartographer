#---Automatically Generated from template 'option.cmake' wrote by @aliben---
#
# @Copyright (C) 2022 All rights reserved.
# @filename: colors.cmake
# @author: aliben.develop@gmail.com
# @create_date: 2022-04-24 23:32:44
# @last_modified_date: NO_LAST_MODIFIED_DATE
# @description: TODO
#---****************************************************************---

macro(define_colors)
  string(ASCII 27 Esc)
  set(ColourReset "${Esc}[m")
  set(ColourBold  "${Esc}[1m")
  set(Red         "${Esc}[31m")
  set(Green       "${Esc}[32m")
  set(Yellow      "${Esc}[33m")
  set(Blue        "${Esc}[34m")
  set(Magenta     "${Esc}[35m")
  set(Cyan        "${Esc}[36m")
  set(White       "${Esc}[37m")
  set(BoldRed     "${Esc}[1;31m")
  set(BoldGreen   "${Esc}[1;32m")
  set(BoldYellow  "${Esc}[1;33m")
  set(BoldBlue    "${Esc}[1;34m")
  set(BoldMagenta "${Esc}[1;35m")
  set(BoldCyan    "${Esc}[1;36m")
  set(BoldWhite   "${Esc}[1;37m")
endmacro()

macro(build_info content)
  MESSAGE(STATUS ${content})
endmacro()

macro(build_warning content)
  MESSAGE(STATUS ${Yellow}${content}${ColourReset})
endmacro()

macro(build_error content)
  MESSAGE(FATAL_ERROR ${BoldRed}${content}${ColourReset})
endmacro()

