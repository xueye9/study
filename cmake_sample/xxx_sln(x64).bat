@echo off

@set OSGEO4W_ROOT=C:\OSGeo4W64
@call %OSGEO4W_ROOT%\bin\o4w_env.bat
@call %OSGEO4W_ROOT%\bin\qt5_env.bat
@call %OSGEO4W_ROOT%\bin\py3_env.bat

@path %PATH%;D:\workspace\JDGIS\build\x64\vc14\output\bin\RelWithDebInfo;C:\Program Files\Git\bin

@set QML2_IMPORT_PATH=%OSGEO4W_ROOT%\apps\qt5\qml

@set QGIS_BUILD_PATH=D:/workspace/JDGIS/build/x64/vc14/output
@set QGIS_PREFIX_PATH=D:/workspace/JDGIS/build/x64/vc14/output/bin/RelWithDebInfo

@set GDAL_FILENAME_IS_UTF8=YES
rem Set VSI cache to be used as buffer, see #6448
set VSI_CACHE=TRUE
set VSI_CACHE_SIZE=1000000
set QT_PLUGIN_PATH=%OSGEO4W_ROOT%\apps\qgis\qtplugins;%OSGEO4W_ROOT%\apps\qt5\plugins


::@set PYTHONPATH=%OSGEO4W_ROOT%\apps\qgis\python;%PYTHONPATH%

REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
REM call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x64
@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
@start "JDGIS" /B devenv.exe .\build\x64\vc14\qgis.sln
