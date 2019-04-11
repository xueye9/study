# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindCURL
# --------
#
# Find curl
#
# Find the native CURL headers and libraries.
#
# ::
#
#   CURL_INCLUDE_DIRS   - where to find curl/curl.h, etc.
#   CURL_LIBRARIES      - List of libraries when using curl.
#   CURL_FOUND          - True if curl found.
#   CURL_VERSION_STRING - the version of curl found (since CMake 2.8.8)

# Look for the header file.
#find_path(CURL_INCLUDE_DIR NAMES curl/curl.h ..)
if(CURL_INCLUDE_DIRS AND CURL_LIBRARIES)
    set(CURL_FOUND true)
else(CURL_INCLUDE_DIRS AND CURL_LIBRARIES)
    set(CURL_PREFIX "" CACHE PATH "Installation prefix for curl Test")
    if(CURL_PREFIX)
        find_path(_CURL_INCLUDE_DIR curl.h
            PATHS "${CURL_PREFIX}/include"
            PATH_SUFFIXES "curl"
            NO_DEFAULT_PATH)
        message(status ${_CURL_INCLUDE_DIR})
        find_library(_CURL_LIBRARY libcurl curl
            PATHS "${CURL_PREFIX}/lib"
            PATH_SUFFIXES "curl"
            NO_DEFAULT_PATH)
    else(CURL_PREFIX)
        find_path(_CURL_INCLUDE_DIR curl.h
            PATH_SUFFIXES "curl")
        find_library(_CURL_LIBRARY curl)
    endif(CURL_PREFIX)
    if(_CURL_INCLUDE_DIR AND _CURL_LIBRARY)
        set(CURL_FOUND true)
        set(CURL_INCLUDE_DIRS ${_CURL_INCLUDE_DIR} CACHE PATH
            "Include directories for CURL")
        set(CURL_LIBRARIES ${_CURL_LIBRARY} CACHE FILEPATH
            "Libraries to link for CURL")
        mark_as_advanced(CURL_INCLUDE_DIRS CURL_LIBRARIES) 
        if(NOT CURL_FIND_QUIETLY)
            message(STATUS "Found CURL Test: ${CURL_LIBRARIES}")
        endif(NOT CURL_FIND_QUIETLY)
    else(_CURL_INCLUDE_DIR AND _CURL_LIBRARY)
        if(CURL_FIND_REQUIRED)
            message(FATAL_ERROR "Could not find the CURL")
        endif(CURL_FIND_REQUIRED)
    endif(_CURL_INCLUDE_DIR AND _CURL_LIBRARY)
endif(CURL_INCLUDE_DIRS AND CURL_LIBRARIES)

