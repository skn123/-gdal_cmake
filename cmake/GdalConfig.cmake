# TODO:
# STDC_HEADERS TODO
# HAVE_GCC_ATOMIC_BUILTINS TODO
# VSI_LARGE_API_SUPPORTED TODO
# VSI_NEED_LARGEFILE64_SOURCE TODO
# -----------------------------------------------------------------------------

include(CheckFunctionExists)
include(CheckIncludeFile)
include(CheckSymbolExists)
include(CheckTypeSize)
include(TestBigEndian)

test_big_endian(BIG_ENDIAN)

# Check includes
# -----------------------------------------------------------------------------

check_include_file(csf.h HAVE_CSF_H)
check_include_file(dbmalloc.h HAVE_DBMALLOC_H)
check_include_file(dlfcn.h HAVE_DLFCN_H)
check_include_file(direct.h HAVE_DIRECT_H)
check_include_file(errno.h HAVE_ERRNO_H)
check_include_file(fcntl.h HAVE_FCNTL_H)
check_include_file(float.h HAVE_FLOAT_H)
check_include_file(inttypes.h HAVE_INTTYPES_H)
check_include_file(limits.h HAVE_LIMITS_H)
check_include_file(locale.h HAVE_LOCALE_H)
check_include_file(memory.h HAVE_MEMORY_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(stdlib.h HAVE_STDLIB_H)
check_include_file(string.h HAVE_STRING_H)
check_include_file(strings.h HAVE_STRINGS_H)
check_include_file(sys/stat.h HAVE_SYS_STAT_H)
check_include_file(sys/types.h HAVE_SYS_TYPES_H)
check_include_file(unistd.h HAVE_UNISTD_H)
check_include_file(values.h HAVE_VALUES_H)
check_include_file(windows.h HAVE_WINDOWS_H)

# TODO: use dependencies
check_include_file(jpeglib.h HAVE_JPEGLIB_H)
check_include_file(png.h HAVE_PNG_H)

# Check functions and macros
# -----------------------------------------------------------------------------

check_function_exists(atoll HAVE_ATOLL)
check_function_exists(fseek64 UNIX_STDIO_64)
check_function_exists(getcwd HAVE_GETCWD)
check_function_exists(snprintf HAVE_SNPRINTF)
check_function_exists(strtof HAVE_DECL_STRTOF)
check_function_exists(strtof HAVE_STRTOF)
check_function_exists(vprintf HAVE_VPRINTF)
check_function_exists(vsnprintf HAVE_VSNPRINTF)
check_function_exists(localtime_r HAVE_LOCALTIME_R)

#check_function_exists(_doprnt.HAVE_DOPRNT)

# Check types
# -----------------------------------------------------------------------------

# LT_OBJDIR
check_type_size("int" SIZEOF_INT)
check_type_size("long" SIZEOF_LONG)
check_type_size("unsigned long" SIZEOF_UNSIGNED_LONG)
check_type_size("void*" SIZEOF_VOIDP)
check_type_size("long long" HAVE_LONG_LONG)

# Find standard and system libraries
# -----------------------------------------------------------------------------

find_library(HAVE_LIBDL NAMES dl)
find_library(HAVE_LIBM NAMES m)
find_library(HAVE_LIBRT NAMES rt)

# Generate configuration files
# -----------------------------------------------------------------------------

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/port/cpl_config.h.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/port/cpl_config.h)

set(INSTALL_HEADERS ${INSTALL_HEADERS}
    ${CMAKE_CURRENT_BINARY_DIR}/port/cpl_config.h)
