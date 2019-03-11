#include "config.h"
#include <fstream>

#include "rapidxml.hpp"
#include "rapidxml_iterators.hpp"
#include "rapidxml_utils.hpp"

#include "easylogging++.h"

INITIALIZE_EASYLOGGINGPP

namespace xlog
{ 
    Config::Config()
    {

    }

    Config::~Config()
    {

    }

    Config& Config::instance()
    {
        static Config ins;
        return ins; 
    }

    void Config::testEasyLog()
    {
        LOG( INFO ) << "one module write easylog++ test";
    }


    void Config::load( const std::string& confFile, const std::string& elConfigFile )
    {
        std::ifstream ifs( elConfigFile, std::ios::binary );
        if (!ifs.is_open())
        {
            LOG( INFO ) << "can not open log config '" << elConfigFile << "'";
        }
        else
        {
            ifs.close();
            el::Configurations conf( elConfigFile );
            // Reconfigure single logger
            //el::Loggers::reconfigureLogger( "default", conf );
            // Actually reconfigure all loggers instead
            el::Loggers::reconfigureAllLoggers( conf );
        }

        ifs.open( confFile );
        if (!ifs.is_open())
        {
            LOG( INFO ) << "can not open log config '" << confFile << "'";
        }
        else
        {
            _loadConfFile( confFile.c_str() );
        }
    }

    void Config::_loadConfFile( const char* confFile )
    {
        rapidxml::file<> fdoc( confFile );
        rapidxml::xml_document<>   doc;
        doc.parse<0>( fdoc.data() );

        rapidxml::xml_node<>* root = doc.first_node();

        rapidxml::xml_node<>* nodeLoggers = root->first_node( "Loggers" );

        std::vector<std::string> vecLoggerName = _loadLoggers( nodeLoggers );
        for (const std::string& strLoggerName : vecLoggerName)
        {
            el::Loggers::getLogger( strLoggerName );
        }
    }

    std::vector<std::string> Config::_loadLoggers( void* ptr )
    {
        rapidxml::xml_node<>* nodeLoggers = (rapidxml::xml_node<>*)ptr;

        rapidxml::xml_node<>* nodeLogger = nodeLoggers->first_node( "Logger" );
        std::vector<std::string> vecLoggerName;
        while (nodeLogger)
        {
            rapidxml::xml_attribute<>* attriName = nodeLogger->first_attribute( "name" );
            if (nullptr == attriName)
                continue;

            std::string strLoggerName( attriName->value() );
            vecLoggerName.push_back( strLoggerName );

            nodeLogger = nodeLogger->next_sibling( "Logger" );
        }
        return vecLoggerName;
    }


    el::base::type::StoragePointer Config::sharedLoggingRepository()
    {
        return el::Helpers::storage();
    }

}
