#pragma once

#include <QCoreApplication>
#include <QVector>

class Application:public QCoreApplication
{
public:
    Application(int , char** ,int = ApplicationFlags );
    ~Application();

    bool notify( QObject *, QEvent * );

    QVector<QObject*> m_vecObjs;
};

