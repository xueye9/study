#pragma once
#include <rapidxml/rapidxml.hpp>
#include <rapidxml/rapidxml_utils.hpp>
#include <rapidxml/rapidxml_iterators.hpp>

#include <spdlog/spdlog.h>
#include <spdlog/sinks/stdout_sinks.h>
#include <spdlog/sinks/stdout_color_sinks.h>
#include "spdlog/sinks/daily_file_sink.h"
#include <spdlog/sinks/sink.h>
#include "spdlog/sinks/rotating_file_sink.h"

#include <iostream>
#include <map>
#include <sstream>
#include <algorithm>

const std::string CONSOLE_SINK="Console";
const std::string ROTATINGFILE_SINK="RotatingFile";
const std::string DAILYFILE_SINK="DailyFile";

namespace slf4cpp
{ 
    //template <typename T>
    class LogConfig
    {
    public:
        static LogConfig& Instance()
        {
            static LogConfig ins;
            return ins;
        }

        ~LogConfig();

        void load(const char* logConfigFilePath)
        { 
            rapidxml::file<> fdoc( logConfigFilePath );
            rapidxml::xml_document<>   doc;
            doc.parse<0>( fdoc.data() );

            //! 获取根节点
            rapidxml::xml_node<>* root = doc.first_node();
            std::cout << root->name() << std::endl;

            rapidxml::xml_node<>* nodeFlush = root->first_node( "flush" );
            long long llFlushInterval(-1);
            if (nullptr == nodeFlush)
            {
                rapidxml::xml_attribute<>* attriInterval = nodeFlush->first_attribute( "interval" );
                std::string strFlushInterval = attriInterval->value();
                std::istringstream( strFlushInterval ) >> llFlushInterval; 
                spdlog::flush_every( std::chrono::seconds( llFlushInterval ) );
            }

            rapidxml::xml_node<>* nodeSinks = root->first_node( "Sinks" );
            if (nullptr == nodeSinks)
                return;

            auto sink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
            rapidxml::xml_node<>* nodeSink = nodeSinks->first_node();
            while (nodeSink)
            {
                rapidxml::xml_attribute<>* sinkNameAttri = nodeSink->first_attribute( "name" );
                std::string strSinkName = sinkNameAttri->value();

                rapidxml::xml_node<>* patternLayout = nodeSink->first_node( "PatternLayout" );
                std::string strPattern("");
                if (patternLayout)
                {
                    rapidxml::xml_attribute<>* patternAttri = patternLayout->first_attribute( "pattern" );
                    //std::cout << patternAttri->name() << std::endl;
                    //std::cout << patternAttri->value() << std::endl;
                    strPattern = patternAttri->value();
                }

                //std::cout << nodeSink->name();
                if (0 == CONSOLE_SINK.compare( nodeSink->name() ))
                {
                    rapidxml::xml_attribute<>* sinkName = nodeSink->first_attribute( "name" );
                    rapidxml::xml_attribute<>* sinkColorAttri = nodeSink->first_attribute( "color" );
                    rapidxml::xml_attribute<>* sinkTargetAttri = nodeSink->first_attribute( "target" );

                    std::string strColor( sinkColorAttri->value() );
                    std::transform( strColor.begin(), strColor.end(), strColor.begin(), ::toupper );

                    std::string strTarget( sinkTargetAttri->value() );
                    std::transform( strTarget.begin(), strTarget.end(), strTarget.begin(), ::toupper );
                    
                    std::shared_ptr<spdlog::sinks::sink> spSink;
                    if (0 == strTarget.compare( "STDERR" ))
                    { 
                        if (0 == strColor.compare( "ON" ))
                        {
                            spSink = std::make_shared<spdlog::sinks::stderr_color_sink_mt>();
                        }
                        else
                        {
                            spSink = std::make_shared<spdlog::sinks::stderr_sink_mt>();
                        }
                    }
                    else
                    { 
                        if (0 == strColor.compare( "ON" ))
                        {
                            spSink = std::make_shared<spdlog::sinks::stdout_color_sink_mt>();
                        }
                        else
                        {
                            spSink = std::make_shared<spdlog::sinks::stdout_sink_mt>();
                        }
                    }

                    if (!strPattern.empty())
                        spSink->set_pattern( strPattern );

                    _mapSinks.insert( std::make_pair( strSinkName, spSink ) );
         
                    //rapidxml::xml_attribute<>* sinkFileName = nodeSink->first_attribute( "fileName" );

                    //std::cout << sinkName->name() << std::endl;
                    //std::cout << sinkName->value() << std::endl;
                    //std::cout << sinkFileName->name() << std::endl;
                }
                else if (0 == ROTATINGFILE_SINK.compare( nodeSink->name() ))
                {
                    //<SizeBasedTriggeringPolicy size = "5242880" / > 
                    //<DefaultRotatingStrategy max = "5" / >
                    
                    rapidxml::xml_attribute<>* fileName = nodeSink->first_attribute( "fileName" );
                    if (nullptr == fileName)
                    {
                        nodeSink = nodeSink->next_sibling();
                        continue;
                    }
                    
                    std::size_t size, max;
                    rapidxml::xml_node<>* nodeSize = nodeSink->first_node( "SizeBasedTriggeringPolicy" );
                    if (nullptr == nodeSize)
                    {
                        nodeSink = nodeSink->next_sibling();
                        continue;
                    }

                    rapidxml::xml_attribute<>* attriSize = nodeSize->first_attribute( "size" );
                    std::istringstream( attriSize->value() ) >> size;

                    rapidxml::xml_node<>* maxRotatingStrategy = nodeSink->first_node( "DefaultRotatingStrategy" );
                    if (nullptr == maxRotatingStrategy)
                    {
                        nodeSink = nodeSink->next_sibling();
                        continue;
                    }

                    rapidxml::xml_attribute<>* attriMax = maxRotatingStrategy->first_attribute( "max" );
                    std::istringstream( attriMax->value() ) >> max;

                    //auto file_logger = spdlog::rotating_logger_mt( "file_logger", "logs/mylogfile", 1048576 * 5, 3 );
                    auto sink = std::make_shared<spdlog::sinks::rotating_file_sink_mt>( fileName->value(), size, max );
                    if (!strPattern.empty())
                        sink->set_pattern( strPattern );

                    _mapSinks.insert( std::make_pair( strSinkName, sink ) );
                }
                else if (0 == DAILYFILE_SINK.compare( nodeSink->name() ))
                {
                    //rapidxml::xml_attribute<>* sinkName = nodeSink->first_attribute( "name" );
                    //rapidxml::xml_attribute<>* sinkFileName = nodeSink->first_attribute( "fileName" );

                    //std::cout << sinkName->name() << std::endl;
                    //std::cout << sinkName->value() << std::endl;
                    //std::cout << sinkFileName->name() << std::endl;
                    //< TimeBasedTriggeringPolicy interval = "14:45" / >
                    rapidxml::xml_node<>* nodeTemp = nodeSink->first_node( "TimeBasedTriggeringPolicy" );
                    if (nullptr == nodeTemp)
                    {
                        nodeSink = nodeSink->next_sibling();
                        continue;
                    }

                    rapidxml::xml_attribute<>* attriTemp = nodeTemp->first_attribute( "time" );
                    int nHour( 0 ), nMinute( 0 );
                    if (nullptr == attriTemp)
                    {
                        std::string strTime = attriTemp->value();
                        std::string::size_type pos = strTime.find( ':' );
                        if (std::string::npos == pos)
                        {
                            nodeSink = nodeSink->next_sibling();
                            continue;
                        }

                        std::string strHour = strTime.substr( 0, pos );
                        std::string strMinute = strTime.substr( pos + 1 );

                        std::istringstream( strHour ) >> nHour;
                        std::istringstream( strMinute ) >> nMinute;
                    }

                    auto sink = std::make_shared<spdlog::sinks::daily_file_sink_mt>( strSinkName, nHour, nMinute );
                    if (!strPattern.empty())
                        sink->set_pattern( strPattern );

                    _mapSinks.insert( std::make_pair( strSinkName, sink ) );
                }
                else
                {

                }

                nodeSink = nodeSink->next_sibling();
            }

       
            rapidxml::xml_node<>* nodeLoggers = root->first_node( "Loggers" );

            loadLoggers( nodeLoggers );
        }

