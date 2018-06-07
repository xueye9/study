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
if(RABBITMQ_INCLUDE_DIRS AND RABBITMQ_LIBRARIES)
    set(RABBITMQ_FOUND true)
else(RABBITMQ_INCLUDE_DIRS AND RABBITMQ_LIBRARIES)
    set(RABBITMQ_PREFIX "" CACHE PATH "Installation prefix for Google Test")
    if(RABBITMQ_PREFIX)
        find_path(_RABBITMQ_INCLUDE_DIR amqp.h
            PATHS "${RABBITMQ_PREFIX}/include"
            PATH_SUFFIXES "rabbitMQ"
            NO_DEFAULT_PATH)
        find_library(_RABBITMQ_LIBRARY rabbitmq.4
            PATHS "${RABBITMQ_PREFIX}/lib"
            NO_DEFAULT_PATH)
    else(RABBITMQ_PREFIX)
        find_path(_RABBITMQ_INCLUDE_DIR amqp.h
            PATH_SUFFIXES "rabbitMQ")
        find_library(_RABBITMQ_LIBRARY rabbitmq.4)
    endif(RABBITMQ_PREFIX)
    if(_RABBITMQ_INCLUDE_DIR AND _RABBITMQ_LIBRARY)
        set(RABBITMQ_FOUND true)
        set(RABBITMQ_INCLUDE_DIRS ${_RABBITMQ_INCLUDE_DIR} CACHE PATH
            "Include directories for RabbitMQ")
        set(RABBITMQ_LIBRARIES ${_RABBITMQ_LIBRARY} CACHE FILEPATH
            "Libraries to link for RabbitMQ")
        mark_as_advanced(RABBITMQ_INCLUDE_DIRS RABBITMQ_LIBRARIES) 
        if(NOT rabbitMQ_FIND_QUIETLY)
            message(STATUS "Found Google Test: ${RABBITMQ_LIBRARIES}")
        endif(NOT rabbitMQ_FIND_QUIETLY)
    else(_RABBITMQ_INCLUDE_DIR AND _RABBITMQ_LIBRARY)
        if(rabbitMQ_FIND_REQUIRED)
            message(FATAL_ERROR "Could not find the RabbitMQ")
        endif(rabbitMQ_FIND_REQUIRED)
    endif(_RABBITMQ_INCLUDE_DIR AND _RABBITMQ_LIBRARY)
endif(RABBITMQ_INCLUDE_DIRS AND RABBITMQ_LIBRARIES)
