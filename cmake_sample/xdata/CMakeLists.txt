 if (POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif (POLICY CMP0048)

project(xdata VERSION 2.0.1.20181129)

# prefix for package variables in CMake configuration file
string (TOLOWER "${PROJECT_NAME}" PACKAGE_NAME)

string (TOUPPER "${PROJECT_NAME}" PACKAGE_PREFIX)

#生成版本头文件
message(STATUS "generating ${PROJECT_SOURCE_DIR}/version.h")
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in
  ${PROJECT_SOURCE_DIR}/version.h @ONLY)

#生成平台相关头文：件
message(STATUS "generating ${PROJECT_SOURCE_DIR}/platform.h")
configure_file(${PROJECT_SOURCE_DIR}/platform.h.in
  ${PROJECT_SOURCE_DIR}/platform.h @ONLY)

#预处理器定义
add_definitions(-DXDATA_EXPORT) 

# 依赖库 curl
FIND_PACKAGE(CURL REQUIRED)
IF(curl_FOUND)
    MESSAGE(STATUS ${CURL_LIBRARY})
    MESSAGE(STATUS ${CURL_INCLUDE_DIRS})
ENDIF()

########################################################
# Files

#定义要导出的文件列表
#SET(PUBLIC_HDRS version.h
#	platform.h
#	export.h
#	export.inl
#    BaseDoc.h
#    SpatialDoc.h
#	FileDoc.h
#	DataSetDoc.h
#	position.h
#    jsongeneralizer.h
#	storeclient.h
#	transferprogress.h
#	status.h
#    schame.h
#	serviceconfig.h)
#
FILE(GLOB_RECURSE HEADER_LIST ./*.h)

#当前目录下的所有的cpp文件都参与本程序的编译
AUX_SOURCE_DIRECTORY(. SRC_LIST)

#set(HEADER_LIST 
#    utility.h
#    position.h 
#    easylogging++.h
#    BaseDoc.h
#	transferprogress.h
#	transferprogressimpl.h
#    SpatialDoc.h
#    SpatialDocImpl.h 
#    library_config.h
#    library_configimpl.h
#    callbackfuncdef.h
#    FileDoc.h
#    FileDocImpl.h
#    DataSetDoc.h
#    DataSetDocImpl.h
#    schame.h
#    jsongeneralizer.h
#    indexclient.h
#    hdfsclient.h
#    storeclient.h 
#    factory.h
#)

#SET(SRC_LIST 
#    xdata_wrap.cxx 
#    utility.cpp
#    position.cpp 
#    platform.cpp 
#    easylogging++.cc 
#    log_manager.cpp
#    BaseDoc.cpp
#	transferprogress.cpp
#	transferprogressimpl.cpp
#    SpatialDoc.cpp
#    SpatialDocImpl.cpp
#    library_config.cpp
#    library_configimpl.cpp
#    callbackfuncdef.cpp
#    FileDoc.cpp
#    FileDocImpl.cpp
#    DataSetDoc.cpp
#    DataSetDocImpl.cpp
#    schame.cpp
#    jsongeneralizer.cpp
#    indexclient.cpp
#    hdfsclient.cpp
#    storeclient.cpp
#    factory.cpp
#    )


########################################################
# Build 

#设置不同编译器的编译选项
IF(CMAKE_CXX_COMPLIER_ID MATCHES "GNU")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC")
    SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
ENDIF()

add_library (${PROJECT_NAME} SHARED ${HEADER_LIST} ${SRC_LIST})

TARGET_INCLUDE_DIRECTORIES(xdata
    PRIVATE ${CURL_INCLUDE_DIRS}
    PRIVATE ${CMAKE_SOURCE_DIR}/third_party/include
    PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
    PUBLIC $<INSTALL_INTERFACE:include>
    PUBLIC $<INSTALL_INTERFACE:include/xdata>
    PUBLIC $<INSTALL_INTERFACE:include/xlog>
    #PUBLIC $<BUILD_INTERFACE:/usr/include/python2.7>
    PUBLIC $<BUILD_INTERFACE:C:/OSGeo4W64/apps/Python37/include>
    #PUBLIC $<BUILD_INTERFACE:C:/OSGeo4W64/apps/Python27/include>
)

target_link_libraries(xdata
	${CURL_LIBRARIES} 
    xlog
    #python2.7
    C:/OSGeo4W64/apps/Python37/libs/python37.lib
    #C:/OSGeo4W64/apps/Python27/libs/python27.lib
)

MESSAGE(STATUS "SYSTEM:${CMAKE_HOST_SYSTEM_NAME}")
IF(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux") 
    target_link_libraries(xdata
        uuid	
        )
ENDIF(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    
########################################################
# Install 
#headers 
set(CONFIG_INSTALL_DIR targets-exported)
set(XDATA_INCLUDE_DIR include/xdata)

install(FILES ${PUBLIC_HDRS} 
		DESTINATION ${XDATA_INCLUDE_DIR})

set (EXPORT_NAME ${PACKAGE_NAME}-targets)
configure_file (${PROJECT_SOURCE_DIR}/../cmake/config.cmake.in  "${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-install.cmake" @ONLY)

#TARGETS 
install(TARGETS xdata
    EXPORT ${EXPORT_NAME}
    RUNTIME DESTINATION bin 
    LIBRARY DESTINATION bin 
    ARCHIVE DESTINATION lib
)

INSTALL(EXPORT ${EXPORT_NAME} DESTINATION ${CONFIG_INSTALL_DIR})

install (FILES "${PROJECT_BINARY_DIR}/${PROJECT_NAME}-config-install.cmake"
    RENAME ${PACKAGE_NAME}-config.cmake
    DESTINATION ${CONFIG_INSTALL_DIR} 
)
