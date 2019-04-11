#pragma once

#ifndef XDATA_API 
  #if defined(_MSC_VER)
    #ifdef XDATA_EXPORT
      #define XDATA_API __declspec(dllexport)
    #else
      #define XDATA_API __declspec(dllimport) 
      // 使用cmake管理工程部再需要已代码的方式引入
	  //#pragma comment(lib, "xdata.lib") 
      //#pragma message("Automatically linking with xdata.dll")
    #endif
  #else
        // 在编译命令中加入 -fvisibility=hidden 参数后，会将所有默认的 public 属性变为hidden,如下声明会使编译命令失效
        // 一般情况下不声明如下命令即可
      #define XDATA_API __attribute__((visibility("default")))
      //#define XDATA_API
//#if __GNUC__ >= 4
//
//#define DLL_PUBLIC __attribute__ ((visibility("default")))
//
//#define DLL_LOCAL  __attribute__ ((visibility("hidden")))
//
//#else
//
//#define DLL_PUBLIC
//
//#define DLL_LOCAL 
//#endif

  #endif
#endif

// 屏蔽警告
#ifdef _MSC_VER
#pragma warning(disable:4251 4275)
#endif // _MSC_VER


// 返回非0值会终端传输
typedef int(*CALLCBACK_getTransferStatus)(long long dlTotal, long long dlNow, long long ulTotal, long long ulNow, long long lastSpend);
