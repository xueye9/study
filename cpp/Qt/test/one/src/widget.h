#pragma once
#include <QWidget>
#include "ui_t_one.h"

class Widget: public QWidget
{
public:
    Widget( QWidget* parent = nullptr, Qt::WindowFlags f = Qt::WindowFlags() );
    ~Widget();

private:
    Ui::Form _ui; 
};

