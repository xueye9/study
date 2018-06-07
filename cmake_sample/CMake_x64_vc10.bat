@echo off
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x64

set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\include
set LIB=%LIB%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\lib

set OSGEO4W_ROOT=C:\OSGeo4W64
echo %OSGEO4W_ROOT%
call "%OSGEO4W_ROOT%\bin\o4w_env.bat"

path %PATH%;E:\Program Files\CMake\cmake-3.11.1-win64-x64\bin

@set INCLUDE=%INCLUDE%;%OSGEO4W_ROOT%\include
@set LIB=%LIB%;%OSGEO4W_ROOT%\lib

start "" "cmake-gui.exe"

