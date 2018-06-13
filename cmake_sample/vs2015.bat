@echo off

@set OSGEO4W_ROOT=C:\OSGeo4W
call "%OSGEO4W_ROOT%\bin\o4w_env.bat"

@set QT_ROOT=C:\OSGeo4W\Qt5

path %QT_ROOT%\bin;%OSGEO4W_ROOT%\bin;%PATH%;

:qwt
set QMAKEFEATURES=%QMAKEFEATURES%

:qwtpolar
set QMAKEFEATURES=%QMAKEFEATURES%

call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
start "gisstore_cpp" devenv.exe .\build\gisstore_cpp.sln
