﻿/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/


#include <QtWidgets>

#include "mainwindow.h"
#include "thread.h"
#include <iostream>

MainWindow::MainWindow()
    : textEdit( new QPlainTextEdit )
{
    setCentralWidget( textEdit );

    createActions();
    createStatusBar();

    readSettings();

    connect( textEdit->document(), &QTextDocument::contentsChanged,
        this, &MainWindow::documentWasModified );

#ifndef QT_NO_SESSIONMANAGER
    QGuiApplication::setFallbackSessionManagementEnabled( false );
    connect( qApp, &QGuiApplication::commitDataRequest,
        this, &MainWindow::commitData );
#endif

    setCurrentFile( QString() );
    setUnifiedTitleAndToolBarOnMac( true );
}

void MainWindow::closeEvent( QCloseEvent *event )
{
    if (maybeSave()) {
        writeSettings();
        event->accept();
    }
    else {
        event->ignore();
    }
}


void MainWindow::keyPressEvent( QKeyEvent *ev )
{
    quint32 i = QRandomGenerator::global()->bounded( 3 );
    std::cout << i << std::endl;
    m_vecThreads[i]->keyPressEvent( ev ); 
}

//bool MainWindow::event( QEvent *e)
//{
//        return QMainWindow::event( e );
//}

void MainWindow::newFile()
{ 
    if (m_vecThreads.empty())
    { 
        Thread* t1 = new Thread( this );
        t1->m_n = 0;
        Thread* t2 = new Thread( this );
        t2->m_n = 1000;
        Thread* t3 = new Thread( this );
        t3->m_n = 10000;

        std::cout << (long long)(t1) << std::endl;
        std::cout << (long long)(t2) << std::endl;
        std::cout << (long long)(t3) << std::endl;

        m_vecThreads.append( t1 );
        m_vecThreads.append( t2 );
        m_vecThreads.append( t3 );

        t1->start();
        t2->start();
        t3->start();
        
    }

    if (maybeSave()) {
        textEdit->clear();
        setCurrentFile( QString() );
    }
}

void MainWindow::open()
{
    if (maybeSave()) {
        QString fileName = QFileDialog::getOpenFileName( this );
        if (!fileName.isEmpty())
            loadFile( fileName );
    }
}

bool MainWindow::save()
{
    if (curFile.isEmpty()) {
        return saveAs();
    }
    else {
        return saveFile( curFile );
    }
}

bool MainWindow::saveAs()
{
    QFileDialog dialog( this );
    dialog.setWindowModality( Qt::WindowModal );
    dialog.setAcceptMode( QFileDialog::AcceptSave );
    if (dialog.exec() != QDialog::Accepted)
        return false;
    return saveFile( dialog.selectedFiles().first() );
}

void MainWindow::about()
{
    QMessageBox::about( this, tr( "About Application" ),
        tr( "The <b>Application</b> example demonstrates how to "
            "write modern GUI applications using Qt, with a menu bar, "
            "toolbars, and a status bar." ) );
}

void MainWindow::documentWasModified()
{
    setWindowModified( textEdit->document()->isModified() );
}

