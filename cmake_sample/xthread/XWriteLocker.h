#pragma once
#include <xthread/XThread.h>

class XReadWriteLock;
class XTHREAD_API XWriteLocker
{
public:
    XWriteLocker(XReadWriteLock *readWriteLock); 
    ~XWriteLocker();
    

    void unlock();

    void relock();
    

    XReadWriteLock *readWriteLock() const; 

private:
    X_DISABLE_COPY(XWriteLocker);

    XReadWriteLock* _lock;
};