#include "XReadWriteLock.h"
#include <pthread.h>

class XReadWriteLockImpl
{
public:
    pthread_rwlock_t m_rwLock;
};

XReadWriteLock::XReadWriteLock()
{
    _impl = new XReadWriteLockImpl();

    pthread_rwlock_init(&_impl->m_rwLock, nullptr);
}

XReadWriteLock::~XReadWriteLock()
{
    if (_impl)
    {
        pthread_rwlock_destroy(&_impl->m_rwLock);
        delete _impl;
        _impl = nullptr;
    }
}

void XReadWriteLock::lockForRead()
{
    pthread_rwlock_rdlock(&_impl->m_rwLock);    //¶ÁÕß¼Ó¶ÁËø  
}

bool XReadWriteLock::tryLockForRead()
{
    if (0 == pthread_rwlock_tryrdlock(&_impl->m_rwLock))
        return true;

    return false;
}

bool XReadWriteLock::tryLockForRead(int timeout)
{
    struct timespec ts;
    ts.tv_sec = timeout;
    ts.tv_nsec = 0;
    if (0 == pthread_rwlock_timedrdlock(&_impl->m_rwLock, &ts))
    {
        return true;
    }

    return false;
}

void XReadWriteLock::lockForWrite()
{
    pthread_rwlock_wrlock(&_impl->m_rwLock);
}

bool XReadWriteLock::tryLockForWrite()
{
    if (0 == pthread_rwlock_trywrlock(&_impl->m_rwLock))
        return true;

    return false; 
}

bool XReadWriteLock::tryLockForWrite(int timeout)
{ 
    struct timespec ts;
    ts.tv_sec = timeout;
    ts.tv_nsec = 0;
    if (0 == pthread_rwlock_timedwrlock(&_impl->m_rwLock, &ts))
    {
        return true;
    }

    return false;
}

void XReadWriteLock::unlock()
{
    pthread_rwlock_unlock(&_impl->m_rwLock); 
}

