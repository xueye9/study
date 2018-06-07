IF (CMAKE_CXX_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  SET(CMAKE_CXX_FLAGS_OLD "${CMAKE_CXX_FLAGS}")
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden")
ENDIF()

# override default path where built files are put to allow running qgis without installing
ADD_SUBDIRECTORY(txtplugin)
ADD_SUBDIRECTORY(imageplugin)
ADD_SUBDIRECTORY(bagplugin)
ADD_SUBDIRECTORY(pcapplugin)