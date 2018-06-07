# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindXDATA
# --------
#
# Find XDATA
#
# Find the native XDATA headers and libraries.
#
# ::
#
#   XDATA_INCLUDE_DIRS   - where to find XDATA/XDATA.h, etc.
#   XDATA_LIBRARIES      - List of libraries when using XDATA.
#   XDATA_FOUND          - True if XDATA found.
#   XDATA_VERSION_STRING - the version of XDATA found (since CMake 2.8.8)

# Look for the header file.
if(XDATA_INCLUDE_DIRS AND XDATA_LIBRARIES)
    set(XDATA_FOUND true)
else(XDATA_INCLUDE_DIRS AND XDATA_LIBRARIES)
    set(XDATA_PREFIX "" CACHE PATH "Installation prefix for Google Test")
    if(XDATA_PREFIX)
        find_path(_XDATA_INCLUDE_DIR xdata.h
            PATHS "${XDATA_PREFIX}/include"
            PATH_SUFFIXES "xdata"
            NO_DEFAULT_PATH)
        find_library(_XDATA_LIBRARY xdata
            PATHS "${XDATA_PREFIX}/lib"
            NO_DEFAULT_PATH)
    else(XDATA_PREFIX)
        find_path(_XDATA_INCLUDE_DIR xdata.h
            PATH_SUFFIXES "xdata")
        find_library(_XDATA_LIBRARY xdata)
    endif(XDATA_PREFIX)
    if(_XDATA_INCLUDE_DIR AND _XDATA_LIBRARY)
        set(XDATA_FOUND true)
        set(XDATA_INCLUDE_DIRS ${_XDATA_INCLUDE_DIR} CACHE PATH
            "Include directories for XDATA")
        set(XDATA_LIBRARIES ${_XDATA_LIBRARY} CACHE FILEPATH
            "Libraries to link for XDATA")
        mark_as_advanced(XDATA_INCLUDE_DIRS XDATA_LIBRARIES) 
        if(NOT XDATA_FIND_QUIETLY)
            message(STATUS "Found XDATA : ${XDATA_LIBRARIES}")
        endif(NOT XDATA_FIND_QUIETLY)
    else(_XDATA_INCLUDE_DIR AND _XDATA_LIBRARY)
        if(XDATA_FIND_REQUIRED)
            message(FATAL_ERROR "Could not find the XDATA")
        endif(XDATA_FIND_REQUIRED)
    endif(_XDATA_INCLUDE_DIR AND _XDATA_LIBRARY)
endif(XDATA_INCLUDE_DIRS AND XDATA_LIBRARIES)

