CMAKE_MINIMUM_REQUIRED(VERSION 3.0.0)

CMAKE_POLICY(SET CMP0048 NEW)
project(xclient VERSION 2.0.1.20180606)

set(VERSION_PROJECT Alpha)
set(VERSION "${PROJECT_VERSION}_${VERSION_PROJECT}")

message(STATUS "xclient VERSION: ${VERSION}")

#版本
MESSAGE(STATUS "${PROJECT_SOURCE_DIR}/version.h")
CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in 
    ${PROJECT_SOURCE_DIR}/version.h @ONLY)

FIND_PACKAGE(Qt4)
FIND_PACKAGE(rabbitMQ)

########################################################
# Files
#headers
FILE(GLOB INCLUDE_LIST "./*.h")

#srcs 
AUX_SOURCE_DIRECTORY(./ SRC_LIST)

#ui
SET (xclient_UIS
	ui/mainbase.ui
    ui/fileeditdialogbase.ui
    ui/dataseteditdialogbase.ui
    ui/uploaddialogbase.ui
    ui/downloaddialogbase.ui
    ui/createDbDialogBase.ui
    ui/deleteDbDialogBase.ui
    ui/UserAuthorityDialogBase.ui
    ui/LoginDialogBase.ui
    ui/setServerUrlDialogBase.ui
)

#moc
SET (xclient_MOC_HDRS
    mainwindow.h
    fileeditdialog.h
    dataseteditdialog.h
    downloaddialog.h
    downloadthread.h
    controldownloadthread.h
    uploadthread.h
    controluploadthread.h
    uploaddialog.h
    workspacedock.h
    workspace.h
    timecounter.h
	createDBdialog.h
	deleteDBdialog.h
    UserAuthorityDialog.h
    LoginDialog.h
    SetServerUrlDialog.h
	MQHandler.h
)

SET (xclient_RCCS
	xclient.qrc)

########################################################
# Build

QT4_WRAP_UI (xclient_UIS_H  ${xclient_UIS})

QT4_WRAP_CPP (xclient_MOC_SRCS  ${xclient_MOC_HDRS})

IF (WIN32)
  IF (MSVC)
    SET (SRC_LIST ${SRC_LIST} ${CMAKE_CURRENT_SOURCE_DIR}/xclient.rc)
  ENDIF(MSVC)
ENDIF (WIN32)

QT4_ADD_RESOURCES(xclient_RCC_SRCS ${xclient_RCCS})

IF(CMAKE_CXX_COMPLIER_ID MATCHES "GNU")
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC") 
    SET(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
ENDIF()

ADD_EXECUTABLE (xclient ${INCLUDE_LIST} ${SRC_LIST}  ${xclient_MOC_SRCS} ${xclient_RCC_SRCS} ${xclient_UIS_H})

#设置CXX标准
########################################################
# Install
#headers
install(FILES
    ${INCLUDE_LIST}
 	DESTINATION 
	include/xdata)

ADD_DEPENDENCIES(xclient xdata)

target_include_directories(xclient
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CURL_INCLUDE_DIRS}>
    PRIVATE $<BUILD_INTERFACE:${QT_INCLUDE_DIR}>
    PRIVATE $<BUILD_INTERFACE:${QT_INCLUDE_DIR}/QtGui>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}>
    PRIVATE $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/3part/include>
    PRIVATE $<BUILD_INTERFACE:${SQLITE3_INCLUDE_DIRS}>
    PRIVATE $<BUILD_INTERFACE:${RABBITMQ_INCLUDE_DIRS}>
)

TARGET_LINK_LIBRARIES(xclient
	${QT_QTCORE_LIBRARY}
    ${QT_QTGUI_LIBRARY}
    ${SQLITE3_LIBRARIES}
    ${RABBITMQ_LIBRARIES}
    xdata
    xplugin
    #PUBLIC $<INSTALL_INTERFACE:${QT_QTCORE_LIBRARY}> 
)


########################################################
# Install

INSTALL(TARGETS xclient
	RUNTIME DESTINATION bin
)


