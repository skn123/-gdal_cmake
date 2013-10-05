set(PORT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(HDRS
  ${PORT_DIR}/cpl_conv.h
  ${PORT_DIR}/cpl_csv.h
  ${PORT_DIR}/cpl_error.h
  ${PORT_DIR}/cpl_hash_set.h
  ${PORT_DIR}/cpl_http.h
  ${PORT_DIR}/cpl_list.h
  ${PORT_DIR}/cpl_minixml.h
  ${PORT_DIR}/cpl_multiproc.h
  ${PORT_DIR}/cpl_port.h
  ${PORT_DIR}/cpl_quad_tree.h
  ${PORT_DIR}/cpl_string.h
  ${PORT_DIR}/cpl_vsi.h
  ${PORT_DIR}/cpl_vsi_virtual.h
  ${PORT_DIR}/cplkeywordparser.h)

set(SRCS
  ${PORT_DIR}/cpl_conv.cpp
  ${PORT_DIR}/cpl_csv.cpp
  ${PORT_DIR}/cpl_error.cpp
  ${PORT_DIR}/cpl_findfile.cpp
  ${PORT_DIR}/cpl_getexecpath.cpp
  ${PORT_DIR}/cpl_hash_set.cpp
  ${PORT_DIR}/cpl_http.cpp
  ${PORT_DIR}/cpl_list.cpp
  ${PORT_DIR}/cpl_minixml.cpp
  ${PORT_DIR}/cpl_multiproc.cpp
  ${PORT_DIR}/cpl_path.cpp
  ${PORT_DIR}/cpl_quad_tree.cpp
  ${PORT_DIR}/cpl_recode_stub.cpp
  ${PORT_DIR}/cpl_strtod.cpp
  ${PORT_DIR}/cpl_string.cpp
  ${PORT_DIR}/cpl_vsi_mem.cpp
  ${PORT_DIR}/cpl_vsil.cpp
  ${PORT_DIR}/cpl_vsil_abstract_archive.cpp
  ${PORT_DIR}/cpl_vsil_buffered_reader.cpp
  ${PORT_DIR}/cpl_vsisimple.cpp
  ${PORT_DIR}/cpl_vsil_sparsefile.cpp
  ${PORT_DIR}/cpl_vsil_subfile.cpp
  ${PORT_DIR}/cpl_vsil_tar.cpp
  ${PORT_DIR}/cpl_vsil_stdin.cpp
  ${PORT_DIR}/cpl_vsil_stdout.cpp
  ${PORT_DIR}/cplgetsymbol.cpp
  ${PORT_DIR}/cplkeywordparser.cpp
  ${PORT_DIR}/cplstring.cpp
  ${PORT_DIR}/cpl_atomic_ops.cpp
  ${PORT_DIR}/cpl_time.cpp
)

if(UNIX)
  list(APPEND SRCS ${PORT_DIR}/cpl_vsil_unix_stdio_64.cpp)
elseif(WIN32)
  list(APPEND SRCS ${PORT_DIR}/cpl_vsil_win32.cpp)
endif()

if(ODBC_FOUND)
  list(APPEND HDRS ${PORT_DIR}/cpl_odbc.h)
  list(APPEND SRCS ${PORT_DIR}/cpl_odbc.cpp)
endif()

if(ZLIB_FOUND)
  list(APPEND HDRS
    ${PORT_DIR}/cpl_minizip_ioapi.h
    ${PORT_DIR}/cpl_minizip_unzip.h)
  list(APPEND SRCS
    ${PORT_DIR}/cpl_minizip_ioapi.cpp
    ${PORT_DIR}/cpl_minizip_unzip.cpp
    ${PORT_DIR}/cpl_vsil_gzip.cpp)
endif()

gdal_add_module(port
  HEADERS ${HDRS}
  SOURCES ${SRCS})
