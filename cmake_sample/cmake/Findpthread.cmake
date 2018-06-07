SET(pthread_ROOT E:/workspace/3part/pthread/2.9.1-release)

MESSAGE(STATUS ${pthread_ROOT})

IF(WIN32)
  IF (MSVC)
		FIND_PATH(pthread_INCLUDE_DIR NAMES pthread.h PATHS 
			${pthread_ROOT} ${pthread_ROOT}/include)
    FIND_LIBRARY(pthread_LIBRARY NAMES pthreadVC2 PATHS
			${pthread_ROOT} ${pthread_ROOT}/x64/vc10
      )
		MESSAGE(STATUS ${pthread_INCLUDE_DIR})
  ENDIF (MSVC)
ELSE(WIN32)

ENDIF(WIN32)

mark_as_advanced(pthread_INCLUDE_DIR)

MESSAGE(STATUS pthread_lib=${pthread_LIBRARY})
mark_as_advanced(pthread_LIBRARY)

IF (pthread_INCLUDE_DIR AND pthread_LIBRARY)
	SET(pthread_FOUND TRUE)
ENDIF (pthread_INCLUDE_DIR AND pthread_LIBRARY)

IF(pthread_FOUND)
  SET(pthread_LIBRARIES ${pthread_LIBRARY})
  SET(pthread_INCLUDE_DIRS ${pthread_INCLUDE_DIR})
ENDIF()
