#pragma once 
#include <QThread>

class QEvent;
class QKeyEvent;
class Thread:public QThread
{
    Q_OBJECT
public:
    Thread(QObject* parent = nullptr);
    ~Thread();

    //bool event( QEvent* e );

    void keyPressEvent( QKeyEvent *ev );

    int m_n;
protected:
    void run();


private:

};

