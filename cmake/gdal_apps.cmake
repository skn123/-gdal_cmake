#==============================================================================#
#Apps built using GDal
#==============================================================================#
SET(gdal_apps_DIR ${PROJECT_SOURCE_DIR}/apps)

#==============================================================================#
#Get a list of all files that are present in the list for testing
#==============================================================================#
FILE(GLOB gdal_apps_SRCS 
          ${gdal_apps_DIR}/*.cpp 
          ${gdal_apps_DIR}/*.h)

REMOVE(gdal_apps_SRCS "${gdal_apps_DIR}/commonutils.h" 
                      "${gdal_apps_DIR}/commonutils.cpp")
#==============================================================================#
#List out all files that will not be used for building apps
#==============================================================================#
# SET(FILES_NOT_USED
    # gdalbuildvrt.cpp
    # gdaltindex 
# )

FOREACH(fileName ${gdal_apps_SRCS})
  GET_FILENAME_COMPONENT(AppName "${fileName}" NAME_WE)
  ADD_EXECUTABLE(${AppName} ${fileName} ${gdal_apps_DIR}/commonutils.cpp)
  TARGET_LINK_LIBRARIES(${AppName} GDal_${VERSION_MAJOR}_${VERSION_MINOR}_${VERSION_PATCH})
ENDFOREACH()