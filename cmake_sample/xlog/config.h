#pragma once
#include <xlog/easylogging++.h>
#include <xlog/export.h>

#include <string>

namespace xlog
{ 
    class XLOG_API Config
    {
    public:
        ~Config();

        static Config& instance();

        void testEasyLog();

        //************************************
        // Method:    load
        // FullName:  OneTestClass::load
        // Access:    public 
        // Returns:   void
        // Qualifier:
        // Parameter: const std::string & confFile          扩展el日志文件,目前只实现了多个loger的
        // Parameter: const std::string & elConfigFile
        //************************************
        void load( const std::string& confFile, const std::string& elConfigFile );

        el::base::type::StoragePointer sharedLoggingRepository();

    private:
        void _loadConfFile( const char* logConfigFilePath );
        std::vector<std::string> _loadLoggers( void* ptr );

        Config ();
    };
}