void MainWindow::createActions()
{

    QMenu *fileMenu = menuBar()->addMenu( tr( "&File" ) );
    QToolBar *fileToolBar = addToolBar( tr( "File" ) );
    const QIcon newIcon = QIcon::fromTheme( "document-new", QIcon( ":/images/new.png" ) );
    QAction *newAct = new QAction( newIcon, tr( "&New" ), this );
    newAct->setShortcuts( QKeySequence::New );
    newAct->setStatusTip( tr( "Create a new file" ) );
    connect( newAct, &QAction::triggered, this, &MainWindow::newFile );
    fileMenu->addAction( newAct );
    fileToolBar->addAction( newAct );

    const QIcon openIcon = QIcon::fromTheme( "document-open", QIcon( ":/images/open.png" ) );
    QAction *openAct = new QAction( openIcon, tr( "&Open..." ), this );
    openAct->setShortcuts( QKeySequence::Open );
    openAct->setStatusTip( tr( "Open an existing file" ) );
    connect( openAct, &QAction::triggered, this, &MainWindow::open );
    fileMenu->addAction( openAct );
    fileToolBar->addAction( openAct );

    const QIcon saveIcon = QIcon::fromTheme( "document-save", QIcon( ":/images/save.png" ) );
    QAction *saveAct = new QAction( saveIcon, tr( "&Save" ), this );
    saveAct->setShortcuts( QKeySequence::Save );
    saveAct->setStatusTip( tr( "Save the document to disk" ) );
    connect( saveAct, &QAction::triggered, this, &MainWindow::save );
    fileMenu->addAction( saveAct );
    fileToolBar->addAction( saveAct );

    const QIcon saveAsIcon = QIcon::fromTheme( "document-save-as" );
    QAction *saveAsAct = fileMenu->addAction( saveAsIcon, tr( "Save &As..." ), this, &MainWindow::saveAs );
    saveAsAct->setShortcuts( QKeySequence::SaveAs );
    saveAsAct->setStatusTip( tr( "Save the document under a new name" ) );


    fileMenu->addSeparator();

    const QIcon exitIcon = QIcon::fromTheme( "application-exit" );
    QAction *exitAct = fileMenu->addAction( exitIcon, tr( "E&xit" ), this, &QWidget::close );
    exitAct->setShortcuts( QKeySequence::Quit );
    exitAct->setStatusTip( tr( "Exit the application" ) );

    QMenu *editMenu = menuBar()->addMenu( tr( "&Edit" ) );
    QToolBar *editToolBar = addToolBar( tr( "Edit" ) );
#ifndef QT_NO_CLIPBOARD
    const QIcon cutIcon = QIcon::fromTheme( "edit-cut", QIcon( ":/images/cut.png" ) );
    QAction *cutAct = new QAction( cutIcon, tr( "Cu&t" ), this );
    cutAct->setShortcuts( QKeySequence::Cut );
    cutAct->setStatusTip( tr( "Cut the current selection's contents to the "
        "clipboard" ) );
    connect( cutAct, &QAction::triggered, textEdit, &QPlainTextEdit::cut );
    editMenu->addAction( cutAct );
    editToolBar->addAction( cutAct );

    const QIcon copyIcon = QIcon::fromTheme( "edit-copy", QIcon( ":/images/copy.png" ) );
    QAction *copyAct = new QAction( copyIcon, tr( "&Copy" ), this );
    copyAct->setShortcuts( QKeySequence::Copy );
    copyAct->setStatusTip( tr( "Copy the current selection's contents to the "
        "clipboard" ) );
    connect( copyAct, &QAction::triggered, textEdit, &QPlainTextEdit::copy );
    editMenu->addAction( copyAct );
    editToolBar->addAction( copyAct );

    const QIcon pasteIcon = QIcon::fromTheme( "edit-paste", QIcon( ":/images/paste.png" ) );
    QAction *pasteAct = new QAction( pasteIcon, tr( "&Paste" ), this );
    pasteAct->setShortcuts( QKeySequence::Paste );
    pasteAct->setStatusTip( tr( "Paste the clipboard's contents into the current "
        "selection" ) );
    connect( pasteAct, &QAction::triggered, textEdit, &QPlainTextEdit::paste );
    editMenu->addAction( pasteAct );
    editToolBar->addAction( pasteAct );

    menuBar()->addSeparator();

#endif // !QT_NO_CLIPBOARD

    QMenu *helpMenu = menuBar()->addMenu( tr( "&Help" ) );
    QAction *aboutAct = helpMenu->addAction( tr( "&About" ), this, &MainWindow::about );
    aboutAct->setStatusTip( tr( "Show the application's About box" ) );


    QAction *aboutQtAct = helpMenu->addAction( tr( "About &Qt" ), qApp, &QApplication::aboutQt );
    aboutQtAct->setStatusTip( tr( "Show the Qt library's About box" ) );

#ifndef QT_NO_CLIPBOARD
    cutAct->setEnabled( false );
    copyAct->setEnabled( false );
    connect( textEdit, &QPlainTextEdit::copyAvailable, cutAct, &QAction::setEnabled );
    connect( textEdit, &QPlainTextEdit::copyAvailable, copyAct, &QAction::setEnabled );
#endif // !QT_NO_CLIPBOARD
}

