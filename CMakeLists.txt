# ======================================================
# StarStable Main Configuration File
# ======================================================

cmake_minimum_required (VERSION 3.1)
set(CMAKE_CONFIGURATION_TYPES Debug Release CACHE TYPE INTERNAL FORCE )
set(CMAKE_SOURCE_DIR ./ CACHE TYPE INTERNAL FORCE )
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY lib  CACHE TYPE INTERNAL FORCE )


set(CMAKE_OSX_ARCHITECTURES $(ARCHS_STANDARD_32_BIT)  CACHE TYPE  INTERNAL FORCE )


project(Crunch C CXX)

set (CMAKE_CXX_STANDARD 11)

# ------------------------------------------
# Determine what to build
set (DEBUG_FLAGS )#-O3 -fomit-frame-pointer -ffast-math -fno-math-errno -g -fno-strict-aliasing -Wall -Wno-unused-value -Wno-unused -march=core2 -lpthread -g)
set (RELEASE_FLAGS )#-O3 -fomit-frame-pointer -ffast-math -fno-math-errno -g -fno-strict-aliasing -Wall -Wno-unused-value -Wno-unused -march=core2 -lpthread -g)


if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
	set (DEBUG_FLAGS ${DEBUG_FLAGS})		
	foreach(_opt IN ITEMS ${DEBUG_FLAGS})
		set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} ${_opt}")
		set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} ${_opt}")
	endforeach()
	
	set (RELEASE_FLAGS ${RELEASE_FLAGS})	
	foreach(_opt IN ITEMS ${RELEASE_FLAGS})
		set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${_opt}")
		set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${_opt}")
	endforeach()
	
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
	set(DEBUG_FLAGS /MTd /W3 -I$(IncludePath) -D_CRT_SECURE_NO_DEPRECATE -D_CRT_SECURE_NO_WARNINGS ${DEBUG_FLAGS})	
	foreach(_opt IN ITEMS ${DEBUG_FLAGS})
		add_compile_options($<$<CONFIG:Debug>:${_opt}>)
	endforeach()	
	
	set (RELEASE_FLAGS /MT /W3 -I$(IncludePath) -D_CRT_SECURE_NO_DEPRECATE -D_CRT_SECURE_NO_WARNINGS ${RELEASE_FLAGS})
	foreach(_opt IN ITEMS ${RELEASE_FLAGS})
		add_compile_options($<$<CONFIG:Release>:${_opt}>)
	endforeach()
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
endif()

list(APPEND FILTER "${CMAKE_CURRENT_SOURCE_DIR}/crnlib/*.h")
list(APPEND FILTER "${CMAKE_CURRENT_SOURCE_DIR}/crnlib/*.hpp")
list(APPEND FILTER "${CMAKE_CURRENT_SOURCE_DIR}/crnlib/lzma_*.cpp")
list(APPEND FILTER "${CMAKE_CURRENT_SOURCE_DIR}/crnlib/crn_*.cpp")
list(APPEND FILTER "${CMAKE_CURRENT_SOURCE_DIR}/crnlib/crnlib.cpp")
	
# Gather source
file(GLOB_RECURSE FILE_LIST ${FILTER})
# Get the group dynamically from the path
foreach(_source IN ITEMS ${FILE_LIST})
	if(NOT ${_source} MATCHES "/_(.*)")
		get_filename_component(_source_path "${_source}" PATH)
		list(APPEND SRC_FILE_LIST ${_source})
		list(APPEND SRC_DIR_LIST ${_source_path})
	else()
		message("-- ${_source} is excluded")
	endif()
endforeach()

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/crnlib)
add_library(crnlib ${SRC_FILE_LIST} )
















