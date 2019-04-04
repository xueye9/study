@set OSGEO4W_ROOT=C:\OSGeo4W64

@set OLD_PATH=%path%
@call %OSGEO4W_ROOT%\bin\o4w_env.bat"
@call %OSGEO4W_ROOT%\bin\py3_env.bat"

REM %OSGEO4W_ROOT%\bin;

REM path %OSGEO4W_ROOT%\apps\Python37;%OSGEO4W_ROOT%\apps\Python37\Scripts;%OSGEO4W_ROOT%\bin;%PATH%;%USERPROFILE%\AppData\Local\Microsoft\WindowsApps;D:\Program Files (x86)\ctags58;D:\Program Files\Vim\vim81
REM path %path%;%old_path%;D:\Program Files (x86)\ctags58;D:\Program Files\Vim\vim81
path %path%;D:\Program Files (x86)\ctags58;D:\Program Files\Vim\vim81;%OLD_PATH%

start "" gvim.exe %1

