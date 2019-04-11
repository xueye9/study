cmake_minimum_required(VERSION 2.18.4)

if (POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif (POLICY CMP0048)


project(t_one VERSION 0.0.1.20190306)

#预处理器定义
add_definitions(-DELPP_QT_LOGGING) 
add_definitions(-DQT_NO_SESSIONMANAGER) 

set(t_one_VERSION "${PROJECT_VERSION}.${BUILD_PROJECT}")

message(STATUS "t_one VERSION: ${t_one_VERSION}")

#版本
#MESSAGE(STATUS "${PROJECT_SOURCE_DIR}/version.h")
#CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in 
#    ${PROJECT_SOURCE_DIR}/version.h @ONLY)

#FIND_PACKAGE(Qt4)
FIND_PACKAGE(Qt5Core QUIET)
FIND_PACKAGE(Qt5Gui REQUIRED)
FIND_PACKAGE(Qt5Widgets CONFIG REQUIRED)
#FIND_PACKAGE(Qt5Quick)
#FIND_PACKAGE(Qt5QuickWidgets)
#FIND_PACKAGE(Qt5Qml)

#MESSAGE(STATUS "t_one == ${CMAKE_MODULE_PATH}")
#FIND_PACKAGE(rabbitmq)
##include(D:/rabbitmq-c/lib64/cmake/rabbitmq-config.cmake)
########################################################
# Files
#headers
FILE(GLOB HEADERS_LIST "./*.h")

#srcs 
AUX_SOURCE_DIRECTORY(./ SRC_LIST)

#ui
FILE(GLOB_RECURSE t_one_UIS  "./*.ui")

#moc
SET (t_one_MOC_HDRS
    thread.h
    mainwindow.h
    widget.h
)

SET (t_one_RCCS
	t_one.qrc
)

########################################################
# Build

QT5_WRAP_UI (t_one_UIS_H  ${t_one_UIS}) 

QT5_WRAP_CPP (t_one_MOC_SRCS  ${t_one_MOC_HDRS})

QT5_ADD_RESOURCES(t_one_RCC_SRCS ${t_one_RCCS})

#IF (WIN32)
#  IF (MSVC)
#    SET (SRC_LIST ${SRC_LIST} ${CMAKE_CURRENT_SOURCE_DIR}/t_one.rc)
#  ENDIF(MSVC)
#ENDIF (WIN32)

IF(CMAKE_CXX_COMPLIER_ID MATCHES "GNU")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC") 
    SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
ENDIF()

#ADD_EXECUTABLE (t_one ${HEADERS_LIST} ${SRC_LIST} ${QMLS_LIST} ${t_one_MOC_SRCS} ${t_one_RCC_SRCS} ${t_one_UIS_H})
ADD_EXECUTABLE (t_one ${HEADERS_LIST} ${SRC_LIST} ${QMLS_LIST} ${t_one_MOC_SRCS} ${t_one_RCC_SRCS} ${t_one_UIS_H})

#设置CXX标准
########################################################
# Install
#headers
#install(FILES
#    ${HEADERS_LIST}
# 	DESTINATION 
#	include/xdata)

#ADD_DEPENDENCIES(t_one xdata xlog)

target_include_directories(t_one
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CURL_INCLUDE_DIRS}>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    #    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/third_party/include>
    #PRIVATE $<BUILD_INTERFACE:${SQLITE3_INCLUDE_DIRS}>
    #PRIVATE $<BUILD_INTERFACE:${rabbitmq_INCLUDE_DIRS}>
)

target_link_libraries(t_one
	${Qt5Core_LIBRARIES}
    ${Qt5Gui_LIBRARIES}
	${Qt5Widgets_LIBRARIES}
    #${Qt5Quick_LIBRARIES}
	#${Qt5QuickWidgets_LIBRARIES}
	#${Qt5Qml_LIBRARIES}
    #${SQLITE3_LIBRARIES}
    #${rabbitmq_LIBRARIES}
    #xdata
    #xplugin 
    #xlog
)


########################################################
# Install

INSTALL(TARGETS t_one
	RUNTIME DESTINATION bin
)


