cmake_minimum_required(VERSION 3.9)
project(LiquidFun CXX)

file(GLOB_RECURSE SOURCES liquidfun/Box2D/Box2D/*.cpp)

add_library(LiquidFun ${SOURCES})
target_include_directories(LiquidFun PUBLIC $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/liquidfun/Box2D> $<INSTALL_INTERFACE:include>)

install(TARGETS LiquidFun 
    EXPORT unofficial-liquidfun-targets
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

install(
    EXPORT unofficial-liquidfun-targets
    FILE unofficial-liquidfun-config.cmake
    NAMESPACE unofficial::liquidfun::
    DESTINATION share/unofficial-liquidfun
)
