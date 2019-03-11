cmake_minimum_required(VERSION 3.0.0) 

project(xlog VERSION 0.0.1.20180116)

#生产版本头文件
#message(STATUS "${PROJECT_SOURCE_DIR}/version.h.in >>> ${PROJECT_SOURCE_DIR}/version.h")
#CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in
  #${PROJECT_SOURCE_DIR}/version.h @ONLY)

#pre difine
add_definitions(-DXLOG_EXPORTS) 

find_package(rapidxml REQUIRED)

########################################################
# Files
file(GLOB_RECURSE HEADER_LIST . *.h)

set(EXPORT_HEADERS config.h
    easylogging++.h
    export.h
) 

aux_source_directory(. SRC_LIST)

########################################################
# Build 
add_library (xlog SHARED ${SRC_LIST} ${HEADER_LIST})

message(STATUS ${rapidxml_INCLUDE_DIRS})
target_include_directories(xlog
        PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
        PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
        PUBLIC $<BUILD_INTERFACE:${rapidxml_INCLUDE_DIRS}>
        )

########################################################
# Install

#headers
install(FILES
	${EXPORT_HEADERS}
 	DESTINATION 
	include/xlog)

#TARGETS 
install(TARGETS xlog
    EXPORT xlog
    RUNTIME DESTINATION bin 
    LIBRARY DESTINATION bin 
    ARCHIVE DESTINATION lib
)

install(EXPORT xlog DESTINATION cmake)
