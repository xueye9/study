#pragma once
#include <xthread/XThread.h>

class XReadWriteLockImpl;
class XTHREAD_API XReadWriteLock
{
public:
    XReadWriteLock();
    ~XReadWriteLock();

    void lockForRead();
    bool tryLockForRead();
    bool tryLockForRead(int timeout);// s

    void lockForWrite();
    bool tryLockForWrite();
    bool tryLockForWrite(int timeout);

    void unlock();

private:
    XReadWriteLockImpl* _impl;

    X_DISABLE_COPY(XReadWriteLock);
};

