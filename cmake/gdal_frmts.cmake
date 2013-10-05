#==============================================================================#
# FRMTS 
# This module depends on gdal_version.h that is present in the gcore folder. 
# However, this should have been built in gdal_ogr. Also, zlib is not built in 
# this module as it should have been built in gdal_port
#==============================================================================#
SET (gdal_frmts_DIR ${PROJECT_SOURCE_DIR}/frmts)
#==============================================================================#
#Take all files present in the various subfolders folder
#==============================================================================#
INCLUDE_DIRECTORIES(${gdal_frmts_DIR})

SET(gdal_frmts_SRCS)
SET(gdal_frmts_HDRS)

#==============================================================================#
# List out all formats that share a common build structure
#==============================================================================#
SET(GDAL_FORMAT_LIST_COMMON
    aaigrid
    adrg
    aigrid
    airsar
	blx
	bmp
	bmp
	bsb
	ceos
	coasp
    cosar
	ctg
	dimap
	elas
	envisat
	fit
	gif
	gtiff
	gxf
    hdf5
	hf2
	hfa
	ilws
	ingr
	iris
	iso8211
	jaxapalsar
	jdem
	jpeg
	kmlsuperoverlay
	l1b
	leveller
	map
	ngsgeoid
	nitf
	ozi
	pcraster
    png	
	r
	rasterlite
	raw
	rik
	rmf
	rs2
	saga
	sdts
	sgi
	srp
	srtmhgt
	terragen
	til
	tsx
	usgsdem
	vrt
	xyz
    zlib
	zmap
)

#==============================================================================#
#Give the user the option to select or deselect modules
#==============================================================================#
FOREACH(format ${GDAL_FORMAT_LIST_COMMON})
  OPTION(GDAL_WITH_${format} "Compilation of GDAL format ${format}" OFF)
  MARK_AS_ADVANCED(GDAL_WITH_${format})
  #hdf5 needs the hdf5 library to be found
  IF((${format} STREQUAL "hdf5") AND (NOT HDF5_FOUND))
    OPTION(GDAL_WITH_hdf5 "Compilation of GDAL format ${format}" OFF)
    MARK_AS_ADVANCED(GDAL_WITH_${format})
	MESSAGE("hdf5 library needs to be found before gdal_hdf5 can be built")
  ENDIF()
ENDFOREACH()

FOREACH(format ${GDAL_FORMAT_LIST_COMMON})
  IF(GDAL_WITH_${format})
    #==========================================================================#
    #Add this directory to the path
    #==========================================================================#
    INCLUDE_DIRECTORIES(${gdal_frmts_DIR}/${format})
    
    #==========================================================================#
    #Different rules are needed for folders in the Special category
    #==========================================================================#
    IF(${format} STREQUAL "png")
      INCLUDE_DIRECTORIES(${gdal_frmts_DIR}/${format}/libpng)
    ELSEIF(${format} STREQUAL "gif")
      INCLUDE_DIRECTORIES(${gdal_frmts_DIR}/${format}/giflib)
	ELSEIF(${format} STREQUAL "jpeg")
      INCLUDE_DIRECTORIES(${gdal_frmts_DIR}/${format}/libjpeg)
	ELSEIF(${format} STREQUAL "pcraster")
      INCLUDE_DIRECTORIES(${gdal_frmts_DIR}/${format}/libcsf)
	  ADD_DEFINITIONS(-DUSE_IN_GDAL)
    ENDIF()
    
    #==========================================================================#
    #Get the files
    #==========================================================================#   
    FILE(GLOB_RECURSE gdal_frmt_SRC
         "${gdal_frmts_DIR}/${format}/*.cpp"
         "${gdal_frmts_DIR}/${format}/*.c")
         
    FILE(GLOB_RECURSE gdal_frmt_HDRS
         "${gdal_frmts_DIR}/${format}/*.h"
         "${gdal_frmts_DIR}/${format}/*.hpp")

    #==========================================================================#
    #Remove some redundant files
    #==========================================================================#
    IF(${format} STREQUAL "hfa")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/hfatest.cpp")
    ELSEIF(${format} STREQUAL "bsb")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/bsb2raw.c")
    ELSEIF(${format} STREQUAL "ceos")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/ceostest.c")
    ELSEIF(${format} STREQUAL "dted")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/dted_test.c")
    ELSEIF(${format} STREQUAL "nitf")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/nitfdump.c")
    ELSEIF(${format} STREQUAL "ntf")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/ntfdump.c")
    ELSEIF(${format} STREQUAL "envisat")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/envisat_dump.c")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/dumpgeo.c")
    ELSEIF(${format} STREQUAL "iso8211")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/8211createfromxml.cpp")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/8211dump.cpp")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/8211view.cpp")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/mkcatalog.cpp")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/timetest.cpp")
    ELSEIF(${format} STREQUAL "sdts")
      REMOVE(gdal_frmt_SRC "${gdal_frmts_DIR}/${format}/sdts2shp.cpp")
	ENDIF()
    #==========================================================================#
    #Create a source group for these files
    #==========================================================================#
    SOURCE_GROUP("Frmts\\${format}\\srcs" FILES ${gdal_frmt_SRC})
    SOURCE_GROUP("Frmts\\${format}\\headers" FILES ${gdal_frmt_HDRS})
    
    #==========================================================================#
    #Add the files to the master list
    #==========================================================================#
    SET(gdal_frmts_SRCS ${gdal_frmts_SRCS} ${gdal_frmt_SRC})
    SET(gdal_frmts_HDRS ${gdal_frmts_HDRS} ${gdal_frmt_HDRS})
    #==========================================================================#
    #Add the definitions
    #==========================================================================#
    ADD_DEFINITIONS("-DFRMT_${format}")
  ENDIF()
