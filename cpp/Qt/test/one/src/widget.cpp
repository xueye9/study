#include "widget.h"

Widget::Widget( QWidget* parent /*= nullptr*/, Qt::WindowFlags f /*= Qt::WindowFlags() */ )  :
    QWidget(parent, f)
{
    _ui.setupUi( this );
}

Widget::~Widget()
{
}
