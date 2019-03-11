project(app)

set(VERSION_MAJOR 0)
set(VERSION_MINOR 0)
set(VERSION_PATCH 1)
set(VERSION_DATE 20170115)
set(VERSION_PROJECT Alpha)
set(VERSION "${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}.${VERSION_DATE}_${VERSION_PROJECT}")

math(EXPR VERSION_INT "${VERSION_MAJOR}*10000+${VERSION_MINOR}*100+${VERSION_PATCH}")
message(STATUS "version:" ${VERSION_PROJECT}(${VERSION_INT}))

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fPIC")
    set(CMAKE_EXE_LINKER_FLAGS "-Wl,-rpath,.")
endif()

#版本
#MESSAGE(STATUS "${PROJECT_SOURCE_DIR}/version.h")
#CONFIGURE_FILE(${PROJECT_SOURCE_DIR}/version.h.in 
    #${PROJECT_SOURCE_DIR}/version.h @ONLY)

########################################################
# Files
file(GLOB_RECURSE HEADER_LIST . *.h)

aux_source_directory(. SRC_LIST)

ADD_EXECUTABLE (app ${HEADER_LIST}  ${SRC_LIST})

target_include_directories(app
        PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
        PUBLIC $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/..>
        )

TARGET_LINK_LIBRARIES(app
   xlog 
)

INSTALL(TARGETS app
	RUNTIME DESTINATION bin
)