    private:

        void loadLoggers( rapidxml::xml_node<>* nodeLoggers )
        {
            rapidxml::xml_node<>* nodeLogger = nodeLoggers->first_node( "Logger" );
            while (nodeLogger)
            { 
                rapidxml::xml_attribute<>* attriName = nodeLogger->first_attribute( "name" );
                if (nullptr == attriName)
                    continue;

                std::string strLoggerName( attriName->value() );

                rapidxml::xml_attribute<>* attriLevel = nodeLogger->first_attribute( "level" );
                if(nullptr == attriLevel)
                    continue;

                std::string strLoggerFlushLevel( "" );
                rapidxml::xml_attribute<>* attriFlushLevel = nodeLogger->first_attribute( "flush-level" );
                if(nullptr == attriFlushLevel)
                    strLoggerFlushLevel = attriFlushLevel->value();

                std::string strLoggerLevel( attriLevel->value() );

                spdlog::level::level_enum eLevel = getLevel( strLoggerLevel );
                std::vector<spdlog::sink_ptr> sinks;

                //nodeLogger = nodeLoggers->next_sibling( "Logger" );
                rapidxml::xml_node<>* nodeSinkRef = nodeLogger->first_node( "sink-ref" );
                while (nodeSinkRef)
                { 
                    rapidxml::xml_attribute<>* attriRef = nodeSinkRef->first_attribute( "ref" ); 
                    std::string strSinkName( attriRef->value() );

                    std::map<std::string, std::shared_ptr<spdlog::sinks::sink> >::iterator it = _mapSinks.find( strSinkName ); 

                    nodeSinkRef = nodeSinkRef->next_sibling( "sink-ref" );
                    if (_mapSinks.end() == it)
                        continue;

                    sinks.push_back( it->second );
                }

                auto combined_logger = std::make_shared<spdlog::logger>( strLoggerName, sinks.begin(), sinks.end() );
                if (combined_logger)
                {
                    combined_logger->set_level( eLevel );
                    if (!strLoggerFlushLevel.empty())
                    {
                        spdlog::level::level_enum eFlushLevel = getLevel( strLoggerFlushLevel );
                        combined_logger->flush_on(eFlushLevel);
                    }
                    spdlog::register_logger( combined_logger );
                }

                nodeLogger = nodeLogger->next_sibling( "Logger" );
            }

        }

