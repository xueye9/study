#include "thread.h"

#include <QEvent>
#include <QKeyEvent>

#include <QMutex>
#include <QMutexLocker>
#include <QWaitCondition>
#include <QRandomGenerator>

#include <iostream>

#include <windows.h>

QMutex g_mux;
QWaitCondition g_cond;
quint32 g_d = QRandomGenerator::global()->bounded(200);

Thread::Thread(QObject* parent):QThread(parent)
{
    //std::cout << g_d << std::endl;
    //std::cout << &g_d << std::endl; 
}

Thread::~Thread()
{
}

void Thread::keyPressEvent( QKeyEvent *ev )
{
    //long long id = (long long)QThread::currentThreadId();
    long long id = (long long)this;
    std::cout << "keypressevent-id:" << id
        << "    key:" << ev->text().toStdString() << std::endl;

    g_cond.wakeOne();
}

//bool Thread::event( QEvent* e )
//{ 
//    QEvent::Type t = e->type();
//    std::cout << (int)t << std::endl;
//    if (e->type() == QEvent::KeyPress) 
//    {
//        // overwrite handling of PolishRequest if any
//
//        QKeyEvent* ke = (QKeyEvent*)e;
//        //g_cond.wakeAll();
//
//        return QThread::event( e );
//    }
//
//    return QThread::event( e );
//}

void Thread::run()
{
    while (true)
    {
        QMutexLocker locker( &g_mux );
        g_cond.wait( &g_mux );

        //long long id = (long long)QThread::currentThreadId();
        long long id = (long long)this;

        std::cout << "run-current_thread_id:" << id << "  count" <<
            m_n << std::endl;

        Sleep( 2000 );
    }
}
