@echo off

@set OSGEO4W_ROOT=C:\OSGeo4W64
call "%OSGEO4W_ROOT%\bin\o4w_env.bat"

::path C:\Program Files\MIT\Kerberos\bin;%OSGEO4W_ROOT%\bin;%PATH%;D:\workspace\3part\x64\vc10\bin
path %PATH%;D:\workspace\3part\x64\vc10\bin

::call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\vcvarsall.bat" x64
@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
start "gisstore_cpp(x64)" devenv.exe .\build\x64\vc10\gisstore_cpp.sln