        spdlog::level::level_enum getLevel( const std::string& level )
        {
            std::string strLevelLower(level);
            std::transform( level.begin(), level.end(), strLevelLower.begin(), ::tolower );
            if (0 == strLevelLower.compare( "trace" ))
                return spdlog::level::trace;

            if (0 == strLevelLower.compare( "debug" ))
                return spdlog::level::debug;

            if (0 == strLevelLower.compare( "info" ))
                return spdlog::level::info;
            
            if (0 == strLevelLower.compare( "warn" ))
                return spdlog::level::warn;

            if (0 == strLevelLower.compare( "err" ))
                return spdlog::level::err;

            if (0 == strLevelLower.compare( "critical" ))
                return spdlog::level::critical;

            if (0 == strLevelLower.compare( "off" ))
                return spdlog::level::off;
            
            return spdlog::level::off;
        } 

    private:
        std::map<std::string, std::shared_ptr<spdlog::sinks::sink> > _mapSinks;
    };

    LogConfig::~LogConfig()
    {
    }

    class Logger
    {
    public:
        Logger() = delete;
        Logger( const std::string& loggerName );
        ~Logger();

        template<typename... Args>
        void trace( const char *fmt, const Args &... args );

        template<typename... Args>
        void debug( const char *fmt, const Args &... args );

        template<typename... Args>
        void info( const char *fmt, const Args &... args );

        template<typename... Args>
        void warn( const char *fmt, const Args &... args );

        template<typename... Args>
        void error( const char *fmt, const Args &... args );

        template<typename... Args>
        void critical( const char *fmt, const Args &... args ); 

        template<typename T>
        void trace( const T &msg );

        template<typename T>
        void debug( const T &msg );

        template<typename T>
        void info( const T &msg );

        template<typename T>
        void warn( const T &msg );

        template<typename T>
        void error( const T &msg );

        template<typename T>
        void critical( const T &msg );

        void flush();
    private:
        std::shared_ptr<spdlog::logger> _spLogger;
    };

    Logger::Logger( const std::string& loggerName )
    {
        _spLogger = spdlog::get( loggerName );
    }

    Logger::~Logger()
    {
        if (_spLogger)
            _spLogger->flush();
    }

    template<typename... Args>
    inline void Logger::trace( const char* fmt, const Args &... args )
    {
        if (_spLogger)
            _spLogger->trace( fmt, args...);
    }

    template<typename T>
    void Logger::trace( const T &msg )
    {
        if (_spLogger)
            _spLogger->trace( msg ); 
    }

    template<typename... Args>
    inline void Logger::debug( const char* fmt, const Args &... args )
    {
        if (_spLogger)
            _spLogger->debug( fmt, args... );
    }

    template<typename T>
    void Logger::debug( const T &msg )
    { 
        if (_spLogger)
            _spLogger->debug( msg );
    }

    template<typename... Args>
    inline void Logger::info( const char* fmt, const Args &... args )
    {
        if (_spLogger)
            _spLogger->info( fmt, args... );
    }

    template<typename T>
    void Logger::info( const T &msg )
    {
        if (_spLogger)
            _spLogger->info( msg );
    }

    template<typename... Args>
    inline void Logger::warn( const char* fmt, const Args &... args )
    {
        if (_spLogger)
            _spLogger->warn( fmt, args... );
    }

    template<typename T>
    void Logger::warn( const T &msg )
    { 
        if (_spLogger)
            _spLogger->warn( msg );
    }

    template<typename... Args>
    inline void Logger::error( const char* fmt, const Args &... args )
    {
        if (_spLogger)
            _spLogger->error( fmt, args... );
    }

    template<typename T>
    void Logger::error( const T &msg )
    { 
        if (_spLogger)
            _spLogger->error( msg );
    }

    template<typename... Args>
    inline void Logger::critical( const char* fmt, const Args &... args )
    {
        if (_spLogger)
            _spLogger->critical( fmt, args... );
    }

    template<typename T>
    void Logger::critical( const T &msg )
    {
        if (_spLogger)
            _spLogger->critical( msg );
    }

}