#include <iostream>

#include <xlog/easylogging++.h>

#include <xlog/config.h> 

SHARE_EASYLOGGINGPP( xlog::Config::instance().sharedLoggingRepository() )

int main( int argc, char* argv[] )
{
    START_EASYLOGGINGPP( argc, argv );

    xlog::Config::instance().load( "D:/workspace/test/test/conf/log.xml", "D:/workspace/test/test/conf/log.conf" );

    /// 注册回调函数  
    //el::Helpers::installPreRollOutCallback( rolloutHandler );

    //OneTestClass c1;
    xlog::Config::instance().testEasyLog();

    // CLOG( ERROR, "performance" ) << "This is info log using performance logger";
    CLOG( ERROR, "test" ) << "This is info log using test logger";
    CLOG( ERROR, "xdata" ) << "This is info log using xdata logger";

    el::Loggers::flushAll();

    getchar();
    return 0;
}