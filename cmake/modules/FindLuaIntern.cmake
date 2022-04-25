if(NOT CMAKE_TOOLCHAIN_FILE)
  find_package(LuaGoogle REQUIRED)
else()
  if(NOT EXISTS ${CMAKE_BINARY_DIR}/include/lua.hpp OR NOT EXISTS ${CMAKE_BINARY_DIR}/lib/liblua.a)
    execute_process(
      COMMAND bash ${PROJECT_SOURCE_DIR}/third_party/lua/build.bash ${CMAKE_BINARY_DIR}/lua_build ${CMAKE_TOOLCHAIN_FILE} ${CMAKE_BINARY_DIR}
      WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}/third_party/lua
      )
    message(STATUS "Build Lua")
  else()
    message(STATUS "Found Lua")
  endif()
  set(LUA_INCLUDE_DIR ${CMAKE_BINARY_DIR}/include)
  set(LUA_LIBRARIES ${CMAKE_BINARY_DIR}/lib/liblua.a)
endif()
