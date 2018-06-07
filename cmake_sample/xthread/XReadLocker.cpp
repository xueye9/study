#include "XReadLocker.h"
#include "XReadWriteLock.h"

XReadLocker::XReadLocker(XReadWriteLock* p)
{
    _lock = p;
    _lock->lockForRead();
}

XReadLocker::~XReadLocker()
{
    unlock();
}

void XReadLocker::unlock()
{
    _lock->unlock();
}

void XReadLocker::relock()
{
    if (_lock) 
    {
        _lock->lockForRead();
    }
}

XReadWriteLock * XReadLocker::readWriteLock() const
{
    return _lock;
}

