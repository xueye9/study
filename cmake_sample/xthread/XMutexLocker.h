#pragma once
#include <xthread/XThread.h>

class XMutex;
class XMutexLockerImpl;
class XTHREAD_API XMutexLocker
{
public:
    explicit XMutexLocker(XMutex *);
    ~XMutexLocker();

    void unlock();
    void relock();
    XMutex *mutex();

private:
    X_DISABLE_COPY(XMutexLocker);

    XMutexLockerImpl* _impl;
};