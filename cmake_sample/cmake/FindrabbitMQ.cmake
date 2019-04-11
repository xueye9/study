# Locate and configure the rabbitmq libraries.
#
# Defines the following variable:
#
#   rabbitmq_FOUND - Found the rabbitmq libraries
#   rabbitmq_INCLUDE_DIRS - The directories needed on the include paths
#   rabbitmq_LIBRARIES - The libraries to link to test executables
#   rabbitmq_MAIN_LIBRARIES - The libraries to link for automatic main() provision
#
#	Copyright 2008 Chandler Carruth
#
#	Licensed under the Apache License, Version 2.0 (the "License"); you may not
#	use this file except in compliance with the License.  You may obtain a copy
#	of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#	WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
#	License for the specific language governing permissions and limitations
#	under the License.

if(rabbitmq_INCLUDE_DIRS AND rabbitmq_LIBRARIES )
  set(rabbitmq_FOUND true)
else(rabbitmq_INCLUDE_DIRS AND rabbitmq_LIBRARIES )
  set(rabbitmq_PREFIX "" CACHE PATH "Installation prefix for rabbitmq")
  if(rabbitmq_PREFIX)
    find_path(_rabbitmq_INCLUDE_DIR amqp.h
      PATHS "${rabbitmq_PREFIX}/include" "${rabbitmq_PREFIX}/include/rabbitmq" 
      #PATH_SUFFIXES "" "rabbitmq" 
      NO_DEFAULT_PATH)
    find_library(_rabbitmq_LIBRARY rabbitmq rabbitmq.4
      PATHS "${rabbitmq_PREFIX}" "${rabbitmq_PREFIX}/lib" 
      NO_DEFAULT_PATH)
  else(rabbitmq_PREFIX)
    find_path(_rabbitmq_INCLUDE_DIR amqp.h
        PATH_SUFFIXES "usr/local/include" "rabbitmq" ENV path )
    find_library(_rabbitmq_LIBRARY rabbitmq)
  endif(rabbitmq_PREFIX)
  if(_rabbitmq_INCLUDE_DIR AND _rabbitmq_LIBRARY)
    set(rabbitmq_FOUND true)
    set(rabbitmq_INCLUDE_DIRS ${_rabbitmq_INCLUDE_DIR} CACHE PATH
      "Include directories for rabbitmq framework")
    set(rabbitmq_LIBRARIES ${_rabbitmq_LIBRARY} CACHE FILEPATH
      "Libraries to link for rabbitmq framework")
    mark_as_advanced(rabbitmq_INCLUDE_DIRS rabbitmq_LIBRARIES)
  else(_rabbitmq_INCLUDE_DIR AND _rabbitmq_LIBRARY)
    if(rabbit_FIND_REQUIRED)
      message(FATAL_ERROR "Could not find the rabbitmq")
    endif(rabbit_FIND_REQUIRED)
  endif(_rabbitmq_INCLUDE_DIR AND _rabbitmq_LIBRARY )
endif(rabbitmq_INCLUDE_DIRS AND rabbitmq_LIBRARIES )
