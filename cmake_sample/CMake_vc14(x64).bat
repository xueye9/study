@echo off
call "E:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64

@set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\include
@set LIB=%LIB%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\lib


@set QTDIR=C:\OSGeo4W64
@set OSGEO4W_ROOT=C:\OSGeo4W64
echo %OSGEO4W_ROOT%
@call "%OSGEO4W_ROOT%\bin\o4w_env.bat"

path %PATH%;E:\Program Files\CMake\cmake-3.8.0-win64-x64\bin;E:\Program Files (x86)\win_flex_bison\

@set INCLUDE=%INCLUDE%;%OSGEO4W_ROOT%\include
@set LIB=%LIB%;%OSGEO4W_ROOT%\lib

start "cmake(x64)" "cmake-gui.exe"

