#==============================================================================#
#CMakeLists file for building GDal
#==============================================================================#
PROJECT(GDal)
CMAKE_MINIMUM_REQUIRED(VERSION 2.8.10)
SET(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
SET(CMAKE_COLOR_MAKEFILE ON)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
LIST(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")

set(VERSION_MAJOR 1)
set(VERSION_MINOR 10)
set(VERSION_PATCH 1)
set(VERSION ${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH})

INCLUDE(GdalConfig)
SET(EXT_LIBS)
IF(WIN32)
  IF (NOT ONCE_SET_CMAKE_INSTALL_PREFIX)
    SET(ONCE_SET_CMAKE_INSTALL_PREFIX true CACHE BOOL
        "Have we set the install prefix yet?" FORCE)
    SET(CMAKE_INSTALL_PREFIX /usr/local CACHE PATH
        "Install path prefix, prepended onto install directories" FORCE)
  ENDIF()
  
  ADD_DEFINITIONS(-D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_DEPRECATE 
                  -D_CRT_SECURE_NO_WARNINGS  -D_SCL_SECURE_NO_DEPRECATE
                  -D_SCL_SECURE_NO_WARNINGS)
  IF(MSVC)
    ADD_DEFINITIONS(-D_WIN32 -DWIN32_LEAN_AND_MEAN)
    ADD_DEFINITIONS("/wd4267 /wd4244 /wd4251 /wd4018")
    LIST(APPEND EXT_LIBS "ws2_32.lib")
  ENDIF()

ENDIF()

#==============================================================================#
#Do we want to enable OpenCL?
#==============================================================================#
OPTION(ENABLE_OPENCL "Use the OpenCL backend" OFF)
IF (ENABLE_OPENCL)
  # For out-of-the-box support on MacOS:
  IF(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    INCLUDE_DIRECTORIES("/opt/local/include") 
    SET(CMAKE_EXE_LINKER_FLAGS "-framework OpenCL")
  ELSE()
    FIND_PACKAGE(OpenCL REQUIRED)
    ADD_DEFINITIONS(-DHAVE_OPENCL -DCL_USE_DEPRECATED_OPENCL_1_1_APIS)
    LIST(APPEND EXT_LIBS ${OPENCL_LIBRARIES})
    INCLUDE_DIRECTORIES(${OPENCL_INCLUDE_DIR})
  ENDIF()
ENDIF()

#==============================================================================#
#Do we want to enable hdf5?
#==============================================================================#
OPTION(ENABLE_HDF5 "Use HDF5 support" OFF)
IF (ENABLE_HDF5)
  FIND_PACKAGE(HDF5 REQUIRED)
  INCLUDE_DIRECTORIES(${HDF5_INCLUDE_DIR})
  LIST(APPEND EXT_LIBS hdf5)
ENDIF()

#==============================================================================#
#Here we list all folders that contain relevant GDal files
#==============================================================================#
SET(GDAL_Components 
    port
    ogr
    alg
	gcore
	frmts
)

#==============================================================================#
#Global variables
#==============================================================================#
SET(gdal_srcs)
INCLUDE_DIRECTORIES(${PROJECT_BINARY_DIR}/port)

#==============================================================================#
#Include all files and/or build relevant libraries here
#==============================================================================#
FOREACH (COMPONENTS ${GDAL_Components})
  INCLUDE(${PROJECT_SOURCE_DIR}/cmake/gdal_${COMPONENTS}.cmake)
ENDFOREACH()

ADD_LIBRARY(GDal_${VERSION_MAJOR}_${VERSION_MINOR}_${VERSION_PATCH} SHARED ${gdal_srcs} ${PROJECT_SOURCE_DIR}/frmts/gdalallregister.cpp)
TARGET_LINK_LIBRARIES(GDal_${VERSION_MAJOR}_${VERSION_MINOR}_${VERSION_PATCH} ${EXT_LIBS})

#==============================================================================#
#Check if we are building unit tests
#==============================================================================#
OPTION(ENABLE_APPS "Build GDal Apps" OFF)
IF (ENABLE_APPS)
  INCLUDE(${PROJECT_SOURCE_DIR}/cmake/gdal_apps.cmake)
ENDIF()