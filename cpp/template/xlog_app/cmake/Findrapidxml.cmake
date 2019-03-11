# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# Findrapidxml
# --------
#
# Find rapidxml
#
# Find the native rapidxml headers and libraries.
#
# ::
#
#   rapidxml_INCLUDE_DIRS   - where to find rapidxml/rapidxml.h, etc.
#   rapidxml_LIBRARIES      - List of libraries when using rapidxml.
#   rapidxml_FOUND          - True if rapidxml found.
#   rapidxml_VERSION_STRING - the version of rapidxml found (since CMake 2.8.8)

# Look for the header file.
#find_path(rapidxml_INCLUDE_DIR NAMES rapidxml/rapidxml.h ..)
if(rapidxml_INCLUDE_DIRS)
    set(rapidxml_FOUND true)
else(rapidxml_INCLUDE_DIRS)
    set(rapidxml_PREFIX "" CACHE PATH "Installation prefix for rapidxml Test")
    if(rapidxml_PREFIX)
        find_path(_rapidxml_INCLUDE_DIR rapidxml.hpp
            PATHS "${rapidxml_PREFIX}/include"
            PATH_SUFFIXES "rapidxml"
            NO_DEFAULT_PATH)
        message(status ${_rapidxml_INCLUDE_DIR})
    else(rapidxml_PREFIX)
        find_path(_rapidxml_INCLUDE_DIR rapidxml.hpp
            PATH_SUFFIXES "rapidxml")
    endif(rapidxml_PREFIX)
    if(_rapidxml_INCLUDE_DIR)
        set(rapidxml_FOUND true)
        set(rapidxml_INCLUDE_DIRS ${_rapidxml_INCLUDE_DIR} CACHE PATH "Include directories for rapidxml")
        mark_as_advanced(rapidxml_INCLUDE_DIRS) 
    else(_rapidxml_INCLUDE_DIR)
        if(rapidxml_FIND_REQUIRED)
            message(FATAL_ERROR "Could not find the rapidxml")
        endif(rapidxml_FIND_REQUIRED)
    endif(_rapidxml_INCLUDE_DIR)
endif(rapidxml_INCLUDE_DIRS)


