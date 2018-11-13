@echo off
::set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\include
::set LIB=%LIB%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\lib

@set OSGEO4W_ROOT=C:\OSGeo4W64
@call %OSGEO4W_ROOT%\bin\o4w_env.bat"
@call %OSGEO4W_ROOT%\bin\qt5_env.bat"
@call %OSGEO4W_ROOT%\bin\py3_env.bat"

path %PATH%;D:\Program Files\CMake\cmake-3.12.0-win64-x64\bin;D:\Program Files (x86)\win_flex_bison;C:\Program Files\Git\bin

::set QML2_IMPORT_PATH=%OSGEO4W_ROOT%\apps\Qt5\qml

::@set GRASS_PREFIX=c:/OSGeo4W64/apps/grass/grass-6.4.4
::@set INCLUDE=%INCLUDE%;%OSGEO4W_ROOT%\include
::@set LIB=%LIB%;%OSGEO4W_ROOT%\lib

REM call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x64
REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64
@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
start "" "cmake-gui.exe"
