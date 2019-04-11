@echo off

@set OSGEO4W_ROOT=C:\OSGeo4W64
@call "%OSGEO4W_ROOT%\bin\o4w_env.bat"
@call "%OSGEO4W_ROOT%\bin\qt5_env.bat"

::path C:\Program Files\MIT\Kerberos\bin;%OSGEO4W_ROOT%\bin;%PATH%;D:\workspace\3part\x64\vc10\bin
path %PATH%;D:\workspace\third_party\x64\vc14\bin

set QML2_IMPORT_PATH=%OSGEO4W_ROOT%\apps\qt5\qml

REM @call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x64

@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
start "" /B devenv.exe .\build\x64\vc141\t_one.sln
