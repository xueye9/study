@set OSGEO4W_ROOT=C:\OSGeo4W64
@call %OSGEO4W_ROOT%\bin\o4w_env.bat"
@call %OSGEO4W_ROOT%\bin\py3_env.bat"

path %PATH%;D:\Program Files\cmake\bin;D:\Program Files\Git\bin;D:\Program Files\LLVM\bin

@call "D:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
@cmd
