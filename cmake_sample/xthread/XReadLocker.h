#pragma once
#include <xthread/XThread.h>

class XReadWriteLock;
class XTHREAD_API XReadLocker
{
public:
    XReadLocker(XReadWriteLock*);
    ~XReadLocker();

    void unlock();

    void relock(); 

    inline XReadWriteLock *readWriteLock() const;

private:
    X_DISABLE_COPY(XReadLocker);
    XReadWriteLock* _lock;
};