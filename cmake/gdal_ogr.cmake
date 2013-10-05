#==============================================================================#
# OGR 
# This module depends on gdal_version.h that is present in the gcore folder
#==============================================================================#
SET (gdal_ogr_DIR ${PROJECT_SOURCE_DIR}/ogr)
SET (gdal_ogrsf_frmts_DIR ${PROJECT_SOURCE_DIR}/ogr/ogrsf_frmts)
#TODO: Cannot add this as kml package would then need to be built and that
#depends on XERCES
#ADD_DEFINITIONS(-DOGR_ENABLED)

#==============================================================================#
#Take all files present in the root folder
#==============================================================================#
INCLUDE_DIRECTORIES(${gdal_ogr_DIR} ${gdal_ogrsf_frmts_DIR})
FILE ( GLOB gdal_ogr_SRCS ${gdal_ogr_DIR}/*.cpp )
FILE ( GLOB gdal_ogr_HDRS ${gdal_ogr_DIR}/*.h )
SET(gdal_ogr_HDRS ${gdal_ogr_HDRS} "${gdal_ogrsf_frmts_DIR}/ogr_attrind.h")
SET(gdal_ogr_HDRS ${gdal_ogr_HDRS} "${gdal_ogrsf_frmts_DIR}/ogrsf_frmts.h")

#==============================================================================#
#Build a source group for these files
#==============================================================================#
SOURCE_GROUP("Ogr\\ogr_source\\src" FILES ${gdal_ogr_SRCS})
SOURCE_GROUP("Ogr\\ogr_headers\\headers" FILES ${gdal_ogr_HDRS})

#==============================================================================#
#List out all formats that we will build
#==============================================================================#

set(OGR_FORMAT_LIST
    generic
    avc
    bna
    csv
    dgn
    gmt
    mem
    mitab
    ntf
    gpx
    rec
    geojson
    shape
    tiger
    vrt
    geoconcept
    xplane
    georss
    gtm
    dxf
    pgdump
    gpsbabel
    sua
    openair
    htf
)

#==============================================================================#
#Give the user the option to select or deselect files
#==============================================================================#
FOREACH(format ${OGR_FORMAT_LIST})
  OPTION(OGR_WITH_${format} "Compilation of OGR format ${format}" OFF)
  MARK_AS_ADVANCED(OGR_WITH_${format})
ENDFOREACH()

FOREACH(format ${OGR_FORMAT_LIST})
  IF(OGR_WITH_${format})
    #==========================================================================#
    #Add this directory to the path
    #==========================================================================#
    INCLUDE_DIRECTORIES(${gdal_ogrsf_frmts_DIR}/${format})
    
    #do something special for geojson
    IF(${format} STREQUAL "geojson")
      INCLUDE_DIRECTORIES(${gdal_ogrsf_frmts_DIR}/${format}/jsonc)
    ENDIF()
    
    #==========================================================================#
    #Get the files
    #==========================================================================#   
    FILE(GLOB_RECURSE ogr_frmt_SRC
         "${gdal_ogrsf_frmts_DIR}/${format}/*.cpp"
         "${gdal_ogrsf_frmts_DIR}/${format}/*.c")
         
    FILE(GLOB_RECURSE ogr_frmt_HDRS
         "${gdal_ogrsf_frmts_DIR}/${format}/*.h"
         "${gdal_ogrsf_frmts_DIR}/${format}/*.hpp")
    
    #==========================================================================#
    #Remove some redundant files
    #==========================================================================#
    IF(${format} STREQUAL "dgn")
      REMOVE(ogr_frmt_SRC "${gdal_ogrsf_frmts_DIR}/dgn/dgnwritetest.c")
      REMOVE(ogr_frmt_SRC "${gdal_ogrsf_frmts_DIR}/dgn/dgndump.c")
    ELSEIF(${format} STREQUAL "tiger")
      REMOVE(ogr_frmt_SRC "${gdal_ogrsf_frmts_DIR}/tiger/tigerinfo.cpp")
    ELSEIF(${format} STREQUAL "xplane")
      REMOVE(ogr_frmt_SRC "${gdal_ogrsf_frmts_DIR}/xplane/test_geo_utils.cpp")
    ELSEIF(${format} STREQUAL "ntf")
      REMOVE(ogr_frmt_SRC "${gdal_ogrsf_frmts_DIR}/ntf/ntfdump.cpp")
    ENDIF()
    #==========================================================================#
    #Create a source group for these files
    #==========================================================================#
    SOURCE_GROUP("Ogr\\${format}\\srcs" FILES ${ogr_frmt_SRC})
    SOURCE_GROUP("Ogr\\${format}\\headers" FILES ${ogr_frmt_HDRS})
    
    #==========================================================================#
    #Add the files to the master list
    #==========================================================================#
    SET(gdal_ogr_SRCS ${gdal_ogr_SRCS} ${ogr_frmt_SRC})
    SET(gdal_ogr_HDRS ${gdal_ogr_HDRS} ${ogr_frmt_HDRS})
    #==========================================================================#
    #Add the definitions
    #==========================================================================#
    STRING(TOUPPER "${format}_ENABLED" THIS_FORMAT_ENABLED)
    ADD_DEFINITIONS("-D${THIS_FORMAT_ENABLED}")
  ENDIF()
ENDFOREACH()

#==============================================================================#
#Finally, add the sources here
#==============================================================================#
SET(gdal_srcs ${gdal_srcs} ${gdal_ogr_SRCS} ${gdal_ogr_HDRS})
