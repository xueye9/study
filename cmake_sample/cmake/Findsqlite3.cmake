# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# Findsqlite3
# --------
#
# Find SQLITE3
#
# Find the native SQLITE3 headers and libraries.
#
# ::
#
#   QSLITE3_INCLUDE_DIRS   - where to find SQLITE3/SQLITE3.h, etc.
#   SQLITE3_LIBRARIES      - List of libraries when using SQLITE3.
#   SQLITE3_FOUND          - True if SQLITE3 found.
#   SQLITE3_VERSION_STRING - the version of SQLITE3 found (since CMake 2.8.8)

if(SQLITE3_INCLUDE_DIRS AND SQLITE3_LIBRARIES)
    set(SQLITE3_FOUND true)
else(SQLITE3_INCLUDE_DIRS AND SQLITE3_LIBRARIES)
    set(SQLITE3_PREFIX "" CACHE PATH "Installation prefix for Google Test")
    if(SQLITE3_PREFIX)
        find_path(_SQLITE3_INCLUDE_DIR sqlite3.h
            PATHS "${SQLITE3_PREFIX}"
            PATH_SUFFIXES "sqlite" "sqlite3"
            NO_DEFAULT_PATH)
        find_library(_SQLITE3_LIBRARY sqlite3_i sqlite3
            PATHS "${SQLITE3_PREFIX}"
            PATH_SUFFIXES "lib"
            NO_DEFAULT_PATH)
    else(SQLITE3_PREFIX)
        find_path(_SQLITE3_INCLUDE_DIR sqlite3.h
            PATH_SUFFIXES "include")
        find_library(_SQLITE3_LIBRARY sqlite_i sqlite3)
    endif(SQLITE3_PREFIX)
    if(_SQLITE3_INCLUDE_DIR AND _SQLITE3_LIBRARY)
        set(SQLITE3_FOUND true)
        set(SQLITE3_INCLUDE_DIRS ${_SQLITE3_INCLUDE_DIR} CACHE PATH
            "Include directories for SQLITE3")
        set(SQLITE3_LIBRARIES ${_SQLITE3_LIBRARY} CACHE FILEPATH
            "Libraries to link for SQLITE3")
        mark_as_advanced(SQLITE3_INCLUDE_DIRS SQLITE3_LIBRARIES) 
        if(NOT SQLITE3_FIND_QUIETLY)
            message(STATUS "Found SQLITE3 Test: ${SQLITE3_LIBRARIES}")
        endif(NOT SQLITE3_FIND_QUIETLY)
    else(_SQLITE3_INCLUDE_DIR AND _SQLITE3_LIBRARY)
        if(SQLITE3_FIND_REQUIRED)
            message(FATAL_ERROR "Could not find the SQLITE3")
        endif(SQLITE3_FIND_REQUIRED)
    endif(_SQLITE3_INCLUDE_DIR AND _SQLITE3_LIBRARY)
endif(SQLITE3_INCLUDE_DIRS AND SQLITE3_LIBRARIES)

