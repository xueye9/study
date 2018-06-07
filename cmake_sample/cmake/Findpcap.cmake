# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#.rst:
# FindPCAP
# --------
#
# Find PCAP
#
# Find the native pcap headers and libraries.
#
# ::
#
#   pcap_INCLUDE_DIRS   - where to find pcap/pcap.h, etc.
#   pcap_LIBRARIES      - List of libraries when using pcap.
#   pcap_FOUND          - True if pcap found.
#   pcap_VERSION_STRING - the version of pcap found (since CMake 2.8.8)

# Look for the header file.
#find_path(pcap_INCLUDE_DIR NAMES pcap/pcap.h ..)

if(PCAP_INCLUDE_DIRS AND PCAP_LIBRARIES)
    set(PCAP_FOUND true)
else(PCAP_INCLUDE_DIRS AND PCAP_LIBRARIES)
    set(PCAP_PREFIX "" CACHE PATH "Installation prefix for pcap")
    set(PCAP_framework "x64" CACHE STRING
        "PCAP_framework chosen by the user at CMake configure time")
    set_property(CACHE PCAP_framework PROPERTY STRINGS x64 x86)

    set(LIB_DIRS "${PCAP_PREFIX}/Lib" "${PCAP_PREFIX}/lib")

    if(PCAP_framework STREQUAL "x64")
        set(LIB_DIRS "${PCAP_PREFIX}/Lib/x64" "${PCAP_PREFIX}/lib/x64")
    endif(PCAP_framework STREQUAL "x64")


    if(PCAP_PREFIX)
        find_path(_PCAP_INCLUDE_DIR pcap.h
            PATHS "${PCAP_PREFIX}" 
            PATH_SUFFIXES "Include" "include"
            NO_DEFAULT_PATH
            )
        find_library(_PCAP_LIBRARY wpcap pcap
            PATHS ${LIB_DIRS} 
            NO_DEFAULT_PATH
            )
    else(PCAP_PREFIX)
        find_path(_PCAP_INCLUDE_DIR pcap.h
            PATH_SUFFIXES "include" "Include"
            )
        find_library(_PCAP_LIBRARY wpcap pcap)
    endif(PCAP_PREFIX)
    if(_PCAP_INCLUDE_DIR AND _PCAP_LIBRARY)
        set(PCAP_FOUND true)
        set(PCAP_INCLUDE_DIRS ${_PCAP_INCLUDE_DIR} CACHE PATH
            "Include directories for Pcap")
        set(PCAP_LIBRARIES ${_PCAP_LIBRARY} CACHE FILEPATH
            "Libraries to link for Pcap")
        mark_as_advanced(PCAP_INCLUDE_DIRS PCAP_LIBRARIES)
        if(NOT pcap_FIND_QUIETLY)
            message(STATUS "Found Pcap Library: ${PCAP_LIBRARIES}")
        endif(NOT pcap_FIND_QUIETLY)
    else(_PCAP_INCLUDE_DIR AND _PCAP_LIBRARY)
        if(pcap_FIND_REQUIRED)
            message(FATAL_ERROR "Could not find the pcap library")
        endif(pcap_FIND_REQUIRED)
    endif(_PCAP_INCLUDE_DIR AND _PCAP_LIBRARY) 
endif(PCAP_INCLUDE_DIRS AND PCAP_LIBRARIES)
