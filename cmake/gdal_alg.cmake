#==============================================================================#
# ALG 
#==============================================================================#
SET(gdal_alg_DIR ${PROJECT_SOURCE_DIR}/alg)
INCLUDE_DIRECTORIES(${gdal_alg_DIR})

#==============================================================================#
#Set the source files that will be used
#==============================================================================#
FILE(GLOB gdal_alg_SRCS ${gdal_alg_DIR}/*.cpp
                        ${gdal_alg_DIR}/*.c)
FILE(GLOB gdal_alg_HDRS ${gdal_alg_DIR}/*.h
                        ${gdal_alg_DIR}/*.txx
                        ${gdal_alg_DIR}/*.hpp)
                        
INCLUDE_DIRECTORIES(${GDal_SOURCE_DIR}/alg)
SOURCE_GROUP("Alg\\srcs" FILES ${gdal_alg_SRCS})
SOURCE_GROUP("Alg\\headers" FILES ${gdal_alg_HDRS})

#Remove some redundant files
LIST(REMOVE_ITEM gdal_alg_SRCS ${gdal_alg_DIR}/gdal_nrgcrs.c)

#==============================================================================#
#Finally, add the sources here
#==============================================================================#
SET(gdal_srcs ${gdal_srcs} ${gdal_alg_SRCS} ${gdal_alg_HDRS})