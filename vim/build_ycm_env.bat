@set OSGEO4W_ROOT=C:\OSGeo4W64
@call %OSGEO4W_ROOT%\bin\o4w_env.bat"
@call %OSGEO4W_ROOT%\bin\py3_env.bat"

path %PATH%;D:\Program Files\CMake\cmake-3.12.0-win64-x64\bin;D:\Program Files (x86)\win_flex_bison;C:\Program Files\Git\bin;D:\Program Files\LLVM\bin

@call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
@cmd