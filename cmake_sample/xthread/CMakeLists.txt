cmake_minimum_required(VERSION 3.0.0)

# project 中指定版本
cmake_policy(SET CMP0048 NEW)
project(xthread VERSION 1.0.0.20180525)

set(VERSION_PROJECT Alpha)
set(VERSION "${PROJECT_VERSION}_${VERSION_PROJECT}")

message(STATUS "xthread VERSION: ${VERSION}")

#生成版本头文件
message(STATUS "generating ${PROJECT_SOURCE_DIR}/version.h")
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in
  ${PROJECT_SOURCE_DIR}/version.h @ONLY)

#生成平台相关头文：件
find_package(pthread REQUIRED)
  
#预处理器定义
add_definitions(-DXTHREAD_EXPORT) 

########################################################
# Files

#定义要导出的文件列表
SET(EXPORT_HEADERS XThread.h
    version.h
    XMutex.h
    XReadLocker.h
    XWriteLocker.h    
    XReadWriteLock.h
	)

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

add_library (xthread SHARED ${HEADER_LIST} ${SRC_LIST})

TARGET_INCLUDE_DIRECTORIES(xthread
    PRIVATE ${pthread_INCLUDE_DIR}
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
    PUBLIC $<INSTALL_INTERFACE:include>
    PUBLIC $<INSTALL_INTERFACE:include/xthread>
)

target_link_libraries(xthread
	${pthread_LIBRARIES} 
)
########################################################
# Install 
#headers
install(FILES
    ${EXPORT_HEADERS}
 	DESTINATION 
	include/xthread)

#TARGETS 
install(TARGETS xthread
    EXPORT xthread
    RUNTIME DESTINATION bin 
    LIBRARY DESTINATION bin 
    ARCHIVE DESTINATION lib
)

INSTALL(EXPORT
    xthread DESTINATION share
)
