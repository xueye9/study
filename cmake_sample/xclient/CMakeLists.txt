if (POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif (POLICY CMP0048)

project(xclient VERSION 3.1.0.20190306)

#预处理器定义
add_definitions(-DELPP_QT_LOGGING) 

set(XCLIENT_VERSION "${PROJECT_VERSION}.${BUILD_PROJECT}")

message(STATUS "xclient VERSION: ${XCLIENT_VERSION}")

#版本
MESSAGE(STATUS "${PROJECT_SOURCE_DIR}/version.h")
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in 
    ${PROJECT_SOURCE_DIR}/version.h @ONLY)

#FIND_PACKAGE(Qt4)
FIND_PACKAGE(Qt5Core QUIET)
FIND_PACKAGE(Qt5Gui REQUIRED)
FIND_PACKAGE(Qt5Widgets CONFIG REQUIRED)
FIND_PACKAGE(Qt5Quick)
FIND_PACKAGE(Qt5QuickWidgets)
FIND_PACKAGE(Qt5Qml)

MESSAGE(STATUS "xclient == ${CMAKE_MODULE_PATH}")
FIND_PACKAGE(rabbitmq)
##include(D:/rabbitmq-c/lib64/cmake/rabbitmq-config.cmake)
########################################################
# Files
#headers
FILE(GLOB HEADERS_LIST "./*.h")

#srcs 
AUX_SOURCE_DIRECTORY(./ SRC_LIST)

#qml
FILE(GLOB_RECURSE QMLS_LIST "*.qml")

#ui
FILE(GLOB_RECURSE xclient_UIS  "./*.ui")

#moc
SET (xclient_MOC_HDRS
    mainwindow.h
    #fileeditdialog.h
    #dataseteditdialog.h
    downloaddialog.h
    downloadthread.h
    controldownloadthread.h
    uploadthread.h
    controluploadthread.h
    uploaddialog.h
#    workspacedock.h
    workspace.h
    timecounter.h
	createDBdialog.h
	deleteDBdialog.h
    SetServerUrlDialog.h
    login.h
	options.h
	options_widget.h
	options_general.h
	options_user.h
	options_automation.h
	confirm.h
	wkspane.h
	XSingleCargoView.h
	file.h
	dataset.h
	#xfiledialog.h
	XCargoTextDockWidget.h
)

SET (xclient_RCCS
	xclient.qrc
)

########################################################
# Build

QT5_WRAP_UI (xclient_UIS_H  ${xclient_UIS}) 

QT5_WRAP_CPP (xclient_MOC_SRCS  ${xclient_MOC_HDRS})

QT5_ADD_RESOURCES(xclient_RCC_SRCS ${xclient_RCCS})

IF (WIN32)
  IF (MSVC)
    SET (SRC_LIST ${SRC_LIST} ${CMAKE_CURRENT_SOURCE_DIR}/xclient.rc)
  ENDIF(MSVC)
ENDIF (WIN32)

IF(CMAKE_CXX_COMPLIER_ID MATCHES "GNU")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC") 
    SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
ENDIF()

ADD_EXECUTABLE (xclient ${HEADERS_LIST} ${SRC_LIST} ${QMLS_LIST} ${xclient_MOC_SRCS} ${xclient_RCC_SRCS} ${xclient_UIS_H})

#设置CXX标准
########################################################
# Install
#headers
#install(FILES
#    ${HEADERS_LIST}
# 	DESTINATION 
#	include/xdata)

ADD_DEPENDENCIES(xclient xdata xlog)

target_include_directories(xclient
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CURL_INCLUDE_DIRS}>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/third_party/include>
    PRIVATE $<BUILD_INTERFACE:${SQLITE3_INCLUDE_DIRS}>
    PRIVATE $<BUILD_INTERFACE:${rabbitmq_INCLUDE_DIRS}>
)

target_link_libraries(xclient
	${Qt5Core_LIBRARIES}
    ${Qt5Gui_LIBRARIES}
	${Qt5Widgets_LIBRARIES}
    ${Qt5Quick_LIBRARIES}
	${Qt5QuickWidgets_LIBRARIES}
	${Qt5Qml_LIBRARIES}
    ${SQLITE3_LIBRARIES}
    ${rabbitmq_LIBRARIES}
    xdata
    xplugin 
    xlog
)


########################################################
# Install

INSTALL(TARGETS xclient
	RUNTIME DESTINATION bin
)


