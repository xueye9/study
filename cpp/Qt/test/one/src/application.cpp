#include "application.h"

Application::Application( int argc, char** argv, int flags/*= ApplicationFlags */ ):QCoreApplication(argc, argv, flags)
{

}

Application::~Application()
{
}

bool Application::notify( QObject * object, QEvent * e)
{
    for (QObject* o : m_vecObjs)
    {
        QCoreApplication::postEvent( o, e );
    }

    return QCoreApplication::notify( object, e );
}
