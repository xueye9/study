@echo off

@set OSGEO4W_ROOT=C:\OSGeo4W64
@call "%OSGEO4W_ROOT%\bin\o4w_env.bat"
@call "%OSGEO4W_ROOT%\bin\qt5_env.bat"

::path C:\Program Files\MIT\Kerberos\bin;%OSGEO4W_ROOT%\bin;%PATH%;D:\workspace\3part\x64\vc10\bin
path %PATH%;D:\Program Files\cmake\bin

REM vs2010
REM @call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x64

REM vs2015
REM @call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64

REM @set INCLUDE=%INCLUDE%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\include
REM @set LIB=%LIB%;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\lib
REM @set INCLUDE=%INCLUDE%;%OSGEO4W_ROOT%\include
REM @set LIB=%LIB%;%OSGEO4W_ROOT%\lib

REM vs2017
@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
start "" /B "cmake-gui.exe"
