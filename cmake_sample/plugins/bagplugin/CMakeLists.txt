cmake_minimum_required(VERSION 3.0.0) 

# project 中指定版本
cmake_policy(SET CMP0048 NEW) 
project(xplugin VERSION 0.0.1.20180319)

set(VERSION_PROJECT Alpha)
set(VERSION "${PROJECT_VERSION}_${VERSION_PROJECT}")

message(STATUS "bagplugin VERSION: ${VERSION}")

SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO}/plugins)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG}/plugins)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE}/plugins)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL}/plugins)

IF(MSVC)
    SET(_warnings "")

    message(STATUS "bagplugin VERSION: msvc")

    # disable warnings
    SET(_warnings "${_warnings} /wd4100 ")  # unused formal parameters
    SET(_warnings "${_warnings} /wd4127 ")  # constant conditional expressions (used in Qt template classes)
    SET(_warnings "${_warnings} /wd4190 ")  # 'identifier' has C-linkage specified, but returns UDT 'identifier2' which is incompatible with C
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${_warnings}")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${_warnings}")
ELSE(MSVC)

ENDIF(MSVC)

#生成版本头文件
message(STATUS "generating ${PROJECT_SOURCE_DIR}/version.h")
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in
  ${PROJECT_SOURCE_DIR}/version.h @ONLY)

find_package(Qt4)

#预处理器定义
add_definitions(-DXPLUGIN_EXPORT) 

########################################################
# Files

FILE(GLOB_RECURSE HEADER_LIST ./*.h)
#定义要导出的文件列表

#当前目录下的所有的cpp文件都参与本程序的编译
AUX_SOURCE_DIRECTORY(. SRC_LIST)

########################################################
# Build 

#设置不同编译器的编译选项
IF(CMAKE_CXX_COMPLIER_ID MATCHES "GNU")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC")
    SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
ENDIF()

add_library (bagplugin SHARED ${HEADER_LIST} ${SRC_LIST})

message(STATUS "bagplugin VERSION: ${CMAKE_SOURCE_DIR}")

TARGET_INCLUDE_DIRECTORIES(bagplugin
    PRIVATE ${CMAKE_SOURCE_DIR}/3part/include
		PRIVATE $<BUILD_INTERFACE:${QT_INCLUDE_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
)

target_link_libraries(bagplugin
	xdata	
	xplugin
	${QT_QTCORE_LIBRARY}
)
########################################################
# Install 
#headers
#install(FILES
#	${INCLUDE_LIST}
# 	DESTINATION 
#	include/xplugin)

#TARGETS 
install(TARGETS bagplugin
    EXPORT xplugin 
    RUNTIME DESTINATION bin/plugins
    LIBRARY DESTINATION bin/plugins 
    ARCHIVE DESTINATION lib
)
