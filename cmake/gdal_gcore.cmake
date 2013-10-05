#==============================================================================#
# GCore
# Here, we assume that gtiff will be built, natively, by GDal
#==============================================================================#
SET (gdal_gcore_DIR ${PROJECT_SOURCE_DIR}/gcore)

FILE ( GLOB gdal_gcore_SRCS ${gdal_gcore_DIR}/*.cpp
                            ${gdal_gcore_DIR}/*.c)
FILE ( GLOB gdal_gcore_HDRS ${gdal_gcore_DIR}/*.h)  

#==============================================================================#
#Set the include directories here
#==============================================================================#
INCLUDE_DIRECTORIES(${gdal_gcore_DIR})  

#==============================================================================#
#Create a source group for these files
#==============================================================================#
SOURCE_GROUP("GCore\\source" FILES ${gdal_gcore_SRCS})
SOURCE_GROUP("GCore\\headers" FILES ${gdal_gcore_HDRS})

#==============================================================================#
#Finally, add the sources here
#==============================================================================#
SET(gdal_srcs ${gdal_srcs} ${gdal_gcore_SRCS} ${gdal_gcore_HDRS})             