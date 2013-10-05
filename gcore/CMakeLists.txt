set(GCORE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(HDRS
  ${GCORE_DIR}/gdal.h
  ${GCORE_DIR}/gdal_frmts.h
  ${GCORE_DIR}/gdal_pam.h
  ${GCORE_DIR}/gdal_priv.h
  ${GCORE_DIR}/gdal_proxy.h
  ${GCORE_DIR}/gdal_rat.h
  ${GCORE_DIR}/gdal_version.h
  ${GCORE_DIR}/gdaljp2metadata.h)

set(SRCS
  ${GCORE_DIR}/gdalallvalidmaskband.cpp
  ${GCORE_DIR}/gdalcolortable.cpp
  ${GCORE_DIR}/gdaldataset.cpp
  ${GCORE_DIR}/gdaldefaultoverviews.cpp
  ${GCORE_DIR}/gdaldefaultasync.cpp
  ${GCORE_DIR}/gdaldriver.cpp
  ${GCORE_DIR}/gdaldrivermanager.cpp
  ${GCORE_DIR}/gdalgmlcoverage.cpp
  ${GCORE_DIR}/gdaljp2box.cpp
  ${GCORE_DIR}/gdaljp2metadata.cpp
  ${GCORE_DIR}/gdalmajorobject.cpp
  ${GCORE_DIR}/gdal_misc.cpp
  ${GCORE_DIR}/gdalmultidomainmetadata.cpp
  ${GCORE_DIR}/gdalnodatamaskband.cpp
  ${GCORE_DIR}/gdalnodatavaluesmaskband.cpp
  ${GCORE_DIR}/gdalopeninfo.cpp
  ${GCORE_DIR}/gdalpamdataset.cpp
  ${GCORE_DIR}/gdalpamproxydb.cpp
  ${GCORE_DIR}/gdalpamrasterband.cpp
  ${GCORE_DIR}/gdalproxydataset.cpp
  ${GCORE_DIR}/gdalproxypool.cpp
  ${GCORE_DIR}/gdalrasterband.cpp
  ${GCORE_DIR}/gdalrasterblock.cpp
  ${GCORE_DIR}/gdal_rat.cpp
  ${GCORE_DIR}/gdal_rpcimdio.cpp
  ${GCORE_DIR}/overview.cpp
  ${GCORE_DIR}/rasterio.cpp)

# TODO: DATA_DIR path, properties have local scope, so invisible in outer dir
#set_source_files_properties(gdaldrivermanager.cpp
#   PROPERTIES COMPILE_FLAGS "-DINST_DATA=\"XXXXXXXX\"")

gdal_add_module(gcore
  HEADERS ${HDRS}
  SOURCES ${SRCS})
