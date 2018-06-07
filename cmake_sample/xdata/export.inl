#ifndef XDATA_EXPORT_INL_
#define XDATA_EXPORT_INL_

#ifndef XDATA_API 
  #if defined(_MSC_VER)
    #ifdef XDATA_EXPORT
      #define XDATA_API __declspec(dllexport)
    #else
      #define XDATA_API __declspec(dllimport) 
	    #pragma comment(lib, "xdata.lib") 
      #pragma message("Automatically linking with xdata.dll")
    #endif
  #elif(__GNUC__) 
    //#if defined(USE_GCC_VISIBILITY_FLAG)
      #define XDATA_API __attribute__((visibility("default")))
      //#pragma message(__GNUC__)
    //#else
      //#define XDATA_API
      //#pragma message("__GNUC__")
      //#pragma message("ttt")
    //#endif 
  #endif
#endif

// 屏蔽警告
#ifdef _MSC_VER
#pragma warning(disable:4251 4275)
#endif // _MSC_VER

#endif	// #XDATA_EXPORT_INL_