ENDFOREACH()

#==============================================================================#
# List out all formats that need additional files for a build
#==============================================================================#
SET(GDAL_FORMAT_LIST_SPECIAL
    gtiff
    geotiff
)    

FOREACH(format ${GDAL_FORMAT_LIST_SPECIAL})
  OPTION(GDAL_WITH_${format} "Compilation of GDAL format ${format}" OFF)
  MARK_AS_ADVANCED(GDAL_WITH_${format})
ENDFOREACH()

#==============================================================================#
#Check if gtiff needs to be built
IF(GDAL_WITH_gtiff)
  #Now check if geotiff needs to be built
  FILE(GLOB gdal_gtiff_SRCS ${gdal_frmts_DIR}/gtiff/*.cpp
                            ${gdal_frmts_DIR}/gtiff/*.c
  )
  FILE(GLOB gdal_gtiff_HDRS ${gdal_frmts_DIR}/gtiff/*.h)
  FILE(GLOB gdal_libtiff_SRCS ${gdal_frmts_DIR}/gtiff/libtiff/*.cpp
                              ${gdal_frmts_DIR}/gtiff/libtiff/.c
  )
  FILE(GLOB gdal_libtiff_HDRS ${gdal_frmts_DIR}/gtiff/libtiff/*.h)
  
  INCLUDE_DIRECTORIES(${gdal_frmts_DIR}/gtiff
                      ${gdal_frmts_DIR}/gtiff/libtiff)
                      
  SET(gdal_frmts_SRCS ${gdal_frmts_SRCS} ${gdal_gtiff_SRCS})
  SET(gdal_frmts_SRCS ${gdal_frmts_SRCS} ${gdal_libtiff_SRCS})
  SET(gdal_frmts_HDRS ${gdal_frmts_HDRS} ${gdal_gtiff_HDRS})
  SET(gdal_frmts_HDRS ${gdal_frmts_HDRS} ${gdal_libtiff_HDRS})
  
  SOURCE_GROUP("Frmts\\gtiff\\srcs" FILES ${gdal_gtiff_SRCS})
  SOURCE_GROUP("Frmts\\gtiff\\headers" FILES ${gdal_gtiff_HDRS})
  SOURCE_GROUP("Frmts\\gtiff\\libtiff\\srcs" FILES ${gdal_libtiff_SRCS})
  SOURCE_GROUP("Frmts\\gtiff\\libtiff\\headers" FILES ${gdal_libtiff_HDRS})

  IF(GDAL_WITH_geotiff)
    FILE(GLOB gdal_libgeotiff_SRCS ${gdal_frmts_DIR}/gtiff/libgeotiff/*.cpp
                                   ${gdal_frmts_DIR}/gtiff/libgeotiff/.c
    )
    FILE(GLOB gdal_libgeotiff_HDRS ${gdal_frmts_DIR}/gtiff/libgeotiff/*.h)
    SOURCE_GROUP("Frmts\\gtiff\\geotiff\\srcs" FILES ${gdal_libgeotiff_SRCS})
    SOURCE_GROUP("Frmts\\gtiff\\geotiff\\headers" FILES ${gdal_libgeotiff_HDRS})
    INCLUDE_DIRECTORIES(${gdal_frmts_DIR}/gtiff/libgeotiff)
    SET(gdal_frmts_SCRS ${gdal_frmts_HDRS} ${gdal_libgeotiff_SCRS})
    SET(gdal_frmts_HDRS ${gdal_frmts_HDRS} ${gdal_libgeotiff_HDRS})
  ENDIF()
  ADD_DEFINITIONS(-DRENAME_INTERNAL_LIBTIFF_SYMBOLS)
  ADD_DEFINITIONS(-DFRMT_gtiff)
ELSE()
  REMOVE_DEFINITIONS(-DFRMT_gtiff)
  REMOVE_DEFINITIONS(-DRENAME_INTERNAL_LIBTIFF_SYMBOLS)
ENDIF()

#==============================================================================#
#Finally, add the sources here
#==============================================================================#
SET(gdal_srcs ${gdal_srcs} ${gdal_frmts_SRCS} ${gdal_frmts_HDRS})