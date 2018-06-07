#include "XWriteLocker.h"
#include "XReadWriteLock.h"

XWriteLocker::XWriteLocker(XReadWriteLock *readWriteLock)
{
    _lock = readWriteLock;

    _lock->lockForWrite();
}

XWriteLocker::~XWriteLocker()
{
    unlock();
}

void XWriteLocker::unlock()
{
    _lock->unlock();
}

void XWriteLocker::relock()
{
    if (_lock)
    {
        _lock->lockForWrite();
    }
}

XReadWriteLock * XWriteLocker::readWriteLock() const
{
    return _lock;
}

