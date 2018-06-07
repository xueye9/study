#ifndef XTHREAD_EXPORT_H_
#define XTHREAD_EXORT_H_

#ifndef XTHREAD_API 
    #if defined(_MSC_VER)
        #ifdef XTHREAD_EXPORT
            #define XTHREAD_API __declspec(dllexport)
        #else
            #define XTHREAD_API __declspec(dllimport) 
        #endif
    #elif(__GNUC__) 
        #define XTHREAD_API __attribute__((visibility("default")))
    #endif
#endif

// ÆÁ±Î¾¯¸æ
#ifdef _MSC_VER
#pragma warning(disable:4251 4275)
#endif // _MSC_VER

#define X_DISABLE_COPY(Class) \
    Class(const Class &){}; \
    Class &operator=(const Class &){return *this;}

#endif	// #XTHREAD_EXPORT_H_
