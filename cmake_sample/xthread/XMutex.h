#pragma once
#include <xthread/XThread.h>

class XMutexImpl;
class XTHREAD_API XMutex
{
public:
    XMutex();
    ~XMutex();

    void lock();     
    bool tryLock();  
    bool tryLock(int timeout);
    void unlock();

    bool locked();
    
private:
    X_DISABLE_COPY(XMutex);
    XMutexImpl* _impl;
};
