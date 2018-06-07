#ifndef XPLUGIN_EXPORT_INL_
#define XPLUGIN_EXPORT_INL_

#ifndef XPLUGIN_API 
  #if defined(_MSC_VER)
    #ifdef XPLUGIN_EXPORT
      #define XPLUGIN_API __declspec(dllexport)
    #else
      #define XPLUGIN_API __declspec(dllimport) 
	    #pragma comment(lib, "xplugin.lib") 
      #pragma message("Automatically linking with xplugin.dll")
    #endif
  #elif(__GNUC__) 
    //#if defined(USE_GCC_VISIBILITY_FLAG)
      #define XPLUGIN_API __attribute__((visibility("default")))
      //#pragma message(__GNUC__)
    //#else
      //#define XPLUGIN_API
      //#pragma message("__GNUC__")
      //#pragma message("ttt")
    //#endif 
  #endif
#endif


// 屏蔽警告
#ifdef _MSC_VER
#pragma warning(disable:4251 4275)
#endif // _MSC_VER

#endif	// #XPLUGIN_EXPORT_INL_
