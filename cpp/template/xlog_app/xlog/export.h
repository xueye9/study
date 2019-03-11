#pragma once

#if defined(_MSC_VER) || defined(__CYGWIN__) || defined(__MINGW32__) || \
    defined( __BCPLUSPLUS__)  || defined( __MWERKS__)

#  if defined(xlog_EXPORTS)
#    define XLOG_API   __declspec(dllexport)
#  elif defined(xlog_IMPORTS)
#    define XLOG_API   __declspec(dllimport)
#  else
#    define XLOG_API
#  endif
#else
#  define XLOG_API
#endif
