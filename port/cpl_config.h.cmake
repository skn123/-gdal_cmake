/* Define to 1 if you have the <direct.h> header file. */
#cmakedefine HAVE_DIRECT_H

#cmakedefine HAVE_WINDOWS_H

#ifdef HAVE_WINDOWS_H

#ifndef CPL_DISABLE_STDCALL
#  define CPL_STDCALL __stdcall
#endif

/* Define if you have the vprintf function.  */
#if (_MSC_VER < 1500)
#  define vsnprintf _vsnprintf
#endif
#  define snprintf _snprintf

#ifndef getcwd
# ifdef HAVE_DIRECT_H
  # include <direct.h>
  # define getcwd _getcwd
# endif
#endif

#define HAVE_SEARCH_H 1

#undef HAVE_LIBDBMALLOC

#define lfind _lfind

#if (_MSC_VER < 1310)
#  define VSI_STAT64 _stat
#  define VSI_STAT64_T _stat
#else
#  define VSI_STAT64 _stat64
#  define VSI_STAT64_T __stat64
#endif

/* VC6 doesn't known intptr_t */
#if (_MSC_VER <= 1200)
    typedef int intptr_t;
#endif

/* */
#pragma warning(disable: 4786)

/* Silence deprecated warnings. */
#pragma warning(disable: 4996)

/* Silence data type conversion warnings. */
#pragma warning(disable: 4224)

/* #define CPL_DISABLE_DLL */

#else

  /* Define to name of 64bit stat function */
# define VSI_STAT64 stat64

  /* Define to name of 64bit stat structure */
# define VSI_STAT64_T stat64

#endif /* HAVE_WINDOWS_H */

/* Define to 1 if you have the `localtime_r' function. */
#cmakedefine HAVE_LOCALTIME_R 1

/* Define to 1 if you have the <assert.h> header file. */
#cmakedefine HAVE_ASSERT_H 1

/* Define if you have the <stdlib.h> header file.  */
#cmakedefine HAVE_STDLIB_H 1

/* Define to 1 if you have the `atoll' function. */
#cmakedefine HAVE_ATOLL 1

/* Define to 1 if you have the <csf.h> header file. */
/* #undef HAVE_CSF_H */

/* Define to 1 if you have the <dbmalloc.h> header file. */
/* #undef HAVE_DBMALLOC_H */

/* Define to 1 if you have the declaration of `strtof', and to 0 if you don't.
   */
#cmakedefine HAVE_DECL_STRTOF 0

/* Define to 1 if you have the <dlfcn.h> header file. */
#cmakedefine HAVE_DLFCN_H 1

/* Define to 1 if you don't have `vprintf' but do have `_doprnt.' */
/* #undef HAVE_DOPRNT */

/* Define to 1 if you have the <errno.h> header file. */
#cmakedefine HAVE_ERRNO_H 1

/* Define to 1 if you have the <fcntl.h> header file. */
#cmakedefine HAVE_FCNTL_H 1

/* Define to 1 if you have the <float.h> header file. */
#cmakedefine HAVE_FLOAT_H 1

/* Define to 1 if you have the `getcwd' function. */
#cmakedefine HAVE_GETCWD 1

/* Define as 0 or 1 according to the floating point format suported by the
   machine */
#define HAVE_IEEEFP 1

/* Define to 1 if the system has the type `int16'. */
/* #undef HAVE_INT16 */

/* Define to 1 if the system has the type `int32'. */
/* #undef HAVE_INT32 */

/* Define to 1 if the system has the type `int8'. */
/* #undef HAVE_INT8 */

/* Define to 1 if you have the <inttypes.h> header file. */
#cmakedefine HAVE_INTTYPES_H 1

/* Define to 1 if you have the <jpeglib.h> header file. */
#cmakedefine HAVE_JPEGLIB_H 1

/* Define to 1 if you have the `dl' library (-ldl). */
#cmakedefine HAVE_LIBDL 1

/* Define to 1 if you have the `m' library (-lm). */
#cmakedefine HAVE_LIBM 1

