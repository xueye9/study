#include "XMutexLocker.h"
#include "XMutex.h"


class XMutexLockerImpl
{
public:
    XMutexLockerImpl() :m_mutex(nullptr) {};

    XMutex* m_mutex;
};

XMutexLocker::XMutexLocker(XMutex *p)
{
    _impl = new XMutexLockerImpl();

    _impl->m_mutex = p; 
    _impl->m_mutex->lock();
}

XMutexLocker::~XMutexLocker()
{
    if (_impl)
    {
        _impl->m_mutex->unlock();
        delete _impl;
    }
}

void XMutexLocker::unlock()
{
    _impl->m_mutex->unlock();
}

void XMutexLocker::relock()
{
    _impl->m_mutex->lock();
}

XMutex * XMutexLocker::mutex()
{
    return _impl->m_mutex;
}