void MainWindow::createStatusBar()
{
    statusBar()->showMessage( tr( "Ready" ) );
}

void MainWindow::readSettings()
{
    QSettings settings( QCoreApplication::organizationName(), QCoreApplication::applicationName() );
    const QByteArray geometry = settings.value( "geometry", QByteArray() ).toByteArray();
    if (geometry.isEmpty()) {
        const QRect availableGeometry = QApplication::desktop()->availableGeometry( this );
        resize( availableGeometry.width() / 3, availableGeometry.height() / 2 );
        move( (availableGeometry.width() - width()) / 2,
            (availableGeometry.height() - height()) / 2 );
    }
    else {
        restoreGeometry( geometry );
    }
}

void MainWindow::writeSettings()
{
    QSettings settings( QCoreApplication::organizationName(), QCoreApplication::applicationName() );
    settings.setValue( "geometry", saveGeometry() );
}

bool MainWindow::maybeSave()
{
    if (!textEdit->document()->isModified())
        return true;
    const QMessageBox::StandardButton ret
        = QMessageBox::warning( this, tr( "Application" ),
            tr( "The document has been modified.\n"
                "Do you want to save your changes?" ),
            QMessageBox::Save | QMessageBox::Discard | QMessageBox::Cancel );
    switch (ret) {
    case QMessageBox::Save:
        return save();
    case QMessageBox::Cancel:
        return false;
    default:
        break;
    }
    return true;
}

void MainWindow::loadFile( const QString &fileName )
{
    QFile file( fileName );
    if (!file.open( QFile::ReadOnly | QFile::Text )) {
        QMessageBox::warning( this, tr( "Application" ),
            tr( "Cannot read file %1:\n%2." )
            .arg( QDir::toNativeSeparators( fileName ), file.errorString() ) );
        return;
    }

    QTextStream in( &file );
#ifndef QT_NO_CURSOR
    QApplication::setOverrideCursor( Qt::WaitCursor );
#endif
    textEdit->setPlainText( in.readAll() );
#ifndef QT_NO_CURSOR
    QApplication::restoreOverrideCursor();
#endif

    setCurrentFile( fileName );
    statusBar()->showMessage( tr( "File loaded" ), 2000 );
}

bool MainWindow::saveFile( const QString &fileName )
{
    QFile file( fileName );
    if (!file.open( QFile::WriteOnly | QFile::Text )) {
        QMessageBox::warning( this, tr( "Application" ),
            tr( "Cannot write file %1:\n%2." )
            .arg( QDir::toNativeSeparators( fileName ),
                file.errorString() ) );
        return false;
    }

    QTextStream out( &file );
#ifndef QT_NO_CURSOR
    QApplication::setOverrideCursor( Qt::WaitCursor );
#endif
    out << textEdit->toPlainText();
#ifndef QT_NO_CURSOR
    QApplication::restoreOverrideCursor();
#endif

    setCurrentFile( fileName );
    statusBar()->showMessage( tr( "File saved" ), 2000 );
    return true;
}

void MainWindow::setCurrentFile( const QString &fileName )
{
    curFile = fileName;
    textEdit->document()->setModified( false );
    setWindowModified( false );

    QString shownName = curFile;
    if (curFile.isEmpty())
        shownName = "untitled.txt";
    setWindowFilePath( shownName );
}

QString MainWindow::strippedName( const QString &fullFileName )
{
    return QFileInfo( fullFileName ).fileName();
}
#ifndef QT_NO_SESSIONMANAGER
void MainWindow::commitData( QSessionManager &manager )
{
    if (manager.allowsInteraction()) {
        if (!maybeSave())
            manager.cancel();
    }
    else {
        // Non-interactive: save without asking
        if (textEdit->document()->isModified())
            save();
    }
}
#endif