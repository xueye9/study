cmake_minimum_required(VERSION 3.0.0) 

# project 中指定版本
cmake_policy(SET CMP0048 NEW) 
project(xplugin VERSION 0.0.1.20180319)

set(VERSION_PROJECT Alpha)
set(VERSION "${PROJECT_VERSION}_${VERSION_PROJECT}")

message(STATUS "xplugin VERSION: ${VERSION}")

#生成版本头文件
message(STATUS "generating ${PROJECT_SOURCE_DIR}/version.h")
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in
  ${PROJECT_SOURCE_DIR}/version.h @ONLY)

find_package(Qt4)

#预处理器定义
add_definitions(-DXPLUGIN_EXPORT) 

########################################################
# Files

#定义要导出的文件列表
SET(INCLUDE_LIST version.h
	export.h
	export.inl
	xplugin.h
	xpluginmetadata.h
	xpluginregistry.h
    pluginexport.h
	)

#当前目录下的所有的cpp文件都参与本程序的编译
AUX_SOURCE_DIRECTORY(. SRC_LIST)

########################################################
# Build 

#设置不同编译器的编译选项
IF(CMAKE_CXX_COMPLIER_ID MATCHES "GNU")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC")
    SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
ENDIF()

add_library (xplugin SHARED ${INCLUDE_LIST} ${SRC_LIST})

TARGET_INCLUDE_DIRECTORIES(xplugin
    PRIVATE ${CMAKE_SOURCE_DIR}/3part/include
		PRIVATE $<BUILD_INTERFACE:${QT_INCLUDE_DIR}>
    PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
    PUBLIC $<INSTALL_INTERFACE:include>
    PUBLIC $<INSTALL_INTERFACE:include/xdata>
)

target_link_libraries(xplugin
	xdata	
	${QT_QTCORE_LIBRARY}
)
########################################################
# Install 
#headers
install(FILES
	${INCLUDE_LIST}
 	DESTINATION 
	include/xplugin)

#TARGETS 
install(TARGETS xplugin
    EXPORT xplugin 
    RUNTIME DESTINATION bin 
    LIBRARY DESTINATION bin 
    ARCHIVE DESTINATION lib
)

INSTALL(EXPORT
	xplugin DESTINATION share
)
