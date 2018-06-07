#include "xmutex.h"
#include <pthread.h>

class XMutexImpl
{ 
public:
    pthread_mutex_t m_mx;
};

XMutex::XMutex()
{
    _impl = new XMutexImpl();

    pthread_mutex_init(&_impl->m_mx, nullptr);
}

XMutex::~XMutex()
{ 
    if (_impl)
    { 
        pthread_mutex_destroy(&_impl->m_mx);
        delete _impl;
        _impl = nullptr;
    }
}

void XMutex::lock()
{
    pthread_mutex_lock(&_impl->m_mx);
}

bool XMutex::tryLock()
{
    if (0 == pthread_mutex_trylock(&_impl->m_mx))
    {
        return true;
    }

    return false;
}

bool XMutex::tryLock(int timeout)
{
    struct timespec tm;
    tm.tv_sec = timeout;
    tm.tv_nsec = 0;
    if (0 == pthread_mutex_timedlock(&_impl->m_mx, &tm))
    {
        return true;
    }

    return false;
}

void XMutex::unlock()
{
    pthread_mutex_unlock(&_impl->m_mx);
}

bool XMutex::locked()
{
    if (!tryLock())
        return true;
    unlock();
    return false;
}

