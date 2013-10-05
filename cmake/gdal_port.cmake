#==============================================================================#
# CPL (Common Portability Library) 
# Here, we assume that the zlib will be built, natively by GDal
#==============================================================================#
SET (gdal_port_DIR ${PROJECT_SOURCE_DIR}/port)
ADD_DEFINITIONS(-DCPL_OPTIONAL_APIS)

FILE(GLOB gdal_port_SRCS ${gdal_port_DIR}/*.cpp
                         ${gdal_port_DIR}/*.c
)
FILE(GLOB gdal_port_HDRS ${gdal_port_DIR}/*.h
)

#Remove files that are not relevant here
IF(NOT UNIX)
  REMOVE(gdal_port_SRCS "${gdal_port_DIR}/cpl_vsil_unix_stdio_64.cpp")
ELSEIF(NOT WIN32)
  REMOVE(gdal_port_SRCS "${gdal_port_DIR}/cpl_vsil_win32.cpp")
ENDIF()

#==============================================================================#
# Remove some files
#==============================================================================#
REMOVE(gdal_port_HDRS "${gdal_port_DIR}/cpl_minizip_ioapi.h" 
                      "${gdal_port_DIR}/cpl_win32ce_api.h"
                      "${gdal_port_DIR}/cpl_wince.h"
                      "${gdal_port_DIR}/cpl_minizip_unzip.h"
                      "${gdal_port_DIR}/cpl_odbc.h")
                      
REMOVE(gdal_port_SRCS "${gdal_port_DIR}/cpl_minizip_ioapi.cpp"
                      "${gdal_port_DIR}/cpl_minizip_zip.cpp"
                      "${gdal_port_DIR}/cpl_minizip_unzip.cpp"
                      "${gdal_port_DIR}/cpl_vsil_gzip.cpp"
                      "${gdal_port_DIR}/cpl_vsil_gzip.cpp"
                      "${gdal_port_DIR}/xmlreformat.cpp" 
                      "${gdal_port_DIR}/cpl_win32ce_api.cpp"
                      "${gdal_port_DIR}/cpl_odbc.cpp"
                      "${gdal_port_DIR}/cpl_vsil_simple.cpp"
                      "${gdal_port_DIR}/cpl_recode_iconv.cpp")

#==============================================================================#
#Set the include directories here
#==============================================================================#
INCLUDE_DIRECTORIES(${gdal_port_DIR})

#==============================================================================#
#Create a source group for these files
#==============================================================================#
SOURCE_GROUP("Port\\source" FILES ${gdal_port_SRCS})
SOURCE_GROUP("Port\\headers" FILES ${gdal_port_HDRS})

#==============================================================================#
#Finally, add the sources here
#==============================================================================#
SET(gdal_srcs ${gdal_srcs} ${gdal_port_SRCS} ${gdal_port_HDRS})