@echo off

@set OSGEO4W_ROOT=C:\OSGeo4W
call "%OSGEO4W_ROOT%\bin\o4w_env.bat"

::set QGIS_PREFIX_PATH=%OSGEO4W_ROOT:\=/%/apps/qgis
@set QGIS_BUILD_PATH=D:/workspace/JDGIS/build/x86/vc10/output
@set QGIS_PREFIX_PATH=D:/workspace/JDGIS/build/x86/vc10/output/bin/RelWithDebInfo

path %OSGEO4W_ROOT%\bin;%PATH%;E:\workspace\JDGIS\build\x86\vc10\output\bin\RelWithDebInfo
set PYTHONPATH=%QGIS_BUILD_PATH%\python\;%QGIS_BUILD_PATH%\python\plugins\

@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x86
::call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat" x86
start "" devenv.exe .\build\x86\vc10\qgis2.18.4.sln