/* Define to 1 if you have the `pq' library (-lpq). */
#cmakedefine HAVE_LIBPQ 1

/* Define to 1 if you have the `rt' library (-lrt). */
#cmakedefine HAVE_LIBRT 1

/* Define to 1 if you have the <limits.h> header file. */
#cmakedefine HAVE_LIMITS_H 1

/* Define to 1 if you have the <locale.h> header file. */
#cmakedefine HAVE_LOCALE_H 1

/* Define to 1, if your compiler supports long long data type */
#cmakedefine HAVE_LONG_LONG 1

/* Define to 1 if you have the <memory.h> header file. */
#cmakedefine HAVE_MEMORY_H 1

/* Define to 1 if you have the <png.h> header file. */
#cmakedefine HAVE_PNG_H 1

/* Define to 1 if you have the `snprintf' function. */
#cmakedefine HAVE_SNPRINTF 1

/* Define to 1 if you have the <stdint.h> header file. */
#cmakedefine HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#cmakedefine HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#cmakedefine HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#cmakedefine HAVE_STRING_H 1

/* Define to 1 if you have the `strtof' function. */
#cmakedefine HAVE_STRTOF 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#cmakedefine HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#cmakedefine HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#cmakedefine HAVE_UNISTD_H 1

/* Define to 1 if you have the <values.h> header file. */
#cmakedefine HAVE_VALUES_H 1

/* Define to 1 if you have the `vprintf' function. */
#cmakedefine HAVE_VPRINTF 1

/* Define to 1 if you have the `vsnprintf' function. */
#cmakedefine HAVE_VSNPRINTF 1

/* Set the native cpu bit order (FILLORDER_LSB2MSB or FILLORDER_MSB2LSB) */
#cmakedefine BIG_ENDIAN
#ifdef BIG_ENDIAN
# define HOST_FILLORDER FILLORDER_MSB2LSB
#else
# define HOST_FILLORDER FILLORDER_LSB2MSB
#endif

/* Define to the sub-directory in which libtool stores uninstalled libraries.
   */
#cmakedefine LT_OBJDIR ".libs/"

/* Define for Mac OSX Framework build */
/* #undef MACOSX_FRAMEWORK */

/* The size of `int', as computed by sizeof. */
#cmakedefine SIZEOF_INT 4

/* The size of `long', as computed by sizeof. */
#cmakedefine SIZEOF_LONG 8

/* The size of `unsigned long', as computed by sizeof. */
#cmakedefine SIZEOF_UNSIGNED_LONG 8

/* The size of `void*', as computed by sizeof. */
#cmakedefine SIZEOF_VOIDP 8

/* Define to 1 if you have the ANSI C header files. */
#cmakedefine STDC_HEADERS 1

/* Define to 1 if you have fseek64, ftell64 */
#cmakedefine UNIX_STDIO_64 1

/* Define to 1 if you want to use the -fvisibility GCC flag */
/* #undef USE_GCC_VISIBILITY_FLAG */

/* Define to 1 if GCC atomic builtins are available */
#cmakedefine HAVE_GCC_ATOMIC_BUILTINS 1

/* Only if we are on unix systems with 64bit stdio */
#ifdef UNIX_STDIO_64
/* Define to name of 64bit fopen function */
# define VSI_FOPEN64 fopen64

/* Define to name of 64bit fseek func */
# define VSI_FSEEK64 fseeko64

/* Define to name of 64bit ftell func */
# define VSI_FTELL64 ftello64
#endif

/* Define to 1, if you have 64 bit STDIO API */
#cmakedefine VSI_LARGE_API_SUPPORTED 1

/* Define to 1, if you have LARGEFILE64_SOURCE */
/* #undef VSI_NEED_LARGEFILE64_SOURCE */

/* Define to 1 if your processor stores words with the most significant byte
   first (like Motorola and SPARC, unlike Intel and VAX). */
/* #undef WORDS_BIGENDIAN */

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
#ifndef __cplusplus
#  ifndef inline
#    define inline __inline
#  endif
#endif
