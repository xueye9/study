cmake_minimum_required(VERSION 3.0.0)

# project 中指定版本
cmake_policy(SET CMP0048 NEW)
project(xdata VERSION 2.0.1.20180606)

set(VERSION_PROJECT Alpha)
set(VERSION "${PROJECT_VERSION}_${VERSION_PROJECT}")

message(STATUS "xdata VERSION: ${VERSION}")

#生成版本头文件
message(STATUS "generating ${PROJECT_SOURCE_DIR}/version.h")
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in
  ${PROJECT_SOURCE_DIR}/version.h @ONLY)

#生成平台相关头文：件
message(STATUS "generating ${PROJECT_SOURCE_DIR}/platform.h")
configure_file(${PROJECT_SOURCE_DIR}/platform.h.in
  ${PROJECT_SOURCE_DIR}/platform.h @ONLY)

find_package(rabbitMQ REQUIRED)
  
#预处理器定义
add_definitions(-DXDATA_EXPORT) 

########################################################
# Files

#定义要导出的文件列表
SET(EXPORT_HEADERS version.h
	platform.h
	export.h
	export.inl
    BaseDoc.h
    SpatialDoc.h
	FileDoc.h
	DataSetDoc.h
	position.h
    JsonGeneralizer.h
	StoreClient.h
	TransferProgress.h
	ServiceConfig.h)

FILE(GLOB_RECURSE HEADER_LIST ./*.h)

#当前目录下的所有的cpp文件都参与本程序的编译
AUX_SOURCE_DIRECTORY(. SRC_LIST)

########################################################
# Build 

#设置不同编译器的编译选项
IF(CMAKE_CXX_COMPLIER_ID MATCHES "GNU")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC")
    SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
ENDIF()

add_library (xdata SHARED ${HEADER_LIST} ${SRC_LIST})

TARGET_INCLUDE_DIRECTORIES(xdata
    PRIVATE ${CURL_INCLUDE_DIRS}
    PRIVATE ${CMAKE_SOURCE_DIR}/3part/include
    PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
    PUBLIC $<INSTALL_INTERFACE:include>
    PUBLIC $<INSTALL_INTERFACE:include/xdata>
)

target_link_libraries(xdata
	${CURL_LIBRARIES} 
)
########################################################
# Install 
#headers
install(FILES
    ${EXPORT_HEADERS}
 	DESTINATION 
	include/xdata)

#TARGETS 
install(TARGETS xdata
    EXPORT xdata
    RUNTIME DESTINATION bin 
    LIBRARY DESTINATION bin 
    ARCHIVE DESTINATION lib
)

INSTALL(EXPORT
    xdata DESTINATION share
)
