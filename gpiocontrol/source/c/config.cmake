#
#  Copyright 2014-2016 CyberVision, Inc.
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#

# Our application name.
set(APP_NAME demo_client)

# Disable unused features
set(WITH_EXTENSION_CONFIGURATION OFF CACHE BOOL "")
set(WITH_EXTENSION_NOTIFICATION OFF CACHE BOOL "")
set(WITH_EXTENSION_LOGGING OFF CACHE BOOL "")
set(WITH_EXTENSION_CONFIGURATION OFF CACHE BOOL "")
set(WITH_EXTENSION_USER OFF CACHE BOOL "")
set(WITH_ENCRYPTION OFF CACHE BOOL "")

# Target-independent flags.
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c99 -g -Wall -Wextra")

if(KAA_PLATFORM STREQUAL "esp8266")
    set(CMAKE_BUILD_TYPE MinSizeRel)
    set(KAA_MAX_LOG_LEVEL 0)
endif()

# Directory containing target support library.
add_subdirectory(targets/${KAA_PLATFORM})
add_subdirectory(targets/common)

# This is required for ESP8266 platform
# due to it's specific requirements regarding linked executable.
# The blank.c file is a placeholder for CMake's add_executable()
# All the code (Kaa SDK, ESP8266 SDK and demo) is compiled as static libraries
# and linked into that executable.
if(KAA_PLATFORM STREQUAL "esp8266")
    add_library(${APP_NAME}_s STATIC src/kaa_demo.c)
    file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/blank.c "")
    add_executable(${APP_NAME} ${CMAKE_CURRENT_BINARY_DIR}/blank.c)
    target_link_libraries(${APP_NAME} ${APP_NAME}_s)
    target_link_libraries(${APP_NAME}_s target_support kaac)
else()
    add_executable(${APP_NAME} src/kaa_demo.c)
    target_link_libraries(${APP_NAME} kaac target_support)
endif()

# For most embedded targets binary stripping is required.
if(${KAA_PRODUCE_BINARY})
    add_custom_command(TARGET ${APP_NAME} POST_BUILD
            COMMAND ${CMAKE_OBJCOPY} -O binary ${APP_NAME} ${APP_NAME}.bin)
endif()
